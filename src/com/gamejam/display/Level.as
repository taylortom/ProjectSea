package com.gamejam.display 
{
	import com.gamejam.views.GameView;
	import flash.display.MovieClip;
	import flash.sampler.NewObjectSample;
	/**
	 * Stores level set up, including obstacles, start and end
	 * @author Kev Adsett
	 */
	public class Level extends MovieClip
	{
		private var _starterCloud : GameObject;
		
		private var _view : GameView;
		
		private var _difficulty : int;
		
		public function Level(_difficulty : int) 
		{
			super();
			this._init();
			this._difficulty = _difficulty;
		}
		
		private function _init()
		{
			_starterCloud = new StartBlock();
			_starterCloud.x = GameView.getInstance().stage.width / 2;
			_starterCloud.y = 190;
			addChild(_starterCloud);
			
			for(var i = 0; i < 10; i++)
			{
				var cloud:GameObject = new Cloud();
				cloud.x = 150*(i+1);
				cloud.y = 300*(i+1);
				/*var depthIndex : int = Math.round(Math.random());
				var depthOptions : Array = new Array(GameView.DEPTH_BACKGROUND, GameView.DEPTH_FOREGROUND);
				trace(depthOptions[depthIndex]);*/
				
				var depthIndex : int = Math.round(Math.random());
				
				if (depthIndex == 0)
				{
					addChildAt(cloud, 0);
				}
				else addChild(cloud);
			}
		}
	}

}