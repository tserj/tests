package modules
{
	import com.moto.template.common.*;
	import com.moto.template.common.utils.MotoUtils;
	import com.moto.template.modules.menu.AbstractMenuItemRenderer;
	import com.moto.template.modules.menu.vo.MenuItemVO;
	
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class RightMenuItemRenderer extends AbstractMenuItemRenderer
	{
		private var _label:TextField;
		private var _bg:MovieClip;
		
		public function RightMenuItemRenderer()
		{
			super();
			
			buttonMode = true;
			mouseChildren = false;
			
			var label1:MovieClip = getChildByName("label") as MovieClip;
			_label = label1.getChildByName("tf") as TextField;
			_label.selectable = false;
			
			_bg = getChildByName("bg") as MovieClip;
		}
		
		override public function updateRenderer(data:Object):void
		{
			super.updateRenderer(data);

			MotoUtils.setHTMLTextFromPropertyVO(_label, data.getPropertyByID(2));
			MotoUtils.setColor(_bg.rect, uint(MenuItemVO(data).getPropertyValueByID(3)));
		}
		
		override public function hide():void
		{
			super.hide();
			removeEventListeners();
		}
		
		/*override protected function over():void 
		{
			super.over();
			trace(new Error("over " + _label.text).getStackTrace());
		}
		
		override protected function out():void 
		{
			super.out();
			trace(new Error("out " + _label.text).getStackTrace());
		}*/
	}
}