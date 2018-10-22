package modules
{
	import com.moto.template.common.view.AdvancedScrollbar;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.modules.richContent.RichContentModule;
	import com.moto.template.modules.catalog.InfoModule
	import com.moto.template.common.utils.MotoUtils;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.events.Event;

	/**
	 * Template rich content module extends Rich content module.
	 */
	public class TemplateRichContentModule extends RichContentModule
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
		
		public function TemplateRichContentModule()
		{
			super();
			
			// Get elements
			_scrollbarClip = MovieClip(getChildByName("scrollbar"));
			_button = _scrollbarClip.getChildByName("button") as MovieClip;
			_track = _scrollbarClip.getChildByName("track") as MovieClip;
			_preview = MovieClip(getChildByName("preview"));
			_preview.visible = false;
			
			// Add event listeners
			addEventListener(INITIALIZATION_COMPLETE, moduleInitializationCompleteHandler);
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		override public function init(vo:MotoObjectVO):void
		{
			_preview.visible = false;
			
			super.init(vo);
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
					// Update scrollbar track button
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
		 * @return Module dimensions
		 */
		override public function getDimensions():Rectangle
		{
			return new Rectangle(0, 0, moduleArea.width, moduleArea.height);
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
			moduleArea.width = newWidth;
			moduleArea.height = newHeight;

			_moduleAreaRectangle = new Rectangle(moduleArea.x, moduleArea.y,
				moduleArea.width, moduleArea.height);

			maskedHolder.scrollRect = _moduleAreaRectangle;
			
			// Move track and button
			_scrollbarClip.x = _moduleAreaRectangle.right + 20;
			_track.height = _moduleAreaRectangle.height;
			
			_preview.width = newWidth;
			_preview.height = newHeight;
			
			// Scrollbar
			if (_scrollbar)
				_scrollbar.update();
		}
		
		override public function dispose():void 
		{
			super.dispose();
			if (_scrollbar)
				_scrollbar.remove();
		}
		
		private function moduleInitializationCompleteHandler(event:Event):void
		{			
			// Update preview visibility
			if (limitedMode && richContentHolder.numChildren == 0)
				_preview.visible = true;
			
			// Scrollbar
			if (_scrollbar)
				_scrollbar.update();
		}
		
		private function addedToStageHandler(event:Event):void
		{
			// Init  scrollbar
			_scrollbar = new AdvancedScrollbar(contentHolder, moduleAreaRectangle, stage);
			_scrollbar.roundedPositionValues = true;
			_scrollbar.resizeTrackButtonDependingOnContent = true;
			_scrollbar.setControls(_track, _button, _track, null, null, _scrollbarClip);
			_scrollbar.update();
		}
	}
}