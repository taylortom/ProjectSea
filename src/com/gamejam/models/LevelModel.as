package com.gamejam.models 
{
	/**
	* ...
	* @author Kev Adsett
	*/
	public class LevelModel 
	{		
		private var _structure:Array;
		
		private var _noRows:int = 8;
		private var _noCols:int = 7;
		
		public function LevelModel(pModel:String) 
		{
			pModel == "" ? generateStructure() : defineStructure(pModel);
			trace("_structure: " + _structure);
		}
		
		private function generateStructure():void 
		{
			this._structure = new Array(this._noRows);
			for (var i = 0; i < this._noRows; i++)
			{
				var thisRow: Array = new Array(this._noCols);
				for (var j = 0; j < this._noCols; j++)
				{
					thisRow[j] = Math.round((Math.random() * 2) - 1);
				}
				this._structure[i] = thisRow;
			}
		}
		
		private function defineStructure(rawData:String):void
		{
			var _rowStrings:Array = rawData.split(/\n/);
			this._noRows = _rowStrings.length;
			
			this._structure = new Array(_noRows);
			
			for (var i = 0; i < _noRows; i++)
			{
				this._structure[i] = _rowStrings[i].split(",");
				this._noCols = this._structure[i].length;
			}
		}
		
		public function get structure():Array { return _structure; }		
		public function get noCols():int { return _noCols; }
		public function get noRows():int { return _noRows; }
	}

}