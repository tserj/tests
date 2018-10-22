package modules 
{
	import com.moto.template.common.events.UpdateMotoObjectEvent;
	import com.moto.template.common.view.AnimatedProgressBar;
	import com.moto.template.modules.form.FormItemRenderer;
	import com.moto.template.shell.model.vo.ModuleVO;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.modules.form.FormModule;
	import com.moto.template.common.utils.MotoUtils;
	import com.moto.template.shell.view.components.AbstractMotoSlot;
	
	import flash.display.MovieClip;
	import slots.SimpleButtonSlot;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	
	public class ContactFormModule extends FormModule
	{
		public var scrollbarTrackColor:Number;
		public var scrollbarButtonColor:Number;
		public var borderColor:Number;
		public var inputTextFormat:TextFormat;
		public var inputTextFormatPropertyVO:PropertyVO;
		public var messageTextFormat:TextFormat;
		public var messageTextFormatPropertyVO:PropertyVO;
		public var submitButtonText:String;
		public var submitButtonPropertyVO:PropertyVO;
		public var resetButtonText:String;
		public var resetButtonPropertyVO:PropertyVO;
		
		private var _preview:MovieClip;
		private var _preloader:AnimatedProgressBar;
		
		private var submitButton:AbstractMotoSlot;
		private var resetButton:AbstractMotoSlot;
		
		public function ContactFormModule() 
		{
			super();
			
			// Get components
			_preview = MovieClip(getChildByName("preview"));
			_preview.visible = false;
			_preloader = AnimatedProgressBar(getChildByName("preloader"));
			
			// Add event listeners
			addEventListener(INITIALIZATION_COMPLETE, moduleInitializationCompleteHandler);
			addEventListener(INITIALIZATION_PROGRESS, moduleInitializationProgressHandler);
			addEventListener(INITIALIZATION_ERROR, moduleInitializationErrorHandler);
		}
		
		override public function init(vo:MotoObjectVO):void
		{
			_preloader.visible = true;
			_preview.visible = false;
			
			super.init(vo);	
			dispatchEvent(new UpdateMotoObjectEvent(UpdateMotoObjectEvent.MOTO_OBJECT_SIZE_UPDATED));
		}
		
		override public function updateProperty(property:PropertyVO):void
		{						
			switch (property.propertyType)
			{
				case 1:
				{					
					scrollbarTrackColor = Number(property.value);
					break;
				}

				case 2:
				{
					scrollbarButtonColor = Number(property.value);
					break;
				}
				
				case 3:
				{
					borderColor = Number(property.value);
					updateFormItemRenderersProperties();
					break;
				}
				
				case 4:
				{
					inputTextFormat = MotoUtils.getTextFormatFromXML(property.value);
					inputTextFormatPropertyVO = property;
					updateFormItemRenderersProperties();
					break;
				}
				
				case 5:
				{
					messageTextFormat = MotoUtils.getTextFormatFromXML(property.value);
					messageTextFormatPropertyVO = property;
					updateMessageField();
					break;
				}
				
				case 6:
				{
					submitButtonPropertyVO = property;
					if (formsManager && formsManager.submitButton)
					{
						submitButton = AbstractMotoSlot(formsManager.submitButton);
						submitButton.updateProperty(MotoUtils.translatePropertyVO(1, submitButtonPropertyVO));
					}
					break;
				}
				
				case 7:
				{
					resetButtonPropertyVO = property;
					if (formsManager && formsManager.resetButton)
					{
						resetButton = AbstractMotoSlot(formsManager.resetButton);
						resetButton.updateProperty(MotoUtils.translatePropertyVO(1, resetButtonPropertyVO));
					}
					break;
				}
			}
		}
		
		override public function getDimensions():Rectangle 
		{
			var superDimensions:Rectangle = super.getDimensions();
			return new Rectangle(0, 0, superDimensions.width || _preview.width, superDimensions.height || _preview.height);
		}
		
		override public function setSize(newWidth:Number, newHeight:Number):void
		{
			super.setSize(newWidth, newHeight);
			_preview.width = newWidth;
			_preview.height = newHeight;
			
			_preloader.x = newWidth / 2;
			_preloader.y = newHeight / 2;
		}
		
		private function moduleInitializationCompleteHandler(event:Event):void
		{		
			// Hide progress bar
			_preloader.hide();
			
			// Form is created -> Update form properties
			updateFormItemRenderersProperties();
			updateProperty(submitButtonPropertyVO);
			updateProperty(resetButtonPropertyVO);
			
			submitButton.addEventListener(MouseEvent.ROLL_OVER, mouseOverButtonHandler);
			submitButton.addEventListener(MouseEvent.ROLL_OUT, mouseOutButtonHandler);
			
			resetButton.addEventListener(MouseEvent.ROLL_OVER, mouseOverButtonHandler);
			resetButton.addEventListener(MouseEvent.ROLL_OUT, mouseOutButtonHandler);
			
			updateMessageField();
			dispatchEvent(new UpdateMotoObjectEvent(UpdateMotoObjectEvent.MOTO_OBJECT_SIZE_UPDATED));
		}
		
		private function mouseOverButtonHandler(event:MouseEvent)
		{
			event.target.overMouse()
		}
		
		private function mouseOutButtonHandler(event:MouseEvent)
		{
			event.target.outMouse();
		}
		
		private function updateModuleProperty(propertyID:uint, propertyValue:String, parameters:Object):void
		{
			var property:PropertyVO = new PropertyVO();
			property.propertyType = propertyID;
			property.value = propertyValue;
			property.parameters = parameters;
			updateProperty(property);
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
						inputTextFormatPropertyVO: inputTextFormatPropertyVO,
						borderColor: borderColor
					});
				}
			}
		}
		
		private function updateMessageField():void
		{
			if (formsManager && formsManager.messageTextField)
			{
				MotoUtils.setHTMLParametersFromPropertyVO(formsManager.messageTextField, messageTextFormatPropertyVO)
				
				formsManager.messageTextField.defaultTextFormat = messageTextFormat;
				if (formsManager.messageTextField.text.length > 0)
					formsManager.messageTextField.setTextFormat(messageTextFormat, 0, 
						formsManager.messageTextField.text.length);
			}
		}
	}
}