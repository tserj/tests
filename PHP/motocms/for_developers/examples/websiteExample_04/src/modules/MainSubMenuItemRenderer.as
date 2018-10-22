package modules 
{
	import com.moto.template.modules.menu.AbstractMenuItemRenderer;
	import com.moto.template.modules.menu.AbstractMotoMenu;
	import com.moto.template.common.utils.MotoUtils;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * Main sub menu item class. We extend AbstractMenuItemRenderer for menu items.
	 */
	public class MainSubMenuItemRenderer extends AbstractMenuItemRenderer
	{
		private var _label:TextField;
		
		private var _area:MovieClip;
		
		public function MainSubMenuItemRenderer() 
		{
			super();
			
			// Get elements
			var _clip:MovieClip = getChildByName("areaOver") as MovieClip;
			var labelHolder:MovieClip = getChildByName("textContent") as MovieClip;
			_label = labelHolder.getChildByName("tf") as TextField;
			_label.selectable = false;
			_label.autoSize = TextFieldAutoSize.LEFT;
			
			buttonMode = true;
			mouseChildren = false;
			hitArea = _clip;
			
			_area = getChildByName("areaOver") as MovieClip;
		}
		
		/**
		 * Update menu item appearance.
		 * 
		 * @param	data MenuItemVO object - Menu item renderer data
		 */
		override public function updateRenderer(data:Object):void
		{
			super.updateRenderer(data);
			
			// Update label
			MotoUtils.setHTMLTextFromPropertyVO(_label, menuItemVO.getPropertyByID(1));
			_label.x = Math.round((_area.width - _label.textWidth) / 2);
		}
	}
	
}