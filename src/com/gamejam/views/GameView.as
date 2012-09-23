﻿package com.gamejam.views{	// Flash imports	import com.gamejam.display.Player;	import com.gamejam.managers.LevelManager;	import flash.display.Sprite;	import flash.display.MovieClip;	import flash.display.Stage;	import flash.geom.Point;		import com.gamejam.datatypes.Camera;	import com.gamejam.display.GameObject;		/**	 * Controls the game's views	 */	public class GameView 	{			private static var _instance:GameView;		private static var allowInstantiation:Boolean = true;			private var _droplet:MovieClip;		private var _mainCam:Camera;				private var _stage:Stage;				private var _gameObjects:Array = new Array();				private var _player : Player;				private static const DEPTH_FRAME: Number = 100;		private static const DEPTH_FOREGROUND: Number = 50;		private static const DEPTH_PLAYER: Number = 40;		private static const DEPTH_BACKGROUND: Number = 30;				public function GameView()		{			if (!allowInstantiation) throw new Error("GameView.GameView: ERROR: Instantiation failed: Use GameView.getInstance()");					}				public static function getInstance():GameView 		{			if (_instance == null) 			{				_instance = new GameView();				allowInstantiation = false;			}						return _instance;		}				public function initialiseCamera():void		{			if(this._stage != null) 			{				this._mainCam = new Camera(new Point(this._stage.stageWidth/2, this._stage.stageHeight/2));			}			else throw new Error("GameView.initialiseCamera: ERROR: Need a reference to the stage to create the camera");					}				public function addGameObject(go:GameObject):Number		{			this._gameObjects.push(go);			return this._gameObjects.length;		}				public function startNewGame():void		{			LevelManager.getInstance().generateNewLevel(0);			_player = new Player();		}				/**		 * Public getters/setters		 */		 		public function get camera():Camera { return this._mainCam; }				public function get gameObjects():Array { return this._gameObjects; }				public function set stage(stage:Stage):void { this._stage = stage; }		public function get stage():Stage { return this._stage; }				public function get player():Player { return _player; }	}}