local gc = Var("GameCommand");

local string_name = gc:GetText();
local string_expl = THEME:GetString("StyleType", gc:GetStyle():GetStyleType());
local icon_color = color("#0e188c");
local icon_color2 = color("#212ca5");

local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame { 
	GainFocusCommand=THEME:GetMetric(Var "LoadingScreen","IconGainFocusCommand");
	LoseFocusCommand=THEME:GetMetric(Var "LoadingScreen","IconLoseFocusCommand");

	LoadActor(THEME:GetPathG("ScreenSelectPlayMode", "icon/_background base"))..{
		GainFocusCommand=cmd(diffuse,color("#DEE0F7"););
		LoseFocusCommand=cmd(diffuse,color("#5F6AE1"););
	};
	LoadFont("_overpass 36px")..{
		Text=string.upper(string_name);
		InitCommand=cmd(y,-12;maxwidth,232);
		OnCommand=cmd(diffuse,icon_color);
	};
	LoadFont("Common Italic Condensed")..{
		Text=string.upper(string_expl);
		InitCommand=cmd(y,29.5;maxwidth,128;diffuse,color("#050d60"););
	};

	LoadActor(THEME:GetPathG("ScreenSelectPlayMode", "icon/_background base"))..{
		DisabledCommand=cmd(diffuse,color("0,0,0,0.5"));
		EnabledCommand=cmd(diffuse,color("1,1,1,0"));
	};
};
return t