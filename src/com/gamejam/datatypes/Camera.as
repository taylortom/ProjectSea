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
		
		private var _paused : Boolean = false;
		
		public function Camera()
		{
			this._position = new Point(0, 650);
		}
		
		public function incrementX(amount:Number):void 
		{ 
			var gos:Array = GameView.getInstance().gameObjects;
			
			if (!_paused)
			{
				this._position.x += amount;
				for(var i = 0; i < gos.length; i++)
				{
					var go:GameObject = gos[i];
					go.x -= amount;
				}
			}
			else GameView.getInstance().player.x += amount;
		}

		public function incrementY(amount:Number):void 
		{ 
			var gos:Array = GameView.getInstance().gameObjects;
			var player:Player = GameView.getInstance().player;
			
			if (!_paused)
			{
				this._position.y += amount;
				for(var i = 0; i < gos.length; i++)
				{
					var go:GameObject = gos[i];
					go.y -= amount;
				}
			}
			else if(player.moveable) player.y += amount;			
		}
		
		public function get position():Point { return _position; }
		
		public function get paused():Boolean { return _paused; }
		public function set paused(value:Boolean):void { _paused = value; }
	}
}
