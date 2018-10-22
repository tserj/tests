package modules
{
	import com.moto.template.common.view.MotoAnimatedItemRenderer;
	import com.moto.template.common.view.components.loaders.ImageLoader;
	import com.moto.template.shell.model.vo.ModuleItemVO;
	import com.moto.template.shell.model.vo.PropertyVO;
	import com.moto.template.common.utils.MotoUtils;
	
	import flash.text.TextField;
	import flash.display.MovieClip;

	/**
	 * News item class. It is item renderer so we extend MotoAnimatedItemRenderer class.
	 */
	public class NewsModuleItem extends MotoAnimatedItemRenderer
	{
		private var _icon:ImageLoader;
		
		private var _description:TextField;
		
		private var _button:MovieClip;
		
		public function NewsModuleItem()
		{
			super();
			
			// Get elements
			_icon = ImageLoader(getChildByName("icon"));
			_icon.buttonMode = true;
			_description = TextField(getChildByName("description"));
			_description.multiline = true;
			_description.wordWrap = true;
			_button = MovieClip(getChildByName("button"));
			_button.buttonMode = true;
			
			// Create text event listener for item renderer text
			createTextFieldLinkListener(_description);
		}
		
		/**
		 * Update item renderer
		 * 
		 * @param	data XML with item data
		 */
		override public function updateRenderer(data:Object):void
		{
			super.updateRenderer(data);
			
			var dataVO:ModuleItemVO = data as ModuleItemVO;
			// Get icon
			var icon:String = dataVO.getPropertyValueByID(1) as String;			
			if (icon)
				_icon.source = pathPrefix + icon;
			
			// Get description
			var descriptionProperty:PropertyVO = dataVO.getPropertyByID(2);
			if (descriptionProperty.value)
			{
				MotoUtils.setHTMLTextFromPropertyVO(_description, descriptionProperty);
			}
		}
		
		/**
		 * Override setSize function to resize item renderer
		 * 
		 * @param	newWidth New slot width
		 * @param	newHeight New slot height
		 */
		override public function setSize(newWidth:Number, newHeight:Number):void
		{
			_description.width = newWidth - 40;
			_button.width = newWidth - 40;
		}
	}
}