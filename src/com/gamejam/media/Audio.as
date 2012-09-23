package com.gamejam.media
{
	// Flash imports
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	
	/*
	 * A sound
 	 */
	public class Audio extends Sound 
	{	
		private var _sound:Sound;
		private var _channel:SoundChannel = new SoundChannel();
		private var _transform = new SoundTransform();
		
		private var _volumeIncrement:Number;
		private var _isPlaying:Boolean = false;
		
		var _fadeInTimer:Timer;
		var _fadeOutTimer:Timer;
				
		public function Audio(soundToAdd:Sound)
		{
			super();
			this._sound = soundToAdd;			
		}
		
		public function start():void
		{
			if(!this._isPlaying)
			{
				this._channel = this._sound.play();
				this._channel.addEventListener(Event.SOUND_COMPLETE, this.onSoundComplete);
				this._isPlaying = true;
			}
		}
		
		public function stop():void
		{
			this._channel.stop();
			this._isPlaying = false;
		}
	
		public function fadeIn(duration:Number)
		{
			this.start();
			
			if(duration > 0)
			{
				this._transform.volume = 0.0;
				this._channel.soundTransform = this._transform;	

				this._fadeInTimer = new Timer(30,(duration/30));
				this._volumeIncrement = 1/(duration/30);
				this._fadeInTimer.addEventListener("timer", this._fadeLoop);
				this._fadeInTimer.start();
			}
		}
		
		public function fadeOut(duration:Number)
		{
			if(this._isPlaying)
			{
				if(duration > 0)
				{
					this._channel.soundTransform = this._transform;	

					this._fadeOutTimer = new Timer(30,(duration/30));
					this._volumeIncrement *= -1;
					this._fadeOutTimer.addEventListener("timer", this._fadeLoop);
					this._fadeOutTimer.start();
				}
			}
		}
	
		private function _fadeLoop(e:TimerEvent)
		{
			this._transform.volume += this._volumeIncrement;
			this._channel.soundTransform = this._transform;	
		}
		
		private function onSoundComplete(e:Event):void
		{
			trace("Audio.onSoundComplete");
		}
		
		public function get volume():Number { return this._transform.volume; }
		public function set volume(newVolume:Number):void
		{ 
			this._transform.volume = newVolume;
			this._channel.soundTransform = this._transform;
		}
		
		public function get playing():Boolean { return this._isPlaying; }
		public function get channel():SoundChannel { return this._channel; }
	}
}