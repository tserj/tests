package modules 
{
	import com.moto.template.modules.menu.AbstractMenuItemRenderer;
	import com.moto.template.modules.menu.vo.MenuItemVO;
	import com.moto.template.common.tools.MotoLogger;
	import com.moto.template.common.utils.MotoUtils;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class RightSubMenuItemRenderer extends AbstractMenuItemRenderer
	{
		private var _label:TextField;
		private var _bg:MovieClip;
		
		public function RightSubMenuItemRenderer() 
		{
			super();
			
			buttonMode = true;
			mouseChildren = false;
			
			var labelHolder:MovieClip = getChildByName("label") as MovieClip;
			_label = labelHolder.getChildByName("tf") as TextField;
			_label.selectable = false;
			
			var bgHolder:MovieClip = getChildByName("bg") as MovieClip;
			_bg = bgHolder.getChildByName("rect") as MovieClip;
		}
		
		override public function updateRenderer(data:Object):void
		{
			super.updateRenderer(data);
			
			MotoUtils.setHTMLTextFromPropertyVO(_label, data.getPropertyByID(2));
			MotoUtils.setColor(_bg, uint(MenuItemVO(data).getPropertyValueByID(3)));
		}
	}
	
}