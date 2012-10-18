package com.gamejam.views
{
	// Flash imports
	import com.gamejam.models.GameModel;
	import flash.media.Sound;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Point;
	
	import com.gamejam.display.Player;
	import com.gamejam.display.TemperatureGauge;
	import com.gamejam.managers.LevelManager;
	import com.gamejam.managers.SoundManager;
	import com.gamejam.datatypes.Camera;
	import com.gamejam.display.GameObject;
	
	/**
	 * Controls the game's views
	 */
	public class GameView 
	{	
		private static var _instance:GameView;
		private static var allowInstantiation:Boolean = true;
			
		private var _droplet:MovieClip;
		private var _mainCam:Camera;
		
		private var _stage:Stage;
		
		private var _gameObjects:Array = new Array();
		
		private var _player:Player;
		private var _tempGauge:TemperatureGauge;
		
		public static const LAYER_FRAME: Number = 4;
		public static const LAYER_FOREGROUND: Number = 3;
		public static const LAYER_PLAYER: Number = 2;
		public static const LAYER_BACKGROUND: Number = 1;
		public static const LAYER_BACKGROUND_IMAGE: Number = 0;
		
		private var _progressBar : MovieClip;
		
		private var _pausedMC : MovieClip;
		
		public function GameView()
		{
			if (!allowInstantiation) throw new Error("GameView.GameView: ERROR: Instantiation failed: Use GameView.getInstance()");			
		}
		
		public static function getInstance():GameView 
		{
			if (_instance == null) 
			{
				_instance = new GameView();
				allowInstantiation = false;
			}
			
			return _instance;
		}
		
		public function initialiseCamera():void
		{
			if(this._stage != null) 
			{
				this._mainCam = new Camera();
			}
			else throw new Error("GameView.initialiseCamera: ERROR: Need a reference to the stage to create the camera");			
		}
		
		public function addGameObject(go:GameObject):Number
		{
			this._gameObjects.push(go);
			return this._gameObjects.length;
		}
		
		public function startNewGame():void
		{
			var playerPos:Point = new Point();
			
			this._player = new Player();
			this._player.moveable = false;
			
			LevelManager.getInstance().loadLevel(0);
			
			var intro:Sound = new MusicIntro();
			SoundManager.getInstance().play(intro, 1.0, 5000);
		}
		
		public function setupGUI():void
		{
			//trace("GameView::setupGUI");
			
			this._progressBar = new ProgressBar();
			this._progressBar.x = 40;
			this._progressBar.y = stage.stageHeight / 2;
			
			this._tempGauge = new TemperatureGauge();
			
			this._pausedMC = new Paused();
			this._pausedMC.x = stage.stageWidth / 2;
			this._pausedMC.y = stage.stageHeight / 2;
			this._pausedMC.visible = false;
		}
		
		public function pause():void
		{
			this.pausedMC.visible = true;
			this._mainCam.paused = true;
			this._player.moveable = false;
		}
		
		public function unpause():void
		{
			this.pausedMC.visible = false;
			this._mainCam.paused = false;
			this._player.moveable = true;
		}
		
		public function resetCurrentLevel()
		{
			this._mainCam.resetPosition();
			this._player.resetPosition();
			GameModel.getInstance().finished = false;
		}
		/**
		 * Public getters/setters
		*/
		
		public function get camera():Camera { return this._mainCam; }
		
		public function get gameObjects():Array { return this._gameObjects; }
		
		public function set stage(stage:Stage):void { this._stage = stage; }
		public function get stage():Stage { return this._stage; }
		
		public function get player():Player { return _player; }
		
		public function get progressBar():MovieClip { return _progressBar; }
		
		public function get tempGauge():TemperatureGauge { return _tempGauge; }
		
		public function get pausedMC():MovieClip { return _pausedMC; }
	}
}