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
			
			this.attachGameObjects();
		}
		
		private function attachGameObjects():void
		{
			var bg:MovieClip = new Background();
			var bga:MovieClip = new MovieClip(); 
			var fga:MovieClip = new MovieClip();
			var frame:MovieClip = new Frame();
			
			addChildAt(bg, GameView.LAYER_BACKGROUND_IMAGE);
			addChildAt(bga, GameView.LAYER_BACKGROUND);
			addChildAt(_view.player, GameView.LAYER_PLAYER);
			addChildAt(fga, GameView.LAYER_FOREGROUND);
			addChildAt(frame, GameView.LAYER_FRAME);
			
			this.attachClouds();
		}
		
		private function attachClouds();
		
		/**
		 * Called every frame
		 */ 
		private function update(e:Event):void
		{
			//trace("Main.update: " + e);
			
			// scroll the camera
			this._view.camera.incrementY(5);
			
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