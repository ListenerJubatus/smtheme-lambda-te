-- ...So I realize that I completely ignored almost each and every
-- metrics-bound element this screen could use, but it's okay, right?

local t = LoadFallbackB()
-- A very useful table...
local eval_lines = {
	"W1",
	"W2",
	"W3",
	"W4",
	"W5",
	"Miss",
	"Held",
	"MaxCombo"
}

-- And a function to make even better use out of the table.
local function GetJLineValue(line, pl)
	if line == "Held" then
		return STATSMAN:GetCurStageStats():GetPlayerStageStats(pl):GetHoldNoteScores("HoldNoteScore_Held")
	elseif line == "MaxCombo" then
		return STATSMAN:GetCurStageStats():GetPlayerStageStats(pl):MaxCombo()
	else
		return STATSMAN:GetCurStageStats():GetPlayerStageStats(pl):GetTapNoteScores("TapNoteScore_" .. line)
	end
	return "???"
end

-- You know what, we'll deal with getting the overall scores with a function too.
local function GetPlScore(pl, scoretype)
	local primary_score = STATSMAN:GetCurStageStats():GetPlayerStageStats(pl):GetScore()
	local secondary_score = FormatPercentScore(STATSMAN:GetCurStageStats():GetPlayerStageStats(pl):GetPercentDancePoints())
	
	if PREFSMAN:GetPreference("PercentageScoring") then
		primary_score, secondary_score = secondary_score, primary_score
	end
	
	if scoretype == "primary" then
		return primary_score
	else
		return secondary_score
	end
end

-- #################################################
-- That's enough functions; let's get this done.

-- Shared portion.
local mid_pane = Def.ActorFrame {
	-- Song/course banner.
	Def.Sprite {
		InitCommand=function(self)
			local target = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			if target and target:HasBanner() then
				self:Load(target:GetBannerPath())
			else
				self:Load(THEME:GetPathG("Common fallback", "banner"))
			end
			self:scaletoclipped(256,80):x(_screen.cx):y(_screen.cy-127)
		end;
		OnCommand=cmd(zoom,0.7;diffusealpha,0;sleep,0.3;decelerate,0.3;diffusealpha,1;zoom,0.8);
		OffCommand=cmd(decelerate,0.3;diffusealpha,0;zoom,0.8);
	},
	-- Banner frame.
	LoadActor("_bannerframe") .. {
		InitCommand=cmd(x,_screen.cx;y,_screen.cy-127;);
		OnCommand=cmd(zoom,0.7;diffusealpha,0;sleep,0.3;decelerate,0.3;diffusealpha,1;zoom,0.8);
		OffCommand=cmd(decelerate,0.3;diffusealpha,0;zoom,0.75);

	}
}


-- Text that's slapped on top of the banner frame.
if not GAMESTATE:IsCourseMode() then
	mid_pane[#mid_pane+1] = LoadActor(THEME:GetPathG("ScreenEvaluation", "StageDisplay")) .. {
		OnCommand=cmd(x,_screen.cx;y,_screen.cy-71;zoom,0.75)
	}
else
	mid_pane[#mid_pane+1] = Def.BitmapText {
		Font="Common Condensed",
		InitCommand=function(self)
			local course = GAMESTATE:GetCurrentCourse()
			self:settext(ToEnumShortString( course:GetCourseType() ))
			self:x(_screen.cx):y(_screen.cy-118.5):diffuse(color("#9d324e")):uppercase(true)
		end,
		OnCommand=cmd(playcommand,"Set";zoomx,0.8;diffusealpha,0;decelerate,0.4;zoomx,1;diffusealpha,1),
		OffCommand=cmd(decelerate,0.3;diffusealpha,0)
	}
end

-- Each line's text, and associated decorations.
for i, v in ipairs(eval_lines) do
	local spacing = 26*i
	local cur_line = "JudgmentLine_" .. v
	
	mid_pane[#mid_pane+1] = Def.ActorFrame{
		InitCommand=cmd(x,_screen.cx;y,(_screen.cy/1.4)+(spacing)),
		
		Def.Quad {
			InitCommand=cmd(zoomto,200,24;diffuse,ColorDarkTone(JudgmentLineToColor(cur_line));fadeleft,0.5;faderight,0.5;diffusealpha,0.75);
			OnCommand=function(self)			
				self:diffusealpha(0):sleep(0.1 * i):decelerate(0.9):diffusealpha(1)
			end;
			OffCommand=function(self)			
				self:sleep(0.1 * i):decelerate(0.3):diffusealpha(0)
			end;			
		};
	
		Def.BitmapText {
			Font = "Common Normal",
			InitCommand=cmd(zoom,0.7;diffuse,ColorLightTone(JudgmentLineToColor(cur_line));settext,string.upper(JudgmentLineToLocalizedString(cur_line));diffusealpha,0.6);
			OnCommand=function(self)			
				self:diffusealpha(0):sleep(0.1 * i):decelerate(0.9):diffusealpha(0.6)
			end;
			OffCommand=function(self)			
				self:sleep(0.1 * i):decelerate(0.3):diffusealpha(0)
			end;	
		}
	}
