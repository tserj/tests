package modules
{
	import com.moto.template.common.events.ItemRendererEvent;
	import com.moto.template.common.events.MotoEvent;
	import com.moto.template.common.view.AdvancedScrollbar;
	import com.moto.template.shell.model.vo.ModuleItemVO;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.modules.catalog.InfoModule
	import com.moto.template.common.utils.MotoUtils;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.events.Event;

	/**
	 * News module class.
	 */
	public class NewsModule extends InfoModule
	{
		public var scrollbarTrackColor:Number;
		
		public var scrollbarButtonColor:Number;

		private var _button:MovieClip;
		
		private var _track:MovieClip;
		
		private var _scrollbarClip:MovieClip;
		
		private var _scrollbar:AdvancedScrollbar;

		/**
		 * Preview is used for the situation when you create an instance in the
		 * admin panel and there is no data yet or it is not initialized. We need
		 * to show menu preview.
		 */
		private var _preview:MovieClip;
		
		private var _preloader:MovieClip;

		public function NewsModule()
		{
			super();

			// Get components
			_scrollbarClip = MovieClip(getChildByName("scrollbar"));
			_button = MovieClip(_scrollbarClip.getChildByName("button"));
			_track = MovieClip(_scrollbarClip.getChildByName("track"));
			_preview = MovieClip(getChildByName("preview"));
			_preview.visible = false;
			_preloader = MovieClip(getChildByName("preloader"));

			// Add event listeners
			this.addEventListener(INITIALIZATION_COMPLETE, moduleInitializationCompleteHandler);
			this.addEventListener(INITIALIZATION_PROGRESS, moduleInitializationProgressHandler);
			this.addEventListener(INITIALIZATION_ERROR, moduleInitializationErrorHandler);
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

			// Initialize
			itemsArranger.verticalSpacing = 10;
			itemsArranger.columns = 1;
		}

		override public function init(vo:MotoObjectVO):void
		{
			_preloader.visible = true;
			_preview.visible = false;

			super.init(vo);

			// Set item renderer width
			itemsArranger.itemWidth = moduleAreaRectangle.width;
		}

		/**
		 * Updates module and module elements appearance.
		 * 
		 * @param	property Property value object
		 */
		override public function updateProperty(property:PropertyVO):void
		{
			switch (property.propertyType)
			{
				case 1:
				{
					// Update scrollbar track color
					scrollbarTrackColor = Number(property.value);
					MotoUtils.setColor(_track, scrollbarTrackColor);
					break;
				}

				case 2:
				{
					// Update scrollbar button color
					scrollbarButtonColor = Number(property.value);
					MotoUtils.setColor(_button, scrollbarButtonColor);
					break;
				}
			}
		}

		/**
		 * Override setSize function to resize our module and its elements properly.
		 * 
		 * @param	newWidth New slot width
		 * @param	newHeight New slot height
		 */
		override public function setSize(newWidth:Number, newHeight:Number):void
		{
			super.setSize(newWidth, newHeight);
			// Resize module area
			moduleArea.width = newWidth - 34;
			moduleArea.height = newHeight;

			// Set module are rectangle (only for area modules)
			_moduleAreaRectangle = new Rectangle(moduleArea.x, moduleArea.y,
				moduleArea.width, moduleArea.height);

			// Set mask
			maskedHolder.scrollRect = _moduleAreaRectangle;

			// Move track and button
			_scrollbarClip.x = _moduleAreaRectangle.right + 20;
			_track.height = _moduleAreaRectangle.height;

			// Update arranger
			if (itemsArranger)
				itemsArranger.itemWidth = moduleAreaRectangle.width;

			// Preview
			_preview.width = newWidth;
			_preview.height = newHeight;

			// Center preloader
			_preloader.x = (newWidth - _preloader.width) / 2;
			_preloader.y = (newHeight - _preloader.height) / 2;

			// Update scrollbar
			if (_scrollbar)
				_scrollbar.update();
		}

		private function moduleInitializationCompleteHandler(event:Event):void
		{
			// Hide progress bar
			_preloader.visible = false;

			// Refresh preview visibility
			if (dataProvider && dataProvider.length == 0)
				_preview.visible = true;

			// Update scrollbar
			if (_scrollbar)
				_scrollbar.update();
		}

		override protected function itemClickHandler(event:ItemRendererEvent):void
        {
            super.itemClickHandler(event);
           
            if (event.itemRenderer && event.data)
            {
                var itemVO:ModuleItemVO = ModuleItemVO(event.data);
               
                var link:String = String(itemVO.getPropertyValueByID(3));
                // Dispatch moto click event
                if (link != "")
                    dispatchEvent(new MotoEvent(MotoEvent.MOTO_CLICK,
                        String(link), true));
            }
        }
		
		override public function dispose():void 
		{
			super.dispose();
			if (_scrollbar)
				_scrollbar.remove();
		}
		
		private function addedToStageHandler(event:Event):void
		{
			// Initialize scrollbar
			_scrollbar = new AdvancedScrollbar(contentHolder, moduleAreaRectangle, stage);
			_scrollbar.roundedPositionValues = true;
			_scrollbar.setControls(_track, _button, _track, null, null, _scrollbarClip);
		}

		private function moduleInitializationProgressHandler(event:Event):void
		{
			// Update progress bar
		}

		private function moduleInitializationErrorHandler(event:Event):void
		{
			// Hide progress bar
			_preloader.visible = false;

			// Show preview pnly in the control panel
			if (limitedMode)
				_preview.visible = true;
		}
	}
}