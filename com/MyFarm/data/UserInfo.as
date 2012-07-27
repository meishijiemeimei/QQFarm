package com.MyFarm.data 
{
	
	/**
	 * ...
	 * @author Salted fish (www.shch8.com) qq:181404930
	 */
	public class UserInfo 
	{
		public var username:String = "";//用户名
		public var wealth:String = "";//财富
		public var house:String = "";//房子
		public var kennel:String = "";//狗窝
		public var fence:String = "";//栅栏
		public var experience:String = "";//经验值
		public var rank:String = "";//等级
		public var weather:String = "";//天气
		public var burden:Array = new Array();//包袱:存放已买物品
		public var warehouse:Array = new Array();//仓库:存放已收获的物品
		public var farmland:Array = new Array();//农田:里面包含了农田状态,作物状态等信息.
		public function UserInfo()
		{
			
		}
		
	}
	
}