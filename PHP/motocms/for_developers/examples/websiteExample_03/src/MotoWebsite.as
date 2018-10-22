package
{
	import com.moto.template.shell.MotoApplication;
	import com.moto.template.common.Moto;
	import com.moto.template.common.view.IAnimatedProgressBar;
	import com.moto.template.common.events.MotoEvent;
	import com.moto.template.common.events.MotoProgressEvent;

	import flash.display.MovieClip;

	/**
	 * Document class for the moto preloader file. Creates new moto
	 * application, shows preloading progress and start website
	 * animation when application is loaded.
	 */
	public class MotoWebsite extends MovieClip
	{		
		private var _preloader:IAnimatedProgressBar;
		
		public function MotoWebsite()
		{		
			stage.stageFocusRect = false;
			
			// Get elements
			_preloader = this.getChildByName(
				"websitePreloader") as IAnimatedProgressBar;
			
			// Create new MotoApplication and pass this as application holder
			var app:MotoApplication = new MotoApplication(this);
			
			// Listen to application progress message to update main preloader
			app.addEventListener(MotoProgressEvent.MOTO_PROGRESS,
				appProgressHandler);
			
			// Listen to application initialization complete event
			app.addEventListener(MotoEvent.INITIALIZATION_COMPLETE,
				appInitializationCompleteHandler);
		}
		
		private function appProgressHandler(event:MotoProgressEvent):void
		{			
			// Update progress bar
			if (_preloader)
				_preloader.setProgress(event.loaded, event.total);
		}
		
		private function appInitializationCompleteHandler(event:MotoEvent):void
		{			
			// Hide progress bar
			if (_preloader)
				_preloader.hide();
				
			// Show website
			Moto.getInstance().website.play();
		}
	}
}
