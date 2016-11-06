local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
		InitCommand=cmd(vertalign,bottom;y,SCREEN_TOP+36;x,SCREEN_CENTER_X;);
		OnCommand=cmd(addy,-80;sleep,0.6;decelerate,0.5;addy,68);
		OffCommand=cmd(sleep,0.2;decelerate,0.5;addy,-68);
			LoadActor("_scoreback") .. {
				InitCommand=cmd(visible,GAMESTATE:IsPlayerEnabled(PLAYER_1);diffuse,PlayerColor(PLAYER_1));
			};
			LoadActor("_scoreback") .. {
				InitCommand=cmd(visible,GAMESTATE:IsPlayerEnabled(PLAYER_2);diffuse,PlayerColor(PLAYER_2);zoomx,-1);
			};
		
		LoadActor("_top") .. {
		};
		LoadFont("Common normal") .. {
				  InitCommand=cmd(strokecolor,color("#000000");zoom,0.75;maxwidth,450);
				  CurrentSongChangedMessageCommand=cmd(finishtweening;playcommand,"Set");
				  CurrentCourseChangedMessageCommand=cmd(finishtweening;playcommand,"Set");
				  ChangedLanguageDisplayMessageCommand=cmd(finishtweening;playcommand,"Set");
				  SetCommand=function(self)
					   local song = GAMESTATE:GetCurrentSong();
					   if song then
							self:settext(song:GetDisplayFullTitle());
							self:playcommand("Refresh");
						else
							self:settext("");
							self:playcommand("Refresh");
					   end
				  end;
		};
	};


if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	t[#t+1] = Def.ActorFrame {
		InitCommand=cmd(x,SCREEN_CENTER_X-195;y,SCREEN_TOP+25;zoom,0.5;horizalign,right;);
		OnCommand=cmd(addy,-68;sleep,0.6;decelerate,0.5;addy,68);		
		OffCommand=cmd(sleep,0.2;decelerate,0.5;addy,-68);
		
		Def.BitmapText {
			Font="_overpass p1score",
			Text="0.00%",
			InitCommand=cmd(horizalign,right);
			JudgmentMessageCommand=function(self) self:queuecommand("RedrawScore") end,
			RedrawScoreCommand=function(self)
				local dp = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPercentDancePoints()
				local percent = FormatPercentScore( dp ):sub(1,-2)
				self:settext(percent .. "%")
			end;
		};
	};	
	t[#t+1]	 = Def.ActorFrame {
			InitCommand=cmd(horizalign,center;x,THEME:GetMetric(Var "LoadingScreen","PlayerP1MiscX");y,SCREEN_BOTTOM-30;);
			OnCommand=cmd(addy,68;sleep,0.6;decelerate,0.5;addy,-68);			
			OffCommand=cmd(sleep,0.2;decelerate,0.5;addy,68);
			LoadActor(THEME:GetPathG("StepsDisplayListRow", "frame")) .. {
				  InitCommand=cmd(zoom,1;);
				  OnCommand=cmd(playcommand,"Set";);
				  CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set";); 
				  PlayerJoinedMessageCommand=cmd(playcommand,"Set";diffusealpha,0;smooth,0.3;diffusealpha,1;);
				  ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set"); 
				  SetCommand=function(self)
					stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
					local song = GAMESTATE:GetCurrentSong();
					if song then 
						if stepsP1 ~= nil then
							local st = stepsP1:GetStepsType();
							local diff = stepsP1:GetDifficulty();
							local cd = GetCustomDifficulty(st, diff);
							self:diffuse(ColorDarkTone(CustomDifficultyToColor(cd)));
						else
							self:settext("")
						end
					else
						self:settext("")
					end
				end					
			};
			
			LoadFont("Common Normal") .. { 
				  InitCommand=cmd(zoom,0.75;);				  
				  OnCommand=cmd(playcommand,"Set";);
				  CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set";); 
				  PlayerJoinedMessageCommand=cmd(playcommand,"Set";diffusealpha,0;smooth,0.3;diffusealpha,1;);
				  ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set"); 
				  SetCommand=function(self)
					stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
					local song = GAMESTATE:GetCurrentSong();
					if song then 
						if stepsP1 ~= nil then
							local st = stepsP1:GetStepsType();
							local diff = stepsP1:GetDifficulty();
							local cd = GetCustomDifficulty(st, diff);
							self:settext(string.upper(THEME:GetString("CustomDifficulty",ToEnumShortString(diff)) .. "  " .. stepsP1:GetMeter()))
							self:diffuse(ColorLightTone(CustomDifficultyToColor(cd)));
							self:strokecolor(ColorDarkTone(CustomDifficultyToColor(cd)));
						else
							self:settext("")
						end
					else
						self:settext("")
					end
				end	
			};
		};
