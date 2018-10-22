package modules
{
	import com.moto.template.common.view.MotoAnimatedItemRenderer;
	import com.moto.template.common.view.components.loaders.ImageLoader;
	import com.moto.template.shell.model.vo.ModuleItemVO;
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.common.utils.MotoUtils;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	
	import flash.text.TextField;
	import flash.display.MovieClip;

	public class NewsModuleItem extends MotoAnimatedItemRenderer
	{
		private var _icon:ImageLoader;
		private var _description:TextField;
		private var _button:MovieClip;
		
		public function NewsModuleItem()
		{
			super();
			
			_icon = ImageLoader(getChildByName("icon"));
			_icon.buttonMode = true;
			
			_description = TextField(getChildByName("description"));
			_description.autoSize = TextFieldAutoSize.LEFT;
			_description.multiline = true;
			_description.wordWrap = true;
			
			_button = MovieClip(getChildByName("button"));
			_button.buttonMode = true;
			
			createTextFieldLinkListener(_description);
		}

		override public function updateRenderer(data:Object):void
		{
			super.updateRenderer(data);
			var icon:String = String(data.getPropertyValueByID(1));			
			if (icon)
				_icon.source = pathPrefix + icon;
			if (data.getPropertyByID(2))
			{
				MotoUtils.setHTMLTextFromPropertyVO(_description, data.getPropertyByID(2));
			}
		}
		
		override public function setSize(newWidth:Number, newHeight:Number):void
		{
			_description.width = newWidth - 40;
			_button.width = newWidth - 40;
		}
		
		override public function getDimensions():Rectangle 
		{
			return new Rectangle(0,0,width, _description.y + _description.height);
		}
	}
}