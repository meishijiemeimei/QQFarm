package com.MyFarm.view{
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import com._public._method.app;
	import flash.display.Stage;
	import flash.system.ApplicationDomain;
	import com.MyFarm.data.UserInfo;
	import flash.display.SimpleButton;
	import com.MyFarm.control.Control;
	import com._public._displayObject.IntroductionText;
	import flash.net.SharedObject;
	import flash.display.DisplayObject;


	/**
	 * ...
	 * @author Salted fish (www.shch8.com) qq:181404930
	 */
	public class InstallFace {
		private static  var instance:InstallFace;
		private var _loaderInfo:LoaderInfo;//获取皮肤swf的LoaderInfo
		private var control:Control;
		private var myIntro:IntroductionText;
		private const EXP:uint = 100;

		public function set loaderInfo(value:LoaderInfo):void {
			_loaderInfo = value;
		}
		/**
		 * 存储对象
		 * @sort SharedObject
		 */
		public var so:SharedObject = SharedObject.getLocal("test", "/");
		/**
		 * 存储作物信息XML
		 * @sort XML
		 */
		public var cropXml:XML;
		/**
		 * 舞台对象
		 * 因为皮肤的安装位置需要调整要舞台
		 * @sort Stage
		 */
		public var _stage:Stage;
		/**
		 * 商店
		 * @sort MovieClip
		 */
		public var _shop:MovieClip;
		public var _showBox:MovieClip;
		/**
		 * 仓库
		 * @sort MovieClip
		 */
		public var _warehouse:MovieClip;
		/**
		 * 用户
		 * @sort UserInfo
		 */
		public var _user:Object;
		//切换用户
		public function set user(value:UserInfo):void {
			_user = value;
		}
		/**
		 * 自定义鼠标
		 * @sort UserInfo
		 */
		public var _myMouse:MovieClip;
		//切换鼠标样式
		public function changeMouse(value:String):void {
			var mc:MovieClip = createClip(value);
			if (mc != null) {
				var _x:Number = _myMouse.x;
				var _y:Number = _myMouse.y;
				_stage.removeChild(_myMouse);
				_myMouse = mc;
				_myMouse.x = _x;
				_myMouse.y = _y;
				_stage.addChild(_myMouse);
				_myMouse.name = value;
			}
		}
		/**
		 * 背景
		 * @sort Sprite
		 */
		public var _bg:Sprite = new Sprite;
		public var _beijing:Sprite;
		/**
		 * 标题栏
		 * @sort Sprite
		 */
		public var _title:Sprite = new Sprite;
		/**
		 * 经验条
		 * @sort MovieClip
		 */
		public var experienceBar:MovieClip;
		/**
		 * 工具栏
		 * @sort Sprite
		 */
		public var _tools:Sprite = new Sprite;
		/**
		 * 好友列表
		 * @sort Sprite
		 */
		public var _friends:Sprite;
		/**
		 * 农田
		 * @sort Array
		 */
		public var _farmland_array:Array = new Array();
		//改变农田状态
		public function farmlandChange(_index:uint, _farmland:String):void {
			var farmland:MovieClip = createClip(_farmland);
			var _x:Number = _farmland_array[_index].x;
			var _y:Number = _farmland_array[_index].y;
			farmlandContainer.removeChild(_farmland_array[_index]);
			_farmland_array[_index] = farmland;
			farmlandContainer.addChild(_farmland_array[_index]);
			_farmland_array[_index].x = _x;
			_farmland_array[_index].y = _y;
			_user.farmland[_index].farmland = _farmland;
		}
		public function reclaimedWasteland():void {
			var num:uint;
			for (var i:uint; i < _user.farmland.length; i++) {
				if (_user.farmland[i].farmland == "Wasteland") {
					num = i;
					break;
				}
			}
			var farmland:MovieClip = createClip("FarmlandS");
			farmland.name = "FarmlandS" + num;
			var _x:Number = _farmland_array[num].x;
			var _y:Number = _farmland_array[num].y;
			farmlandContainer.removeChild(_farmland_array[num]);
			_farmland_array[num] = farmland;
			farmlandContainer.addChild(_farmland_array[num]);
			_farmland_array[num].x = _x;
			_farmland_array[num].y = _y;
			var reclaim:Sprite = farmlandContainer.getChildByName("reclaim") as Sprite;
			if (num < _user.farmland.length-1) {
				reclaim.x = _farmland_array[num + 1].x + (_farmland_array[num + 1].width - reclaim.width) / 2;
				reclaim.y = _farmland_array[num + 1].y - _farmland_array[num + 1].height / 3;
				farmlandContainer.setChildIndex(reclaim, farmlandContainer.numChildren - 1);
			} else {
				farmlandContainer.removeChild(reclaim);
			}
			_user.farmland[num].farmland = "FarmlandS";
			so.data.user = _user;
			so.flush();
		}
		/**
		 * 农田容器
		 * @sort Sprite
		 */
		public var farmlandContainer:Sprite = new Sprite;
		/**
		 * 狗窝
		 * @sort Sprite
		 */
		public var _kennel:Sprite;
		//跟换狗窝
		public function set kennel(value:String):void {
			var kennel:Sprite = createClip(value);
			if (kennel != null) {
				var _x:Number = _kennel.x;
				var _y:Number = _kennel.y;
				_bg.removeChild(_kennel);
				_kennel = kennel;
				_bg.addChild(_kennel);
				_kennel.x = _x;
				_kennel.y = _y;
			}
		}
		/**
		 * 栅栏
		 * @sort Sprite
		 */
		public var _fence:Sprite;
		//跟换栅栏
		public function set fence(value:String):void {
			var fence:Sprite = createClip(value);
			if (fence != null) {
				var _x:Number = _fence.x;
				var _y:Number = _fence.y;
				_bg.removeChild(_fence);
				_fence = fence;
				_bg.addChild(_fence);
				_fence.x = _x;
				_fence.y = _y;
			}
		}
		/**
		 * 房子
		 * @sort Sprite
		 */
		public var _house:Sprite;
		//跟换房子
		public function set house(value:String):void {
			var house:Sprite = createClip(value);
			if (house!=null) {
				var _x:Number = _house.x;
				var _y:Number = _house.y;
				_bg.removeChild(_house);
				_house = house;
				_bg.addChild(_house);
				_house.x = _x;
				_house.y = _y;
			}
		}
		public static function getInstance():InstallFace {
			if (instance == null) {
				return instance=new InstallFace  ;
			} else {
				return instance;
			}
		}
		//安装皮肤
		public function install():void {
			_stage.addChild(_bg);
			_beijing = createClip("beijing");
			_beijing.x = -15;
			_bg.addChild(_beijing);
			_house = createClip(_user.house);
			_house.x = 580;
			_house.y = 250;
			_bg.addChild(_house);
			_fence = createClip(_user.fence);
			_fence.x = 380;
			_fence.y = 195;
			_bg.addChild(_fence);
			_kennel = createClip(_user.kennel);
			_kennel.x = 460;
			_kennel.y = 200;
			_bg.addChild(_kennel);
			_myMouse = createClip("CursorArrow");
			_myMouse.name = "CursorArrow";
			farmland();
			installToolsBar();
			installHead();
			theWeather();
		}
		//农田安装
		private function farmland():void {
			var value:Array = _user.farmland;
			var virgin:Boolean = true;//强大的命名
			for (var i:uint; i < value.length; i++) {
				var farmland:MovieClip = createClip(value[i].farmland);
				farmland.name = value[i].farmland + i;
				_farmland_array.push(farmland);
				farmlandContainer.addChild(farmland);
				farmland.x = 254 - i % 3 * (farmland.width / 2 + 3) + ((i/3)>>0)*farmland.width / 2;
				farmland.y = 284 + ((i/3)>>0)*farmland.height/2 + i % 3 * (farmland.height / 2 + 3);
				if (value[i].crop != undefined) {
					var date:Date = new Date;
					// 成长需要总时间/(当前时间 - 种下时间) 判断值是否为整数，为整数取整数，不为整数强制转化成整数int();
					var num:int;
					if (value[i].harvest == undefined) {
						num = (int(date.time/1000) - value[i].time)/int(int(cropXml.items.(@seed == value[i].crop).@time)/5) is int?(int(date.time/1000) - value[i].time)/int(int(cropXml.items.(@seed == value[i].crop).@time)/5):int((int(date.time/1000) - value[i].time)/int(int(cropXml.items.(@seed == value[i].crop).@time)/5));
						if (num > 5) {
							num = 5;
							if (value[i].yield == undefined) {
								value[i].yield = cropXml.items.(@seed == value[i].crop).@yield - 3 + int(Math.random() * 6);
							}
							value[i].growth = "收获果实"+value[i].yield+"个,还剩"+value[i].yield+"个";
							value[i].progress = 1;
						} else {
							value[i].growth = "距离成熟还有" + transformationTime(int(cropXml.items.(@seed == value[i].crop).@time) - (int(date.time / 1000) - value[i].time));
							value[i].progress = (int(date.time/1000) - value[i].time)/int(cropXml.items.(@seed == value[i].crop).@time);
						}
					} else {
						num = 6;
					}
					//健康值
					//value[i].health = 
					var seed:Sprite = getChild(cropXml.items.(@seed == value[i].crop).@crop);
					for (var k:uint=0; k < seed.numChildren; k++) {
						var crop:DisplayObject = seed.getChildAt(k);
						if (k == num) {
							crop.visible = true;
						} else {
							crop.visible = false;
						}
					}
					seed.name = "xxxxxxxxx" + i;
					farmlandContainer.addChild(seed);
					seed.x = farmland.x;
					seed.y = farmland.y;
					_user.farmland[i].state = num;
				}
				if (value[i].farmland == "Wasteland" && virgin) {
					virgin = false;
					var reclaim:Sprite = createClip("Reclaim");
					reclaim.name = "reclaim";
					reclaim.x = farmland.x + (farmland.width - reclaim.width) / 2;
					reclaim.y = farmland.y - farmland.height / 3;
					farmlandContainer.addChild(reclaim);
				}
			}
			_bg.addChild(farmlandContainer);
		}
		//天气
		private function theWeather():void {
			var date:Date = new Date;
			var str:String;
			var currentHours:Number = date.getHours();
			if (currentHours > 6 && currentHours < 18) {
				if (_user.weather == undefined) {
					var num:Number = Math.random();
					if (num > 0.5) {
						str = "Rain";
					} else {
						str = "Sunny";
					}
					_user.weather = str;
				} else {
					str = _user.weather;
				}
			} else {
				str = "Night";
				_user.weather == undefined;
			}
			var weather:MovieClip = createClip(str);
			var it:IntroductionText;
			switch (str) {
				case "Rain" :
					it = new IntroductionText(weather, _stage, {titletext:"雨天", contenttext:"雨天地里不会干旱!" } );
					break;
				case "Sunny" :
					it = new IntroductionText(weather, _stage, {titletext:"晴天", contenttext:"炎热的天气小心地里干旱!" } );
					break;
				case "Night" :
					it = new IntroductionText(weather, _stage, {titletext:"夜晚", contenttext:"小心晚上出动的小偷!" } );
					break;
			}
			weather.x = (_stage.stageWidth - weather.width) / 2;
			_title.addChild(weather);
		}
		//返回   xx小时xx分钟xx秒
		public function transformationTime(value:uint):String {
			var hour:Number=int(value / 3600);//我们取小时
			var minute:Number=int((value - hour * 3600) / 60);//取分钟
			var second:Number = value - hour * 3600 - minute * 60;//我们取秒
			return hour + "小时" + minute + "分钟" + second + "秒";
		}
		private function installToolsBar():void {
			var interval:Number;
			_stage.addChild(_tools);
			var toolsBg:Sprite = createClip("ToolBarBg");
			toolsBg.name = "ToolBarBg";
			_tools.addChild(toolsBg);
			var cursor:SimpleButton = createButton("Cursor");
			cursor.name = "CursorArrow";
			interval = (toolsBg.width - cursor.width * 7) / 8;
			cursor.x = interval;
			cursor.y = -5;
			var it:IntroductionText = new IntroductionText(cursor, _stage, {titletext:"选择工具", contenttext:"可以选取物品和拖动农场!" } );
			_tools.addChild(cursor);
			var buttonSeed:SimpleButton = createButton("ButtonSeed");
			buttonSeed.name = "ButtonSeed";
			buttonSeed.x = cursor.x + cursor.width + interval;
			buttonSeed.y = -5;
			var it1:IntroductionText = new IntroductionText(buttonSeed, _stage, {titletext:"包袱", contenttext:"存放已购买的种子!" } );
			_tools.addChild(buttonSeed);
			var packBarBg:Sprite = createClip("PackBarBg");
			packBarBg.name = "PackBarBg";
			packBarBg.x = (toolsBg.width - packBarBg.width) / 2;
			packBarBg.y = -10 - packBarBg.height;
			_tools.addChild(packBarBg);
			showBurden();
			packBarBg.visible = false;
			var buttonHoe:SimpleButton = createButton("ButtonHoe");
			buttonHoe.name = "CursorHoe";
			buttonHoe.x = buttonSeed.x + buttonSeed.width + interval;
			buttonHoe.y = -5;
			var it2:IntroductionText = new IntroductionText(buttonHoe, _stage, {titletext:"铁锹", contenttext:"可以用来翻地!" } );
			_tools.addChild(buttonHoe);
			var buttonWater:SimpleButton = createButton("ButtonWater");
			buttonWater.name = "CursorWater";
			buttonWater.x = buttonHoe.x + buttonHoe.width + interval;
			buttonWater.y = -5;
			var it3:IntroductionText = new IntroductionText(buttonWater, _stage, {titletext:"浇水壶", contenttext:"可以用来浇水防旱(Q)!" } );
			_tools.addChild(buttonWater);
			var buttonHook:SimpleButton = createButton("ButtonHook");
			buttonHook.name = "CursorHook";
			buttonHook.x = buttonWater.x + buttonWater.width + interval;
			buttonHook.y = -5;
			var it4:IntroductionText = new IntroductionText(buttonHook, _stage, {titletext:"除草剂", contenttext:"可以用来除草(W)!" } );
			_tools.addChild(buttonHook);
			var buttonPesticide:SimpleButton = createButton("ButtonPesticide");
			buttonPesticide.name = "CursorPesticide";
			buttonPesticide.x = buttonHook.x + buttonHook.width + interval;
			buttonPesticide.y = -5;
			var it5:IntroductionText = new IntroductionText(buttonPesticide, _stage, {titletext:"杀虫剂", contenttext:"可以用来杀虫(E)!" } );
			_tools.addChild(buttonPesticide);
			var buttonHand:SimpleButton = createButton("ButtonHand");
			buttonHand.name = "CursorHand";
			buttonHand.x = buttonPesticide.x + buttonPesticide.width + interval;
			buttonHand.y = -5;
			var it6:IntroductionText = new IntroductionText(buttonHand, _stage, {titletext:"手套", contenttext:"用于收获果实(R)!" } );
			_tools.addChild(buttonHand);
			_tools.x = (_stage.stageWidth - _tools.width) / 2;
			_tools.y = _stage.stageHeight - toolsBg.height - 10;
		}
		//---------------读取包袱内的物品-------------------
		public function showBurden():void {
			var value:Array = _user.burden;
			var mc:Sprite = _tools.getChildByName("PackBarBg") as Sprite;
			if (mc.getChildByName("container") != null) {
				mc.removeChild(mc.getChildByName("container"));
			}
			var container:Sprite = new Sprite;
			container.name = "container";
			for (var i:uint; i < value.length; i++) {
				var bg:MovieClip = createClip("ItemBg");
				var seed:Sprite = createClip(value[i].Items);
				seed.name = value[i].Items;
				bg.addChild(seed);
				bg.name = value[i].Items;
				seed.x = (bg.width - seed.width) / 2;
				seed.y = (bg.height - seed.height) / 2;
				bg.x = (mc.height - bg.height) / 2 + (bg.width+(mc.height - bg.height) / 2) * i;
				bg.y = (mc.height - bg.height) / 2;
				bg.txt.text = value[i].number;
				bg.txt.mouseEnabled = false;
				container.addChild(bg);
			}
			mc.addChild(container);
		}
		//-----------------读取仓库内的物品----------------------
		public function showWarehouse():void {
			var value:Array = _user.warehouse;
			var interval:uint = 18;
			var mc:MovieClip = _stage.getChildByName("warehouse") as MovieClip;
			if (mc.getChildByName("container") != null) {
				mc.removeChild(mc.getChildByName("container"));
			}
			var container:Sprite = new Sprite;
			container.name = "container";
			var total:int;
			for (var i:uint; i < value.length; i++) {
				var bg:MovieClip = createClip("ItemBg");
				var fruit:Sprite = createClip(value[i].fruit);
				fruit.name = "bg" + i;
				bg.addChild(fruit);
				bg.name = "bg" + i;
				fruit.x = (bg.width - fruit.width) / 2;
				fruit.y = (bg.height - fruit.height) / 2;
				bg.x = 15 + i % int((mc.width - interval) / (bg.width + interval)) * (bg.width+interval);
				bg.y = 65 + ((i/int((mc.width-interval)/(bg.width + interval))) >> 0) * (bg.width + interval);
				bg.txt.text = value[i].number;
				bg.txt.mouseEnabled = false;
				bg.buttonMode = true;
				total +=  int(value[i].number) * int(value[i].price);
				container.addChild(bg);
			}
			mc.worth_txt.text = total;
			mc.addChild(container);
		}
		//更新经验等级和金钱
		public function changeExp():void {
			if (int(_user.experience) < int(_user.rank) * EXP) {
				experienceBar.bar.width = (int(int(_user.experience) / (int(_user.rank) * EXP) * 120));
			} else {
				_user.experience = int(_user.experience) - int(_user.rank) * EXP;
				_user.rank = int(_user.rank) + 1;
				experienceBar.bar.width = (int(int(_user.experience) / (int(_user.rank) * EXP) * 120));
			}
			experienceBar.username.text = _user.username;
			experienceBar.wealth_txt.text = _user.wealth;
			experienceBar.rank_txt.text = _user.rank;
			if (myIntro != null) {
				myIntro.infoObject = { title:"等级: " + String(_user.rank), content:"当前经验: " + String(_user.experience) + " / " + String(int(_user.rank) * EXP) } ;
			}
		}
		private function installHead():void {
			var headBg:Sprite = createClip("HeadBg");
			headBg.x = (_stage.stageWidth - headBg.width) / 2;
			_title.addChild(headBg);
			var picture:Sprite = createClip("TipBg");
			picture.y = (headBg.height - picture.height) / 2;
			picture.x = (headBg.height - picture.height) / 2;
			_title.addChild(picture);
			experienceBar = createClip("ExpBar");
			experienceBar.x = picture.x + picture.width + (headBg.height - picture.height) / 2;
			experienceBar.y = (headBg.height - experienceBar.height) / 2;
			experienceBar.username.text = _user.username;
			experienceBar.username.mouseEnabled = false;
			experienceBar.wealth_txt.text = _user.wealth;
			experienceBar.wealth_txt.mouseEnabled = false;
			experienceBar.rank_txt.text = _user.rank;
			experienceBar.rank_txt.mouseEnabled = false;
			experienceBar.rank_txt.autoSize = "left";
			experienceBar.name = "experienceBar";
			_title.addChild(experienceBar);
			var buttonDecorate:SimpleButton = createButton("ButtonDecorate");
			buttonDecorate.x = _stage.stageWidth - buttonDecorate.width - (headBg.height - buttonDecorate.height) / 2;
			buttonDecorate.y = (headBg.height - buttonDecorate.height) / 2;
			buttonDecorate.name = "ButtonDecorate";
			var it:IntroductionText = new IntroductionText(buttonDecorate, _stage, {titletext:"饰品店", contenttext:"里面可以购买物品来装扮农场!" } );
			_title.addChild(buttonDecorate);
			var buttonShop:SimpleButton = createButton("ButtonShop");
			buttonShop.x = buttonDecorate.x - buttonShop.width - (headBg.height - buttonDecorate.height) / 2;
			buttonShop.y = (headBg.height - buttonShop.height) / 2;
			buttonShop.name = "ButtonShop";
			var it1:IntroductionText = new IntroductionText(buttonShop, _stage, {titletext:"商店", contenttext:"可以购买一些你需要的物品!" } );
			_title.addChild(buttonShop);
			var buttonWarehouse:SimpleButton = createButton("ButtonWarehouse");
			buttonWarehouse.x = buttonShop.x - buttonWarehouse.width - (headBg.height - buttonDecorate.height) / 2;
			buttonWarehouse.y = (headBg.height - buttonWarehouse.height) / 2;
			buttonWarehouse.name = "ButtonWarehouse";
			var it2:IntroductionText = new IntroductionText(buttonWarehouse, _stage, {titletext:"仓库", contenttext:"存放我的物品!" } );
			_title.addChild(buttonWarehouse);
			var buttonFarm:SimpleButton = createButton("ButtonFarm");
			buttonFarm.x = buttonWarehouse.x - buttonFarm.width - (headBg.height - buttonDecorate.height) / 2;
			buttonFarm.y = (headBg.height - buttonFarm.height) / 2;
			buttonFarm.name = "ButtonFarm";
			var it3:IntroductionText = new IntroductionText(buttonFarm, _stage, {titletext:"我的农场", contenttext:"我的农场和作物!" } );
			_title.addChild(buttonFarm);
			_stage.addChild(_title);
			_shop = createClip("MyStore");
			_shop.name = "MyStore";
			_shop.x = (_stage.stageWidth - _shop.width) / 2;
			_shop.y = (_stage.stageHeight - _shop.height) / 2;
			_shop.tab1.buttonMode = true;
			_shop.tab2.buttonMode = true;
			_shop.tab3.buttonMode = true;
			//_showBox = createClip("ShowBox");
			//_showBox.name = "ShowBox"
			_stage.addChild(_shop);
			_shop.visible = false;
			_warehouse = createClip("warehouse");
			_warehouse.name = "warehouse";
			_warehouse.x = (_stage.stageWidth - _warehouse.width) / 2;
			_warehouse.y = (_stage.stageHeight - _warehouse.height) / 2;
			_warehouse.worth_txt.mouseEnabled = false;
			_stage.addChild(_warehouse);
			showWarehouse();
			_warehouse.visible = false;
			//===================开始安装控制============================
			control = Control.getInstance();
			control.installControl();

			_stage.addChild(_myMouse);
			changeExp();
			//----------------tips---------------------------
			myIntro = new IntroductionText(experienceBar, _stage, {titletext:"等级: "+String(_user.rank), contenttext:"当前经验: "+String(_user.experience)+" / "+String(int(_user.rank)*EXP)} );
		}
		private function createClip(className:String):MovieClip {
			var clip:MovieClip;
			var thisDomain:ApplicationDomain;
			thisDomain=_loaderInfo.applicationDomain;
			clip=app.createMc(className,thisDomain);
			if (clip == null) {
				clip = null;
			}
			return clip;
		}
		public function getChild(_name:String):MovieClip {
			return createClip(_name);
		}
		private function createButton(className:String):SimpleButton {
			var but:SimpleButton;
			var thisDomain:ApplicationDomain;
			thisDomain=_loaderInfo.applicationDomain;
			but=app.createButton(className,thisDomain);
			if (but == null) {
				but = null;
			}
			return but;
		}
	}
}