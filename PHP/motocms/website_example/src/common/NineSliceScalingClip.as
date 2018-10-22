package common
{
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	
	public class NineSliceScalingClip extends MovieClip
	{
		private var _slices:Array = new Array();
		private var _allow9SliceScaling:Boolean = true;
		
		public static const SLICE_PREFIX:String = "slice_";
		
		public function NineSliceScalingClip()
		{
			for (var i:uint = 0; i < 9; i++)
			{
				var slice:MovieClip = getChildByName(SLICE_PREFIX + String(i + 1))
					as MovieClip;
				if (slice)
				{
					_slices.push(slice);
				}
				else
				{
					_allow9SliceScaling = false;
					break;
				}
			}
		}
		
		override public function set width(value:Number):void
		{
			if (_allow9SliceScaling)
				resize(value, height);
			else
				super.width = value;
		}
		
		override public function set height(value:Number):void
		{
			if (_allow9SliceScaling)
				resize(width, value);
			else
				super.height = value;
		}
		
		public function resize(w:Number, h:Number):void
		{				
			// Set equal slices width by columns
			_slices[0].width = _slices[3].width = _slices[6].width =
				Math.max(_slices[0].width, _slices[3].width, _slices[6].width);
			_slices[1].width = _slices[4].width = _slices[7].width =
				Math.max(_slices[1].width, _slices[4].width, _slices[7].width);
			_slices[2].width = _slices[5].width = _slices[8].width =
				Math.max(_slices[2].width, _slices[5].width, _slices[8].width);
			
			// Set equal slices height by rows
			_slices[0].height = _slices[1].height = _slices[2].height =
				Math.max(_slices[0].height, _slices[1].height, _slices[2].height);
			_slices[3].height = _slices[4].height = _slices[5].height =
				Math.max(_slices[3].height, _slices[4].height, _slices[5].height);
			_slices[6].height = _slices[7].height = _slices[8].height =
				Math.max(_slices[6].height, _slices[7].height, _slices[8].height);
			
			// Get 9 slice scaling rectangle
			var scale9Rect:Rectangle = new Rectangle(_slices[0].x + _slices[0].width,
				_slices[0].y + _slices[0].height, w - _slices[0].width - _slices[2].width,
				h - _slices[0].height - _slices[6].height); 
			
			// Position slices
			_slices[1].x = _slices[4].x = _slices[7].x = scale9Rect.x;
			_slices[3].y = _slices[4].y = _slices[5].y = scale9Rect.y;
			_slices[1].width = _slices[4].width = _slices[7].width = scale9Rect.width;
			_slices[3].height = _slices[4].height = _slices[5].height = scale9Rect.height;
			_slices[2].x = _slices[5].x = _slices[8].x = scale9Rect.right;
			_slices[6].y = _slices[7].y = _slices[8].y = scale9Rect.bottom;
		}
	}
}