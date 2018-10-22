package slots 
{
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.shell.view.components.AbstractMotoSlot;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import com.moto.template.common.utils.MotoUtils;

	public class PageBackgroundSlot extends AbstractMotoSlot
	{
		private var _bg:MovieClip;
		private var _bgColor:Number;
		
		public function PageBackgroundSlot() 
		{
			_bg = getChildByName("bg") as MovieClip;
		}
		
		override public function updateProperty(property:PropertyVO):void
		{			
			switch (property.propertyType)
			{
				case 1:
				{
					_bgColor = Number(property.value);
					MotoUtils.setColor(_bg, _bgColor);
					break;
				}
			}
		}
		override public function setSize(newWidth:Number, newHeight:Number):void 
		{
			_bg.width = newWidth;
			_bg.height = newHeight;
			super.setSize(newWidth, newHeight);
		}
	}
	
}