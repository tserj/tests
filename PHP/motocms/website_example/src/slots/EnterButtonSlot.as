package slots
{
	import com.moto.template.common.utils.MotoUtils;
	import com.moto.template.common.view.IAnimatedProgressBar;
	import com.moto.template.common.view.components.loaders.ImageLoader;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.shell.view.components.AbstractMotoSlot;
	import flash.geom.Rectangle;

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.net.URLRequest;
	import flash.text.TextField;

	public class EnterButtonSlot extends AbstractMotoSlot
	{
		private var _label1:MovieClip;
		private var _label2:MovieClip;
		private var _bg:MovieClip;
		
		public function EnterButtonSlot()
		{
			super();
			
			_label1 = getChildByName("label1") as MovieClip;
			_label2 = getChildByName("label2") as MovieClip;
			_bg = getChildByName("bg") as MovieClip;
		}

		override public function updateProperty(property:PropertyVO):void
		{			
			switch (property.propertyType)
			{
				case 1:
				{					
					var tf1 :TextField = _label1.getChildByName("tf") as TextField;					
					var tf2 = _label2.getChildByName("tf") as TextField;
					MotoUtils.setHTMLTextFromPropertyVO(tf1, property);
					MotoUtils.setHTMLTextFromPropertyVO(tf2, property);

					break;
				}

				case 2:
				{
					MotoUtils.setColor(_bg.rect, Number(property.value));
					break;
				}
			}
		}
		
		override public function hide():void
		{
			removeEventListeners();
			gotoAndPlay("hide");
		}
		
		override public function getDimensions():Rectangle
		{
			return new Rectangle(0, 0, _bg.width, _bg.height);
		}
	}
}