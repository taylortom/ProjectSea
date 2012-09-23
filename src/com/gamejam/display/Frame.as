package com.gamejam.display 
{
	import com.gamejam.views.GameView;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Kev Adsett
	 */
	public class Frame extends MovieClip 
	{
		
		public function Frame() 
		{
			super();
			this.setChildIndex(this, GameView.DEPTH_FRAME);
		}
		
	}

}