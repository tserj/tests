package slots
{
	import com.moto.template.common.events.UpdateMotoObjectEvent;
	import com.moto.template.common.utils.MotoUtils;
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.shell.view.components.AbstractMotoSlot;
	import flash.geom.Rectangle;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;

	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * List element slot class. We extend AbstractMotoSlot to create slots.
	 */
	public class ListElementSlot extends AbstractMotoSlot
	{
		private var _tf:TextField;
		
		private var _button:MovieClip;
		
		private var _buttonMask:MovieClip;
		
		private var _bg:MovieClip;

		public function ListElementSlot()
		{
			super();

			// Get slot elements
			_buttonMask = getChildByName("buttonMask") as MovieClip;
			_bg = getChildByName("bg") as MovieClip;
			_button = getChildByName("button") as MovieClip;
			buttonMode = true;
			_tf = textHolder.getChildByName("tf") as TextField;
			
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_tf.wordWrap = false;
			_tf.multiline = false;
			
			
			mouseChildren = false;
			hitArea = _button;
		}
		
		/**
		 * Updates slot appearance.
		 * 
		 * @param	property Property value object
		 */
		override public function updateProperty(property:PropertyVO):void
		{
			switch (property.propertyType)
			{
				case 1 :
				{
					// There is label in the second property.
					// We need to update embed fonts parameter. It has string type in parameters
					// object so we are converting it to Boolean using MotoUtils.
					MotoUtils.setHTMLTextFromPropertyVO(_tf, property);
					
					
					if (getDimensions().width < _tf.width)
					{
						setSize(_tf.width, 0);
						updateDimensions();
					}
					// We need to center our textfield
					_tf.y = Math.ceil((_bg.clip.height - _tf.textHeight) / 2) - 2;
					break;
				}
			}
		}
				
		/**
		 * Override setSize function to resize our slot properly.
		 * 
		 * @param	newWidth New slot width
		 * @param	newHeight New slot height
		 */
		override public function setSize(newWidth:Number, newHeight:Number):void
		{
			//super.setSize(newWidth, newHeight);
			if (newWidth < _tf.width)
				return;
			_buttonMask.clip.width = newWidth;
			_bg.clip.width = newWidth;
			_button.clip.width = newWidth;
		}
		
		/**
		 * Return custom slot dimensions. Use bg width and height as slot
		 * width and height.
		 * 
		 * @return Dimensions rectangle
		 */
		override public function getDimensions():Rectangle
		{
			return new Rectangle(0, 0, _bg.clip.width, _bg.clip.height);
		}
		
		override protected function mouseOverHandler(event:MouseEvent):void
		{
			this.gotoAndPlay(overFrameLabel);
		}
		
		override protected function mouseOutHandler(event:MouseEvent):void
		{
			this.gotoAndPlay(outFrameLabel);
		}
	}
}