local t = Def.ActorFrame {};

-- Base bar diffuse,color("#1C1C1B");diffusebottomedge,color("#333230");
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(vertalign,top;);
	OnCommand=function(self)
		self:diffusealpha(0):addy(-64):decelerate(0.5):addy(64):diffusealpha(1);
	end;
	OffCommand=cmd(sleep,0.3;decelerate,0.7;addy,-105;diffusealpha,0;);
		Def.Quad {
			InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH,60;);
			OnCommand=function(self)
				self:diffuse(color("#000000")):diffusealpha(0.8)
			end;
		};
		Def.Quad {
			InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH,60;);
			OnCommand=function(self)
				self:diffuse(color("#181C4D")):diffuserightedge(color("#181C4D")):diffusealpha(0.8)
			end;
		};
		LoadActor("_shade") .. {
			InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH,60;);
			OnCommand=function(self)
				self:diffusealpha(1):faderight(1):diffuse(ColorLightTone(color("#6168BA"))):blend('BlendMode_Add')
			end;
		};
		LoadActor("_pulse") .. {
			InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH,60;);
			OnCommand=function(self)
				self:diffusealpha(1):faderight(1):diffuse(ColorLightTone(color("#6168BA"))):blend('BlendMode_Add'):queuecommand("Animate")
			end;
			AnimateCommand=cmd(faderight,1;decelerate,16;fadeleft,1;faderight,0;decelerate,16;fadeleft,0;faderight,1;queuecommand,"Animate");
			OffCommand=cmd(stoptweening);
		};
		-- Shadow
};

-- Diamond (todo: Migrate mode colors to global vars)
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,-SCREEN_CENTER_X+48;y,SCREEN_TOP+20;zoom,0.6;);
	OnCommand=cmd(diffusealpha,0;sleep,0.5;decelerate,0.7;diffusealpha,1;);
	OffCommand=cmd(decelerate,0.2;addx,-110;);

	-- Diamond BG
	Def.Quad {
		InitCommand=cmd(vertalign,top;zoomto,54,54;rotationz,45;);
		OnCommand=function(self)
			self:diffuse(color("#434DC4")):diffusealpha(0.7)
		end;
	},
	-- Symbol selector
	Def.Sprite {
		Name="HeaderDiamondIcon";
		InitCommand=cmd(horizalign,center;y,18;x,-20;diffusealpha,0.8);
		OnCommand=function(self)
			local screen = SCREENMAN:GetTopScreen():GetName();
			if FILEMAN:DoesFileExist("Themes/"..THEME:GetCurThemeName().."/Graphics/ScreenWithMenuElements header/"..screen.." icon.png") then
				self:Load(THEME:GetPathG("","ScreenWithMenuElements header/"..screen.." icon"));
			else
				print("iconerror: file does not exist")
				self:Load(THEME:GetPathG("","ScreenWithMenuElements header/Generic icon"));
			end;
		end;
	},
};

-- Text
t[#t+1] = LoadFont("Common Header") .. {
	Name="HeaderTitle";
	Text=Screen.String("HeaderText");
	InitCommand=cmd(zoom,0.75;x,-SCREEN_CENTER_X+72;y,30;horizalign,left;diffuse,color("#7E85D9");diffusetopedge,color("#FFFFFF");shadowlength,1;);
	OnCommand=cmd(diffusealpha,0;sleep,0.5;decelerate,0.7;diffusealpha,1;);
	UpdateScreenHeaderMessageCommand=function(self,param)
		self:settext(param.Header);
	end;
	OffCommand=cmd(decelerate,0.2;diffusealpha,0;);
};

-- t[#t+1] = LoadFont("Common Condensed") .. {
	-- Name="HeaderSubTitle";
	-- Text=Screen.String("HeaderSubText");
	-- InitCommand=cmd(zoom,0.8;x,-SCREEN_CENTER_X+110;y,70;horizalign,left;diffuse,color("#ffffff");shadowlength,1;skewx,-0.1);
	-- OnCommand=cmd(diffusealpha,0;sleep,0.55;smooth,0.3;diffusealpha,0.75;);
	-- UpdateScreenHeaderMessageCommand=function(self,param)
		-- self:settext(param.Header);
	-- end;
	-- OffCommand=cmd(smooth,0.3;diffusealpha,0;);
-- };

return t;