local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH,5;addy,-36;diffuse,Color("Black");fadetop,1;diffusealpha,0.8);
	};
};

t[#t+1] = Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH,36;);
		OnCommand=function(self)
		self:diffuse(color("#000000")):diffusealpha(0.95)
		end;
	};
	Def.Quad {
		InitCommand=cmd(vertalign,bottom;zoomto,SCREEN_WIDTH,36;fadeleft,0.6;faderight,0.6;);
		OnCommand=function(self)
		self:diffuse(color("#000000")):diffusetopedge(color("#181924")):diffusealpha(0.95)
		end;
	};
};

return t;
