local gc = Var("GameCommand");

local string_name = gc:GetText();
local string_expl = THEME:GetString("StyleType", gc:GetStyle():GetStyleType());
local icon_color = color("#FFCB05");
local icon_color2 = color("#F0BA00");

local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame { 
	GainFocusCommand=cmd(stoptweening;bob;effectmagnitude,0,0,3;decelerate,0.1;zoom,1;diffusealpha,1;);
	LoseFocusCommand=cmd(stoptweening;stopeffect;decelerate,0.1;zoom,0.85;diffusealpha,0.5);
	OffCommand=cmd(decelerate,0.2;zoom,0.7;diffusealpha,0;);

	LoadActor(THEME:GetPathG("_style", "base"))..{
	};
	LoadFont("_overpass 36px")..{
		Text=string.upper(string_name);
		InitCommand=cmd(y,-12;maxwidth,232);
		OnCommand=cmd(diffuse,Color.White);
	};
	LoadFont("Common normal")..{
		Text=string.upper(string_expl);
		InitCommand=cmd(y,32;maxwidth,222);
	};

	LoadActor(THEME:GetPathG("ScreenSelectPlayMode", "icon/_background base"))..{
		DisabledCommand=cmd(diffuse,color("0,0,0,0.5"));
		EnabledCommand=cmd(diffuse,color("1,1,1,0"));
	};
};
return t