﻿package com.gamejam.display{	// Flash imports	import flash.display.MovieClip;	import com.gamejam.views.GameView;	/*	 * A basic game object 	 */	public class GameObject extends MovieClip 	{			private var _collidable:Boolean = false;				public function GameObject()		{			var gv:GameView = GameView.getInstance();			gv.addGameObject(this);		}				public function get collidable():Boolean { return this._collidable; }		public function set collidable(isCollidable):void { this._collidable = isCollidable; }	}}