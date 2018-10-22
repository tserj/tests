package modules 
{
	import com.moto.template.common.events.ItemRendererEvent;
	import com.moto.template.common.events.PageChangeEvent;
	import com.moto.template.common.view.AlignModeEnum;
	import com.moto.template.common.view.IItemRenderer;
	import com.moto.template.shell.model.vo.ModuleItemVO;
	import com.moto.template.shell.model.vo.ModuleVO;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.modules.gallery.SimpleGalleryModule;
	import com.moto.template.common.tools.MotoArranger;
	
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.DisplayObject;
	
	/**
	 * Gallery module class.
	 */
	public class GalleryModule extends SimpleGalleryModule
	{		
		public var thumbnailWidth:Number;
		
		public var thumbnailHeight:Number;
		
		private var _galleryPreview:GalleryPreviewImage;
		
		private var _firstButton:MovieClip;
		
		private var _previousButton:MovieClip;
		
		private var _nextButton:MovieClip;
		
		private var _lastButton:MovieClip;
		
		private var _boundsRectangle:MovieClip;
		
		private var _selectedItemRenderer:IItemRenderer;
		
		private var _preview:MovieClip;
		
		private var _preloader:MovieClip;
		
		private var _startIndex:uint = 0;
		
		public function GalleryModule() 
		{
			super();
			
			// Get components
			_galleryPreview = GalleryPreviewImage(getChildByName("galleryPreview"));
			_firstButton = MovieClip(getChildByName("firstButton"));
			_firstButton.buttonMode = true;
			_previousButton = MovieClip(getChildByName("previousButton"));
			_previousButton.buttonMode = true;
			_nextButton = MovieClip(getChildByName("nextButton"));
			_nextButton.buttonMode = true;
			_lastButton = MovieClip(getChildByName("lastButton"));
			_lastButton.buttonMode = true;
			_boundsRectangle = MovieClip(getChildByName("boundsRectangle"));
			_preview = MovieClip(getChildByName("preview"));
			_preview.visible = false;
			_preloader = MovieClip(getChildByName("preloader"));
			
			// Add event listeners
			this.addEventListener(INITIALIZATION_COMPLETE, moduleInitializationCompleteHandler);
			this.addEventListener(INITIALIZATION_PROGRESS, moduleInitializationProgressHandler);
			this.addEventListener(INITIALIZATION_ERROR, moduleInitializationErrorHandler);
		}
		
		override public function init(vo:MotoObjectVO):void
		{
			_preloader.visible = true;
			_preview.visible = false;
			
			super.init(vo);
			
			_galleryPreview.pathPrefix = pathPrefix;
			
			// Configure Arranger
			thumbnailsArranger.horizontalAlign = AlignModeEnum.CENTER;
			thumbnailsArranger.verticalAlign = AlignModeEnum.MIDDLE;
			
			// Configure Paginator
			thumbnailsPaginator.nextButton = _nextButton;
			thumbnailsPaginator.previousButton = _previousButton;
			thumbnailsPaginator.firstButton = _firstButton;
			thumbnailsPaginator.lastButton = _lastButton;		
		}
		
		/**
		 * Override setSize function to resize our module and its elements properly.
		 * 
		 * @param	newWidth New slot width
		 * @param	newHeight New slot height
		 */
		override public function setSize(newWidth:Number, newHeight:Number):void
		{
			// Size restriction
			if (newWidth < 100)
				newWidth = 100;
				
			if (newHeight < 100)
				newHeight = 100;
			super.setSize(newWidth, newHeight);
			_boundsRectangle.width = newWidth;
			_boundsRectangle.height = newHeight;
			
			// Preview
			var previewHeight:Number = newHeight * 2 / 3;
			_galleryPreview.setSize(newWidth, previewHeight);
			
			thumbnailsArranger.maxWidth = newWidth;
			thumbnailsArranger.itemWidth = newHeight - previewHeight - 11 - 20;
			thumbnailsArranger.itemHeight = thumbnailsArranger.itemWidth;
			
			thumbnailsPaginator.itemsPerPage = Math.floor(newWidth / thumbnailsArranger.itemWidth);
			thumbnailsArranger.horizontalSpacing = (newWidth - thumbnailsPaginator.itemsPerPage *
				thumbnailsArranger.itemWidth) / (thumbnailsPaginator.itemsPerPage - 1);
				
			thumbnailsArranger.rows = 1;
			
			// Thumbnails
			if (thumbnailsHolder)
			{
				thumbnailsHolder.x = 0;
				thumbnailsHolder.y = previewHeight + 10;
			}
			
			// Button controls
			_firstButton.y = _previousButton.y = _nextButton.y =
				_lastButton.y = newHeight - 11;
			_firstButton.x = 10;
			_previousButton.x = _firstButton.x + _firstButton.width + 10;
			_lastButton.x = newWidth - _lastButton.width - 10;
			_nextButton.x = _lastButton.x - _nextButton.width - 10;
			
			// Preview
			_preview.width = newWidth;
			_preview.height = newHeight;
			
			// Center preloader
			_preloader.x = (newWidth - _preloader.width) / 2;
			_preloader.y = (newHeight - _preloader.height) / 2;
		}
		
		override public function getDimensions():Rectangle
		{
			return new Rectangle(0, 0, _boundsRectangle.width, _boundsRectangle.height);
		}
		
		override protected function thumbnailClickHandler(event:ItemRendererEvent):void
		{
			// Change gallery preview on thumbnail click
			if (_galleryPreview && event.itemRenderer != _selectedItemRenderer)
			{
				_selectedItemRenderer = event.itemRenderer;
				_galleryPreview.change(event.data as ModuleItemVO);
			}
		}
		
		override protected function thumbnailsPaginatorChangeHandler(event:PageChangeEvent):void {
			super.thumbnailsPaginatorChangeHandler(event);
			thumbnailsArranger.selectItemRendererByIndex(_selectedItemRenderer.index, false);
		}
		
		private function moduleInitializationCompleteHandler(event:Event):void
		{		
			// Hide progress bar
			_preloader.visible = false;
			
			setSize(vo.width, vo.height);			
			
			if (_galleryPreview && galleryDataProvider && galleryDataProvider[_startIndex])
			{
				_galleryPreview.init(galleryDataProvider[_startIndex]);
				thumbnailsArranger.selectItemRendererByIndex(_startIndex, false);
			}
		}
		
		private function moduleInitializationProgressHandler(event:Event):void
		{
			// Update progress bar
		}
		
		private function moduleInitializationErrorHandler(event:Event):void
		{
			_preloader.visible = false;
		}	
	}
}