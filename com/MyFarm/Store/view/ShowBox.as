package com.MyFarm.Store.view
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton
	import flash.display.Sprite;
	import flash.events.MouseEvent
	import flash.text.TextField
	import flash.text.TextFormat
	import flash.events.Event
	import flash.events.TextEvent
	import flash.display.Loader
	import flash.net.URLRequest
	import com._public._filter.transitions.Tweener
	
	/**
	* ...
	* @author Salted fish (www.shch8.com) qq:181404930
	*/
	public class ShowBox extends Sprite
	{
		private var img:DisplayObject;
		private var _width:Number;
		private var _height:Number;
		private var price:Number;
		private var _x:Number;
		private var _y:Number;
		private var bg:Sprite;
		private var displayObject:DisplayObject;
		private var mc:MovieClip;
		private var str:String;
		private var fun:Function;
		private var info:Object;
		public function ShowBox(_mc:MovieClip,_str:String,_url:String,_displayObject:DisplayObject,_info:Object,_fun:Function)
		{
			   mc = _mc;
			   _width = mc.width;
			   _height = mc.height;
			   str = _str;
			   fun = _fun;
			   info = _info;
			   if (_str == "tab1")
			   {
			   mc.stepper.value = 1;
			   addListen();
			   init(_info.price, _info.name, _info.information, _info.type, _info.maturation, _info.experience, _info.rank, _info.yield, _info.prices, _info.revenue);
			   }else if (_str == "tab2")
			   {
			   mc.stepper.value = 1;
				addListen();
			    init2(_info.name,_info.price,_info.type,_info.info);
			   }else if (_str == "tab3")
			   {
				addListen2();
				init3(_info.name,_info.price,_info.type,_info.info);
			   }
			   if(_url!=""){
			   begin(_url);
			   }else if (_displayObject != null) 
			   {
			   displayObject = _displayObject;
			   }
		}
		private function init(_price:String, _introduction_title:String, _introduction_content:String,_type:String,_maturation:String,_experience:String,_rank:String,_yield:String,_prices:String,_revenue:String):void
		{
			mc.stepper.textField.maxChars = 2;
			mc.type_txt.mouseEnabled = false;
			mc.type_txt.text = _type;
			mc.maturation_txt.mouseEnabled = false;
			mc.maturation_txt.text = _maturation + " 小时";
			mc.experience_txt.mouseEnabled = false;
			mc.experience_txt.text = _experience + " / 季";
			mc.rank_txt.mouseEnabled = false;
			mc.rank_txt.text = _rank + " 级";
			mc.price_txt.mouseEnabled = false;
			mc.price_txt.text = _price + " 金币";
			price = Number(_price);
			mc.title_txt.mouseEnabled = false;
			mc.title_txt.text = _introduction_title;
			mc.yield_txt.text = _yield+"个";
			mc.yield_txt.mouseEnabled = false;
			mc.prices_txt.text = _prices + "金币";
			mc.prices_txt.mouseEnabled = false;
			mc.revenue_txt.text = _revenue + "金币";
			mc.revenue_txt.mouseEnabled = false;
		}
		private function init2(_name:String,_price:String,_type:String,_info:String):void
		{
			mc.stepper.textField.maxChars = 2;
			mc.title_txt.text = _name;
			mc.title_txt.mouseEnabled = false;
			mc.price_txt.text = _price + "金币";
			mc.price_txt.mouseEnabled = false;
			mc.type_txt.text = _type;
			mc.type_txt.mouseEnabled = false;
			mc.info_txt.text = _info;
			mc.info_txt.mouseEnabled = false;
			price = Number(_price);
		}
		private function init3(_name:String,_price:String,_type:String,_info:String):void
		{
			mc.title_txt.text = _name;
			mc.title_txt.mouseEnabled = false;
			mc.price_txt.text = _price + "金币";
			mc.price_txt.mouseEnabled = false;
			mc.type_txt.text = _type;
			mc.type_txt.mouseEnabled = false;
			mc.info_txt.text = _info;
			mc.info_txt.mouseEnabled = false;
			price = Number(_price);
		}
		private function addListen():void
		{
			mc.define.addEventListener(MouseEvent.CLICK, defineClick);
			mc.cancel.addEventListener(MouseEvent.CLICK, closeClick);
			mc.close_btn.addEventListener(MouseEvent.CLICK, closeClick);
			mc.stepper.textField.addEventListener(TextEvent.TEXT_INPUT, textInputHandler);
			mc.stepper.addEventListener(Event.CHANGE, stepperChange);
		}
		private function addListen2():void
		{
			mc.define.addEventListener(MouseEvent.CLICK, defineClick);
			mc.cancel.addEventListener(MouseEvent.CLICK, closeClick);
			mc.close_btn.addEventListener(MouseEvent.CLICK, closeClick);
		}
		private function begin(_url:String):void
		{
			var loader:Loader = new Loader();
			loader.load(new URLRequest(_url));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
		}
		public function beginShow():void
		{
			_x = mc.x;
			_y = mc.y;
			mc.width = mc.width / 10;
			mc.height = mc.height / 10;
			mc.x += (_width - mc.width) / 2;
			mc.y += (_height - mc.height) / 2;
			mc.alpha = 0;
			Tweener.addTween(mc, { width:_width, height:_height, alpha:1, time:1, x:_x, y:_y, onComplete:beginComplete } );
		}
		private function beginComplete():void
		{
			if (img != null)
			{
			img.x = 19;
			img.y = 40;
			img.width = 80;
			img.height = 80;
			mc.addChild(img);
			}else if (displayObject != null)
			{
			displayObject.scaleX = 1.5;
			displayObject.scaleY = 1.5;
			displayObject.x = 19 + (80 - displayObject.width) / 2;
			displayObject.y = 40 + (80 - displayObject.height) / 2;
			mc.addChild(displayObject);
			}
			bg = createShape(2000, 2000, 0x000000, 0);
			mc.parent.addChildAt(bg, mc.parent.numChildren - 1);
		}
		private function loaderComplete(event:Event):void
		{
			img = DisplayObject(event.target.content);
		}
		private function defineClick(event:MouseEvent):void
		{
			if (str != "tab3")
			{
			var worth:uint = int(mc.price_txt.text.slice(0,mc.price_txt.text.indexOf("金")));
			fun(int(info.id), worth);
			}
		}
		private function closeClick(event:MouseEvent=null):void
		{
			Tweener.addTween(mc, { width:mc.width/10,height:mc.height/10, alpha:0, time:1, x:_x + (mc.width - mc.width/10)/2, y:_y + (mc.height -mc.height/10)/2, onComplete:endComplete } );
		}
		public function close():void
		{
			closeClick();
		}
		private function endComplete():void
		{
			if(img!=null){
			mc.removeChild(img);
			}else if (displayObject != null) {
			mc.removeChild(displayObject);
			}
			mc.height *= 10;
			mc.width *= 10;
			mc.parent.removeChild(bg);
			mc.parent.removeChild(mc);
			release();
		}
		private function textInputHandler(event:TextEvent):void
		{
			mc.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		private function enterFrameHandler(event:Event):void
		{
			if (mc.stepper.textField.text.length < 1)
			{
				mc.stepper.textField.text = "1";
				mc.price_txt.text = price + " 金币";
				mc.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
			else
			{
				mc.price_txt.text = price * int(mc.stepper.textField.text) + " 金币";
				mc.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}
		private function stepperChange(event:Event):void
		{
			mc.price_txt.text = price * int(mc.stepper.textField.text) + " 金币";
		}
		public function release():void
		{
			img = null;
		    bg = null;
			mc.define.removeEventListener(MouseEvent.CLICK, defineClick);
			mc.cancel.removeEventListener(MouseEvent.CLICK, closeClick);
			mc.close_btn.removeEventListener(MouseEvent.CLICK, closeClick);
			if (str!="tab3")
			{
			mc.info.text = "";
			mc.stepper.textField.removeEventListener(TextEvent.TEXT_INPUT, textInputHandler);
			mc.stepper.removeEventListener(Event.CHANGE, stepperChange);
			}
			mc = null
			displayObject = null
		}
		private function createShape(_w:Number, _h:Number, _color:uint, _alpha:Number):Sprite
		{
			var shape:Sprite = new Sprite;
			shape.graphics.beginFill(_color, _alpha);
			shape.graphics.drawRect(0, 0, _w, _h);
			shape.graphics.endFill();
			return shape;
		}
	}
	
}