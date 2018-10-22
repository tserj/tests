package modules 
{
	import com.moto.template.modules.form.FormItemRenderer;
	import com.moto.template.modules.form.items.FormItem;
	import com.moto.template.modules.form.FormModule;
	import com.moto.template.common.utils.MotoUtils;
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * Contact form item.
	 */
	public class ContactFormItem extends FormItemRenderer
	{
		private var _border:Sprite;
		
		private var _tf:TextField;
		
		public function ContactFormItem() 
		{
			super();

			// Get elements
			_border = Sprite(getChildByName("border"));
			_tf = TextField(getChildByName("tf"));
		}
		
		/**
		 * Resize contact form item elements
		 * 
		 * @param	newWidth New item width
		 * @param	newHeight New item height
		 */
		override public function setSize(newWidth:Number, newHeight:Number):void
		{
			_border.width = newWidth;
			_border.height = newHeight;
			
			_tf.width = newWidth - 21;
			_tf.height = newHeight - 10;
		}
		
		/**
		 * We need to return contact form item textfield.
		 * 
		 * @return Object Target textfield
		 */
		override public function getTarget():Object
		{
			return _tf;
		}
		
		override public function updateProperties(data:Object):void
		{
			// Update field text
			_tf.defaultTextFormat = data.inputTextFormat;
			MotoUtils.setHTMLParametersFromPropertyVO(_tf, data.inputTextFormatProperty);
			if (_tf.text.length)
				_tf.setTextFormat(data.inputTextFormat, 0, _tf.text.length);
			
			// Update border color
			MotoUtils.setColor(_border, data.borderColor);
		}
	}
}