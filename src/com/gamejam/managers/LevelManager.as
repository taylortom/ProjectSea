package com.gamejam.managers 
{
	import com.gamejam.display.Level;
	/**
	 * Stores level information
	 * @author Kev Adsett
	 */
	public class LevelManager 
	{
		private static var _instance:LevelManager;
		private static var allowInstantiation:Boolean = true;
		
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
		
		public function generateNewLevel(difficulty : int):Level
		{
			return new Level(difficulty);
		}
		
	}

}