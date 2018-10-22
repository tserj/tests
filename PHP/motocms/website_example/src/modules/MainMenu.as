package modules
{
	import com.moto.template.common.Moto;
	import com.moto.template.common.events.ItemRendererEvent;
	import com.moto.template.common.events.MotoEvent;
	import com.moto.template.common.view.IItemRenderer;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.modules.menu.AbstractMenuItemRenderer;
	import com.moto.template.modules.menu.StaticMotoMenu;
	import com.moto.template.common.utils.MotoUtils;
	import com.google.analytics.core.EventInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import caurina.transitions.Tweener;

	import flash.display.MovieClip;

	public class MainMenu extends StaticMotoMenu
	{
		private var itemsPositions:Array = [-122, -61, 0, 61, 122];
		
		private var hideAnimationDelays:Array = [0.3, 0.25, 0.2, 0.31, 0.4];
		
		private var showAnimationDelays:Array = [0.1, 0.05, 0, 0.11, 0.2];
		
		private var _preview:MovieClip;

		public function MainMenu()
		{
			super();
			
			// Preview
			_preview = MovieClip(getChildByName("preview"));
			_preview.width = 777;
			_preview.height = 60;
			_preview.visible = false;
			
			// Set item renderer prefix
			itemRendererPrefix = "menuItemRenderer_";
			
			addEventListener(INITIALIZATION_ERROR, initializationErrorHandler);
			addEventListener(INITIALIZATION_COMPLETE, initializationCompleteHandler);
			
			if (Moto.getInstance().website)
				Moto.getInstance().eventDispatcher.addEventListener(MotoEvent.SWITCH_PAGE, motoSwitchPageHandler);
		}
		
		override public function getItemRendererSubMenuPoint(
			itemRenderer:AbstractMenuItemRenderer):Point
		{
			return new Point(itemRenderer.x, itemsPositions[itemRenderer.index] + 61);
		}
		
		override public function show():void
		{
			if (itemsArranger && itemsArranger.itemsCollection)
			{
				for (var i:uint = 0; i < itemsArranger.itemsCollection.length; i++)
				{
					var item:IItemRenderer = itemsArranger.itemsCollection[i] as IItemRenderer;
					Tweener.addTween(item.getInstance(), {
						y: Math.round(itemsPositions[i]),
						time: 1,
						transition: "easeOutExpo"
					});
					(item.getInstance() as MovieClip).play();
				}
			}
			
			mouseChildren = true;
			mouseEnabled = true;
		}
		
		override public function hide():void
		{
			if (itemsArranger && itemsArranger.itemsCollection)
			{
				for (var i:uint = 0; i < itemsArranger.itemsCollection.length; i++)
				{
					var item:AbstractMenuItemRenderer = 
						itemsArranger.itemsCollection[i] as AbstractMenuItemRenderer;
					MotoUtils.callFunctionWithDelay(item.hide, hideAnimationDelays[i]);
				}
			}
			
			mouseChildren = false;
			mouseEnabled = false;
		}
		
		public function recreate():void
		{
			if (itemsArranger && itemsArranger.itemsCollection)
			{
				for (var i:uint = 0; i < itemsArranger.itemsCollection.length; i++)
				{
					var item:AbstractMenuItemRenderer = itemsArranger.itemsCollection[i] as AbstractMenuItemRenderer;
					MotoUtils.callFunctionWithDelay(item.show, showAnimationDelays[
						itemsArranger.itemsCollection.length - 1 - i]);
				}
			}
			
			if (!limitedMode)
			{
				mouseChildren = true;
				mouseEnabled = true;
			}
		}
		
		override public function getDimensions():Rectangle
		{
			return new Rectangle(0, 0, 777, 60);
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
								y:Math.round( itemsPositions[i] + subMenuHolder.height + 1),
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
			if (subMenuHolder)
			{
				if (itemsArranger && itemsArranger.itemsCollection)
				{
					for (var i:uint = 0; i < itemsArranger.itemsCollection.length; i++)
					{
						var item:IItemRenderer = itemsArranger.itemsCollection[i] as IItemRenderer;
						if (item.index > subMenuItemRendererIndex)
						{
							Tweener.addTween(item.getInstance(), {
								y: Math.round(itemsPositions[i]),
								time: 1.5,
								transition: "easeInSin"
							});
						}
					}
				}
			}
			
			super.hideSubMenu(removeAllSubMenus);
		}
		
		private function initializationCompleteHandler(event:Event):void
		{
			/*
			if (!limitedMode)
				updateSelectedMenuButton(Moto.getInstance().currentPage);
			*/
			
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
		
		private function motoSwitchPageHandler(event:Event):void
		{
			/*
			if (!limitedMode)
				updateSelectedMenuButton(Moto.getInstance().currentPage);
			*/
		}
	}
}