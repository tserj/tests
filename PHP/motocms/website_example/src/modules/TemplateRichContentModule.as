package modules
{
	import com.moto.template.common.view.AdvancedScrollbar;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.modules.richContent.RichContentModule;
	import com.moto.template.modules.catalog.InfoModule;
	import com.moto.template.common.utils.MotoUtils;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.events.Event;

	public class TemplateRichContentModule extends RichContentModule
	{
		public var scrollbarTrackColor:Number;
		public var scrollbarButtonColor:Number;
		
		private var _button:MovieClip;
		private var _track:MovieClip;
		private var _scrollbarClip:MovieClip;
		private var _scrollbar:AdvancedScrollbar;
		
		private var _preview:MovieClip;
		
		public function TemplateRichContentModule()
		{
			super();
			
			_scrollbarClip = MovieClip(getChildByName("scrollbar"));
			_button = _scrollbarClip.getChildByName("button") as MovieClip;
			_track = _scrollbarClip.getChildByName("track") as MovieClip;
			_preview = MovieClip(getChildByName("preview"));
			_preview.visible = false;
			
			addEventListener(INITIALIZATION_COMPLETE, moduleInitializationCompleteHandler);
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		override public function init(vo:MotoObjectVO):void
		{
			_preview.visible = false;
			
			super.init(vo);
		}
		
		override public function updateProperty(property:PropertyVO):void
		{			
			switch (property.propertyType)
			{
				case 1:
				{					
					scrollbarTrackColor = Number(property.value);
					MotoUtils.setColor(_track, scrollbarTrackColor);
					break;
				}

				case 2:
				{
					scrollbarButtonColor = Number(property.value);
					MotoUtils.setColor(_button, scrollbarButtonColor);
					break;
				}
			}
		}
		
		override public function getDimensions():Rectangle
		{
			return new Rectangle(0, 0, moduleArea.width, moduleArea.height);
		}
		
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
			
			// Scrollbar update
			if (_scrollbar)
				_scrollbar.update();
		}
		
		private function moduleInitializationCompleteHandler(event:Event):void
		{			
			if (limitedMode && richContentHolder.numChildren == 0)
				_preview.visible = true;
			// Scrollbar update
			if (_scrollbar)
				_scrollbar.update();
		}
		
		private function addedToStageHandler(event:Event):void
		{
			_scrollbar = new AdvancedScrollbar(contentHolder, moduleAreaRectangle, stage);
			_scrollbar.roundedPositionValues = true;
			_scrollbar.resizeTrackButtonDependingOnContent = true;
			_scrollbar.setControls(_track, _button, _track, null, null, _scrollbarClip);
			_scrollbar.update();
		}
		
		override public function dispose():void 
		{
			super.dispose();
			if (_scrollbar)
				_scrollbar.remove();
		}
	}
}