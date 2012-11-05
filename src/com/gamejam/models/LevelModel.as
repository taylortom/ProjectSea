package com.gamejam.models 
{
	/**
	* ...
	* @author Kev Adsett
	*/
	public class LevelModel 
	{		
		private var _structure:Array;
		
		private var _noRows:int;
		private var _noCols:int;
		
		public function LevelModel(pModel:String) 
		{
			defineStructure(pModel);
			
		}
		
		private function defineStructure(rawData:String):void
		{
			var _rowStrings:Array = rawData.split(/\n/);
			this._noRows = _rowStrings.length;
			
			this._structure = new Array(_rowStrings.length);
			
			for (var i = 0; i < _rowStrings.length; i++)
			{
				this._structure[i] = _rowStrings[i].split(",");
				this._noCols = this._structure[i].length;
			}
		}
		
		public function get structure():Array 
		{
			return _structure;
		}
		
		public function get noCols():int 
		{
			return _noCols;
		}
		
		public function get noRows():int 
		{
			return _noRows;
		}
	}

}