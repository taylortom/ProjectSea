package com.gamejam.managers 
{
	import com.gamejam.display.Level;
	import fl.motion.Color;
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
		
		public function generateNewLevel(length: int, difficulty : int):Level
		{
			_currentLevel = new Level(length, difficulty);
			return _currentLevel
		}
		
		public function get currentLevel():Level 
		{
			return _currentLevel;
		}
	}

}