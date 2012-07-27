package com.MyFarm.Store.view
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import com._public._displayObject.IntroductionText
	import flash.display.Loader
	import flash.display.Stage;
	import flash.events.TextEvent;
	import flash.net.URLRequest
	import flash.events.Event
	import flash.text.TextField
	import flash.text.TextFormat
	
	/**
	* ...
	* @author Salted fish (www.shch8.com) qq:181404930
	*/
	public class  DisplayBox extends Sprite
	{
		private var _width:Number = 50
		private var _height:Number = 50
		private var lineColor:uint = 0x00ccff
		private var color:uint = 0xffffff
		private var _alpha:Number = 0.5
		private var bg:Sprite
		private var txtColor:uint = 0xcc6600
		private var priceColor:uint = 0xff6600
		public function DisplayBox(_url:String,_stage:Stage, _price:String,_displayObject:DisplayObject = null, _introduction_title:String = "", _introduction_content:String = "")
		{
			this.buttonMode = true;
			var introductionText:IntroductionText = new IntroductionText(this, _stage, { lineColor:0xffffff, lineAlpha:0.5, lineThickness:1, bgColor:0xffffff, bgAlpha:0.3, txtColor:0x000000, contenttext:_introduction_content, titletext:_introduction_title } );
			addChild(introductionText);
			bg = createShape();
			addChild(bg);
			inittext(_price);
			if (_url != "")
			{
			var loader:Loader = new Loader;
			loader.load(new URLRequest(_url));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCompleteHandler);
			}else {
			if (_displayObject != null)
			{
			_displayObject.x = 1 + (_width - _displayObject.width ) / 2;
			_displayObject.y = 1 + (_height - _displayObject.height ) / 2;
			addChild(_displayObject);
			}
			}
		}
		private function inittext(_text:String):void
		{
			var txt:TextField = new TextField();
			txt.text = "金币:";
			txt.textColor = txtColor;
			txt.autoSize = "left";
			txt.y = _height + 5;
			txt.mouseEnabled = false;
			addChild(txt);
			var price:TextField = new TextField;
			price.text = _text;
			price.autoSize = "left";
			price.textColor = priceColor;
			var textFormat:TextFormat = new TextFormat;
			textFormat.bold = true;
			price.setTextFormat(textFormat);
			price.x = txt.width;
			price.y = _height + 5;
			price.mouseEnabled = false;
			addChild(price);
		}
		private function loadCompleteHandler(event:Event):void
		{
			event.target.content.width = _width;
			event.target.content.height = _height;
			event.target.content.x = 1;
			event.target.content.y = 1;
			addChild(event.target.content);
		}
		private function createShape():Sprite
		{
			var shape:Sprite = new Sprite;
			shape.graphics.lineStyle(1, lineColor);
			shape.graphics.beginFill(color, _alpha);
			shape.graphics.drawRect(0, 0, _width + 2, _height + 2);
			shape.graphics.endFill();
			return shape;
		}
	}
	
}