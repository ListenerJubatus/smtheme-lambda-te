return LoadFont("Common normal") .. {
	Text=GetLifeDifficulty();
	AltText="";
	BeginCommand=function(self)
		self:settextf( Screen.String("TimingDifficulty"), GetTimingDifficulty() );
		self:diffuse(color("#7B87AD")):zoom(0.5);
		self:diffusealpha(0):sleep(0.5):smooth(0.3):diffusealpha(1);
	end;
};
