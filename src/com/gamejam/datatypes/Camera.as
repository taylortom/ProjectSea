package com.gamejam.datatypes
{
	// Flash imports
	import com.gamejam.managers.LevelManager;
	import com.gamejam.utils.normalise;
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
			this._position = new Point(0, 0);
		}
		
		public function resetPosition()
		{
			this._position.x = 0;
			this._position.y = 0;
		}
		
		public function incrementX(amount:Number):void { if (!_paused) this._position.x += amount; }
		public function incrementY(amount:Number):void { if (!_paused) this._position.y += amount;}
		
		public function get progress():Number
		{
			/*var lm:LevelManager = LevelManager.getInstance();
			trace("this.position.y: " + this.position.y + ", lm.currentLevel.length + 650: " + (lm.currentLevel.length + 650));
			return normalise(this.position.y, 650, (lm.currentLevel.length + 650));*/
			return 0;
		}
		
		public function get position():Point { return _position; }
		
		public function get paused():Boolean { return _paused; }
		public function set paused(value:Boolean):void { _paused = value; }
	}
}
