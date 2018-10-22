package slots
{
	import caurina.transitions.Tweener;
	import com.moto.template.common.*;
	import com.moto.template.common.utils.MotoUtils;
	import com.moto.template.common.view.AnimatedProgressBar;
	import com.moto.template.common.view.IAnimatedProgressBar;
	import com.moto.template.common.view.components.loaders.ImageLoader;
	import com.moto.template.common.view.components.loaders.MediaLoader;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.shell.view.components.AbstractMotoSlot;
	import flash.geom.Rectangle;

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.net.URLRequest;
	import flash.text.TextField;

	public class PageImageSlot extends AbstractMotoSlot
	{
		private var _mask:MovieClip;
		private var _image:ImageLoader;
		private var _bg:MovieClip;
		private var _preloader:AnimatedProgressBar;
		
		public function PageImageSlot()
		{
			super();
			
			// Get slot elements
			_mask = getChildByName("imageMask") as MovieClip;
			var holder:MovieClip = getChildByName("imageHolder") as MovieClip;
			_image = holder.getChildByName("image") as ImageLoader;
			_bg = getChildByName("bg") as MovieClip;
			_preloader = preloaderHolder.getChildByName("preloader") as AnimatedProgressBar;
			
			// _image.scalingMode = MediaLoader.FIT_IMAGE;
			
			holder.mask = _mask;
		}

		override public function updateProperty(property:PropertyVO):void
		{						
			switch (property.propertyType)
			{
				case 1:
				{
					_image.addEventListener(Event.COMPLETE, imageCompleteHandler);
					_image.source = pathPrefix + String(property.value);
					break;
				}

				case 2:
				{
					MotoUtils.setColor(_bg, Number(property.value));
					break;
				}
			}
		}
		
		override public function setSize(newWidth:Number, newHeight:Number):void
		{
			_bg.width = newWidth;
			_bg.height = newHeight;
			
			_mask.width = newWidth-2;
			_mask.height = newHeight - 2;
			
			_image.width = newWidth-2;
			_image.height = newHeight - 2;
			
			_preloader.x = (_bg.width) / 2;
			_preloader.y = (_bg.height) / 2;
		}
		
		override public function getDimensions():Rectangle
		{
			return new Rectangle(0, 0, _bg.width, _bg.height);
		}
		
		private function imageCompleteHandler(event:Event):void
		{			
			Tweener.addTween(_preloader, { alpha:0, onComplete:function():void { _preloader.hide() }} );
			
			gotoAndPlay("show");
		}
	}
}