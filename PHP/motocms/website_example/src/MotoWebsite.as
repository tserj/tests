package
{
	import com.moto.template.shell.MotoApplication;
	import com.moto.template.common.Moto;
	import com.moto.template.common.view.IAnimatedProgressBar;
	import com.moto.template.common.events.MotoEvent;
	import com.moto.template.common.events.MotoProgressEvent;
	
	import common.FontLoader;
	
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;

	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	public class MotoWebsite extends MovieClip
	{		
		private var _preloader:IAnimatedProgressBar;
		
		private var _preloaderTextfield:TextField;
		
		public function MotoWebsite()
		{			
			// Configure stage
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.stageFocusRect = false;
			
			// View components
			_preloader = this.getChildByName(
				"websitePreloader") as IAnimatedProgressBar;
				
			_preloaderTextfield = MovieClip(_preloader).textHolder.tf;
			
			// Create new Moto Application
			var app:MotoApplication = new MotoApplication(this);
			
			app.addEventListener(MotoProgressEvent.MOTO_PROGRESS,
				appProgressHandler);
			app.addEventListener(MotoEvent.INITIALIZATION_COMPLETE,
				appInitializationCompleteHandler);
		}
		
		private function appProgressHandler(event:MotoProgressEvent):void
		{			
			// Update progress bar
			if (_preloader)
			{
				_preloader.setProgress(event.loaded, event.total);
				
				_preloaderTextfield.text = _preloader.percentLoaded + "%";
				_preloaderTextfield.x = - Math.round(_preloaderTextfield.textWidth / 2);
			}
		}
		
		private function appInitializationCompleteHandler(event:MotoEvent):void
		{		
			if (_preloader)
				_preloader.hide();
			
			// Show website
			Moto.getInstance().website.play();
		}
	}
}
