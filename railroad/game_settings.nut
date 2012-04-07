class GameSettings{
	settings = {};
	constructor(){
		/* Get known settings and store them */
		/**/
		settings.IndustriesBeforeTowns <- ::ai_instance.GetSetting("# of first routes are industry");
        settings.IndustryTownRatio <- ::ai_instance.GetSetting("Chance to build town route"); 
	}
}