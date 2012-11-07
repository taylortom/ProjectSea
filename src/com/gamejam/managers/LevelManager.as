package com.gamejam.managers 
{
	import com.gamejam.display.Level;
	import com.gamejam.models.LevelModel;
	import fl.motion.Color;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * Stores level information
	 * @author Kev Adsett
	 */
	public class LevelManager 
	{
		private static var _instance:LevelManager;
		private static var allowInstantiation:Boolean = true;
		private var _currentLevel : Level;
		
		public function LevelManager() 
		{
			if (!allowInstantiation) throw new Error("LevelManager.LevelManager: ERROR: Instantiation failed: Use LevelManager.getInstance()");	
		}
		
		public static function getInstance():LevelManager 
		{
			if (_instance == null) 
			{
				_instance = new LevelManager();
				allowInstantiation = false;
			}
			
			return _instance;
		}
		
		public function generateNewLevel(length: int):Level
		{
			this._currentLevel = new Level( new LevelModel(""), length);
			return _currentLevel;
		}
		
		public function get currentLevel():Level 
		{
			return _currentLevel;
		}
		
		public function set currentLevel(value:Level):void 
		{
			_currentLevel = value;
		}
		
		public function loadLevel(levelNumber: int):void
		{
			var urlLoader : URLLoader = new URLLoader(new URLRequest("levels/" + levelNumber + ".lvl"));
			urlLoader.addEventListener(Event.COMPLETE, this.onLevelLoaded);
		}
		
		private function onLevelLoaded(e:Event):void 
		{
			this._currentLevel = new Level( new LevelModel(e.target.data));
		}
	}

}