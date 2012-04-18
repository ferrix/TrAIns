/*  Contains  information about current game.
    Settings, ai start date, ...*/
class GameInfo{
	ai_start_date = null;
    settings = null;
    constructor(){
    	/* Get ai start date */
    	ai_start_date = AIDate.GetCurrentDate();
        /* Get known settings and store them */
        settings = {};
        settings.IndustriesBeforeTowns <- ::ai_instance.GetSetting("# of first routes are industry");
        settings.IndustryTownRatio <- ::ai_instance.GetSetting("Chance to build town route"); 
    }
    function GetYearsElapsed();
}

/* Returns years elapsed from the time ai started. */
function GameInfo::GetYearsElapsed(){
    local currentDate =	AIDate.GetCurrentDate();
    return AIDate.GetYear(currentDate)-AIDate.GetYear(ai_start_date)
}