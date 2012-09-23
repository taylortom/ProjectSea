package com.gamejam.utils 
{
	/**
	 * ...
	 * @author Kev Adsett
	 */
	
	public function map(value : Number, lo1 : Number, hi1 : Number, lo2 : Number, hi2 : Number):Number
	{
		var normal = value / (hi1 - lo1);
		return (normal * (hi2 - lo2))+ lo2;
	}

}