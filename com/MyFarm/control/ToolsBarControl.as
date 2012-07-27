package com.MyFarm.control 
{
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Mouse;
	import com.MyFarm.view.InstallFace;
	
	/**
	 * ...
	 * @author Salted fish (www.shch8.com) qq:181404930
	 */
	public class ToolsBarControl
	{
		private var face:InstallFace = InstallFace.getInstance();
		public function ToolsBarControl() 
		{
			face._tools.addEventListener(MouseEvent.MOUSE_UP, toolsSelected);
			face._stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			face._tools.addEventListener(MouseEvent.MOUSE_OVER, toolsOverHandler);
		}
		private function toolsOverHandler(event:MouseEvent):void
		{
		    Mouse.show();
			face._myMouse.visible = false;
			face._tools.addEventListener(MouseEvent.MOUSE_OUT, toolsOutHandler);
		}
		private function toolsOutHandler(event:MouseEvent):void
		{
			Mouse.hide();
			face._myMouse.visible = true;
			face._tools.removeEventListener(MouseEvent.MOUSE_OUT, toolsOutHandler);
		}
		private function keyUpHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == 81)
			{
			face.changeMouse("CursorWater");
			}
			else if (event.keyCode == 87)
			{
			face.changeMouse("CursorHook");
			}
			else if (event.keyCode == 69)
			{
			face.changeMouse("CursorPesticide");
			}
			else if (event.keyCode == 82)
			{
			face.changeMouse("CursorHand");
			}
		}
		private function toolsSelected(event:MouseEvent):void
		{
			if(event.target.name=="CursorArrow"||event.target.name=="CursorHand"||event.target.name=="CursorHook"||event.target.name=="CursorPesticide"||event.target.name=="CursorWater"||event.target.name=="CursorHoe")
			face.changeMouse(event.target.name);
			if (event.target.name == "ButtonSeed")
			{
			if (!face._tools.getChildByName("PackBarBg").visible)
			{
			face._bg.addEventListener(MouseEvent.CLICK, clickHandler);
			face._tools.getChildByName("PackBarBg").visible = true;
			face._tools.getChildByName("PackBarBg").addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			face.changeMouse("CursorArrow");
			}
			else
			{
			face._tools.getChildByName("PackBarBg").visible = false;
			}
			}
			if (String(event.target.name).indexOf("Seed")>0)
			{
				face.changeMouse(event.target.name);
			}
		}
		private function clickHandler(event:MouseEvent):void
		{
			face._tools.getChildByName("PackBarBg").visible = false;
			face._bg.removeEventListener(MouseEvent.CLICK, clickHandler);
			face._tools.getChildByName("PackBarBg").removeEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			face._tools.getChildByName("PackBarBg").removeEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
		}
		private function mouseOverHandler(event:MouseEvent):void
		{
			face._tools.getChildByName("PackBarBg").addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
		}
		private function mouseOutHandler(event:MouseEvent):void
		{
			face._tools.getChildByName("PackBarBg").visible = false;
			face._bg.removeEventListener(MouseEvent.CLICK, clickHandler);
			face._tools.getChildByName("PackBarBg").removeEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			face._tools.getChildByName("PackBarBg").removeEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
		}
	}
	
}