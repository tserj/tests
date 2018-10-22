package modules 
{
	import com.moto.template.common.Moto;
	import com.moto.template.modules.menu.DynamicMotoMenu;
	import flash.events.Event;
	
	public class MainSubMenu extends DynamicMotoMenu
	{
		public function MainSubMenu()
		{
			itemsArranger.columns = 1;
			itemsArranger.verticalSpacing = 1;
			
			addEventListener(INITIALIZATION_COMPLETE, initializationCompleteHandler);
		}
		
		private function initializationCompleteHandler(event:Event):void
		{
			/*
			if (!limitedMode)
				updateSelectedMenuButton(Moto.getInstance().currentPage);
			*/
		}
	}	
}