local bg = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,0"));
		StartTransitioningCommand=cmd(sleep,0.4;linear,2;diffusealpha,1;sleep,1;);
	};
};

return bg