package com.MyFarm{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.display.MovieClip;
	import com.MyFarm.view.InstallFace;
	import flash.display.LoaderInfo;
	import flash.net.SharedObject;
	import com.MyFarm.data.UserInfo;
	/**
	 * ...
	 * 主程序
	 * @author Salted fish (www.shch8.com)
	 */
	public class FarmMain extends Sprite {
		private var skinXmlUrl:String = "com/MyFarm/data/xml/skin.xml";//存放皮肤路径xml.
		private var cropXmlUrl:String = "com/MyFarm/data/xml/Crop.xml";//作物的xml.
		private var skinXml:XML;
		private var num:uint;
		private var movie:MovieClip;
		private var loadingBar:MovieClip;
		private var face:InstallFace;
		private var isLocation:Boolean;
		private var loader:Loader;
		private var urlloader:URLLoader;
		private var urlloader2:URLLoader;
		public function FarmMain() {
			//判断是本地还是网络.
			isLocation = (stage.loaderInfo.url).substr(0, 8) == "file:///"?true:false;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			if (isLocation) {
				this.addEventListener(Event.ADDED_TO_STAGE, locationInit);
			} else {
				//加载网络
			}
		}
		private function locationInit(event:Event):void {
			var so:SharedObject = SharedObject.getLocal("test", "/");
			face = InstallFace.getInstance();
			if (so.data.user != undefined) {
				face._user = so.data.user;
			} else {
				var user:UserInfo = new UserInfo();
				user.username = "咸鱼";
				user.wealth = "2000";
				user.house = "house";
				user.kennel = "kennel";
				user.fence = "fence";
				user.experience = "1";
				user.rank = "01";
				user.burden = new Array();
				user.warehouse = new Array();
				user.farmland = new Array( { farmland:"FarmlandS" }, { farmland:"FarmlandS" }, { farmland:"FarmlandS" }, { farmland:"FarmlandS" }, { farmland:"FarmlandS" }, { farmland:"FarmlandS" }, { farmland:"Wasteland" }, { farmland:"Wasteland" }, { farmland:"Wasteland" }, { farmland:"Wasteland" }, { farmland:"Wasteland" }, { farmland:"Wasteland" }, { farmland:"Wasteland" }, { farmland:"Wasteland" }, { farmland:"Wasteland" }, { farmland:"Wasteland" }, { farmland:"Wasteland" }, { farmland:"Wasteland" } );
				user.burden = new Array();// { name:"草莓",Items:"StrawberrySeed", number:3 }, {  name:"桃子",Items:"PeachSeed", number:5 }, {  name:"豌豆",Items:"PeaSeed", number:1 }
				user.warehouse = new Array();//{ name:"草莓",fruit:"StrawberrySeed",number:85,price:26},{ name:"桃子",fruit:"PeachSeed",number:26,price:30},{ name:"香蕉",fruit:"BananaSeed",number:18,price:43},{ name:"柚子",fruit:"PomeloSeed",number:52,price:23},{ name:"菠萝",fruit:"PineappleSeed",number:65,price:27},{ name:"辣椒",fruit:"ChiliSeed",number:34,price:35},{ name:"西红柿",fruit:"TomatoSeed",number:76,price:21}
				user.weather = "Sunny";
				so.data.user = user;
				so.flush();
				face._user = user;
				user = null;
			}
			so = null;
			movie = new openingMovie();//加载动画
			movie.x = (stage.stageWidth - 172) / 2;
			movie.y = (stage.stageHeight - 400) / 2;
			addChild(movie);
			loadingBar = new progressBar();//加载进度条
			loadingBar.x = (stage.stageWidth - loadingBar.width) / 2;
			loadingBar.y = (stage.stageHeight - loadingBar.height) / 2;
			loadingBar.txt.mouseEnabled = false;
			addChild(loadingBar);
			//首先加载皮肤的XML。
			urlloader = new URLLoader(new URLRequest(skinXmlUrl));
			urlloader.addEventListener(Event.COMPLETE, loadedSkinXmlComplete);
		}
		private function loadedSkinXmlComplete(event:Event):void {
			urlloader.removeEventListener(Event.COMPLETE, loadedSkinXmlComplete);
			urlloader = null;
			skinXml = XML(event.target.data);
			//加载作物的XML。
			urlloader2 = new URLLoader(new URLRequest(cropXmlUrl));
			urlloader2.addEventListener(Event.COMPLETE, loadCropXmlComplete);
		}
		private function loadCropXmlComplete(event:Event):void {
			face.cropXml = XML(event.target.data);
			loopLoadSkin();
		}
		private function loopLoadSkin():void {
			loader = new Loader();
			//加载皮肤。
			loader.load(new URLRequest(skinXml.skin[num].@url));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, skinLoadComplete);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, skinLoadProgress);
		}
		private function skinLoadProgress(event:ProgressEvent):void {
			if (movie.currentFrame == 58) {
				movie.gotoAndPlay("loading");
			}
			var i:uint = int(event.bytesLoaded / event.bytesTotal * 100);
			loadingBar.gotoAndStop(i);
			loadingBar.txt.text = "加载"+skinXml.skin[num].@name+i+"%";
		}
		private function skinLoadComplete(event:Event):void {
			if (skinXml.skin[num].@name == "道具") {
				//获取皮肤SWF的LoaderInfo。
				face.loaderInfo = LoaderInfo(event.target);
			}
			num++;
			if (num < skinXml.skin.length()) {
				loopLoadSkin();
			} else {
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, skinLoadComplete);
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, skinLoadProgress);
				loader = null;
				this.removeChild(movie);
				movie = null;
				this.removeChild(loadingBar);
				loadingBar = null;
				face._stage = stage;
				//开始安装.
				face.install();
			}
			loader = null;
			movie = null;
			loadingBar = null;
			urlloader = null;
		}
	}
}