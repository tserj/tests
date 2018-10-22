package modules
{
	import com.moto.template.common.events.ItemRendererEvent;
	import com.moto.template.common.events.MotoEvent;
	import com.moto.template.common.view.IItemRenderer;
	import com.moto.template.common.Moto;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.modules.menu.AbstractMenuItemRenderer;
	import com.moto.template.modules.menu.StaticMotoMenu
	import caurina.transitions.Tweener;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import flash.display.MovieClip;

	public class RightMenu extends StaticMotoMenu
	{
		private var itemsPositions:Array = [ -122, -61, 0, 61, 122];
		
		private var _preview:MovieClip;
		
		public function RightMenu()
		{
			super();
			
			// Preview
			_preview = MovieClip(getChildByName("preview"));
			_preview.width = 129;
			_preview.height = 60;
			_preview.visible = false;
			
			// Set item renderer prefix
			itemRendererPrefix = "menuItemRenderer_";
			
			addEventListener(INITIALIZATION_ERROR, initializationErrorHandler);
			addEventListener(INITIALIZATION_COMPLETE, initializationCompleteHandler);
		}
		
		override public function init(vo:MotoObjectVO):void 
		{
			super.init(vo);
			
			if (!limitedMode)
				Moto.getInstance().eventDispatcher.addEventListener(MotoEvent.SWITCH_PAGE, motoSwitchPageHandler);
		}
		
		override public function getItemRendererSubMenuPoint(
			itemRenderer:AbstractMenuItemRenderer):Point
		{
			return new Point(itemRenderer.x, itemsPositions[itemRenderer.index] + 61);
		}
		
		override public function hide():void
		{
			for (var i:uint = 0; i < itemsArranger.itemsCollection.length; i++)
			{
				var item:AbstractMenuItemRenderer = 
					itemsArranger.itemsCollection[i] as AbstractMenuItemRenderer;
				item.hide();
			}
		}
		
		override public function getDimensions():Rectangle
		{
			return new Rectangle(0, 0, 129, 60);
		}
		
		public function get subMenuHolder():Sprite
		{
			if (currentOpenedSubMenu)
				return currentOpenedSubMenu.parent as Sprite;
			else
				return null;
		}
		
		override protected function itemClickHandler(event:ItemRendererEvent):void
        {
			if (!Moto.getInstance().animationIsPlaying)
				super.itemClickHandler(event);
		}
		
		override public function showSubMenu(itemRenderer:AbstractMenuItemRenderer):void
		{
			if (!Moto.getInstance().animationIsPlaying)
			{
				super.showSubMenu(itemRenderer);
				
				if (subMenuHolder && subMenuHolder.parent)
				{
					// Move sub menu to the back
					getSubMenuTargetHolder().setChildIndex(subMenuHolder, 0);
				
					// Move main menu items
					for (var i:uint = 0; i < itemsArranger.itemsCollection.length; i++)
					{
						var item:IItemRenderer = itemsArranger.itemsCollection[i] as IItemRenderer;
						if (item.index > subMenuItemRendererIndex && subMenuHolder.height > 0)
						{
							Tweener.addTween(item.getInstance(), {
								y: itemsPositions[i] + subMenuHolder.height + 1,
								time: 1.5,
								transition: "easeOutSin"
							});
						}
					}
				}
			}
		}
		
		override public function hideSubMenu(removeAllSubMenus:Boolean = false):void
		{			
			// Move main menu items
			if (subMenuHolder)
			{
				for (var i:uint = 0; i < itemsArranger.itemsCollection.length; i++)
				{
					var item:IItemRenderer = itemsArranger.itemsCollection[i] as IItemRenderer;
					if (item.index > subMenuItemRendererIndex)
					{
						Tweener.addTween(item.getInstance(), {
							y: itemsPositions[i],
							time: 1.5,
							transition: "easeInSin"
						});
					}
				}
			}
			
			super.hideSubMenu(removeAllSubMenus);
		}
		
		private function motoSwitchPageHandler(event:Event):void
		{
			if (!limitedMode)
				updateSelectedMenuButton(Moto.getInstance().currentPage);
		}
		
		private function initializationCompleteHandler(event:Event):void
		{
			if (!limitedMode)
				updateSelectedMenuButton(Moto.getInstance().currentPage);
		
			
			if (limitedMode)
			{
				_preview.visible = (menuItemsData && 
					menuItemsData.length > 0) ? false : true;
			}
		}
		
		private function initializationErrorHandler(event:Event):void
		{
			itemsArranger.removeItems();
			if (limitedMode)
				_preview.visible = true;
		}
	}
}