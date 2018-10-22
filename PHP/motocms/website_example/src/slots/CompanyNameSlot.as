package slots
{
	import com.moto.template.common.view.IAnimatedProgressBar;
	import com.moto.template.common.view.components.loaders.ImageLoader;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.shell.view.components.AbstractMotoSlot;
	import com.moto.template.common.utils.MotoUtils;
	import flash.display.Sprite;

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.net.URLRequest;
	import flash.text.TextField;

	public class CompanyNameSlot extends AbstractMotoSlot
	{
		private var _label:MovieClip;
		private var _tf:TextField;
		private var _button:MovieClip;
		
		public function CompanyNameSlot()
		{
			super();
			
			_label = getChildByName("label") as MovieClip;
			_tf = _label.getChildByName("tf") as TextField;
			_tf.autoSize = "left";
			_button = getChildByName("button") as MovieClip;
		}

		override public function updateProperty(property:PropertyVO):void
		{			
			switch (property.propertyType)
			{
				case 1:
				{
					MotoUtils.setHTMLTextFromPropertyVO(_tf, property);
					_button.width = _tf.textWidth;
					break;
				}
			}
		}
	}
}