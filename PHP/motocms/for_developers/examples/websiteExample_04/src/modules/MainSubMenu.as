package modules 
{
	import com.moto.template.common.events.ItemRendererEvent;
	import com.moto.template.common.Moto;
	import com.moto.template.modules.menu.AbstractMenuItemRenderer;
	import com.moto.template.modules.menu.DynamicMotoMenu;
	import flash.events.Event;
	import flash.geom.Point;

	import flash.display.MovieClip;
	
	/**
	 * Main Sub menu class. We extend DynamicMotoMenu for menus with dynamically 
	 * created items and StaticMotoMenu for static menu items.
	 */
	public class MainSubMenu extends DynamicMotoMenu 
	{		
		private var _line:MovieClip;
		
		private var _isHiding:Boolean = false;
		
		private var _bg:MovieClip;
		
		public function MainSubMenu() 
		{
			super();
			
			// Get elements
			_bg = bg.getChildByName("clip") as MovieClip;
			
			// Set sub menu remove delay
			subMenuRemoveDelay = 1;
			
			// Configure items arranger
			itemsArranger.target = itemsHolder;
			itemsArranger.columns = 1;
			itemsArranger.verticalSpacing = 0;
			
			addEventListener(INITIALIZATION_COMPLETE, initializationCompleteHandler);
		}
		
		private function initializationCompleteHandler(event:Event):void
		{			
			// Change background height according to the number of items created
			if (parentMenu)
				_bg.height = parentMenu.currentOpenedSubMenu.itemsArranger.numberOfItemRenderersDrawn * 26 + 16;
				
			if (!limitedMode)
				updateSelectedMenuButton(Moto.getInstance().currentPage);
		}
		
		override public function hide():void
		{			
			if (!_isHiding)
			{
				_isHiding = true;
				super.hide();
				gotoAndPlay("hide");
			}
		}
		
		/**
		 * Override point location where drop down menu will be placed.
		 * 
		 * @param	itemRenderer Current item renderer.
		 * @return Point for the drop down menu placement.
		 */
		override public function getItemRendererSubMenuPoint(
			itemRenderer:AbstractMenuItemRenderer):Point
		{
			return new Point(itemRenderer.x + 141, itemRenderer.y + 5);
		}
		
		override protected function itemClickHandler(event:ItemRendererEvent):void
        {
			// Do not allow clicks while animation is playing
			if (!limitedMode && !Moto.getInstance().animationIsPlaying)
				super.itemClickHandler(event);
		}
	}
}