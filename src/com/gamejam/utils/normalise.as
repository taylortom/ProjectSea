package com.gamejam.utils 
{
	/**
	 * ...
	 * @author Kev Adsett
	 */
	
	public function normalise(value : Number, low : Number, high : Number)
	{		
		var range = high - low;
		return (value - low) / range;
	}
}