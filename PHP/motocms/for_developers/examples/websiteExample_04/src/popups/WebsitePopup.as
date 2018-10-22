package popups 
{
	import com.moto.template.common.view.AdvancedScrollbar;
	import com.moto.template.shell.model.vo.PopupVO;
	import com.moto.template.shell.view.components.AbstractMotoPopup;
	import com.moto.template.common.Moto;
	import com.moto.template.common.utils.MotoUtils;
	import com.moto.template.common.events.MotoEvent;
	
	import flash.geom.Point;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * Website popup class. We need to extend AbstractMotoPopup to create custom popup.
	 */
	public class WebsitePopup extends AbstractMotoPopup
	{				
		private var _popupHolder:MovieClip;
		
		private var _dragArea:MovieClip;
		
		private var _isDragging:Boolean = false;
		
		public function WebsitePopup()
		{
			super();
			
			// Get elements
			_popupHolder = getChildByName("popupHolder") as MovieClip;
			// Popup drag area
			_dragArea = _popupHolder.getChildByName("dragArea") as MovieClip;
			_dragArea.buttonMode = true;
			// Hit area for close button
			var _area:MovieClip = _popupHolder.closeButton.getChildByName("area");
			// Close button
			closeButton = _popupHolder.getChildByName("closeButton") as MovieClip;;
			closeButton.mouseChildren = false;
			closeButton.hitArea = _area;
			// Roll over and roll out animation
			closeButton.addEventListener(MouseEvent.ROLL_OVER, closeButtonRollOverHandler);
			closeButton.addEventListener(MouseEvent.ROLL_OUT, closeButtonRollOutHandler);
			
			// Listen to added to stage event to create popup drag and drop logic
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		/**
		 * Overrides popup hide function. There is removePopup() by default but we need
		 * to animate popup before removing and remove our event listeners. So we play
		 * animation and call removePopup() function in the last frame of popup animation.
		 */
		override public function hide():void
		{
			// Remove event listeners
			_dragArea.removeEventListener(MouseEvent.MOUSE_DOWN, dragAreaMouseDownHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);
			closeButton.removeEventListener(MouseEvent.ROLL_OVER, closeButtonRollOverHandler);
			closeButton.removeEventListener(MouseEvent.ROLL_OUT, closeButtonRollOutHandler);
			
			// Hide popup and then remove it
			gotoAndPlay("hide");
			_popupHolder.gotoAndPlay("hide");
			_popupHolder.closeButton.gotoAndPlay("hide");
		}
		
		private function addedToStageHandler(event:Event):void
		{
			// Add event listeners
			_dragArea.addEventListener(MouseEvent.MOUSE_DOWN, dragAreaMouseDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);
		}
		
		private function dragAreaMouseDownHandler(event:MouseEvent):void
		{
			if (!_isDragging)
			{
				// Start drag
				_isDragging = true;
				_popupHolder.startDrag();
				
				// Listen to stage mouse move to lock popup drag area
				stage.addEventListener(MouseEvent.MOUSE_MOVE, stageMouseMoveHandler);
			}
		}
		
		private function stageMouseUpHandler(event:MouseEvent):void
		{
			// Stop drag and remove stage mouse move listener
			_isDragging = false;
			_popupHolder.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMoveHandler);
		}
			
		private function closeButtonRollOverHandler(event:MouseEvent):void
		{
			MovieClip(closeButton).gotoAndPlay("over");
		}
		
		private function closeButtonRollOutHandler(event:MouseEvent):void
		{
			MovieClip(closeButton).gotoAndPlay("out");
		}
		
		private function stageMouseMoveHandler(event:MouseEvent):void
		{
			var globalPopupHolderPoint:Point = localToGlobal(new Point(
				_popupHolder.x, _popupHolder.y));
			var targetPopupHolderPoint:Point;	
			if (globalPopupHolderPoint.x < 0)
				targetPopupHolderPoint = new Point(0, globalPopupHolderPoint.y);
			else if (globalPopupHolderPoint.y < 0)
				targetPopupHolderPoint = new Point(globalPopupHolderPoint.x, 0);
			else if (globalPopupHolderPoint.x + _dragArea.width > stage.stageWidth)
				targetPopupHolderPoint = new Point(stage.stageWidth - 
					_dragArea.width, globalPopupHolderPoint.y);
			else if (globalPopupHolderPoint.y + _dragArea.height > stage.stageHeight)
				targetPopupHolderPoint = new Point(globalPopupHolderPoint.x, 
					stage.stageHeight - _dragArea.height);
			
			if (targetPopupHolderPoint)
			{
				targetPopupHolderPoint = globalToLocal(targetPopupHolderPoint);
				_popupHolder.x = targetPopupHolderPoint.x;
				_popupHolder.y = targetPopupHolderPoint.y;
			}
		}
	}	
}