local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
  InitCommand=cmd(Center);
	Def.Quad {
		InitCommand=cmd(scaletoclipped,SCREEN_WIDTH,SCREEN_HEIGHT);
		OnCommand=cmd(diffuse,color("#000000");diffusebottomedge,color("#212121"));
	};
};

t[#t+1] = Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+20;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT*0.70;);
		OnCommand=cmd(diffuse,color("#000000");diffusealpha,0.75);
	};
};

return t;
