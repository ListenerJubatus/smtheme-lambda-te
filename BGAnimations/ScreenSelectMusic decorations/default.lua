local t = LoadFallbackB();

t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X-161;y,SCREEN_CENTER_Y+23);
	OnCommand=cmd(addx,-SCREEN_CENTER_X-40;sleep,0.2;decelerate,0.6;addx,SCREEN_CENTER_X+40);
	OffCommand=cmd(sleep,0.3;decelerate,0.4;diffusealpha,0;zoom,0.75;);
	LoadActor("_pane") .. {
		InitCommand=cmd(zoom,0.75;)
	};

	-- Artist
	Def.ActorFrame {
	InitCommand=cmd(addy,-80);
	OffCommand=cmd(decelerate,0.3;diffusealpha,0);
	LoadFont("Common condensed") .. {
			 InitCommand=cmd(zoom,0.5;horizalign,left;addx,-128;visible,not GAMESTATE:IsCourseMode(););				  
            OnCommand=cmd(queuecommand,"Set");
            ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
            SetCommand=function(self)
                self:settext("ARTIST:");
                self:diffuse(color("#FFFFFF")):queuecommand("Refresh");
            end;
		};
	LoadFont("Common condensed") .. {
				  InitCommand=cmd(zoom,0.5;maxwidth,240;horizalign,left;addx,-84;visible,not GAMESTATE:IsCourseMode(););				  
				  OnCommand=function(self)
						self:diffuse(color("#FFFFFF"));
					end;
				  CurrentSongChangedMessageCommand=cmd(finishtweening;queuecommand,"Set");
				  CurrentCourseChangedMessageCommand=cmd(finishtweening;queuecommand,"Set");
				  ChangedLanguageDisplayMessageCommand=cmd(finishtweening;queuecommand,"Set");
				  SetCommand=function(self)
					   local song = GAMESTATE:GetCurrentSong();
					   if song then
							self:settext(song:GetDisplayArtist());
							self:playcommand("Refresh");
						else
							self:settext("");
							self:playcommand("Refresh");
					   end
				  end;
		};
	
	LoadFont("Common condensed") .. {
			InitCommand=cmd(zoom,0.5;horizalign,left;addx,52+12;visible,not GAMESTATE:IsCourseMode(););				  
            OnCommand=cmd(queuecommand,"Set");
            ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
            SetCommand=function(self)
                self:settext("LENGTH:");
                self:diffuse(color("#FFFFFF")):queuecommand("Refresh");
            end;
	};
		
	LoadFont("Common condensed") .. {
			InitCommand=cmd(zoom,0.5;horizalign,left;addx,-128;addy,15;visible,not GAMESTATE:IsCourseMode(););				  
            OnCommand=cmd(queuecommand,"Set");
            ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
            SetCommand=function(self)
                self:settext("BPM:");
                self:diffuse(color("#FFFFFF")):queuecommand("Refresh");
            end;
	};
	
			
	LoadFont("Common condensed") .. {
			InitCommand=cmd(zoom,0.5;horizalign,right;addx,122+10;addy,15;visible,not GAMESTATE:IsCourseMode(););				  
            OnCommand=cmd(queuecommand,"Set");
			CurrentSongChangedMessageCommand=cmd(finishtweening;queuecommand,"Set");
			CurrentCourseChangedMessageCommand=cmd(finishtweening;queuecommand,"Set");
			ChangedLanguageDisplayMessageCommand=cmd(finishtweening;queuecommand,"Set");
			SetCommand=function(self)
					   local song = GAMESTATE:GetCurrentSong();
					   if song then
							self:settext("/" .. song:GetGroupName());
							self:playcommand("Refresh");
						else
							self:settext("");
							self:playcommand("Refresh");
					   end
				  end;
	};
	StandardDecorationFromFileOptional("BPMDisplay","BPMDisplay");
	
	Def.ActorFrame {
			InitCommand=cmd(zoom,0.5;horizalign,left;addx,112+10;visible,not GAMESTATE:IsCourseMode(););				  
            OnCommand=cmd(queuecommand,"Set");
			-- Length
			StandardDecorationFromFileOptional("SongTime","SongTime") .. {
			SetCommand=function(self)
				local curSelection = nil;
				local length = 0.0;
				if GAMESTATE:IsCourseMode() then
					curSelection = GAMESTATE:GetCurrentCourse();
					self:queuecommand("Reset");
					if curSelection then
						local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber());
						if trail then
							length = TrailUtil.GetTotalSeconds(trail);
						else
							length = 0.0;
						end;
					else
						length = 0.0;
					end;
				else
					curSelection = GAMESTATE:GetCurrentSong();
					self:queuecommand("Reset");
					if curSelection then
						length = curSelection:MusicLengthSeconds();
						if curSelection:IsLong() then
							self:queuecommand("Long");
						elseif curSelection:IsMarathon() then
							self:queuecommand("Marathon");
						else
							self:queuecommand("Reset");
						end
					else
						length = 0.0;
						self:queuecommand("Reset");
					end;
				end;
				self:settext( SecondsToMSS(length) );
			end;
				CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
				CurrentCourseChangedMessageCommand=cmd(queuecommand,"Set");
				CurrentTrailP1ChangedMessageCommand=cmd(queuecommand,"Set");
				CurrentTrailP2ChangedMessageCommand=cmd(queuecommand,"Set");
			};
		};
	};
	
};

