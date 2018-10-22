package slots
{
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.shell.view.components.AbstractMotoSlot;
	import com.moto.template.common.utils.MotoUtils;
	import flash.events.Event;

	import flash.display.MovieClip;
	import flash.text.TextField;

	public class SimpleButtonSlot extends AbstractMotoSlot
	{
		public var labelTextfield:TextField;
		public var buttonClip:MovieClip;
		
		public function SimpleButtonSlot()
		{
			super();
			
			// Get slot elements
			labelTextfield = getChildByName("tf") as TextField;
			labelTextfield.autoSize = "left";
			labelTextfield.wordWrap = false;
			labelTextfield.multiline = false;
			
			buttonClip = getChildByName("button") as MovieClip;
			buttonClip.buttonMode = true;
		}
		
		override public function updateProperty (property:PropertyVO):void
		{
			switch (property.propertyType) 
			{
				case 1:
					MotoUtils.setHTMLTextFromPropertyVO(labelTextfield, property)
				break;
				
			}
		}
		
		public function overMouse ():void
		{
			this.gotoAndPlay (overFrameLabel);
		}
		public function outMouse ():void
		{
			this.gotoAndPlay (outFrameLabel);
		}
	}
}