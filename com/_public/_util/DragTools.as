package com._public._util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Salted fish (www.shch8.com) qq:181404930
	 */
	public class DragTools 
	{
		private var target:Sprite;
		private var object:Object;
		private var bm:Bitmap;
		private var ra:Bitmap;
		private var container:Sprite = new Sprite;
		private var bd:BitmapData
		/**
	    * ...
	    * _target:Sprite 目标对象
		* _object:Object 包涵了拖动设置
		* @param methods    String
		* bitmap  //拖动的时候生成位图，当拖动完成的时候在移动对象并且清除位图
		* rectangle //拖动的时候生成一个范围框，也就是该对象的最大范围，移动完成的时候消失。
	    */
		public function DragTools(_target:Sprite,_object:Object)
		{
			target = _target;
			object = _object;
		}
		public function beginDrag(lockCenter:Boolean = false, bounds:Rectangle = null):void
		{
			if (object.methods == "bitmap")
			{
			if (bm != null) return;
			var rect:Rectangle = target.getBounds(target.parent);
			bd = new BitmapData(rect.width, rect.height);
			bd.draw(target);
			bm = new Bitmap(bd);
			container.addChild(bm);
			container.x = target.x;
			container.y = target.y;
			target.visible = false;
			target.parent.addChildAt(container,target.parent.getChildIndex(target));
			container.startDrag(lockCenter, bounds);
			}else if (object.methods == "rectangle")
			{
			container.graphics.lineStyle(4, 0x996633);
			container.graphics.beginFill(0x000000, 0);
			container.graphics.drawRect(0, 0, target.width, target.height);
			container.graphics.endFill();
			container.x = target.x;
			container.y = target.y;
			target.parent.addChildAt(container,target.parent.getChildIndex(target)+1);
			container.startDrag(lockCenter, bounds);
			}else
			{
			target.startDrag(lockCenter, bounds);
			}
		}
		public function endDrag():void
		{
			if (object.methods == "bitmap")
			{
			if (bm == null) return;
			target.x = container.x;
			target.y = container.y;
			container.removeChild(bm);
			target.parent.removeChild(container);
			bm = null;
			target.visible = true;
			bd.dispose();
			bd = null;
			}else if (object.methods == "rectangle")
			{
			target.x = container.x;
			target.y = container.y;
			container.graphics.clear();
			container.x = 0;
			container.y = 0;
			target.parent.removeChild(container);
			}else
			{
			target.stopDrag();
			}
		}
	}
	
}