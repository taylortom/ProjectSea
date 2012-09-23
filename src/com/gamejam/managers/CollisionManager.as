﻿package com.gamejam.managers{	// Flash imports		import com.gamejam.views.GameView;	import com.gamejam.display.GameObject;		/**	 * Controls the sound	 */	public class CollisionManager 	{			private static var _instance:CollisionManager;		private static var allowInstantiation:Boolean = true;				private var _collisionObjects:Array = new Array();			public function CollisionManager()		{			if (!allowInstantiation) throw new Error("CollisionManager.CollisionManager: ERROR: Instantiation failed: Use CollisionManager.getInstance()");					}				public static function getInstance():CollisionManager 		{			if (_instance == null) 			{				_instance = new CollisionManager();				allowInstantiation = false;			}						return _instance;		}				public function addObject(object:GameObject)		{			this._collisionObjects.push(object);		}				public function checkForCollisions():Array		{			var collisions:Array = new Array();						var player:Player = GameView.getInstance().player;						for(var i = 0; i < this._collisionObjects.length; i++)			{				var co:GameObject = this._collisionObjects[i];								//var inter = player.getRect().intersection(co.getRect());				//if ((inter.width*inter.height) != 0) 				    //collisions.push(co);			}						return collisions;		}				/**		 * Public getters/setters		 */		 		//public function get camera():Camera { return this._mainCam; }	}}