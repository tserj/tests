package
{
	import com.moto.template.shell.MotoApplication;
	import com.moto.template.common.Moto;
	import com.moto.template.common.view.IAnimatedProgressBar;
	import com.moto.template.common.events.MotoEvent;
	import com.moto.template.common.events.MotoProgressEvent;

	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	public class MotoWebsite extends MovieClip
	{		
		private var _preloader:IAnimatedProgressBar;
		
		public function MotoWebsite()
		{			
			// Configure stage
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP
			stage.stageFocusRect = false;
			
			_preloader = appPreloader as IAnimatedProgressBar;
			
			// Create new Moto application
			var app:MotoApplication = new MotoApplication(this);
			
			// Event listeners
			app.addEventListener(MotoProgressEvent.MOTO_PROGRESS,
				appProgressHandler);
			app.addEventListener(MotoEvent.INITIALIZATION_COMPLETE,
				appInitializationCompleteHandler);
		}
		
		private function appProgressHandler(event:MotoProgressEvent):void
		{
			// Update application progress bar
			if (_preloader)
				_preloader.setProgress(event.loaded, event.total);
		}
		
		private function appInitializationCompleteHandler(event:MotoEvent):void
		{			
			// Hide application preloader
			gotoAndPlay("hide");
		}
		
		public function showWebsite():void
		{
			// Show website
			Moto.getInstance().website.play();
		}
	}
}
