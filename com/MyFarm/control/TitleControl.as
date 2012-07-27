package com.MyFarm.control 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.TextEvent;
	import com._public._filter.transitions.Tweener;
	import flash.ui.Mouse;
	import com.MyFarm.Store.MyStore;
	import com._public._method.ClearMemory;
	import com.MyFarm.view.InstallFace;
	
	/**
	 * ...
	 * @author Salted fish (www.shch8.com) qq:181404930
	 */
	public class TitleControl
	{
		private var bg:Sprite;
		private var myStore:MyStore
		private var showBox:MovieClip;
		private var photo:Sprite;
		private var num:int;
		private var tipBox:MovieClip;
		private var tipBox2:MovieClip;
		private var face:InstallFace = InstallFace.getInstance();
		public function TitleControl() 
		{
			bg = createShape(face._stage.stageWidth, face._stage.stageHeight);
			face._title.addEventListener(MouseEvent.CLICK, titleClickHandler);
			face._title.addEventListener(MouseEvent.MOUSE_OVER, titleOverHandler);
		}
		private function titleOverHandler(event:MouseEvent):void
		{
			Mouse.show();
			face._myMouse.visible = false;
			face._title.addEventListener(MouseEvent.MOUSE_OUT, titleOutHandler);
		}
		private function titleOutHandler(event:MouseEvent):void
		{
			Mouse.hide();
			face._myMouse.visible = true;
			face._title.removeEventListener(MouseEvent.MOUSE_OUT, titleOutHandler);
		}
		private function titleClickHandler(event:MouseEvent):void
		{
			if (event.target.name == "ButtonDecorate")
			{
				showDecorate();
				face._title.removeEventListener(MouseEvent.MOUSE_OUT, titleOutHandler);
			}
			else if (event.target.name == "ButtonShop")
			{
				showShop();
				face._title.removeEventListener(MouseEvent.MOUSE_OUT, titleOutHandler);
			}
			else if (event.target.name == "ButtonWarehouse")
			{
				showWarehouse();
				face._title.removeEventListener(MouseEvent.MOUSE_OUT, titleOutHandler);
			}
			else if (event.target.name == "ButtonFarm")
			{
				
			}
		}
		private function showDecorate():void
		{
			
		}
		private function showShop():void
		{
			Mouse.show();
			face._myMouse.visible = false;
			face._stage.addChild(bg);
			face._stage.setChildIndex(face._shop,face._stage.numChildren-1);
			face._shop.visible = true;
			face._shop.alpha = 0.2;
			var _x:Number = face._shop.x;
			var _y:Number = face._shop.y;
			var _w:Number = face._shop.width;
			var _h:Number = face._shop.height;
			face._shop.width /= 5;
			face._shop.height /= 5;
			face._shop.x = (face._stage.stageWidth - face._shop.width) / 2;
		    face._shop.y = (face._stage.stageHeight - face._shop.height) / 2;
			Tweener.addTween(face._shop, { alpha:1, x:_x, y:_y, width:_w, height:_h, time:0.5,onComplete:shoptweenComplete } );
		}
		private function showWarehouse():void
		{
			Mouse.show();
			face._myMouse.visible = false;
			face._stage.addChild(bg);
			face._stage.setChildIndex(face._warehouse,face._stage.numChildren-1);
			face._warehouse.visible = true;
			face._warehouse.alpha = 0.2;
			var _x:Number = face._warehouse.x;
			var _y:Number = face._warehouse.y;
			var _w:Number = face._warehouse.width;
			var _h:Number = face._warehouse.height;
			face._warehouse.width /= 5;
			face._warehouse.height /= 5;
			face._warehouse.x = (face._stage.stageWidth - face._warehouse.width) / 2;
		    face._warehouse.y = (face._stage.stageHeight - face._warehouse.height) / 2;
			Tweener.addTween(face._warehouse, { alpha:1, x:_x, y:_y, width:_w, height:_h, time:0.5, onComplete:warehousetweenComplete } );
			face._warehouse.addEventListener(MouseEvent.CLICK, warehouseClickHandler);
			if (face._user.warehouse.length > 0)
			{
			face._warehouse.ask_btn.visible = true;
			face._warehouse.ask_btn.addEventListener(MouseEvent.CLICK, soldAllHandler);
			}
			else
			{
			face._warehouse.ask_btn.visible = false;
			}
		}
		private function shoptweenComplete():void
		{
			if (myStore == null)
			{
			var arr:Array = new Array();
			var box:MovieClip = face.getChild("shopbox");
			arr.push(box);
			var box2:MovieClip = face.getChild("shopbox2");
			arr.push(box2);
			var box3:MovieClip = face.getChild("shopbox3");
			arr.push(box3);
			myStore = new MyStore(face._shop, face._stage, arr);
			myStore.currentRank = int(face._user.rank);
			}
			face._shop.close_btn.addEventListener(MouseEvent.CLICK, closeClickHandler);
		}
		private function warehousetweenComplete():void
		{
			face._warehouse.close_btn.addEventListener(MouseEvent.CLICK, warehouseCloseHandler);
		}
		private function closeClickHandler(event:MouseEvent):void
		{
			Mouse.hide();
			face._myMouse.visible = true;
			face._stage.removeChild(bg);
			face._shop.visible = false;
		}
		private function warehouseCloseHandler(event:MouseEvent):void
		{
			Mouse.hide();
			face._myMouse.visible = true;
			face._warehouse.removeEventListener(MouseEvent.CLICK, warehouseClickHandler);
			face._stage.removeChild(bg);
			face._warehouse.visible = false;
			var clearMemory:ClearMemory = ClearMemory.getInstance();
			clearMemory.runClear();
			face.so.data.user = face._user;
			face.so.flush();
		}
		private function shopClickHandler(event:MouseEvent):void
		{
			trace(event.target.name);
		}
		private function soldAllHandler(event:MouseEvent):void
		{
			tipBox2 = face.getChild("Tips2");
			face._stage.addChild(tipBox2);
			tipBox2.x = face._warehouse.x + (face._warehouse.width - tipBox2.width) / 2;
			tipBox2.y = face._warehouse.y + (face._warehouse.height - tipBox2.height) / 2;
			tipBox2.txt.text = "是否出售所有物品,总价值为:" + face._warehouse.worth_txt.text;
			tipBox2.txt.mouseEnabled = false;
			tipBox2.close_btn.addEventListener(MouseEvent.CLICK, tips2CloseHandler);
			tipBox2.cancel.addEventListener(MouseEvent.CLICK, tips2CloseHandler);
			tipBox2.define.addEventListener(MouseEvent.CLICK, tipClickHandler);
		}
		private function tips2CloseHandler(event:MouseEvent = null):void
		{
			tipBox2.close_btn.removeEventListener(MouseEvent.CLICK, tips2CloseHandler);
			tipBox2.cancel.removeEventListener(MouseEvent.CLICK, tips2CloseHandler);
			tipBox2.define.removeEventListener(MouseEvent.CLICK, tipClickHandler);
			face._stage.removeChild(tipBox2);
			tipBox2 = null;
			face.so.data.user = face._user;
			face.so.flush();
		}
		private function tipClickHandler(event:MouseEvent):void
		{
			var totalNumber:int = int(face._warehouse.worth_txt.text);
			face._user.wealth = String(int(face._user.wealth) + totalNumber);
			face._user.warehouse = new Array();
			face.showWarehouse();
			face.changeExp();
			face._warehouse.ask_btn.visible = false;
			tips2CloseHandler();
		}
		private function warehouseClickHandler(event:MouseEvent):void
		{
			if (String(event.target.name).indexOf("bg")>-1)
			{
			num = int(String(event.target.name).slice(2, 3))
			//trace(face._user.warehouse[num].price)
			showBox = face.getChild("box");
			face._stage.addChild(showBox);
			showBox.x = face._warehouse.x + (face._warehouse.width - showBox.width) / 2;
			showBox.y = face._warehouse.y + (face._warehouse.height - showBox.height) / 2;
			showBox.price_txt.text = face._user.warehouse[num].price + "金币";
			showBox.stepper.value = face._user.warehouse[num].number;
			showBox.stepper.textField.restrict = "0-9";
			showBox.stepper.textField.maxChars = 3;
			showBox.txt.text = "输入卖出数量(1-"+face._user.warehouse[num].number+")"
			showBox.stepper.maximum = face._user.warehouse[num].number;
			showBox.total_txt.text = (int(face._user.warehouse[num].number) * int(face._user.warehouse[num].price)) + "金币";
			showBox.title_txt.text = face._user.warehouse[num].name;
			photo = face.getChild(face._user.warehouse[num].fruit);
			showBox.addChild(photo);
			photo.x = 18 + (80 - photo.width) / 2;
			photo.y = 40 + (80 - photo.height) / 2;
			showBox.close_btn.addEventListener(MouseEvent.CLICK, showBoxClose);
			showBox.cancel.addEventListener(MouseEvent.CLICK, showBoxClose);
			showBox.stepper.addEventListener(Event.CHANGE, stepperChange);
			showBox.stepper.textField.addEventListener(TextEvent.TEXT_INPUT, stepperInputHandler);
			showBox.define.addEventListener(MouseEvent.CLICK, soldHandler);
			}
		}
		private function showBoxClose(event:MouseEvent=null):void
		{
			showBox.stepper.removeEventListener(Event.CHANGE, stepperChange);
			showBox.cancel.removeEventListener(MouseEvent.CLICK, showBoxClose);
			showBox.close_btn.removeEventListener(MouseEvent.CLICK, showBoxClose);
			showBox.stepper.textField.removeEventListener(TextEvent.TEXT_INPUT, stepperInputHandler);
			face._stage.removeChild(showBox);
			photo = null;
			showBox = null;
			face.so.data.user = face._user;
			face.so.flush();
		}
		private function stepperChange(event:Event):void
		{
			showBox.total_txt.text = (int(showBox.stepper.value) * int(showBox.price_txt.text.slice(0, showBox.price_txt.text.indexOf("金")))) + "金币";
		}
		private function stepperInputHandler(event:TextEvent):void
		{
			face._stage.addEventListener(Event.ENTER_FRAME, stepperEnterFrame);
		}
		private function stepperEnterFrame(event:Event):void
		{
			if (showBox.stepper.textField.text == "")
			{
				showBox.stepper.value = 1;
				showBox.total_txt.text = (int(showBox.stepper.value) * int(showBox.price_txt.text.slice(0, showBox.price_txt.text.indexOf("金")))) + "金币";
			}
			else
			{
				if (int(showBox.stepper.textField.text) > showBox.stepper.maximum)
				{
				showBox.stepper.textField.text = showBox.stepper.maximum;
				}
				showBox.total_txt.text = (int(showBox.stepper.textField.text) * int(showBox.price_txt.text.slice(0, showBox.price_txt.text.indexOf("金")))) + "金币";
			}
			face._stage.removeEventListener(Event.ENTER_FRAME, stepperEnterFrame);
		}
		private function soldHandler(event:MouseEvent):void
		{
			var totalNumber:int = int(showBox.total_txt.text.slice(0, showBox.total_txt.text.indexOf("金")));
			face._user.wealth = String(int(face._user.wealth) + totalNumber);
			var number:int = int(int(showBox.total_txt.text.slice(0, showBox.total_txt.text.indexOf("金"))) / int(showBox.price_txt.text.slice(0, showBox.price_txt.text.indexOf("金"))))
			face._user.warehouse[num].number = int(face._user.warehouse[num].number) - number;
			var name:String = face._user.warehouse[num].name;
			if (face._user.warehouse[num].number < 1)
			{
			face._user.warehouse.splice(num, 1);
			}
			face.showWarehouse();
			face.changeExp();
			showBoxClose();
			tipBox = face.getChild("Tips");
			face._stage.addChild(tipBox);
			tipBox.x = face._warehouse.x + (face._warehouse.width - tipBox.width) / 2;
			tipBox.y = face._warehouse.y + (face._warehouse.height - tipBox.height) / 2;
			tipBox.num_txt.text = number;
			tipBox.num_txt.mouseEnabled  = false;
			tipBox.name_txt.text = name;
			tipBox.name_txt.mouseEnabled = false;
			tipBox.price_txt.text = totalNumber;
			tipBox.price_txt.mouseEnabled = false;
			tipBox.close_btn.addEventListener(MouseEvent.CLICK, tipsCloseHandler);
			tipBox.define.addEventListener(MouseEvent.CLICK, tipsCloseHandler);
			if (face._user.warehouse.length < 1)
			{
			face._warehouse.ask_btn.visible = false;
			}
		}
		private function tipsCloseHandler(event:MouseEvent):void
		{
			tipBox.close_btn.removeEventListener(MouseEvent.CLICK, tipsCloseHandler);
			tipBox.define.removeEventListener(MouseEvent.CLICK, tipsCloseHandler);
			face._stage.removeChild(tipBox);
			tipBox = null;
			face.so.data.user = face._user;
			face.so.flush();
		}
		private function createShape(_w:Number,_h:Number):Sprite
		{
			var shape:Sprite = new Sprite;
			shape.graphics.beginFill(0x000000, 0);
			shape.graphics.drawRect(0, 0, _w, _h);
			shape.graphics.endFill();
			return shape;
		}
		
	}
	
}