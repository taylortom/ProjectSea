package com.gamejam.datatypes
{
	// Flash imports
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import com.gamejam.display.GameObject;
	import com.gamejam.views.GameView;
	
	/*
	 * An abstract camera datatype
	 * Used to position all game objects
 	 */
	public class Camera
	{	
		private var _position:Point
	
		public function Camera(pos:Point)
		{
			trace("Camera.Camera: (" + pos.x + "," + pos.y + ")");
			this._position = new Point(pos.x, pos.y);
		}
		
		public function incrementX(amount:Number):void 
		{ 
			var gos:Array = GameView.getInstance().gameObjects;
			
			for(var i = 0; i < gos.length; i++)
			{
				var go:GameObject = gos[i];
				go.x += amount;
			}
		}
		
		public function incrementY(amount:Number):void 
		{ 
			var gos:Array = GameView.getInstance().gameObjects;
			
			for(var i = 0; i < gos.length; i++)
			{
				var go:GameObject = gos[i];
				go.y += amount;
			}
		}
	}
}
