local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	LoadActor("_base") .. {
		InitCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
	};	
};

return t;
