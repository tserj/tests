package modules 
{
	import com.moto.template.modules.form.FormItemRenderer;
	import com.moto.template.shell.model.vo.ModuleVO;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.modules.form.FormModule;
	import com.moto.template.common.utils.MotoUtils;
	import com.moto.template.shell.view.components.AbstractMotoSlot;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	
	/**
	 * Contact form module
	 */
	public class ContactFormModule extends FormModule
	{
		public var borderColor:Number;
		
		public var inputTextFormat:TextFormat;
		
		public var inputTextFormatProperty:PropertyVO;
		
		public var messageTextFormat:TextFormat;
		
		public var messageTextFormatProperty:PropertyVO;
		
		public var submitButtonProperty:PropertyVO;
		
		public var resetButtonProperty:PropertyVO;
		
		/**
		 * Preview is used for the situation when you create an instance in the
		 * admin panel and there is no data yet or it is not initialized. We need
		 * to show menu preview.
		 */
		private var _preview:MovieClip;
		
		private var _preloader:MovieClip;
		
		public function ContactFormModule() 
		{
			super();
			
			// Get components
			_preview = MovieClip(getChildByName("preview"));
			_preview.visible = false;
			_preloader = MovieClip(getChildByName("preloader"));
			
			// Add event listeners
			addEventListener(INITIALIZATION_COMPLETE, moduleInitializationCompleteHandler);
			addEventListener(INITIALIZATION_PROGRESS, moduleInitializationProgressHandler);
			addEventListener(INITIALIZATION_ERROR, moduleInitializationErrorHandler);
		}
		
		override public function init(vo:MotoObjectVO):void
		{
			// Hide preview and preloader
			_preloader.visible = true;
			_preview.visible = false;
			
			super.init(vo);			
		}
		
		/**
		 * Updates module and module elements appearance.
		 * 
		 * @param	property Property value object
		 */
		override public function updateProperty(property:PropertyVO):void
		{						
			switch (property.propertyType)
			{
				
				case 3:
				{
					// Update form items border color
					borderColor = Number(property.value);
					updateFormItemRenderersProperties();
					break;
				}
				
				case 4:
				{
					// Update input text format
					inputTextFormat = MotoUtils.getTextFormatFromXML(property.value);
					inputTextFormatProperty = property;
					updateFormItemRenderersProperties();
					break;
				}
				
				case 5:
				{
					// Update form message text format
					messageTextFormat = MotoUtils.getTextFormatFromXML(property.value);
					messageTextFormatProperty = property;
					updateMessageField();
					break;
				}
				
				case 6:
				{
					// Update submit button text
					submitButtonProperty = property;
					if (formsManager && formsManager.submitButton)
					{
						var submitButton:AbstractMotoSlot = AbstractMotoSlot(formsManager.submitButton);
						submitButton.updateProperty(MotoUtils.translatePropertyVO(1, property));
						submitButton.setSize(formsManager.submitButtonRect.width, formsManager.submitButtonRect.height);
					}
					break;
				}
				
				case 7:
				{
					// Update reset button text
					resetButtonProperty = property;
					if (formsManager && formsManager.resetButton)
					{
						var resetButton:AbstractMotoSlot = AbstractMotoSlot(formsManager.resetButton);
						resetButton.updateProperty(MotoUtils.translatePropertyVO(1, property));
						resetButton.setSize(formsManager.resetButtonRect.width, formsManager.resetButtonRect.height);
					}
					break;
				}
			}
		}
		
		private function updateMessageField():void
		{
			if (formsManager && formsManager.messageTextField)
			{
				MotoUtils.setHTMLParametersFromPropertyVO(formsManager.messageTextField, messageTextFormatProperty);
				
				formsManager.messageTextField.defaultTextFormat = messageTextFormat;
				if (formsManager.messageTextField.text.length > 0)
					formsManager.messageTextField.setTextFormat(messageTextFormat, 0, 
						formsManager.messageTextField.text.length);
			}
		}
		
		/**
		 * Resize module and its elements
		 * 
		 * @param	newWidth New module width
		 * @param	newHeight New module height
		 */
		override public function setSize(newWidth:Number, newHeight:Number):void
		{			
			super.setSize(newWidth, newHeight);
			
			_preview.width = newWidth;
			_preview.height = newHeight;
			
			_preloader.x = (newWidth - _preloader.width) / 2;
			_preloader.y = (newHeight - _preloader.height) / 2;
		}
		
		private function moduleInitializationCompleteHandler(event:Event):void
		{		
			// Hide progress bar
			_preloader.visible = false;
			
			// Form is created -> Update form properties
			updateFormItemRenderersProperties();
			updateProperty(properties[6]);
			updateProperty(properties[7]);
			
			// Update message text field
			updateMessageField();
		}
		
		private function moduleInitializationProgressHandler(event:Event):void
		{
			// Update progress bar
		}
		
		private function moduleInitializationErrorHandler(event:Event):void
		{
			_preloader.visible = false;
			
			if (limitedMode)
				_preview.visible = true;
		}
		
		private function updateFormItemRenderersProperties():void
		{
			if (itemRenderersCollection && itemRenderersCollection.length > 0)
			{
				for each (var item:FormItemRenderer in itemRenderersCollection)
				{
					item.updateProperties({
						inputTextFormat: inputTextFormat,
						inputTextFormatProperty: inputTextFormatProperty,
						borderColor: borderColor
					});
				}
			}
		}
	}
}