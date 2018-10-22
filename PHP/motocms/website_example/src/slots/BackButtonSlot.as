package slots
{
	import com.moto.template.common.view.IAnimatedProgressBar;
	import com.moto.template.common.view.components.loaders.ImageLoader;
	import com.moto.template.shell.model.vo.MotoObjectVO;
	import com.moto.template.shell.view.components.AbstractMotoSlot;
	import flash.geom.Rectangle;

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.net.URLRequest;
	import flash.text.TextField;

	public class BackButtonSlot extends AbstractMotoSlot
	{		
		public function BackButtonSlot()
		{
			super();
		}
		
		override public function show():void
		{
			createEventListeners();
			gotoAndPlay("show");
		}
		
		override public function hide():void
		{
			removeEventListeners();
			gotoAndPlay("hide");
		}
		
		override public function getDimensions():Rectangle
		{
			return new Rectangle(0, 0, width, height);
		}
	}
}