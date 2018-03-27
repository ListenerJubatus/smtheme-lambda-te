-- color based on screen name
function ScreenColor(screen)
    local colors = {
        ["ScreenSelectStyle"]         = ScreenColors.Style, 
        ["ScreenSelectPlayMode"]      = ScreenColors.PlayMode, 
        ["ScreenSelectMusic"]         = ScreenColors.Music, 
        ["ScreenSelectCourse"]        = ScreenColors.Course, 
        ["ScreenPlayerOptions"]       = ScreenColors.PlayerOptions,
        ["ScreenNestyPlayerOptions"]  = ScreenColors.PlayerOptions,
        ["ScreenOptionsService"]      = ScreenColors.OptionsService,
        ["ScreenEvaluationNormal"]    = ScreenColors.Evaluation, 
        ["ScreenHighScores"]    = ScreenColors.Evaluation, 
        ["ScreenEvaluationSummary"]   = ScreenColors.Summary, 
        ["ScreenStageInformation"]   = ScreenColors.StageInformation, 
        ["ScreenEditMenu"]			  = ScreenColors.Edit, 
        ["ScreenSMOnlineLogin"]			  = ScreenColors.Online, 
        ["ScreenNetRoom"]			  = ScreenColors.Online, 
        ["ScreenNetSelectMusic"]			  = ScreenColors.Online, 
		["ScreenNetEvaluation"]    = ScreenColors.Evaluation, 
        ["Default"]                   = ScreenColors.Default,
    }

    if colors[screen] then return colors[screen];
    else return colors["Default"]; end;
end;

ScreenColors = {
    Style           = color("#434DC4"),
    PlayMode        = color("#434DC4"),
    Music           = color("#434DC4"),
    Online           = color("#434DC4"),
    Course          = color("#434DC4"),
    PlayerOptions   = color("#434DC4"),
    OptionsService  = color("#434DC4"),
    Evaluation      = color("#434DC4"),
    Summary         = color("#434DC4"),
    StageInformation  = color("#D05722"),
    Edit         = color("#434DC4"),
    Default         = color("#434DC4"),
}

ModeIconColors = {
    Normal      = color("#1AE0E4"),
    Rave        = color("#3ACF2A"), 
    Nonstop     = color("#CFC42A"),
    Oni         = color("#CF502A"),
    Endless     = color("#981F41"),
}

GameColor = {
    PlayerColors = {
        PLAYER_1 = color("#4B82DC"),
        PLAYER_2 = color("#DF4C47"),
		both = color("#FFFFFF"),
    },
    PlayerDarkColors = {
        PLAYER_1 = color("#16386E"),
        PLAYER_2 = color("#65110F"),
		both = color("#F5E1E1"),
    },
	Difficulty = {
        --[[ These are for 'Custom' Difficulty Ranks. It can be very  useful
        in some cases, especially to apply new colors for stuff you
        couldn't before. (huh? -aj) ]]
        Beginner    = color("#1AE0E4"),         -- Mint
        Easy        = color("#3ACF2A"),         -- Green
        Medium      = color("#CFC42A"),         -- Yellow
        Hard        = color("#CF502A"),         -- Orange
        Challenge   = color("#981F41"),         -- Plum
        Edit        = color("0.8,0.8,0.8,1"),   -- Gray
        Couple      = color("#ed0972"),         -- hot pink
        Routine     = color("#ff9a00"),         -- orange
        --[[ These are for courses, so let's slap them here in case someone
        wanted to use Difficulty in Course and Step regions. ]]
        Difficulty_Beginner = color("#1AE0E4"),     -- Mint
        Difficulty_Easy     = color("#2FA74D"),     -- Green
        Difficulty_Medium   = color("#CFC42A"),     -- Yellow
        Difficulty_Hard     = color("#CF502A"),     -- Orange
        Difficulty_Challenge    = color("#981F41"), -- Plum
        Difficulty_Edit     = color("0.8,0.8,0.8,1"),       -- gray
        Difficulty_Couple   = color("#ed0972"),             -- hot pink
        Difficulty_Routine  = color("#ff9a00")              -- orange
    },
    Stage = {
        Stage_1st   = color("#3A44AF"),
        Stage_2nd   = color("#3A44AF"),
        Stage_3rd   = color("#3A44AF"),
        Stage_4th   = color("#3A44AF"),
        Stage_5th   = color("#3A44AF"),
        Stage_6th   = color("#3A44AF"),
        Stage_Next  = color("#3A44AF"),
        Stage_Final = color("#3A44AF"),
        Stage_Extra1    = color("#3A86AF"),
        Stage_Extra2    = color("#AF3A3A"),
        Stage_Nonstop   = color("#3A44AF"),
        Stage_Oni   = color("#3A44AF"),
        Stage_Endless   = color("#3A44AF"),
        Stage_Event = color("#3A44AF"),
        Stage_Demo  = color("#3A44AF")
    },
    Judgment = {
        JudgmentLine_W1     = color("#A0DBF1"),
        JudgmentLine_W2     = color("#F1E4A2"),
        JudgmentLine_W3     = color("#ABE39B"),
        JudgmentLine_W4     = color("#86ACD6"),
        JudgmentLine_W5     = color("#958CD6"),
        JudgmentLine_Held   = color("#FFFFFF"),
        JudgmentLine_Miss   = color("#F97E7E"),
        JudgmentLine_MaxCombo   = color("#ffc600")
    },
}

GameColor.Difficulty["Crazy"]       = GameColor.Difficulty["Hard"]
GameColor.Difficulty["Freestyle"]   = GameColor.Difficulty["Easy"]
GameColor.Difficulty["Nightmare"]   = GameColor.Difficulty["Challenge"]
GameColor.Difficulty["HalfDouble"]  = GameColor.Difficulty["Medium"]