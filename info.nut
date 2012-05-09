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
		return "Luis Henrique O. Rios, Ferrix Hovi, Mikael Lavi, Johan Strandman, Teemu Tossavainen";
	}
   function GetName(){
		return "trAIns++";
	}
   function GetShortName(){
		return "TRAI";
	}
   function GetDescription(){
		return "the trAIns is a competitive AI that plays only with trains. It creates and manages railroad routes that connects industries and railroad routes that connects two towns. The last can transport passengers. It is also partially compatible with NARS and 2CC.";
	}
   function GetVersion(){
		return 3;
	}
   function CanLoadFromVersion(version){
      return false;
   }
   function GetDate(){
		return "2012-05-09";
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
        AddSetting({name = "Town route min length", description = "Minimum length of town route", min_value = 10, max_value = 600, easy_value = 120, medium_value = 120, hard_value = 120, custom_value = 120, flags = 0});
        AddSetting({name = "Town route max length", description = "Maximum length of town route", min_value = 0, max_value = 590, easy_value = 220, medium_value = 220, hard_value = 220, custom_value = 220, flags = 0});
        AddSetting({name = "Industry route min length", description = "Minimum length of industry route", min_value = 10, max_value = 600, easy_value = 100, medium_value = 100, hard_value = 100, custom_value = 100, flags = 0});
        AddSetting({name = "Industry route max length", description = "Maximum length of industry route", min_value = 0, max_value = 590, easy_value = 290, medium_value = 290, hard_value = 290, custom_value = 290, flags = 0});
        AddSetting({name = "N first routes are industry", description = "Changes how many industries are built first", min_value = 0, max_value = 10, easy_value = 3, medium_value = 3, hard_value = 3, custom_value = 3, flags = 0});
        AddSetting({name = "Max consecutive routes of same type", description = "Maximum number of routes built before building at least one of another type", min_value = 0, max_value = 100, easy_value = 3, medium_value = 3, hard_value = 3, custom_value = 3, flags = 0});
        
        AddSetting({name = "Chance to build town route", description = "Changes the chance to build town or industry route ", min_value = 0, max_value = 100, easy_value = 50, medium_value = 50, hard_value = 50, custom_value = 50, flags = 0});
        AddLabels("Chance to build town route", {_0 = "Only industries", _100 = "Only towns"});
        
        
    }
};

RegisterAI(trAIns());