end

t[#t+1] = mid_pane

-- #################################################
-- Time to deal with all of the player stats. ALL OF THEM.

local eval_parts = Def.ActorFrame {}

for ip, p in ipairs(GAMESTATE:GetHumanPlayers()) do
	-- Some things to help positioning
	local step_count_offs = string.find(p, "P1") and -80 or 80
	local grade_parts_offs = string.find(p, "P1") and -270 or 270
	local p_grade = STATSMAN:GetCurStageStats():GetPlayerStageStats(p):GetGrade()
	
	-- Step counts.
	for i, v in ipairs(eval_lines) do
		local spacing = 26*i
		eval_parts[#eval_parts+1] = Def.BitmapText {
			Font = "Common Normal",
			InitCommand=cmd(x,_screen.cx + step_count_offs;y,(_screen.cy/1.4)+(spacing);diffuse,ColorLightTone(PlayerColor(p));zoom,0.75;diffusealpha,1.0;shadowlength,1),
			OnCommand=function(self)
				self:settext(GetJLineValue(v, p))
				if string.find(p, "P1") then
					self:horizalign(right)
				else
					self:horizalign(left)
				end
				self:diffusealpha(0):sleep(0.1 * i):decelerate(0.9):diffusealpha(1)
			end,
			OffCommand=function(self)			
				self:sleep(0.1 * i):decelerate(0.3):diffusealpha(0)
			end;	
			
		}
	end
	
	-- Primary score.
	eval_parts[#eval_parts+1] = Def.BitmapText {
		Font = "Common normal",
		InitCommand=cmd(x,_screen.cx + (grade_parts_offs * 0.8);y,(_screen.cy-27);diffuse,PlayerColor(p);zoom,1;shadowlength,1),
		OnCommand=function(self)
			self:settext(GetPlScore(p, "primary")):horizalign(center)
			self:diffusealpha(0):sleep(0.9):decelerate(0.4):diffusealpha(1)
		end;
		OffCommand=cmd(decelerate,0.3;diffusealpha,0;);
	}
	-- Secondary score.
	eval_parts[#eval_parts+1] = Def.BitmapText {
		Font = "Common normal",
		InitCommand=cmd(x,_screen.cx + (grade_parts_offs * 0.8);y,(_screen.cy-27)+23;diffuse,ColorMidTone(PlayerColor(p));zoom,0.75;shadowlength,1),
		OnCommand=function(self)
			self:settext(GetPlScore(p, "secondary")):horizalign(center)
			self:diffusealpha(0):sleep(0.9):decelerate(0.4):diffusealpha(1)
		end;
		OffCommand=cmd(sleep,0.1;decelerate,0.3;diffusealpha,0;);
	}
	
	-- Letter grade and associated parts.
	eval_parts[#eval_parts+1] = Def.ActorFrame{
		InitCommand=cmd(x,_screen.cx + (grade_parts_offs * 0.8);y,_screen.cy/1.91),
		OnCommand=cmd(diffusealpha,0;zoom,0.75;sleep,0.9;decelerate,0.4;zoom,1;diffusealpha,1),
		OffCommand=cmd(decelerate,0.3;diffusealpha,0;zoom,0.75);
		Def.Quad {
			InitCommand=cmd(zoomto,160,90;diffuse,color("#394D91");diffusealpha,0.4);
		},
		
		LoadActor(THEME:GetPathG("GradeDisplay", "Grade " .. p_grade)) .. {
			InitCommand=cmd(zoom,0.5;);
			OnCommand=function(self)
			        if STATSMAN:GetCurStageStats():GetPlayerStageStats(p):GetStageAward() then
					  self:sleep(1.3):smooth(0.4):addy(-6);
					else
					  self:addy(0);
					end;
			end;
		},
		
		Def.BitmapText {
			Font = "Common normal",
			InitCommand=cmd(diffuse,Color.White;zoom,0.6;addy,32;maxwidth,220;uppercase,true;diffuse,color("#CEE5ED");diffusetopedge,color("#8C9DBA");),
			OnCommand=function(self)
				if STATSMAN:GetCurStageStats():GetPlayerStageStats(p):GetStageAward() then
					self:settext(THEME:GetString( "StageAward", ToEnumShortString(STATSMAN:GetCurStageStats():GetPlayerStageStats(p):GetStageAward()) ))
					self:diffusealpha(0):zoomx(0.4):sleep(1.3):decelerate(0.4):zoomx(0.6):diffusealpha(1)
				end
			end
		}
	}
end

t[#t+1] = eval_parts


-- todo: replace.
if GAMESTATE:IsHumanPlayer(PLAYER_1) == true then
	if GAMESTATE:IsCourseMode() == false then
	local grade_parts_offs = -270
	-- Difficulty banner
	t[#t+1] = Def.ActorFrame {
	  InitCommand=cmd(x,_screen.cx + (grade_parts_offs * 0.8);y,_screen.cy-52;zoom,1;visible,not GAMESTATE:IsCourseMode(););
	  OnCommand=cmd(diffusealpha,0;zoom,0.5;sleep,0.9;decelerate,0.3;zoom,0.8;diffusealpha,1);
	  OffCommand=cmd(decelerate,0.3;diffusealpha,0;);
	 
	 LoadActor(THEME:GetPathG("StepsDisplayListRow", "frame")) .. {
			InitCommand=cmd(zoom,1;horizalign,center;);
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
			InitCommand=cmd(zoom,0.75;horizalign,center;);
			OnCommand=cmd(playcommand,"Set";);
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set";);
			ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set";);
			SetCommand=function(self)
			stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
			local song = GAMESTATE:GetCurrentSong();
			  if song then
				if stepsP1 ~= nil then
				  local st = stepsP1:GetStepsType();
				  local diff = stepsP1:GetDifficulty();
				  local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
				  local cd = GetCustomDifficulty(st, diff, courseType);
				  self:settext(string.upper(THEME:GetString("CustomDifficulty",ToEnumShortString(diff))) .. "  " .. stepsP1:GetMeter());
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

end;


if GAMESTATE:IsHumanPlayer(PLAYER_2) == true then

	if GAMESTATE:IsCourseMode() == false then
	local grade_parts_offs = 270
	-- Difficulty banner
	t[#t+1] = Def.ActorFrame {
	  	  InitCommand=cmd(x,_screen.cx + (grade_parts_offs * 0.8);y,_screen.cy-52;zoom,1;visible,not GAMESTATE:IsCourseMode(););
	  OnCommand=cmd(diffusealpha,0;zoom,0.5;sleep,0.9;decelerate,0.3;zoom,0.8;diffusealpha,1);
	  OffCommand=cmd(decelerate,0.3;diffusealpha,0;);
	 
	 LoadActor(THEME:GetPathG("StepsDisplayListRow", "frame")) .. {
			InitCommand=cmd(zoom,1;horizalign,center;);
			OnCommand=cmd(playcommand,"Set";);
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set";); 
			PlayerJoinedMessageCommand=cmd(playcommand,"Set";diffusealpha,0;smooth,0.3;diffusealpha,1;);
			ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set"); 
			SetCommand=function(self)
					stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_2)
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
			InitCommand=cmd(zoom,0.75;horizalign,center;);
			OnCommand=cmd(playcommand,"Set";);
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set";);
			ChangedLanguageDisplayMessageCommand=cmd(playcommand,"Set";);
			SetCommand=function(self)
			stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_2)
			local song = GAMESTATE:GetCurrentSong();
			  if song then
				if stepsP1 ~= nil then
				  local st = stepsP1:GetStepsType();
				  local diff = stepsP1:GetDifficulty();
				  local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;
				  local cd = GetCustomDifficulty(st, diff, courseType);
				  self:settext(string.upper(THEME:GetString("CustomDifficulty",ToEnumShortString(diff))) .. "  " .. stepsP1:GetMeter());
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
end;

t[#t+1] = StandardDecorationFromFileOptional("LifeDifficulty","LifeDifficulty");
t[#t+1] = StandardDecorationFromFileOptional("TimingDifficulty","TimingDifficulty");

-- if gameplay_pause_count > 0 then
	-- t[#t+1]= Def.BitmapText{
		-- Font= "_roboto condensed 24px",
		-- Text= THEME:GetString("PauseMenu", "pause_count") .. ": " .. gameplay_pause_count,
		-- InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-100+26;);
		-- OnCommand=function(self)
			-- self:diffuse(color("#ffffff")):zoom(0.8);
			-- self:diffusealpha(0):sleep(0.5):smooth(0.3):diffusealpha(1);
		-- end;
		-- OffCommand=cmd(decelerate,0.3;diffusealpha,0);
	-- }
-- end

return t;

