package com._public._displayObject 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author chx (www.shch8.com)
	 */
	public class Card extends Sprite
	{
		private var cardAlpha:Number = 0.4;
		private var cardColor:uint = 0xffffff;
		private var lineColor:uint = 0xffffff;
		private var lineAlpha:Number = 0.6;
		private var timer:Timer;
		private var myTxt:TextField
		private var bg:Sprite;
		private var bool:Boolean;
		public function Card() 
		{
			timer = new Timer(3000, 1);
			myTxt = new TextField;
			myTxt.textColor = 0x000000;
			myTxt.mouseEnabled = false;
			myTxt.autoSize = "left";
		}
		public function showCard(_info:String):void
		{
			timer.reset();
			if (bool)
			{
			removeChild(myTxt);
			removeChild(bg);
			}
			createText(_info);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
		}
		private function timerCompleteHandler(event:TimerEvent):void
		{
			removeChild(myTxt);
			removeChild(bg);
			bool = false;
		}
		private function createText(_info:String):void
		{
			myTxt.text = _info;
			bg = createShape(myTxt.textWidth + 4, myTxt.textHeight + 4, cardColor, cardAlpha, lineColor, lineAlpha );
			addChild(bg);
			addChild(myTxt);
			bool = true;
		}
		private function createShape(_w:Number,_h:Number,_color:uint,_alpha:Number,_lineColor:uint,_lineAlpha:Number):Sprite
		{
			var shape:Sprite = new Sprite
			shape.graphics.lineStyle(1, _lineColor, _lineAlpha);
			shape.graphics.beginFill(_color, _alpha);
			shape.graphics.drawRect(0, 0, _w, _h);
			shape.graphics.endFill();
			return shape;
		}
		
	}
	
}