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
		private var _bg:MovieClip;
		private var _frame:MovieClip;
		private var _sea:GameObject;
		
		private var _starterCloud : GameObject;
		
		private var _view : GameView;
		
		private var _difficulty : int;
		
		public function Level(_difficulty : int) 
		{
			super();
			this._init();
			this._difficulty = _difficulty;
			
			this.attachGameObjects();
		}
		
		private function _init()
		{
			this._view = GameView.getInstance();
			
			this._bg = new Background();
			this._frame = new Frame();
			
			// placeholders
			var bga:MovieClip = new MovieClip(); 
			var fga:MovieClip = new MovieClip();

			addChild(this._bg);
			addChildAt(bga, GameView.LAYER_BACKGROUND);
			addChildAt(this._view.player, GameView.LAYER_PLAYER);
			addChildAt(fga, GameView.LAYER_FOREGROUND);
			addChildAt(this._frame, GameView.LAYER_FRAME);
		}
		
		private function attachGameObjects():void
		{
			_starterCloud = new StartCloud();
			_starterCloud.x = GameView.getInstance().stage.width / 2;
			_starterCloud.y = 190;
			addChildAt(_starterCloud, GameView.LAYER_FOREGROUND);
			
			for(var i = 0; i < 10; i++)
			{
				var layer:Number = Math.round(Math.random());
				
				var cloud:GameObject = new Cloud();
				cloud.x = 150 * (i + 1);
				cloud.y = 300 * (i + 1);
				
				if(layer == 0) addChildAt(cloud, GameView.LAYER_FOREGROUND);
				else addChildAt(cloud, GameView.LAYER_BACKGROUND);
			}
			
			this._sea = new Sea();
			this._sea.y = this._bg.y + this._bg.height - this._sea.height;
			addChildAt(this._sea, GameView.LAYER_FOREGROUND);
		}
	}

}