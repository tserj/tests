package slots
{
	import caurina.transitions.Tweener;
	import com.moto.template.common.*;
	import com.moto.template.common.view.AnimatedProgressBar;
	import com.moto.template.common.view.IAnimatedProgressBar;
	import com.moto.template.common.view.components.loaders.ImageLoader;
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

	public class PageImageSlot2 extends AbstractMotoSlot
	{
		private var _mask:MovieClip;
		private var _image:ImageLoader;
		private var _preloader:AnimatedProgressBar;
		
		public function PageImageSlot2()
		{
			super();
			
			// Get slot elements
			_mask = getChildByName("imageMask") as MovieClip;
			var holder:MovieClip = getChildByName("imageHolder") as MovieClip;
			_image = holder.getChildByName("image") as ImageLoader;
			_preloader = preloaderHolder.getChildByName("preloader") as AnimatedProgressBar;
			
			holder.mask = _mask;
		}
		
		override public function updateProperty(property:PropertyVO):void
		{						
			switch (property.propertyType)
			{
				case 1:
				{
					_image.source = pathPrefix + property.value;
					_image.addEventListener(Event.COMPLETE, imageCompleteHandler);
					break;
				}
			}
		}
		
		override public function setSize(newWidth:Number, newHeight:Number):void
		{			
			_mask.width = newWidth;
			_mask.height = newHeight;
			
			_image.width = newWidth;
			_image.height = newHeight;
			
			_preloader.x = _mask.width / 2;
			_preloader.y = _mask.height / 2;
		}
		
		override public function getDimensions():Rectangle
		{
			return new Rectangle(0, 0, _mask.width, _mask.height);
		}
		
		private function imageCompleteHandler(event:Event):void
		{
			Tweener.addTween(_preloader, {alpha:0, onComplete:function():void { _preloader.hide() }});
			gotoAndPlay("show");
		}
	}
}