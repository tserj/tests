package modules
{
	import com.moto.template.modules.gallery.GalleryThumbnail;
	import com.moto.template.common.view.components.loaders.ImageLoader;
	import com.moto.template.shell.model.vo.ModuleItemVO;
	
	import flash.events.Event;
	import flash.display.MovieClip;
	import caurina.transitions.Tweener;
	import flash.events.IOErrorEvent;
	
	/**
	 * Gallery item class.
	 */
	public class GalleryItem extends GalleryThumbnail
	{
		private var _mask:MovieClip;
		
		private var _image:ImageLoader;
		
		private var _bg:MovieClip;
		
		private var _preloader:MovieClip;
		
		public function GalleryItem() 
		{
			super();
			
			buttonMode = true;
			
			// Get elements
			_mask = getChildByName("imageMask") as MovieClip;
			var holder:MovieClip = getChildByName("imageHolder") as MovieClip;
			_image = holder.getChildByName("image") as ImageLoader;
			_bg = getChildByName("bg") as MovieClip;
			_preloader = getChildByName("preloader") as MovieClip;
			
			// Set mask
			holder.mask = _mask;
		}
		
		override public function updateRenderer(data:Object):void
		{
			super.updateRenderer(data);
			var dataVO:ModuleItemVO = data as ModuleItemVO;
			// Update item renderer image
			_image.addEventListener(Event.COMPLETE, imageCompleteHandler);
			_image.addEventListener(IOErrorEvent.IO_ERROR, imageIOErrorHandler);
			_image.source = pathPrefix + dataVO.getPropertyValueByID(2);
		}
		
		/**
		 * Resize item renderer elements
		 * 
		 * @param	newWidth New item width
		 * @param	newHeight New item height
		 */
		override public function setSize(newWidth:Number, newHeight:Number):void
		{
			_bg.width = newWidth;
			_bg.height = newHeight;
			
			_mask.width = newWidth-2;
			_mask.height = newHeight - 2;
			
			_image.width = newWidth-2;
			_image.height = newHeight - 2;
			
			_preloader.x = (_bg.width - _preloader.width) / 2;
			_preloader.y = (_bg.height - _preloader.height) / 2;
		}
		
		private function imageCompleteHandler(event:Event):void
		{
			// Hide preloader and show image on complete
			Tweener.addTween(_preloader, {alpha:0});
			show();
		}
		
		private function imageIOErrorHandler(event:IOErrorEvent):void
		{
			trace("Image loading error");
		}
	}
}