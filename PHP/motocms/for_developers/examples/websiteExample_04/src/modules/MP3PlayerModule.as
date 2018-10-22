package modules 
{
	import caurina.transitions.properties.SoundShortcuts;
	import com.moto.template.common.utils.MotoUtils;
	import com.moto.template.shell.model.vo.ModuleItemVO;
	import com.moto.template.shell.model.vo.ModuleVO;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.modules.mediaPlayer.SimpleMusicPlayerModule;
	import caurina.transitions.Tweener;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * MP3 Player Module is simple music player module.
	 */
	public class MP3PlayerModule extends SimpleMusicPlayerModule
	{
		private var _button:MovieClip;
		
		private var _tf:TextField;
		
		public var soundLabel:String;
		
		public var onLabel:String;
		
		public var offLabel:String;
		
		public function MP3PlayerModule() 
		{			
			// Get elements
			_tf = TextField(getChildByName("tf"));
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_button = MovieClip(getChildByName("button"));
			_button.buttonMode = true;
			_button.addEventListener(MouseEvent.CLICK, buttonClickHandler);
			SoundShortcuts.init();
			// Add event listeners
			addEventListener(INITIALIZATION_ERROR, moduleInitializationErrorHandler);
		}
		
		override public function init(vo:MotoObjectVO):void
		{
			super.init(vo);
			
			_button.width = _tf.textWidth;
			_button.height = _tf.textHeight;
			
			// Turn off music in the limited mode
			if (limitedMode)
			{				
				_muteSound = true;
				Tweener.addTween(_soundChannel, {
					_sound_volume: 0,
					time: 0.1
				});
				switchLabel();
			}
		}
		
		/**
		 * Updates module and module elements appearance.
		 * 
		 * @param	property Property value object
		 */
		override public function updateProperty(property:PropertyVO):void
		{			
			switch (property.propertyType)
			{
				case 1:
				{
					// Update ON label
					switchLabel();
					break;
				}
				
				case 2:
				{
					// Update OFF label
					switchLabel();
					break;
				}
			}
		}
		
		override protected function initConfiguration():void 
		{
			super.initConfiguration();
			
			if (autoLoadAndPlay && !limitedMode)
			{
				_muteSound = false;
			}
			else
			{
				_muteSound = true;
			}
			switchLabel();
		}		
		
		override public function switchVolume():void
		{
			_muteSound = !_muteSound;
			switchLabel();
			Tweener.removeTweens(_soundChannel);
			if (_muteSound)
			{
				Tweener.addTween(_soundChannel, {
					_sound_volume: 0, onComplete:function ():void { pauseTrack() },
					time: 2
				});
			}
			else
			{
				if (!limitedMode && !isPlaying)
				{
					playTrack();
					Tweener.addTween(_soundChannel, {
						_sound_volume: 0,
						time: 0
					});
				}
				Tweener.addTween(_soundChannel, {
					_sound_volume: defaultVolume,
					delay: .2,
					time: 20
				});
			}
		}
		
		private function switchLabel():void
		{
			var labelPropertyVO:PropertyVO;
			if (!_muteSound)
			{
				labelPropertyVO = properties[1];
				MotoUtils.setHTMLTextFromPropertyVO(_tf, labelPropertyVO);
			}
			else
			{
				labelPropertyVO = properties[2];
				MotoUtils.setHTMLTextFromPropertyVO(_tf, labelPropertyVO);
			}
		}
		
		private function buttonClickHandler(event:MouseEvent):void
		{
			switchVolume();
		}
		
		/**
		 * We need to tell module which property represents track URL
		 * 
		 * @return String Track URL
		 */
		override protected function getCurrentTrackURL():String
        {
            var propertyVO:ModuleItemVO = getCurrentTrackData();
            if (propertyVO)
                return pathPrefix + propertyVO.getPropertyValueByID(1);
            else
                return "";
        }
		
		private function moduleInitializationErrorHandler(event:Event):void
		{
			// Error
		}
	}
}