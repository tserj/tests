package common
{
	import com.moto.template.common.view.AnimatedProgressBar;
	import flash.text.TextField;

	public class AppPreloader extends AnimatedProgressBar
	{		
		private var _tf:TextField;
		
		public function AppPreloader()
		{			
			_tf = getChildByName("tf") as TextField;
		}

		override public function setProgress(value:Number, total:Number):void
		{
			super.setProgress(value, total);
			
			// Update textfield
			_tf.text = percentLoaded + "%";
		}
	}
}
