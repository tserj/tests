package modules
{
	import com.moto.template.common.utils.MotoUtils;
	import com.moto.template.modules.menu.AbstractMenuItemRenderer;
	import com.moto.template.modules.menu.vo.MenuItemVO;
	import com.moto.template.shell.model.vo.PropertyVO;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * Main sub menu item class. We extend AbstractMenuItemRenderer for menu items.
	 */
	public class MainMenuItemRenderer extends AbstractMenuItemRenderer
	{
		private var _label:TextField;
		
		private var _textHolder:MovieClip;
		
		private var _area:MovieClip;
		
		private var _overClip:MovieClip;
		
		private var _menuMask:MovieClip;
		
		public function MainMenuItemRenderer()
		{
			super();

			// Get elements
			_area = getChildByName("area") as MovieClip;
			_overClip = overClip.getChildByName("bg") as MovieClip;
			_textHolder = getChildByName("menuTextHolder") as MovieClip;
			_menuMask = getChildByName("menuMask") as MovieClip;
			
			buttonMode = true;
			mouseChildren = false;
			hitArea = _area;
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		/**
		 * Update menu item appearance.
		 * 
		 * @param	data MenuItemVO object - Menu item renderer data
		 */
		override public function updateRenderer(data:Object):void
		{
			super.updateRenderer(data);
			
			// Update all the textfields and resize masks depending on menu item text
			var labelPropperty:PropertyVO = menuItemVO.getPropertyByID(1);
			for (var i:uint = 1; i < 4; i++)
			{
				_label = _textHolder["menuText"+i].getChildByName("tf") as TextField;
				
				_label.selectable = false;
				_label.multiline = false;
				_label.autoSize = "left";
				MotoUtils.setHTMLTextFromPropertyVO(_label, labelPropperty, true);
				_label.y = Math.round((_area.height - _label.textHeight) / 2) - 3;
			}
			_overClip.width = _label.textWidth + 5;
			_overClip.y = Math.round(_label.height)-4;
			_area.width = _label.textWidth + 8;
			_area.height = Math.round(_label.height)-3;
			_menuMask.width = _label.textWidth + 8;
			_menuMask.height = Math.round(_label.height)-3;
		}
		
		override public function getDimensions():Rectangle
		{
			return new Rectangle(0, 0, _area.width, _area.height);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			if (selected)
				gotoAndPlay(overLabel);
			else
				show();
		}
	}
}