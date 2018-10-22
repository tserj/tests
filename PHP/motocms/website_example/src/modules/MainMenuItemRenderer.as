package modules
{
	import com.moto.template.common.*;
	import com.moto.template.common.utils.MotoUtils;
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.modules.menu.AbstractMenuItemRenderer;
	import com.moto.template.modules.menu.vo.MenuItemVO;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class MainMenuItemRenderer extends AbstractMenuItemRenderer
	{
		private var _label:TextField;
		private var _bg:MovieClip;
		
		public function MainMenuItemRenderer()
		{
			super();
			
			buttonMode = true;
			mouseChildren = false;
			
			var label1:MovieClip = getChildByName("label1") as MovieClip;
			_label = label1.getChildByName("tf") as TextField;
			_label.selectable = false;			
			_bg = getChildByName("bg") as MovieClip;
		}
		
		override public function updateRenderer(data:Object):void
		{
			super.updateRenderer(data);

			MotoUtils.setHTMLTextFromPropertyVO(_label, data.getPropertyByID(1));
			MotoUtils.setColor(_bg.rect, uint(MenuItemVO(data).getPropertyValueByID(3)));
		}
		
		override public function hide():void
		{
			super.hide();
			removeEventListeners();
		}
		
		override public function show():void
		{
			super.show();
			MotoUtils.callFunctionWithDelay(createEventListeners, 1);
		}
	}
}