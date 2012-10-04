﻿package com.gamejam
{
	// Flash imports
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.media.Sound;
	
	import com.gamejam.managers.LevelManager;
	import com.gamejam.managers.CollisionManager;
	import com.gamejam.managers.SoundManager;
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
			this._view.setupGUI();
			
			_view.startNewGame();
			
			// add the level 
			addChild(LevelManager.getInstance().currentLevel);
			
			stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyboardUp);
		}
		
		private function onKeyboardUp(e:KeyboardEvent):void
		{
			//trace(e);
			
			if(e.keyCode == Keyboard.SPACE)
			{
				if (!this._model.started)
				{
					addChild(this._view.progressBar);
					addChild(this._view.pausedMC);
					addChild(this._view.tempGauge);
					
					stage.addEventListener(Event.ENTER_FRAME, this._update);
					this._view.player.moveable = true;
					
					var musicLoop:Sound = new MusicLoop();
					var sm:SoundManager = SoundManager.getInstance();
					sm.crossfade(musicLoop, 3000);
					
					this._model.started = true;
				}
				else
				{
					if(!this._model.paused)
					{
						this._view.pause();
						this._model.paused = true;
					}
					else
					{
						this._view.unpause();
						this._model.paused = false;
					}
				}
			}
		}
		
		/**
		 * Called every frame
		 */ 
		private function _update(e:Event):void
		{
			if (!_model.paused)
			{
				// scroll the camera
				this._view.camera.incrementY(5);
				
				var collisions:Array = CollisionManager.getInstance().checkForCollisions();
				
				if (collisions.length > 0) {
					this._view.player.increaseTemperature();
				}
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