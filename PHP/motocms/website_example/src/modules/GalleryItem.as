package modules
{
	import com.moto.template.common.view.AnimatedProgressBar;
	import com.moto.template.modules.gallery.GalleryThumbnail;
	import com.moto.template.common.view.components.loaders.ImageLoader;
	import com.moto.template.common.view.components.loaders.MediaLoader;
	import com.moto.template.shell.model.vo.ModuleItemVO;
	import flash.events.Event;
	import flash.display.MovieClip;
	import caurina.transitions.Tweener;
	import flash.events.IOErrorEvent;
	import com.moto.template.common.events.MediaLoaderErrorEvent;
	
	public class GalleryItem extends GalleryThumbnail
	{
		private var _mask:MovieClip;
		
		private var _image:ImageLoader;
		
		private var _bg:MovieClip;
		
		private var _preloader:AnimatedProgressBar;
		
		public function GalleryItem() 
		{
			super();
			
			buttonMode = true;
			
			// Get slot elements
			_mask = getChildByName("imageMask") as MovieClip;
			var holder:MovieClip = getChildByName("imageHolder") as MovieClip;
			_image = holder.getChildByName("image") as ImageLoader;
			_bg = getChildByName("bg") as MovieClip;
			_preloader = preloaderHolder.getChildByName("preloader") as AnimatedProgressBar;
			
			// Set mask
			holder.mask = _mask;
		}
		
		override public function updateRenderer(data:Object):void
		{
			super.updateRenderer(data);
			var dataVO:ModuleItemVO = ModuleItemVO(data);
			_image.addEventListener(Event.COMPLETE, imageCompleteHandler);
			_image.addEventListener(IOErrorEvent.IO_ERROR, imageIOErrorHandler);
			_image.addEventListener(MediaLoaderErrorEvent.ERROR, imageIOErrorHandler);
			_image.source = pathPrefix + String(dataVO.getPropertyValueByID(2));
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
		
		private function imageCompleteHandler(event:Event):void
		{
			// createEventListeners();
			Tweener.addTween(_preloader, {alpha:0, onComplete:function():void { _preloader.hide() }});
			show();
		}
		
		private function imageIOErrorHandler(event:Event):void
		{
			trace("Image loading error");
		}
	}
}