end;
if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	t[#t+1] = Def.ActorFrame {
		InitCommand=cmd(x,SCREEN_CENTER_X+195;y,SCREEN_TOP+25;zoom,0.5;horizalign,left;);
		OnCommand=cmd(addy,-68;sleep,0.6;decelerate,0.5;addy,68);		
		OffCommand=cmd(sleep,0.2;decelerate,0.5;addy,-68);
		
		Def.BitmapText {
			InitCommand=cmd(horizalign,left);
			Font="_overpass p2score",
			Text="0.00%",
			JudgmentMessageCommand=function(self) self:queuecommand("RedrawScore") end,
			RedrawScoreCommand=function(self)
				local dp = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPercentDancePoints()
				local percent = FormatPercentScore( dp ):sub(1,-2)
				self:settext(percent .. "%")
			end;
		};
	};
		t[#t+1]	 = Def.ActorFrame {
			InitCommand=cmd(horizalign,center;x,THEME:GetMetric(Var "LoadingScreen","PlayerP2MiscX");y,SCREEN_BOTTOM-30;);
			OnCommand=cmd(addy,68;sleep,0.6;decelerate,0.5;addy,-68);			
			OffCommand=cmd(sleep,0.2;decelerate,0.5;addy,68);			
			LoadActor(THEME:GetPathG("StepsDisplayListRow", "frame")) .. {
				  InitCommand=cmd(zoom,1;);
				  OnCommand=cmd(playcommand,"Set";);
				  CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set";); 
				  PlayerJoinedMessageCommand=cmd(playcommand,"Set";diffusealpha,0;smooth,0.3;diffusealpha,1;);
				  ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set"); 
				  SetCommand=function(self)
					stepsP2 = GAMESTATE:GetCurrentSteps(PLAYER_2)
					local song = GAMESTATE:GetCurrentSong();
					if song then 
						if stepsP2 ~= nil then
							local st = stepsP2:GetStepsType();
							local diff = stepsP2:GetDifficulty();
							local cd = GetCustomDifficulty(st, diff);
							self:diffuse(ColorDarkTone(CustomDifficultyToColor(cd)));
						else
							self:settext("")
						end
					else
						self:settext("")
					end
				end					
			};
			
			LoadFont("Common Normal") .. { 
				  InitCommand=cmd(zoom,0.75;);				  
				  OnCommand=cmd(playcommand,"Set";);
				  CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set";); 
				  PlayerJoinedMessageCommand=cmd(playcommand,"Set";diffusealpha,0;smooth,0.3;diffusealpha,1;);
				  ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set"); 
				  SetCommand=function(self)
					stepsP2 = GAMESTATE:GetCurrentSteps(PLAYER_2)
					local song = GAMESTATE:GetCurrentSong();
					if song then 
						if stepsP2 ~= nil then
							local st = stepsP2:GetStepsType();
							local diff = stepsP2:GetDifficulty();
							local cd = GetCustomDifficulty(st, diff);
							self:settext(string.upper(THEME:GetString("CustomDifficulty",ToEnumShortString(diff)) .. "  " .. stepsP2:GetMeter()))
							self:diffuse(ColorLightTone(CustomDifficultyToColor(cd)));
							self:strokecolor(ColorDarkTone(CustomDifficultyToColor(cd)));
						else
							self:settext("")
						end
					else
						self:settext("")
					end
				end	
			};
		};
end;

return t