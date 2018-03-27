local t = Def.ActorFrame{
	InitCommand=cmd(fov,70);
	Def.ActorFrame {
		InitCommand=cmd(zoom,0.75);
		OnCommand=cmd(diffusealpha,0;zoom,0.4;decelerate,0.7;diffusealpha,1;zoom,0.75);
			LoadActor("_text");
		};
	};

return t;
