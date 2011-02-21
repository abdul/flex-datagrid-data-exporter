/*
  Copyright (c) 2007, Abdul Qabiz (http://www.abdulqabiz.com)
  All rights reserved.

  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of copyright holder nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/**
	_________________________________________________________________________________________________________________

	DataGridDataExporter is a util-class to export DataGrid's data into different format.	
	@class DataGridDataExporter (public)
	@author Abdul Qabiz (mail at abdulqabiz dot com) 
	@version 0.01 (2/8/2007)
	@availability 9.0+
	@usage<code>DataGridDataExporter.<staticMethod> (dataGridReference)</code>
	@example
		<code>
			var csvData:String = DataGridDataExporter.exportCSV (dg);
		</code>
	__________________________________________________________________________________________________________________

	*/
package com.abdulqabiz.utils
{
	import mx.controls.DataGrid;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.collections.IList;
	import mx.collections.IViewCursor;
	import mx.collections.CursorBookmark;

	public class DataGridDataExporter
	{

		public static function exportCSV(dg:DataGrid, csvSeparator:String="\t", lineSeparator:String="\n"):String
		{
			var data:String = "";
			var columns:Array = dg.columns;
			var columnCount:int = columns.length;
			var column:DataGridColumn;
			var header:String = "";
			var headerGenerated:Boolean = false;
			var dataProvider:Object = dg.dataProvider;

			var rowCount:int = dataProvider.length;
			var dp:Object = null;

		
			var cursor:IViewCursor = dataProvider.createCursor ();
			var j:int = 0;
			
			//loop through rows
			while (!cursor.afterLast)
			{
				var obj:Object = null;
				obj = cursor.current;
				
				//loop through all columns for the row
				for(var k:int = 0; k < columnCount; k++)
				{
					column = columns[k];

					//Exclude column data which is invisible (hidden)
					if(!column.visible)
					{
						continue;
					}
				
					data += "\""+ column.itemToLabel(obj)+ "\"";

					if(k < (columnCount -1))
					{
						data += csvSeparator;
					}

					//generate header of CSV, only if it's not genereted yet
					if (!headerGenerated)
					{
						header += "\"" + column.headerText + "\"";
						if (k < columnCount - 1)
						{
							header += csvSeparator;
						}
					}
					
				
				}
				
				headerGenerated = true;

				if (j < (rowCount - 1))
				{
					data += lineSeparator;
				}

				j++;
				cursor.moveNext ();
			}
			
			//set references to null:
			dataProvider = null;
			columns = null;
			column = null;

			
			return (header + "\r\n" + data);
		}	
	}

}
