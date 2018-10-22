package modules
{
	import com.moto.template.common.events.ItemRendererEvent;
	import com.moto.template.common.view.IItemRenderer;
	import com.moto.template.common.Moto;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.modules.menu.AbstractMenuItemRenderer;
	import com.moto.template.modules.menu.DynamicMotoMenu;
	import com.moto.template.common.utils.MotoUtils;
	import com.moto.template.common.events.MotoEvent;
	import flash.geom.Rectangle;
	
	import caurina.transitions.Tweener;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	/**
	 * Main menu class. We extend DynamicMotoMenu for menus with dynamically 
	 * created items and StaticMotoMenu for static menu items.
	 */
	public class MainMenu extends DynamicMotoMenu
	{				
		public var splash:Boolean = false;
		
		public var startArray:Array = [];
		
		public var allowSubMenu:Boolean = false;
		
		public var submenuY:Number = 0;

		private var _menuHolder:MovieClip;
		
		/**
		 * Preview is used for the situation when you create an instance in the
		 * admin panel and there is no data yet or it is not initialized. We need
		 * to show menu preview.
		 */
		private var _preview:MovieClip;
		
		public function MainMenu()
		{
			super();
			
			// Get elements
			_menuHolder = getChildByName("menuHolder") as MovieClip;
			_preview = MovieClip(getChildByName("preview"));
			
			hideSubMenuOnMouseUp = true;
			startArray = [];
			subMenuRemoveDelay = 1;
			
			// Setup menu items arranger
			// Set item renderers holder
			itemsArranger.target = _menuHolder;
			itemsArranger.rows = 1;
			itemsArranger.horizontalSpacing = 20;
			itemsArranger.itemRendererCreationDelay = 0.12;
			itemsArranger.dynamicItemsDimensions = true;
			
			_preview.width = 400;
			_preview.height = 50;
			
			// Create listeners for complete and error module events
			addEventListener(INITIALIZATION_COMPLETE, initializationCompleteHandler);
			addEventListener(INITIALIZATION_ERROR, initializationErrorHandler);
		}
		
		override public function init(vo:MotoObjectVO):void 
		{
			super.init(vo);
			
			// Create listener for the switch page logic to switch menu buttons
			// We should check if Moto is created cause there is no Moto in the 
			// control panel
			if (!limitedMode)
				moto.eventDispatcher.addEventListener(MotoEvent.SWITCH_PAGE, motoSwitchPageHandler);
		}
		
		override public function dispose():void 
		{
			super.dispose();
			moto.eventDispatcher.removeEventListener(MotoEvent.SWITCH_PAGE, motoSwitchPageHandler);
		}
		
		/**
		 * @return Module dimensions
		 */
		override public function getDimensions():Rectangle
		{
			return new Rectangle(0, 0, 450, 30);
		};

		/**
		 * Override point location where drop down menu will be placed.
		 * 
		 * @param	itemRenderer Current item renderer.
		 * @return Point for the drop down menu placement.
		 */
		override public function getItemRendererSubMenuPoint(
			itemRenderer:AbstractMenuItemRenderer):Point
		{
			return new Point(itemRenderer.x + Math.round(itemRenderer.width / 2 - 67), 
				itemRenderer.y + 10);
		}	
		
		/**
		 * Shows sub menu.
		 * 
		 * @param	itemRenderer Selected menu item renderer.
		 */
		override public function showSubMenu(itemRenderer:AbstractMenuItemRenderer):void
		{		
			// Do not show submenu while animation is playing
			if (!limitedMode && !moto.animationIsPlaying && allowSubMenu)
				super.showSubMenu(itemRenderer)
		}

		override protected function itemClickHandler(event:ItemRendererEvent):void
        {
			// Do not allow clicks while animation is playing
			if (!limitedMode && !moto.animationIsPlaying)
				super.itemClickHandler(event);
		}
		
		private function initializationCompleteHandler(event:Event):void
		{
			// Switch menu button
			if (!limitedMode)
				updateSelectedMenuButton(moto.currentPage);
			
			// Hide preview
			_preview.visible = false;
			
			// Allow sub menu appearance only after initial menu animation
			MotoUtils.callFunctionWithDelay(function():void { 
				allowSubMenu = true; 
			}, _itemsArranger.numberOfItemRenderersDrawn * 0.15 + 2);
		}
				
		private function motoSwitchPageHandler(event:Event):void
		{
			// Change selected menu item if website page was switched.
			if (!limitedMode)
				updateSelectedMenuButton(moto.currentPage);
		}
		
		private function initializationErrorHandler(event:Event):void
		{
			// Remove item arranger items if there are any
			itemsArranger.removeItems();
			
			// Show preview in the control panel
			if (limitedMode)
				_preview.visible = true;
		}
	}
}