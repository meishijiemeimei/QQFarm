package com.MyFarm.control 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent
	import com._public._displayObject.Card;
	import flash.ui.Mouse;
	import com.MyFarm.view.InstallFace
	
	
	/**
	 * ...
	 * 农田控制
	 * @author Salted fish (www.shch8.com) qq:181404930
	 */
	public class FarmlandControl
	{
		private var myCard:Card = new Card;
		private var tips:MovieClip;
		private var bg:Sprite;
		private var num:Number;
		private var progress:MovieClip;
		private var crop:DisplayObjectContainer;
		private var count:uint;
		private var face:InstallFace = InstallFace.getInstance();
		public function FarmlandControl()
		{
			face.farmlandContainer.addEventListener(MouseEvent.MOUSE_OVER, farmlandOverHandler);
			face.farmlandContainer.addEventListener(MouseEvent.CLICK, farmlandClickHandler);
			face._stage.addChild(myCard);
		}
		private function farmlandOverHandler(event:MouseEvent):void
		{
			var str:String = String(event.target.name).slice(0, 9);
			if (str == "FarmlandS")
			{
			var mc:MovieClip = face.farmlandContainer.getChildByName(event.target.name) as MovieClip;
			if (mc != null)
			{
			mc.gotoAndStop(2);
			mc.addEventListener(MouseEvent.MOUSE_OUT, farmlandOutHandler);
			}
			}
			if (count == 0)
			{
			addListener();
			}
		}
		private function addListener():void
		{
			for (var i:uint; i < face.farmlandContainer.numChildren; i++ )
			{
			var mc:DisplayObject = face.farmlandContainer.getChildAt(i);
			if (mc.name.indexOf("xxxxxxxxx") > -1)
			{
			mc.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			}
			}
		}
		private function rollOverHandler(event:MouseEvent):void
		{
			var num:uint = int(String(event.target.name).slice(9, String(event.target.name).length));
			if (face._user.farmland[num].harvest == undefined)
			{
			progress = face.getChild("FarmInfo");
			face._stage.addChild(progress);
			progress.growText.text = face._user.farmland[num].growth;
			progress.growBar.width = 122 * Number(face._user.farmland[num].progress);
			progress.x = face._stage.mouseX;
			progress.y = face._stage.mouseY;
			event.target.addEventListener(MouseEvent.ROLL_OUT, cropMouseOut);
			}
		}
		private function cropMouseOut(event:MouseEvent):void
		{
			face._stage.removeChild(progress);
			event.target.removeEventListener(MouseEvent.ROLL_OUT, cropMouseOut);
		}
		private function farmlandOutHandler(event:MouseEvent):void
		{
			event.target.removeEventListener(MouseEvent.MOUSE_OUT, farmlandOutHandler);
			var mc:MovieClip = event.target as MovieClip;
			if (mc != null)
			mc.gotoAndStop(1);
		}
		private function farmlandClickHandler(event:MouseEvent):void
		{
			var str:String = String(event.target.name).slice(0, 9);
			if (event.target.parent.name == face.farmlandContainer.name)
			{
			num = Number(String(event.target.name).slice(9, String(event.target.name).length));
			}
			else
			{
			num = Number(String(event.target.parent.name).slice(9, String(event.target.parent.name).length));
			}
			if (str != "Wasteland"&&event.target!=face.farmlandContainer.getChildByName("reclaim"))
			{
			if (face._myMouse.name == "CursorHoe")
			{
				trace("铁锹")
				if (face._user.farmland[num].crop != undefined)
				{
				if (face._user.farmland[num].harvest == undefined)
				{
				Mouse.show();
				face._myMouse.visible = false;
				tips = face.getChild("Tips2");
				bg = createShape(face._stage.stageWidth, face._stage.stageHeight);
				face._stage.addChild(bg);
				face._stage.addChild(tips);
				tips.x = (face._stage.stageWidth - tips.width) / 2;
				tips.y = (face._stage.stageHeight - tips.height) / 2;
				tips.txt.text = "是否确定要铲除!!!";
				tips.txt.mouseEnabled = false;
				tips.define.addEventListener(MouseEvent.CLICK, tipsDefineHandler);
				tips.cancel.addEventListener(MouseEvent.CLICK, tipsCloseHandler);
				tips.close_btn.addEventListener(MouseEvent.CLICK, tipsCloseHandler);
				}
				else
				{
				face.farmlandContainer.removeChild(face.farmlandContainer.getChildByName("xxxxxxxxx"+num));
				face._user.farmland[num].crop = undefined;
		    	face._user.farmland[num].state = undefined;
		    	face._user.farmland[num].time = undefined;
		    	face._user.farmland[num].growth = undefined;
				face._user.farmland[num].harvest = undefined;
				face._user.farmland[num].progress = undefined;
		    	face.so.data.user = face._user;
		    	face.so.flush();
				}
				}
				else
				{
				myCard.showCard("不允许对空地进行操作!");
				myCard.x = face._bg.x + face._farmland_array[num].x + (face._farmland_array[num].width - myCard.width) / 2;
				myCard.y = face._bg.y + face._farmland_array[num].y + face._farmland_array[num].height / 2 - myCard.height;
				}
			}
			else if (face._myMouse.name == "CursorWater")
			{
				trace("水壶")
				if (str == "FarmlandG")
				{
				
				}
				else
				{
				myCard.showCard("这块地不用浇水!");
				myCard.x = face._bg.x + face._farmland_array[num].x + (face._farmland_array[num].width - myCard.width) / 2;
				myCard.y = face._bg.y + face._farmland_array[num].y + face._farmland_array[num].height / 2 - myCard.height;
				}
			}
			else if (face._myMouse.name == "CursorHook")
			{
			//--------------------除草---------------------------判断是否长草，有草除草.
			    trace("除草剂")
				if (face._user.farmland[num].grass != undefined)
				{
				
				}
				else
				{
				myCard.showCard("这块地不用除草!");
				myCard.x = face._bg.x + face._farmland_array[num].x + (face._farmland_array[num].width - myCard.width) / 2;
				myCard.y = face._bg.y + face._farmland_array[num].y + face._farmland_array[num].height / 2 - myCard.height;
				}
			}
			else if (face._myMouse.name == "CursorPesticide")
			{
			//---------------------杀虫--------------------------判断是否有虫，有虫就可以杀虫.
			    trace("杀虫剂")
				if (face._user.farmland[num].worm != undefined)
				{
				
				}
				else
				{
				myCard.showCard("这块地不用杀虫!");
				myCard.x = face._bg.x + face._farmland_array[num].x + (face._farmland_array[num].width - myCard.width) / 2;
				myCard.y = face._bg.y + face._farmland_array[num].y + face._farmland_array[num].height / 2 - myCard.height;
				}
			}
			else if (face._myMouse.name == "CursorHand")
			{
			//-----------------------收割--------------------------判断是否有产量，有产量表示已经成熟.
			    trace("手套")
				if (face._user.farmland[num].progress == 1&&face._user.farmland[num].harvest == undefined)
				{
				trace("成熟")
				var mc:MovieClip = face.farmlandContainer.getChildByName("xxxxxxxxx" + num) as MovieClip;
				if (mc != null)
				{
				for (var p:uint; p < mc.numChildren;p++ )
				{
				if (p != 6)
				{
				mc.getChildAt(p).visible = false;
				}
				else
				{
				mc.getChildAt(p).visible = true;
				}
				}
				var being:Number = -1;
				for (var m:uint; m < face._user.warehouse.length; m++ )
				{
				if (face._user.farmland[num].crop == face._user.warehouse[m].fruit)
				{
				being = m;
				break;
				}
				}
				if (being>-1)
				{
				face._user.warehouse[being].number = int(face._user.warehouse[being].number) + face._user.farmland[num].yield;
				}
				else
				{
				face._user.warehouse.push( { fruit:face._user.farmland[num].crop, number:face._user.farmland[num].yield,name:String(face.cropXml.items.(@seed == face._user.farmland[num].crop).@name) , price:int(face.cropXml.items.(@seed == face._user.farmland[num].crop).@price) } );
				}
				face.showWarehouse();
				face._user.farmland[num].progress = undefined;
				face._user.farmland[num].harvest = "xx";
				face._user.experience = int(face._user.experience) + int(face.cropXml.items.(@seed == face._user.farmland[num].crop).@experience);
				trace(int(face.cropXml.items.(@seed == face._user.farmland[num].crop).@experience))
				face.changeExp();
				face.so.data.user = face._user;
				face.so.flush();
				}
				}
				else
				{
				myCard.showCard("这块地没有东西可收获!");
				myCard.x = face._bg.x + face._farmland_array[num].x + (face._farmland_array[num].width - myCard.width) / 2;
				myCard.y = face._bg.y + face._farmland_array[num].y + face._farmland_array[num].height / 2 - myCard.height;
				}
			}
			else
			{
			trace("其他(种子、肥料、选择工具)")
			if (face._myMouse.name.indexOf("Seed") > 0)
			{
			if (face._user.farmland[num].crop != undefined)
			{
			    myCard.showCard("不可以种在这里哦!");
				myCard.x = face._bg.x + face._farmland_array[num].x + (face._farmland_array[num].width - myCard.width) / 2;
				myCard.y = face._bg.y + face._farmland_array[num].y + face._farmland_array[num].height / 2 - myCard.height;
			}
			else
			{
				var seed:Sprite = face.getChild(face.cropXml.items.(@seed == face._myMouse.name).@crop);
				seed.name = "xxxxxxxxx" + num;
				for (var k:uint; k < seed.numChildren; k++ )
				{
					var crop:DisplayObject = seed.getChildAt(k);
					if (k == 0)
					{
					crop.visible = true;
					}
					else
					{
					crop.visible = false;	
					}
				}
				face.farmlandContainer.addChild(seed);
				seed.x = event.target.x;
				seed.y = event.target.y;
				face._user.farmland[num].crop = face._myMouse.name;
				face._user.farmland[num].state = "0";
				face._user.farmland[num].growth = "距离成熟还有" + face.transformationTime(face.cropXml.items.(@seed == face._myMouse.name).@time);
				face._user.farmland[num].progress = 0;
				var date:Date = new Date();
				face._user.farmland[num].time = int(date.time / 1000);
				for (var i:uint; i < face._user.burden.length; i++ )
				{
				if (face._user.burden[i].Items == face._myMouse.name)
				{
				face._user.burden[i].number = int(face._user.burden[i].number) - 1;
				if (face._user.burden[i].number == "0")
				{
				face._user.burden.splice(i, 1);
				face.changeMouse("CursorArrow");
				}
				}
				}
				face.showBurden();
				face.so.data.user = face._user;
				face.so.flush();
			}
			}
			}
			}
		}
		private function tipsDefineHandler(event:MouseEvent):void
		{
			face.farmlandContainer.removeChild(face.farmlandContainer.getChildByName("xxxxxxxxx"+num));
			face._user.farmland[num].crop = undefined;
			face._user.farmland[num].state = undefined;
			face._user.farmland[num].time = undefined;
			face._user.farmland[num].growth = undefined;
			face._user.farmland[num].progress = undefined;
			tipsCloseHandler();
			face.so.data.user = face._user;
			face.so.flush();
		}
		private function tipsCloseHandler(event:MouseEvent = null):void
		{
			Mouse.hide();
			face._myMouse.visible = true;
			face._stage.removeChild(tips);
			face._stage.removeChild(bg);
			tips.define.removeEventListener(MouseEvent.CLICK, tipsDefineHandler);
			tips.cancel.removeEventListener(MouseEvent.CLICK, tipsCloseHandler);
			tips.close_btn.removeEventListener(MouseEvent.CLICK, tipsCloseHandler);
			tips = null;
			bg = null;
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