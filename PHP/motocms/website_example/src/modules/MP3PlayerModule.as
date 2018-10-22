package modules 
{
	import com.moto.template.common.utils.MotoUtils;
	import com.moto.template.modules.mediaPlayer.SimpleMusicPlayerModule;
	import com.moto.template.shell.model.vo.ModuleItemVO;
	import com.moto.template.shell.model.vo.ModuleVO;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.shell.model.vo.PropertyVO;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import caurina.transitions.Tweener;
	import flash.text.TextFieldAutoSize;
	
	public class MP3PlayerModule extends SimpleMusicPlayerModule
	{
		private var _button:MovieClip;
		private var _tf:TextField;
		
		public var soundLabel:String;
		public var onLabel:String;
		public var offLabel:String;
		
		public function MP3PlayerModule() 
		{			
			_tf = TextField(getChildByName("tf"));
			_tf.autoSize = TextFieldAutoSize.LEFT;
			
			_button = MovieClip(getChildByName("button"));
			_button.buttonMode = true;
			_button.addEventListener(MouseEvent.CLICK, buttonClickHandler);
			
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
					time: 0
				});
			}
		}
		
		override public function updateProperty(property:PropertyVO):void
		{			
			super.updateProperty(property);
			switch (property.propertyType)
			{
				case 1:
				{
					switchLabel();
				}
				
				case 2:
				{
					switchLabel();
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
		
		private function buttonClickHandler(event:MouseEvent):void
		{
			switchVolume();
		}
		
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
	}
}