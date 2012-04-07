/*
 * trAIns - An AI for OpenTTD
 * Copyright (C) 2009  Luis Henrique O. Rios
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/


class trAIns extends AIInfo {
   function GetAuthor(){
		return "Luis Henrique O. Rios";
	}
   function GetName(){
		return "trAIns-mod4";
	}
   function GetShortName(){
		return "TRAI";
	}
   function GetDescription(){
		return "the trAIns is a competitive AI that plays only with trains. It creates and manages railroad routes that connects industries and railroad routes that connects two towns. The last can transport passengers. It is also partially compatible with NARS and 2CC.";
	}
   function GetVersion(){
		return 2;
	}
   function CanLoadFromVersion(version){
      return false;
   }
   function GetDate(){
		return "2010-07-02";
	}
   function CreateInstance(){
		return "trAIns";
	}
   function GetSettings(){
   }
	function MinVersionToLoad(){
		return 2;
	}
	function GetAPIVersion(){
		return "1.0";
	}
	function UseAsRandomAI(){
		return true;
	}
	function GetURL(){
		return "http://www.dcc.ufmg.br/~lhrios/trains/";
	}
	
	
	function GetSettings() 
    {
    	/* Add settings to the list */
        AddSetting({name = "Chance to build town route", description = "Changes the chance to build town or industry route ", min_value = 0, max_value = 100, easy_value = 50, medium_value = 50, hard_value = 50, custom_value = 50, flags = 0});
        AddLabels("Chance to build town route", {_0 = "Only industries", _100 = "Only towns"});
        AddSetting({name = "N first routes are industry", description = "Changes how many industries are built first", min_value = 0, max_value = 10, easy_value = 3, medium_value = 3, hard_value = 3, custom_value = 3, flags = 0});
        
    }
};

RegisterAI(trAIns());
