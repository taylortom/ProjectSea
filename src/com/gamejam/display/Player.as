﻿package com.gamejam.display 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * Player class - movement controlled by keyboard, stores values for temperature and movement
	 * @author Kev Adsett
	 */
	public class Player extends MovieClip
	{
		private var _movementDirection : int;
		private static var LEFT : int = -1;
		private static var STILL : int = 0;
		private static var RIGHT : int = 1;
		
		private var xVel : Number = 0.0;
		private var xPos : Number = 0.0;
		private var maxVel : Number = 20.0;
		
		private var health : int = 2;
		private var maxHealth : int = 2;
		
		private var temperature : int = 0;
		
		public function Player() 
		{
			super();
			_init();
		}
		
		private function _init():void 
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyboardUp);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			//trace("_movementDirection: " + _movementDirection);
			_move();
			_changeState();
		}
		
		private function onKeyboardDown(e:KeyboardEvent):void 
		{
			//trace("e.keyCode: " + e.keyCode);
			if (e.keyCode == Keyboard.LEFT)
			{
				_movementDirection = LEFT;
			}
			else if (e.keyCode == Keyboard.RIGHT)
			{
				_movementDirection = RIGHT;
			}
		}
		
		private function onKeyboardUp(e:KeyboardEvent):void 
		{
			_movementDirection = STILL;
		}
		
		public function kill():void
		{
			trace("Dead");
			// play death animation
			
			// at the end of the animation, remove eventlisteners, destroy movieclip
		}
		
		private function _changeState(): void
		{
			switch(temperature)
			{
				case -3: 
					this.gotoAndPlay("frozen");
					break;
				case -2:
					this.gotoAndPlay("freezing2");
					break;
				case -1:
					this.gotoAndPlay("freezing1");
					break;
				case 0:
					this.gotoAndPlay("water");
					break;
				case 1:
					this.gotoAndPlay("boiling1");
					break;
				case 2:
					this.gotoAndPlay("boiling2");
					break;
				case 3:
					this.gotoAndPlay("boiled");
					break;
			}
		}
		
		private function _move():void 
		{
			switch(_movementDirection)
			{
				case LEFT:
					if (xVel > -maxVel) xVel-=2;
					break;
				case RIGHT:
					if (xVel < maxVel) xVel+=2;
					break;
				case STILL:
					if (xVel < 0)
					{
						xVel+=2;
					}
					else if (xVel > 0)
					{
						xVel-=2;
					}
					break;
			}
			this.rotation = -xVel;
			x += xVel;
		}
	}

}