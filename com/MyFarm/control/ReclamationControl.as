package com.MyFarm.control
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import com.MyFarm.view.InstallFace;
	
	/**
	 * ...
	 * @author Salted fish (www.shch8.com) qq:181404930
	 */
	public class ReclamationControl
	{
		private var tips:MovieClip;
		private var bg:Sprite;
		private var face:InstallFace = InstallFace.getInstance();
		private var reclaim:Sprite;
		private var click:Boolean;
		public function ReclamationControl() 
		{
			reclaim = face.farmlandContainer.getChildByName("reclaim") as Sprite;
			if (reclaim != null)
			{
			reclaim.buttonMode = true;
			reclaim.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			reclaim.addEventListener(MouseEvent.CLICK, reclaimClickHandler);
		    }
		}
		private function onOver(evt:MouseEvent):void
		{
			Mouse.show();
			face._myMouse.visible = false;
			reclaim.addEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		private function onOut(evt:MouseEvent):void
		{
			if (!click)
			{
			Mouse.hide();
			face._myMouse.visible = true;
			reclaim.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			}
		}
		private function reclaimClickHandler(event:MouseEvent):void
		{
			click = true;
			Mouse.show();
			face._myMouse.visible = false;
			bg = createShape(face._stage.stageWidth, face._stage.stageHeight);
			face._stage.addChild(bg);
			tips = face.getChild("Tips2");
			face._stage.addChild(tips);
			tips.x = (face._stage.stageWidth - tips.width) / 2;
			tips.y = (face._stage.stageHeight - tips.height) / 2;
			if (face._user.wealth > 10000)
			{
			tips.txt.text = "开垦新地需要10000金币,你已经达到要求是否要开垦!";
			tips.define.mouseEnabled = true;
			}
			else
			{
			tips.txt.text = "开垦新地需要10000金币,你没达到要求无法开垦!";
			tips.define.mouseEnabled = false;
			}
			tips.define.addEventListener(MouseEvent.CLICK, defineClick);
			tips.cancel.addEventListener(MouseEvent.CLICK, closeHandler);
			tips.close_btn.addEventListener(MouseEvent.CLICK, closeHandler);
		}
		private function defineClick(event:MouseEvent):void
		{
			face.reclaimedWasteland();
			face._user.wealth = int(face._user.wealth) - 10000;
			face.so.data.user = face._user;
			face.so.flush();
			closeHandler();
			face.changeExp();
		}
		private function closeHandler(event:MouseEvent = null):void
		{
			Mouse.hide();
			face._myMouse.visible = true;
			face._stage.removeChild(bg);
			face._stage.removeChild(tips);
			tips.define.removeEventListener(MouseEvent.CLICK, defineClick);
			tips.cancel.removeEventListener(MouseEvent.CLICK, closeHandler);
			tips.close_btn.removeEventListener(MouseEvent.CLICK, closeHandler);
			reclaim.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			click = false;
			bg = null;
			tips = null;
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