package modules 
{
	import com.moto.template.common.view.AnimatedProgressBar;
	import com.moto.template.modules.gallery.GalleryPreview;
	import com.moto.template.common.view.components.loaders.ImageLoader;
	import com.moto.template.common.view.components.loaders.MediaLoader;
	import com.moto.template.shell.model.vo.ModuleItemVO;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import caurina.transitions.Tweener;

	public class GalleryPreviewImage extends GalleryPreview
	{
		private var _mask:MovieClip;
		private var _mask2:MovieClip;
		private var _image:ImageLoader;
		private var _image2:ImageLoader;
		private var _bg:MovieClip;
		private var _preloader:AnimatedProgressBar;
		private var _loaderInfo:LoaderInfo;
		private var _initialized:Boolean = false;
		
		public function GalleryPreviewImage() 
		{
			// Get slot elements
			_mask = getChildByName("imageMask") as MovieClip;
			_mask2 = getChildByName("imageMask2") as MovieClip;
			var holder:MovieClip = getChildByName("imageHolder") as MovieClip;
			var holder2:MovieClip = getChildByName("imageHolder2") as MovieClip;
			_image = holder.getChildByName("image") as ImageLoader;
			_image2 = holder2.getChildByName("image") as ImageLoader;
			_bg = getChildByName("bg") as MovieClip;
			_preloader = preloaderHolder.getChildByName("preloader") as AnimatedProgressBar;
			
			// Set mask
			holder.mask = _mask;
			holder2.mask = _mask2;
		}
		
		override public function init(data:ModuleItemVO):void
		{
			super.init(data);
			
			_loadImage(pathPrefix + data.getPropertyValueByID(1));
		}
		
		override public function change(data:ModuleItemVO):void
		{
			super.change(data);
			_preloader.show();
			Tweener.addTween(_preloader, { alpha:1 } );
			
			_loadImage(pathPrefix + data.getPropertyValueByID(1));
		}
		
		private function _loadImage(url:String):void
		{
			if (_loaderInfo)
			{
				_loaderInfo.removeEventListener(Event.COMPLETE, imageCompleteHandler);
				_loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, imageIOErrorHandler);
			}
			_loaderInfo = loadImage(url);
			_loaderInfo.addEventListener(Event.COMPLETE, imageCompleteHandler);
			_loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, imageIOErrorHandler);
		}
		
		override public function setSize(newWidth:Number, newHeight:Number):void
		{
			_bg.width = newWidth;
			_bg.height = newHeight;
			
			_mask.width = newWidth-2;
			_mask.height = newHeight - 2;
			
			_image.width = newWidth-2;
			_image.height = newHeight - 2;
			
			_mask2.width = newWidth-2;
			_mask2.height = newHeight - 2;
			
			_image2.width = newWidth-2;
			_image2.height = newHeight - 2;
			
			_preloader.x = (_bg.width - _preloader.width) / 2;
			_preloader.y = (_bg.height - _preloader.height) / 2;
		}
		
		private function imageCompleteHandler(event:Event):void
		{
			event.target.removeEventListener(Event.COMPLETE, imageCompleteHandler)
			if (!_initialized)
			{
				_initialized = true;
				setLoadedBitmap(_image);
				gotoAndPlay("show");
			} else {
				setLoadedBitmap(_image2);
				gotoAndPlay("change");
			}
			Tweener.addTween(_preloader, {alpha:0, onComplete:function():void { _preloader.hide() }});
		}
		
		private function imageIOErrorHandler(event:Event):void
		{
			trace("Image loading error");
		}
		
	}
}