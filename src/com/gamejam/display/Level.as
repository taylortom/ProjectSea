package com.gamejam.display 
{
	import com.gamejam.datatypes.Camera;
	import com.gamejam.display.Cloud;
	import com.gamejam.display.TemperatureObject;
	import com.gamejam.managers.LevelManager;
	import com.gamejam.models.GameModel;
	import com.gamejam.models.LevelModel;
	import com.gamejam.utils.map;
	import com.gamejam.views.GameView;
	import fl.motion.Color;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
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
		
		private var _length : int;
		
		private var _model : LevelModel;
		
		public function Level(pModel:LevelModel = null, pDifficulty : int = 0) 
		{
			if (pModel == null)
			{
				this._model = new LevelModel("");
			}
			else
			{
				this._model = pModel;
			}
			super();
			this._init();
			this._difficulty = pDifficulty;
			this._length = this._model.noRows * 500;
			this.attachGameObjects();
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			var cam : Camera = GameView.getInstance().camera;

			if (cam.position.y < this._length - GameView.getInstance().stage.stageHeight && GameModel.getInstance().started)
			{
				cam.incrementY(5);
			}
			
			var progress_mc = GameView.getInstance().progressBar.progress_mc;
			progress_mc.y = map(GameView.getInstance().player.progress, 0, 1, -180, 140);
			_tintBackground(0xdaecf9, GameView.getInstance().player.progress);
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
			this._starterCloud.position.x = GameView.getInstance().stage.stageWidth/2;
			this._starterCloud.position.y = this._view.stage.stageHeight/2;
			addChildAt(this._starterCloud, GameView.LAYER_FOREGROUND);
			
			this._sea = new SeaFront();			
			this._sea.position.y = this._length - this._sea.height;
			addChildAt(this._sea, GameView.LAYER_FOREGROUND);
		
			var seaBehind = new SeaBehind();
			seaBehind.position.y = this._sea.position.y;
			addChildAt(seaBehind, GameView.LAYER_BACKGROUND);
				
			var front:Boolean = false;
			
			// some clouds			
			for(var i = 0; i < 10; i++)
			{
				var cloudXPos:Number = Math.random()*this._bg.width;
				var cloudYPos:Number = Math.random()*(this._length-(this._sea.height*2 + this._view.stage.stageHeight*1.5));
				cloudYPos += this._view.stage.stageHeight*1.5;
				
				var cloud:Cloud = new Cloud();
				cloud.position.x = cloudXPos;
				cloud.position.y = cloudYPos;
				if(front) addChildAt(cloud, GameView.LAYER_FOREGROUND);
				else addChildAt(cloud, GameView.LAYER_BACKGROUND);
							
				front = !front;
			}
			
			var structure:Array = this._model.structure;
			
			for (var r = 0; r < this._model.noRows; r++)
			{
				for (var c = 0; c < this._model.noCols; c++)
				{
					if (structure[r][c] == 1)
					{
						var hotTrailXPos:Number = map(c, 0, this._model.noCols - 1, 0, this._view.stage.stageWidth);
						var hotTrailYPos:Number = map(r, 0, this._model.noRows - 1, this._view.stage.stageHeight, this._length - this._sea.height*2);
						
						var hotTrail:TemperatureObject = new HotTrail();
						hotTrail.isHot = true;
						hotTrail.position.x = hotTrailXPos;
						hotTrail.position.y = hotTrailYPos;
						
						addChildAt(hotTrail, GameView.LAYER_FOREGROUND);
					}
					else if (structure[r][c] == -1)
					{
						var coldTrailXPos:Number = map(c, 0, this._model.noCols - 1, 0, this._view.stage.stageWidth);
						var coldTrailYPos:Number = map(r, 0, this._model.noRows - 1, this._view.stage.stageHeight, this._length - this._sea.height*2);
						
						var coldTrail:TemperatureObject = new ColdTrail();
						coldTrail.isHot = false;
						coldTrail.position.x = coldTrailXPos;
						coldTrail.position.y = coldTrailYPos;
						
						addChildAt(coldTrail, GameView.LAYER_FOREGROUND);
					}
				}
			}
		}	
		
		private function _tintBackground(newColour:uint, percentage:Number):void
		{
			var cTint:Color = new Color();
			cTint.setTint(newColour, percentage);
			this._bg.transform.colorTransform = cTint;
		}
		
		public function get length():int 
		{
			return _length;
		}
		
		public function set length(value:int):void 
		{
			_length = value;
		}
		
		public function get bg():MovieClip 
		{
			return _bg;
		}
	}
}