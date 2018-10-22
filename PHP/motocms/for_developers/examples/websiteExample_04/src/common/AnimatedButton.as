package common 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.FrameLabel;
	
	public class AnimatedButton extends MovieClip
	{
		/**
		 * Click event handler function
		 */
		public var click:Function;
		
		/**
		 * Mouse Over event handler function
		 */
		public var mouseOver:Function;
		
		/**
		 * Mouse Out event handler function
		 */
		public var mouseOut:Function;
		
		/**
		 * Mouse Down event handler function
		 */
		public var mouseDown:Function;
		
		/**
		 * Mouse Up event handler function
		 */
		public var mouseUp:Function;
		
		/**
		 * Current state name
		 */
		private var _currentState:String = "";
		
		public function get currentState():String
		{
			return _currentState;
		}
		
		/**
		 * True is listeners were added
		 */
		private var _listenersAdded:Boolean = false;
		
		/**
		 * MovieClip label names collection
		 */
		private var _currentLabelNames:Array;
		
		public static const DOWN:String = "down";
		
		public static const UP:String = "up";
		
		public static const OVER:String = "over";
		
		public static const OUT:String = "out";
		
		public static const ENABLED:String = "enabled";
		
		public static const DISABLED:String = "disabled";
		
		public function AnimatedButton() 
		{
			super();
			
			buttonMode = true;
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);

			_currentLabelNames = [];
			for (var i:uint = 0; i < currentLabels.length; i++)
			{
				var frameLabel:FrameLabel = currentLabels[i];
				_currentLabelNames.push(frameLabel.name);
			}
		}
		
		public function addEventListeners():void
		{
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			addEventListener(MouseEvent.CLICK, mouseClickHandler);
			
			_listenersAdded = true;
		}
		
		public function removeEventListeners():void
		{
			removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			removeEventListener(MouseEvent.CLICK, mouseClickHandler);
			
			_listenersAdded = false;
		}
		
		public function enable():void
		{
			changeState(ENABLED);
		}
		
		public function disable():void
		{
			changeState(DISABLED);
		}
		
		protected function mouseClickHandler(event:MouseEvent):void
		{
			if (click != null)
				click.call(this, event);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			changeState(OVER);
			
			if (mouseOver != null)
				mouseOver.call(this, event);
		}
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			changeState(OUT);
			
			if (mouseOut != null)
				mouseOut.call(this, event);
		}
		
		protected function mouseDownHandler(event:MouseEvent):void
		{
			changeState(DOWN);
			
			if (mouseDown != null)
				mouseDown.call(this, event);
		}
		
		protected function mouseUpHandler(event:MouseEvent):void
		{
			changeState(UP);
			
			if (mouseUp != null)
				mouseUp.call(this, event);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			if (!_listenersAdded)
				addEventListeners();
		}
		
		private function removedFromStageHandler(event:Event):void
		{
			if (_listenersAdded)
				removeEventListeners();
		}
		
		private function changeState(stateLabel:String):void
		{
			if (_currentState != stateLabel &&
				_currentLabelNames.indexOf(stateLabel) != -1)
				gotoAndPlay(stateLabel);
		}
	}
}