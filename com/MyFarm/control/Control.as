package com.MyFarm.control 
{
	import com._public._util.DragTools;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event
	import flash.ui.Mouse;
	import flash.geom.Rectangle;
	import com.MyFarm.view.InstallFace;
	/**
	 * ...控制
	 * @author Salted fish (www.shch8.com) qq:181404930
	 */
	public class Control
	{
		public static var instance:Control;
		private var face:InstallFace = InstallFace.getInstance();
		private var rectangle:Rectangle;
		private var dragTools:DragTools;
		private var startX:Number;
		private var startY:Number;
		//--------------------------------
		private var farmlandControl:FarmlandControl;
		private var toolsBarControl:ToolsBarControl;
		private var titleControl:TitleControl;
		private var reclamationControl:ReclamationControl
		//----------------------------------
		
		public function Control()
		{
		    super();
		}
		public static function getInstance():Control
		{
			if (instance == null)
			{
			return instance = new Control();
			}
			else
			{
			return instance;
			}
		}
		public function installControl():void
		{
			//===================鼠标===============================
			Mouse.hide();
		    face._bg.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			//===================农田=============================
			if (farmlandControl == null)
			{
			farmlandControl = new FarmlandControl;
			reclamationControl = new ReclamationControl;
			//===================工具栏===========================
			toolsBarControl = new ToolsBarControl;
			//===================标题栏===========================
			titleControl = new TitleControl;
			//---------------------------------------------
			dragTools = new DragTools(face._bg, { methods:"bitmap" } );
			}
		}
		private function mouseOverHandler(event:MouseEvent):void
		{
			face._stage.addEventListener(MouseEvent.MOUSE_MOVE, enterFrameHandler);
			face._bg.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		private function enterFrameHandler(event:Event):void
		{
			face._myMouse.x = face._stage.mouseX;
			face._myMouse.y = face._stage.mouseY;
		}
		private function mouseDownHandler(event:MouseEvent):void
		{
			if (face._myMouse.name == "CursorArrow")
			{
			face._myMouse.gotoAndPlay(2);
			}
		//----------------------背景拖动---------------------------
		    startX = face._stage.mouseX;
			startY = face._stage.mouseY;
		    rectangle = new Rectangle(0, 0, face._stage.stageWidth - face._bg.width + 40, face._stage.stageHeight -face._bg.height + 10);
			//face._bg.startDrag(false, rectangle);
			face._stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			face._stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		private function onMove(evt:MouseEvent):void
		{
			var numX:int = int(startX - face._stage.mouseX);
			var numY:int = int(startY - face._stage.mouseY);
			if (numX<10||numX>10||numY<10||numY>10)
			{
			face._stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMove)
			dragTools.beginDrag(false, rectangle);
			}
		}
		private function mouseUpHandler(event:MouseEvent):void
		{
			if (face._myMouse.name == "CursorArrow")
			{
			face._myMouse.gotoAndStop(1);
			}
		//-----------------------------------------------------------
		    //face._bg.stopDrag();
			dragTools.endDrag();
			rectangle = null;
			face._stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMove)
			face._stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			if (face._myMouse.name != "CursorArrow")
			{
			face._myMouse.gotoAndPlay(2);
			}
		}
	}
	
}