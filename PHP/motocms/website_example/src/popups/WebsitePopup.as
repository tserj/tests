package popups 
{
	import com.moto.template.shell.model.vo.PopupVO;
	import com.moto.template.shell.view.components.AbstractMotoPopup;
	import com.moto.template.common.Moto;
	import com.moto.template.common.utils.MotoUtils;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class WebsitePopup extends AbstractMotoPopup
	{				
		public function WebsitePopup()
		{
			super();
			
			closeButton = popup_holder_17.closeButton;
			closeButton.addEventListener(MouseEvent.ROLL_OVER, closeButtonRollOverHandler);
			closeButton.addEventListener(MouseEvent.ROLL_OUT, closeButtonRollOutHandler);
		}
		
		override public function hide():void
		{
			closeButton.removeEventListener(MouseEvent.ROLL_OVER, closeButtonRollOverHandler);
			closeButton.removeEventListener(MouseEvent.ROLL_OUT, closeButtonRollOutHandler);
			
			gotoAndPlay("hide");
			popup_holder_17.closeButton.gotoAndPlay("hide");
		}
		
		private function closeButtonRollOverHandler(event:MouseEvent):void
		{
			MovieClip(closeButton).gotoAndPlay("over");
		}
		
		private function closeButtonRollOutHandler(event:MouseEvent):void
		{
			MovieClip(closeButton).gotoAndPlay("out");
		}
	}	
}