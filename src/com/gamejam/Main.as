package com.gamejam
{
	// Flash imports
	import com.gamejam.managers.LevelManager;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
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
			
		public function Main()
		{
			this._model = GameModel.getInstance();
			this._view = GameView.getInstance();
			
			this._view.stage = stage;
			this._view.initialiseCamera();
			
			stage.addEventListener(Event.ENTER_FRAME, this.update);
			
			_view.startNewGame();
			
			//addChildAt(_view.player, GameView.DEPTH_PLAYER);
			
			addChild(LevelManager.getInstance().currentLevel)
		}
		
		/**
		 * Called every frame
		 */ 
		private function update(e:Event):void
		{
			//trace("Main.update: " + e);
			
			// scroll the camera
			this._view.camera.incrementY(-5);
			
			//this.cleanUp();
		}
		
		public function cleanUp():void
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