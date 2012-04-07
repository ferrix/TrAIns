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

class LocomotiveValuator {
	/* Public: */
	constructor(engines){
		/* Adjust importance of reliability based on game setting*/
		switch(::ai_instance.game_settings.vehicle_breakdowns){
			case 0:
				reliability_importance = 0.0;
			break;
			case 1:
				reliability_importance = 1.5;
			break;
			case 2:
				reliability_importance = 2.5;
			break;
		}
		/**/
		engines.Valuate(AIEngine.GetMaxSpeed);
		engines.Sort(AIAbstractList.SORT_BY_VALUE, false);
		largest_max_speed = engines.GetValue(engines.Begin()).tofloat();

		engines.Valuate(AIEngine.GetPower);
		engines.Sort(AIAbstractList.SORT_BY_VALUE, false);
		largest_power = engines.GetValue(engines.Begin()).tofloat();

		engines.Valuate(AIEngine.GetPrice);
		engines.Sort(AIAbstractList.SORT_BY_VALUE, false);
		largest_price = engines.GetValue(engines.Begin()).tofloat();

		engines.Valuate(AIEngine.GetReliability);
		engines.Sort(AIAbstractList.SORT_BY_VALUE, false);
		largest_reliability = engines.GetValue(engines.Begin()).tofloat();

		engines.Valuate(AIEngine.GetRunningCost);
		engines.Sort(AIAbstractList.SORT_BY_VALUE, false);
		largest_running_cost = engines.GetValue(engines.Begin()).tofloat();

		engines.Valuate(AIEngine.GetWeight);
		engines.Sort(AIAbstractList.SORT_BY_VALUE, false);
		largest_weight = engines.GetValue(engines.Begin()).tofloat();
	}

	function _tostring(){
		local s = "Largest max speed: " + largest_max_speed.tostring();
		s += " Largest price: " + largest_price.tostring();
		s += " Largest reliability: " + largest_reliability.tostring();
		s += " Largest power: " + largest_power.tostring();
		s += " Largest running cost: " + largest_running_cost.tostring();
		s += " Largest weight: " + largest_weight.tostring();
		s += " Reliability importance: " + reliability_importance.tostring();
		return s;
	}

	function ValuateLocomotive(id, self){
		this = self;
        /* Calculate locomotive value
        + 0.25 * running cost when compared to largest(cheaper is better).
        + 0|1.5|2.5 * reliability compared to best. Depends on game setting.
        + 1.5 * (max)speed compared to most fastest.
        + 0.75 * power compared to most powerful.
        + 1.25 * price compared to most expensive(cheaper is better)
        + 0.75 * weigth compared to largest weigth (heavier is better)
        100000 * others
        returns integer
        */ 
		local v = 0.0;
		v += 0.25 * (1.0 - (AIEngine.GetRunningCost(id).tofloat() / largest_running_cost));
		v += reliability_importance * (AIEngine.GetReliability(id).tofloat() / largest_reliability);
		v += 1.5 * (AIEngine.GetMaxSpeed(id).tofloat() / largest_max_speed);
		v += 0.75 * (AIEngine.GetPower(id).tofloat() / largest_power);
		v += 1.25 * (1.0 - (AIEngine.GetPrice(id).tofloat() / largest_price));
		v += 0.75 * (AIEngine.GetWeight(id).tofloat() / largest_weight);
		v *= 100000;
		return v.tointeger();
	}

	/* Private: */
	largest_max_speed = null;
	largest_power = null;
	largest_price = null;
	largest_reliability = null;
	largest_running_cost = null;
	largest_weight = null;
	reliability_importance = null;
}

class RailTypeValuator {
	/* Public: */
	constructor(){
		lv = LocomotiveValuator(RailroadRoute.GetEvaluatedLocomotiveEnginesList(null, null, null));
	}

	function ValuateRailType(id, self){
		this = self;

		local engines = RailroadRoute.GetEvaluatedLocomotiveEnginesList(null, id, null);
		if(engines.Count() != 0){
			engines.Valuate(LocomotiveValuator.ValuateLocomotive, lv);
			engines.Sort(AIAbstractList.SORT_BY_VALUE, false);
			return engines.GetValue(engines.Begin());
		}
		return 0;
	}

	/* Private: */
	lv = null;
}

/*  Valuates destination industries by distance.
    order is:
    distance in between min & max
    distance below min
    distance over max
*/
class DestinationIndustryValuator {
    /* public */
    constructor(source_industry, min_distance, max_distance){
        source_industry_id =source_industry;
        min_distance_to_industry = min_distance;
        max_distance_to_industry = max_distance;
    }
    
    function ValuateIndustries(industries){
    	foreach(d_industry in industries){
    		/* Get distance from source industry */
            distance = AITile.GetDistanceManhattanToTile(AIIndustry.GetLocation(source_industry_id), AIIndustry.GetLocation(railroad_route.d_industry));
            
            if(distance < min_distance)
            {
            	
            	industry.valuation = 1000*distance;
            }
            else
                if(distance > max_distance)
                {
                    industry.valuation = 10000*distance;	
                }
                else 
                {
                	industry.valuation = distance;
                }
    	}
    	industries.sort();
    }
    
    /* Private */
    source_industry_id	= null;
    max_distance_to_industry  = null;
    min_distance_to_industry  = null;
}

class IndustryValuator {
	/* Public: */
	static function ValuateIndustries(industries){
		local cargos = RailroadManager.GetOrdedCargos();

		foreach(industry in industries){
			local v, stations_around;

			v = AIIndustry.GetLastMonthProduction(industry.industry_id, industry.cargo).tofloat();
			v *= 1.0 - (AIIndustry.GetLastMonthTransportedPercentage(industry.industry_id, industry.cargo).tofloat() / 100.0);
			stations_around = AIIndustry.GetAmountOfStationsAround(industry.industry_id);
			v /= (stations_around.tofloat() + 1.0);
			v *= cargos.GetValue(industry.cargo).tofloat();
			industry.valuation = (v * 100000).tointeger();
		}
		industries.sort();
	}
}

class TownValuator {
	/* Public: */
	static function ValuateTowns(towns){
		foreach(town_usage in towns){
			local v, cargo = ::ai_instance.railroad_manager.passenger_cargo;

			v = AITown.GetLastMonthProduction(town_usage.town_id, cargo).tofloat();
			v *= 1.0 - (AITown.GetLastMonthTransportedPercentage(town_usage.town_id, cargo).tofloat() / 100.0);
			town_usage.valuation = (v * 100000).tointeger();
		}
		towns.sort();
	}
}
