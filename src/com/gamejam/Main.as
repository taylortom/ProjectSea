package com.gamejam
{
	// Flash imports
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import com.gamejam.managers.LevelManager;
	import com.gamejam.managers.CollisionManager;
	import com.gamejam.display.GameObject;
	import com.gamejam.models.GameModel;
	import com.gamejam.views.GameView;

	/*
	 * The main program
 	 */
	public class Main extends MovieClip 
	{	
		private var _model:GameModel;
		private var _view:GameView;
		
		private var _ignoreCollisions:Boolean = false;
		var _collisionTimer:Timer;
			
		public function Main()
		{
			this._model = GameModel.getInstance();
			this._view = GameView.getInstance();
			
			this._view.stage = stage;
			this._view.initialiseCamera();
			_view.setupGUI();
			
			stage.addEventListener(Event.ENTER_FRAME, this._update);
			
			this._collisionTimer = new Timer(1000,1);
			this._collisionTimer.addEventListener("timer", this._onCollisionTimerComplete);
			
			_view.startNewGame();
			
			// add the level 
			addChild(LevelManager.getInstance().currentLevel);
			addChild(_view.progressBar);
		}
		
		/**
		 * Called every frame
		 */ 
		private function _update(e:Event):void
		{			
			// scroll the camera
			this._view.camera.incrementY(7);
			
			var collisions:Array = CollisionManager.getInstance().checkForCollisions();
			if(!this._ignoreCollisions && collisions.length > 0)
			{
				this._ignoreCollisions = true;
				this._collisionTimer.start();
				
				this._view.player.increaseTemperature();
			}
			
			//this.cleanUp();
		}
		
		private function _onCollisionTimerComplete(e:Event)
		{
			this._ignoreCollisions = false;
		}
		
		private function _cleanUp():void
		{
			for(var i = 0; i < this._view.gameObjects.length; i++)
			{	
				var go:GameObject = this._view.gameObjects[i];
			
				if(go.x < -stage.width/2 ||
				   go.x > stage.width*1.5 ||
				   go.y < -stage.height/2 ||
				   go.y > stage.height*1.5)
				{
					removeChild(go);
					go = null;
				}
			}
		}
	}
}