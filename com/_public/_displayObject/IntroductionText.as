package com._public._displayObject{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	public class IntroductionText extends Sprite {
		private var _Container:Sprite = new Sprite;//容器
		private var bg:Sprite;
		private var content_txt:TextField;
		private var title_txt:TextField;
		private var ias:Object;
		private var _range:Stage;
		private var _displayObject:DisplayObject;
		/**
		 * @params _displayObject
		 * @sort DisplayObject
		 * 用作的显示对象
		 * 
		 * @params _range
		 * @sort Stage
		 * 作用区域
		 * 
		 * @params informationAndStyle
		 * @sort Object
		 * @property lineColor @sort uint
		 * @property lineAlpha @sort Number
		 * @property lineThickness @sort Number
		 * @property bgColor @sort uint
		 * @property bgAlpha @sort Number
		 * @property txtColor @sort uint
		 * @property contenttext @sort String
		 * @property titletext @sort String
		 */
		public function IntroductionText(_displayObject:DisplayObject, _range:Stage, _informationAndStyle:Object) 
		{
			this._displayObject = _displayObject;
			this._range = _range;
			ias = _informationAndStyle;
			_displayObject.addEventListener(MouseEvent.ROLL_OVER, overHandler);
			_displayObject.addEventListener(MouseEvent.ROLL_OUT, outHandler);
			init();
		}
		public function set infoObject(value:Object):void
		{
			content_txt.text = value.content;
			title_txt.text = value.title;
		}
		private function init():void {
			var lineColor:uint;
			if (ias.lineColor == undefined) {
				lineColor = 0xffffff;
			} else {
				lineColor = ias.lineColor;
			}
			var lineAlpha:Number;
			if (ias.lineAlpha == undefined) {
				lineAlpha = 0.5;
			} else {
				lineAlpha = ias.lineAlpha;
			}
			var lineThickness:Number;
			if (ias.lineThickness == undefined) {
				lineThickness = 1;
			} else {
				lineThickness = ias.lineThickness;
			}
			var bgColor:uint;
			if (ias.bgColor == undefined) {
				bgColor = 0xffffff;
			} else {
				bgColor = ias.bgColor;
			}
			var bgAlpha:Number;
			if (ias.bgAlpha == undefined) {
				bgAlpha = 0.5;
			} else {
				bgAlpha = ias.bgAlpha;
			}
			var txtColor:uint;
			if (ias.txtColor == undefined) {
				txtColor = 0x000000;
			} else {
				txtColor = ias.txtColor;
			}
			var contenttext:String;
			if (ias.contenttext == undefined) {
				contenttext = "";
			} else {
				contenttext = ias.contenttext;
			}
			var titletext:String;
			if (ias.titletext == undefined) {
				titletext = "";
			} else {
				titletext = ias.titletext;
			}
			content_txt = new TextField;
			content_txt.textColor = txtColor;
			content_txt.mouseEnabled = false;
			content_txt.text = contenttext;
			content_txt.autoSize = "left";
			title_txt = new TextField;
			title_txt.textColor = txtColor;
			title_txt.mouseEnabled = false;
			title_txt.text = titletext;
			title_txt.autoSize = "left";
			if (titletext != "")
			{
			title_txt.x = 4;
			title_txt.y = 4;
			content_txt.y = title_txt.height + title_txt.y;
			content_txt.x = 4;
			}
			else
			{
			content_txt.y = 4;
			content_txt.x = 4;	
			}
			if (title_txt.width > content_txt.width) {
				bg = introductionBg(bgColor, bgAlpha, lineThickness, lineColor, lineAlpha,title_txt.width + 10,title_txt.height + content_txt.height + 10);
			} else {
				bg = introductionBg(bgColor, bgAlpha, lineThickness, lineColor, lineAlpha, content_txt.width + 10, title_txt.height + content_txt.height + 10);
			}
			_Container.addChild(bg);
			_Container.addChild(title_txt);
			_Container.addChild(content_txt);
		}
		private function overHandler(event:MouseEvent):void {
			_range.addChild(_Container);
			_Container.x = _range.mouseX;
			_Container.y = _range.mouseY + 5;
			_displayObject.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		private function mouseMoveHandler(event:MouseEvent):void {
			if (_range.mouseY > _range.stageHeight - _Container.height - 20) {
				_Container.y = _range.mouseY - _Container.height - 10;
			} else {
				_Container.y = _range.mouseY + 20;
			}
			if (_range.mouseX > _range.stageWidth - _Container.width) {
				_Container.x = _range.stageWidth - _Container.width;
			} else {
				_Container.x = _range.mouseX;
			}
		}
		private function outHandler(event:MouseEvent):void {
			_range.removeChild(_Container);
		}
		private function introductionBg(_color:uint,_alpha:Number,_linethickness:Number,_linecolor:uint,_linealpha:Number, _w:Number, _h:Number):Sprite {
			var s:Sprite = new Sprite;
			s.graphics.lineStyle(_linethickness, _linecolor, _linealpha);
			s.graphics.beginFill(_color, _alpha);
			s.graphics.drawRect(0, 0, _w, _h);
			s.graphics.endFill();
			return s;
		}
	}
}