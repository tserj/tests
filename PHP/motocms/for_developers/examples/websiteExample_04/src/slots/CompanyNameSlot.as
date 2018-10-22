package slots
{
	import caurina.transitions.Tweener;
	import com.moto.template.common.utils.MotoUtils;
	import com.moto.template.common.view.components.loaders.ImageLoader;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.shell.view.components.AbstractMotoSlot;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.net.URLRequest;
	import flash.text.TextField;

	/**
	 * Company name slot class. We extend AbstractMotoSlot to create slots.
	 */
	public class CompanyNameSlot extends AbstractMotoSlot
	{
		private var _image:ImageLoader;
		
		private var _preloader:MovieClip;
		
		private var _holder:MovieClip;
		
		private var _tf:TextField;
				
		public function CompanyNameSlot()
		{
			super();
			
			// Get slot elements
			_holder = getChildByName("imageHolder") as MovieClip;
			_image = _holder.getChildByName("image") as ImageLoader;
			_preloader = getChildByName("preloader") as MovieClip;
			_tf = textHolder.getChildByName("tf") as TextField;		
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_tf.wordWrap = false;
			_tf.multiline = false;
					
			mouseChildren = false;
		}
		
		/**
		 * Return custom slot dimensions. Use image width and height as slot
		 * width and height.
		 * 
		 * @return Dimensions rectangle
		 */
		override public function getDimensions():Rectangle
		{
			return new Rectangle(0, 0, _image.width, _image.height);
		}
		
		/**
		 * Override setSize function to resize our slot properly. We resize only
		 * image to get effect needed.
		 * 
		 * @param	newWidth New slot width
		 * @param	newHeight New slot height
		 */
		override public function setSize(newWidth:Number, newHeight:Number):void
		{
			_image.width = newWidth;
			_image.height = newHeight;
		}
		
		/**
		 * Updates slot appearance.
		 * 
		 * @param	property Property value object
		 */
		override public function updateProperty(property:PropertyVO):void
		{						
			// There are two properties to update so check property type
			switch (property.propertyType)
			{
				case 1:
				{
					// There is image source in the first property so set image source
					// We need to use pathPrefix for file paths in slots and modules.
					_image.source = pathPrefix + String(property.value);
					_image.addEventListener(Event.COMPLETE, imageCompleteHandler);
					break;
				}
				
				case 2:
				{
					// There is company name in the second property.
					// We need to update embed fonts parameter. It has string type in parameters
					// object so we are converting it to Boolean using MotoUtils.
					MotoUtils.setHTMLTextFromPropertyVO(_tf, property);
					break;
				}
			}
		}
		
		/**
		 * Shows slot animation when image is loaded.
		 * 
		 * @param	event
		 */
		private function imageCompleteHandler(event:Event):void
		{
			// Hide image preloader
			Tweener.addTween(_preloader, { alpha:0 } );
			
			// Show animation
			gotoAndPlay("show");
		}
	}
}