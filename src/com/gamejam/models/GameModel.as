﻿package com.gamejam.models{	/* 	* Stores game data 	*/		public class GameModel	{			private static var _instance:GameModel;			public function GameModel()		{			if (_instance) throw new Error("GameModel.GameModel: ERROR: Instantiation failed: Use GameView.getInstance()");					}				public static function getInstance():GameModel		{			if (_instance == null) _instance = new GameModel();			return _instance;		}	}}