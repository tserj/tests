package slots
{
	import com.moto.template.common.utils.MotoUtils;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.shell.view.components.AbstractMotoSlot;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;

	import flash.display.MovieClip;
	import flash.text.TextField;

	public class SimpleButtonSlot extends AbstractMotoSlot
	{
		private var _labelTextfield:TextField;
		
		private var _buttonClip:MovieClip;
		
		public function SimpleButtonSlot()
		{
			super();
			
			// Get slot elements
			_labelTextfield = getChildByName("tf") as TextField;
			_labelTextfield.autoSize = TextFieldAutoSize.LEFT;
			_labelTextfield.wordWrap = false;
			_labelTextfield.multiline = false;
			
			_buttonClip = getChildByName("button") as MovieClip;
			_buttonClip.buttonMode = true;
		}
		
		override public function updateProperty(propertyVO:PropertyVO):void 
		{
			super.updateProperty(propertyVO);
			switch (propertyVO.propertyType) 
			{
				case 1:
					MotoUtils.setHTMLTextFromPropertyVO(_labelTextfield, propertyVO);
					
					setSize(Math.max(_labelTextfield.width, width), Math.max(_labelTextfield.height, height));
				break;
				
			}
		}
		
		override public function setSize(newWidth:Number, newHeight:Number):void 
		{
			newWidth = Math.max(newWidth, _labelTextfield.width);
			newHeight = Math.max(newHeight, _labelTextfield.height);
			super.setSize(newWidth, newHeight);
			
			_labelTextfield.x = int((newWidth - _labelTextfield.width) * .5)
			_labelTextfield.y = int((newHeight - _labelTextfield.height) * .5)
			
			_buttonClip.width = newWidth;
			_buttonClip.height = newHeight;
		}
		
		override public function getDimensions():Rectangle 
		{
			return super.getDimensions();
		}
	}
}