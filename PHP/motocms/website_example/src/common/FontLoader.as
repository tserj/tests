package common 
{	
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class FontLoader extends EventDispatcher
	{
		private var _fontLoader:Loader;
		
		private var _fontName:String = "";
		
		public function get fontName():String
		{
			return _fontName;
		}
		
		private var _fontURL:String = "";
		
		public function get fontURL():String
		{
			return _fontURL;
		}
		
		private var _textFormat:TextFormat;
		
		public function get textFormat():TextFormat
		{
			return _textFormat;
		}
		
		public function FontLoader() 
		{
			
		}	
		
		public function load(fontURL:String):void
		{
			_fontURL = fontURL;
			
			_fontLoader = new Loader();
			
			_fontLoader.contentLoaderInfo.addEventListener(
				IOErrorEvent.IO_ERROR, fontLoaderErrorHandler);
			_fontLoader.contentLoaderInfo.addEventListener(
				ProgressEvent.PROGRESS, fontLoaderProgressHandler);
			_fontLoader.contentLoaderInfo.addEventListener(
				SecurityErrorEvent.SECURITY_ERROR, fontLoaderErrorHandler);
			_fontLoader.contentLoaderInfo.addEventListener(
				Event.COMPLETE, fontLoaderCompleteHandler);
			
			_fontLoader.load(new URLRequest(_fontURL), 
				new LoaderContext(false, new ApplicationDomain(null)));
		}
		
		private function fontLoaderErrorHandler(event:ErrorEvent):void
		{
			dispatchEvent(event);
		}
		
		private function fontLoaderProgressHandler(event:ProgressEvent):void
		{
			dispatchEvent(event);
		}
		
		private function fontLoaderCompleteHandler(event:Event):void
		{
			// Register font
			try
			{
				var motoFontInfoClass:Class =
					_fontLoader.contentLoaderInfo.applicationDomain.getDefinition("MotoFontInfo") as Class;
				if (motoFontInfoClass)
				{
					var definitionName:String = motoFontInfoClass.FONT_CLASS;
					var fontClass:Class =
						_fontLoader.contentLoaderInfo.applicationDomain.getDefinition(
							definitionName) as Class;
					for (var j:uint = 0; j < fontClass.classes.length; j++)
					{
						Font.registerFont(fontClass.classes[j]);
					}
					
					if (motoFontInfoClass.FONT_NAME)
						_fontName = motoFontInfoClass.FONT_NAME;
				}
				
				_textFormat = new TextFormat(_fontName);
				
				dispatchEvent(event);
			}
			catch (error:Error)
			{
				dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, error.message));
			}			
		}
	}
}