package com.gamejam
{
	// Flash imports
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	import com.gamejam.models.GameModel;
	import com.gamejam.views.GameView;

	/*
	 * The main program
 	 */
	public class Main extends MovieClip 
	{	
		private var _model:GameModel;
		private var _view:GameView;
	
		public function Main()
		{
			this._model = GameModel.getInstance();
			this._view = GameView.getInstance();
			
			this._view.stage = stage;
			this._view.initialiseCamera();
			
			var drop = new Droplet();
			drop.x = 500;
			addChild(drop);
			
			stage.addEventListener(Event.ENTER_FRAME, this.update);
		}
		
		private function update(e:Event):void
		{
			//trace("Main.update: " + e);
			this._view.camera.incrementY(1);
		}
	}
}