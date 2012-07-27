package com.MyFarm.Store{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.SimpleButton;
	import com.MyFarm.Store.view.DisplayBox;
	import com.MyFarm.Store.view.ShowBox;
	import flash.utils.getDefinitionByName;
	import com.MyFarm.view.InstallFace;
	import com._public._method.ClearMemory;
	
	/**
	* ...
	* @author chx (www.shch8.com) qq:181404930
	*/
	public class MyStore {
		private var currentTab:String;
		private var box:DisplayBox;
		private var container:Sprite = new Sprite;
		private var interval:Number = 20;
		private var margins:Number = 20;
		private var xml_array:Array = new Array;
		private var showBox:ShowBox;
		private var currentXML:XML;
		private var myBox:MovieClip;
		private var _showBoxArr:Array;
		private var stage:Stage;
		private var install:InstallFace = InstallFace.getInstance();
		private var rank:uint = 1;
		
		public function MyStore( _mc:MovieClip, _stage:Stage,_boxArr:Array) {
			stage = _stage;
			_showBoxArr = _boxArr;
			myBox = _mc;
			xml_array["tab1"] = "com/MyFarm/data/xml/seed.xml";
			xml_array["tab2"] = "com/MyFarm/data/xml/props.xml";
			xml_array["tab3"] = "com/MyFarm/data/xml/decorative.xml";
			init();
		}
		private function init():void {
			myBox.tab1.buttonMode = true;
			myBox.tab2.buttonMode = true;
			myBox.tab3.buttonMode = true;
			myBox.tab1.gotoAndStop(2);
			currentTab = "tab1";
			addListen();
			loaderXML(xml_array["tab1"]);
			container.name = "container";
			myBox.addChild(container);
		}
		private function addListen():void {
			myBox.tab1.addEventListener(MouseEvent.CLICK, tabChange);
			myBox.tab2.addEventListener(MouseEvent.CLICK, tabChange);
			myBox.tab3.addEventListener(MouseEvent.CLICK, tabChange);
		}
		public function set currentRank(value:uint):void
		{
			rank = value
		}
		private function getXML(_xml:XML):void {
			currentXML = _xml;
			var setY:Number = myBox.tab1.y + myBox.tab1.height + margins;
			myBox.scrollBar.y = setY;
			container.y = 0;
			var num:uint = int((myBox.width - margins * 2) / (50 + interval));
			var j:uint;
			for (var i:uint; i < _xml.item.length(); i++) {
				if (_xml.item[i].@url != undefined) {
					box = new DisplayBox(_xml.item[i].@url, stage, _xml.item[i].@price, null , _xml.item[i].@name, _xml.item[i].@information);
				} else {
					var obj:MovieClip = createClip(_xml.item[i].@object);
					box = new DisplayBox("", stage, _xml.item[i].@price, obj, _xml.item[i].@name, _xml.item[i].@information);
				}
				box.name = i.toString();
				box.x = (box.width + interval) * j + margins;
				box.y = setY;
				j++;
				if ((i + 1) % num == 0) {
					setY += box.height + margins;
					j = 0;
				}
				container.addChild(box);
			}
			container.addEventListener(MouseEvent.CLICK, clickHandler);
			myBox.scrollBar.effectObject = "container";
			//trace(container.numChildren);
		}
		private function clickHandler(event:MouseEvent):void 
		{
			var num:uint = int(currentTab.slice(3, 4))-1;
			var i:uint = int(event.target.parent.name);
			var obj:Object = new Object;
			obj.price = currentXML.item[i].@price;
			obj.name = currentXML.item[i].@name;
			obj.information = currentXML.item[i].@information;
			obj.type = currentXML.item[i].@type;
			obj.maturation = currentXML.item[i].@maturation;
			obj.experience = currentXML.item[i].@experience;
			obj.rank = currentXML.item[i].@rank;
			obj.yield = currentXML.item[i].@yield;
			obj.prices = currentXML.item[i].@prices;
			obj.info = currentXML.item[i]
			obj.id = i;
			obj.revenue = Number(obj.yield) * Number(obj.prices);
			if (num == 0)
			{
			if (int(obj.rank) > rank)
			{
			_showBoxArr[num].define.mouseEnabled = false;
			_showBoxArr[num].info.text = "等级不够，无法购买!";
			}
			else
			{
			_showBoxArr[num].define.mouseEnabled = true;
			_showBoxArr[num].info.text = "";
			}
			}else if (num == 1)
			{
			
			}else if (num == 2)
			{
			
			}
			_showBoxArr[num].info.mouseEnabled = false;
			if (currentXML.item[i].@url!=undefined) {
				showBox = new ShowBox(_showBoxArr[num],currentTab,currentXML.item[i].@url, null, obj,buySomething );
			} else {
				var mc:MovieClip = createClip(currentXML.item[i].@object);
				showBox = new ShowBox(_showBoxArr[num],currentTab,"", mc, obj,buySomething);
			}
			stage.addChild(_showBoxArr[num]);
			_showBoxArr[num].x = myBox.x +(myBox.width - _showBoxArr[num].width) / 2;
			_showBoxArr[num].y = myBox.y + (300 - _showBoxArr[num].height) / 2;
			showBox.beginShow();
		}
		private function buySomething(_id:uint,_worth:Number):void
		{
			var num:uint = int(currentTab.slice(3, 4))-1;
			if (_worth < int(install._user.wealth))
			{
			var number:uint = _worth / int(currentXML.item[_id].@price);
			install._user.wealth = int(install._user.wealth) - _worth;
			var j:int = -1;
			for (var i:uint; i < install._user.burden.length; i++ )
			{
				if (install._user.burden[i].Items == currentXML.item[_id].@object)
				{
				j = i
				break;
				}
			}
			if (j > -1)
			{
			install._user.burden[j].number = int(install._user.burden[j].number) + number;
			}
			else
			{
			install._user.burden.push( { name:String(currentXML.item[_id].@name), Items:String(currentXML.item[_id].@object), number:number } );
			}
			install.showBurden();
			install.changeExp();
			_showBoxArr[num].info.text = "";
			showBox.close();
			install.so.data.user = install._user
			install.so.flush();
			}
			else
			{
			_showBoxArr[num].info.text = "资金不足!!!";
			}
		}
		private function tweenComplete():void {
			myBox.parent.removeChild(myBox);
		}
		private function tabChange(event:MouseEvent):void {
			if (event.target.name == currentTab) {
				return;
			}
			switch (event.target.name) {
				case "tab1" :
				case "tab2" :
				case "tab3" :
					clear();
					loaderXML(xml_array[event.target.name]);
					var mc:MovieClip = myBox.getChildByName(currentTab) as MovieClip;
					if (mc != null) {
						mc.gotoAndStop(1);
					}
					currentTab = event.target.name;
					event.target.gotoAndStop(2);
					break;
			}
		}
		private function loaderXML(_str:String):void {
			var loader:URLLoader = new URLLoader(new URLRequest(_str));
			loader.addEventListener(Event.COMPLETE, loadXMLComplete);
		}
		private function loadXMLComplete(event:Event):void {
			getXML(XML(event.target.data));
		}
		private function clear():void {
			for (var i:uint = container.numChildren; i > 0; i--) {
				container.removeChildAt(i - 1);
			}
		}
		public function clearMemory():void
		{
			var clearMemory:ClearMemory = ClearMemory.getInstance();
			myBox.tab1.removeEventListener(MouseEvent.CLICK, tabChange);
			myBox.tab2.removeEventListener(MouseEvent.CLICK, tabChange);
			myBox.tab3.removeEventListener(MouseEvent.CLICK, tabChange);
			box = null;
			while (container.numChildren > 0)
			{
			container.removeChildAt(0);
			}
			container = null;
			currentXML = null;
			myBox = null;
			_showBoxArr = new Array();
			stage = null;
			clearMemory.runClear();
		}
		private function createClip(className:String):MovieClip 
		{
			return install.getChild(className);
		}
	}
}