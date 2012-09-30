package com.gamejam.display 
{
	import com.gamejam.datatypes.Camera;
	import com.gamejam.display.Cloud;
	import com.gamejam.display.TemperatureObject;
	import com.gamejam.utils.map;
	import com.gamejam.views.GameView;
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * Stores level set up, including obstacles, start and end
	 * @author Kev Adsett
	 */
	public class Level extends MovieClip
	{
		private var _bg:MovieClip;
		private var _sea:GameObject;
		private var _frame:MovieClip;
		private var _starterCloud : GameObject;
		
		private var _view : GameView;
		private var _difficulty : int;
		
		public function Level(_difficulty : int) 
		{
			super();
			trace("Level::Level");
			this._init();
			this._difficulty = _difficulty;
			
			this.attachGameObjects();
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			var cam : Camera = GameView.getInstance().camera;

			if (cam.position.y >= this._bg.height)
			{
				cam.paused = true;
			}
			
			if (!cam.paused) 
			{
				var progress_mc = GameView.getInstance().progressBar.progress_mc;
				progress_mc.y = map(cam.position.y, 650, this._bg.height+650, -180, 140);
			}
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
			this._starterCloud = new StartCloud();
			this._starterCloud.x = GameView.getInstance().stage.stageWidth/2;
			this._starterCloud.y = this._view.stage.stageHeight/2;
			addChildAt(this._starterCloud, GameView.LAYER_FOREGROUND);
			
			this._sea = new SeaFront();			
			this._sea.y = this._bg.y + this._bg.height - this._sea.height;
			addChildAt(this._sea, GameView.LAYER_FOREGROUND);
		
			var seaBehind = new SeaBehind();
			seaBehind.y = this._sea.y;
			addChildAt(seaBehind, GameView.LAYER_BACKGROUND);
				
			var front:Boolean = false;
			
			// some clouds			
			for(var i = 0; i < 10; i++)
			{
				var xPos:Number = Math.random()*this._bg.width;
				var yPos:Number = Math.random()*(this._bg.height-(this._sea.height*2 + this._view.stage.stageHeight*1.5));
				yPos += this._view.stage.stageHeight*1.5;
				
				var cloud:Cloud = new Cloud();
				cloud.x = xPos;
				cloud.y = yPos;
				if(front) addChildAt(cloud, GameView.LAYER_FOREGROUND);
				else addChildAt(cloud, GameView.LAYER_BACKGROUND);
							
				front = !front;
			}
			
			// some hot trails			
			for(var j = 0; j < 5; j++)
			{
				var xPos:Number = Math.random()*this._bg.width;
				var yPos:Number = Math.random()*(this._bg.height-(this._sea.height*2 + this._view.stage.stageHeight*1.5));
				yPos += this._view.stage.stageHeight*1.5;
								
				var hotTrail:TemperatureObject = new HotTrail();
				hotTrail.x = xPos;
				hotTrail.y = yPos;
			
				addChildAt(hotTrail, GameView.LAYER_FOREGROUND);
			}
		}	
	}
}