-- Sort and stage display tiles
t[#t+1] = Def.ActorFrame {
    InitCommand=cmd(x,SCREEN_CENTER_X+150;y,SCREEN_CENTER_Y-160;visible,not GAMESTATE:IsCourseMode(););
    OnCommand=cmd(diffusealpha,0;zoomx,0.7;sleep,0.3;decelerate,0.3;diffusealpha,1;zoomx,1;);
	OffCommand=cmd(linear,0.3;diffusealpha,0;);
	LoadActor(THEME:GetPathG("", "_stageFrame"))  .. {
	    InitCommand=cmd(diffusealpha,1;zoom,1.0);
	};

    LoadFont("Common Normal") .. {
            InitCommand=cmd(zoom,0.75;diffuse,color("#FFFFFF");diffusealpha,0.6;horizalign,left;addx,-80;addy,-1;);
            OnCommand=cmd(queuecommand,"Set");
            ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
            SetCommand=function(self)
                self:settext("SORT:");
                self:queuecommand("Refresh");
            end;
    };

    LoadFont("Common Normal") .. {
          InitCommand=cmd(zoom,0.75;maxwidth,SCREEN_WIDTH;addx,80;addy,-1;diffuse,color("#FFFFFF");uppercase,true;horizalign,right;);
          OnCommand=cmd(queuecommand,"Set");
          SortOrderChangedMessageCommand=cmd(queuecommand,"Set");
          ChangedLanguageDisplayMessageCommand=cmd(queuecommand,"Set");
          SetCommand=function(self)
               local sortorder = GAMESTATE:GetSortOrder();
               if sortorder then
					self:finishtweening();
					self:smooth(0.4);
					self:diffusealpha(0);
                    self:settext(SortOrderToLocalizedString(sortorder));
                    self:queuecommand("Refresh"):stoptweening():diffusealpha(0):smooth(0.3):diffusealpha(1)
				else
					self:settext("");
					self:queuecommand("Refresh");
               end
          end;
    };
};
	
t[#t+1] = StandardDecorationFromFileOptional("PaneDisplayFrameP1","PaneDisplayFrame");
t[#t+1] = StandardDecorationFromFileOptional("PaneDisplayFrameP2","PaneDisplayFrame");
t[#t+1] = StandardDecorationFromFileOptional("PaneDisplayTextP1","PaneDisplayTextP1");
t[#t+1] = StandardDecorationFromFileOptional("PaneDisplayTextP2","PaneDisplayTextP2");
t[#t+1] = StandardDecorationFromFileOptional("DifficultyList","DifficultyList");

return t
