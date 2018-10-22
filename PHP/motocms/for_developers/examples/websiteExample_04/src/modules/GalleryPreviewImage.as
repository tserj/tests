package modules 
{
	import com.moto.template.modules.gallery.GalleryPreview;
	import com.moto.template.common.view.components.loaders.ImageLoader;
	import caurina.transitions.Tweener;
	import com.moto.template.shell.model.vo.ModuleItemVO;
	import flash.display.LoaderInfo;
	
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * Gallery preview class
	 */
	public class GalleryPreviewImage extends GalleryPreview
	{
		private var _mask:MovieClip;
		
		private var _mask2:MovieClip;
		
		private var _image:ImageLoader;
		
		private var _image2:ImageLoader;
		
		private var _bg:MovieClip;
		
		private var _preloader:MovieClip;
		
		private var _initialized:Boolean = false;
		
		private var _loaderInfo:LoaderInfo;
		
		public function GalleryPreviewImage() 
		{
			// Get elements
			_mask = getChildByName("imageMask") as MovieClip;
			_mask2 = getChildByName("imageMask2") as MovieClip;
			var holder:MovieClip = getChildByName("imageHolder") as MovieClip;
			var holder2:MovieClip = getChildByName("imageHolder2") as MovieClip;
			_image = holder.getChildByName("image") as ImageLoader;
			_image2 = holder2.getChildByName("image") as ImageLoader;
			_bg = getChildByName("bg") as MovieClip;
			_preloader = getChildByName("preloader") as MovieClip;
			
			/*// Set up the first image
			_image.addEventListener(Event.COMPLETE, imageCompleteHandler);
			
			// Set up the second image
			_image2.addEventListener(Event.COMPLETE, image2CompleteHandler);*/
			
			// Set masks
			holder.mask = _mask;
			holder2.mask = _mask2;
		}
		
		override public function init(data:ModuleItemVO):void 
		{
			super.init(data);
			
			// Set first image source after initialization
			// We should use pathPrefix for file paths
			if (_loaderInfo)
				_loaderInfo.removeEventListener(Event.COMPLETE, imageCompleteHandler);
			_loaderInfo = loadImage(pathPrefix + data.getPropertyValueByID(1));
			_loaderInfo.addEventListener(Event.COMPLETE, imageCompleteHandler);
		}
		
		override public function change(data:ModuleItemVO):void 
		{
			super.change(data);
			
			// Show preloader
			Tweener.addTween(_preloader, { alpha:1 } );
			
			// Load image to the second loader
			if (_loaderInfo)
				_loaderInfo.removeEventListener(Event.COMPLETE, imageCompleteHandler);
			_loaderInfo = loadImage(pathPrefix + data.getPropertyValueByID(1));
			_loaderInfo.addEventListener(Event.COMPLETE, imageCompleteHandler);
		}
		
		/**
		 * Override setSize function to resize our preview and its elements properly.
		 * 
		 * @param	newWidth New slot width
		 * @param	newHeight New slot height
		 */
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
			} 
			else 
			{
				setLoadedBitmap(_image2);
				gotoAndPlay("change");
			}
			//Tweener.addTween(_preloader, {alpha:0, onComplete:function():void { _preloader.hide() }});
		}
		
	}
}