-- Made by DKN :) (Version: 2.2)

--FOR EASIER READING, GO TO THE TOP BAR AND PRESS "COLLAPSE ALL FOLDS"

--WATCH THE YT TUTORIAL FIRST IF YOU NEED TO!
--https://www.youtube.com/watch?v=o0W86EKBra8&t=1s


--[[ How to call animation for your object:
	
	local UIanims = require(game.ReplicatedStorage.Modules.UI)
	local ScreenGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGUI")
	
	local yourObject = ScreenGui.WhateverTheDirectoryIs
	
	
]]

--[[ DEBUG: If you have problems....


!!!!Go to top of studio and COLLAPSE all folds to make things easier to read!!!!

I put comments near each function(that needs a comment) so you know what options are available.


:You might need to read what the functions need to run, in parenthesis. 
EXAMPLE: function blahblah.Blah(THIS, OR_THIS, OR_EVEN_THIS)!



:Unfortunately I'm not skilled enough to cut corners, so if you are to use a function, you will have to put in every single variable to run a function.

:Try Reinstalling the module, something might've been deleted that shouldn't have!

:If all else fails, you might've messed up on the regular script. These all work for me lol.

If you need, contact me on discord dkn1f3 if ya need any assistance!

]]

--[[ TIP(s): 

:For your UI, make use of attributes. You can make an attribute of the position of your UI object, and then make another attribute being the target position. So you can always refer back to the old position!

:If using for loops to animate multiple objects, :GetChildren() is more performant than :GetDescendants(). You may possibly  need :GetDescendants() but use it wisely.

:Remember :IsA("") exists for specifying type of objects you are trying to affect!


]]

--[[ VERSIONS: 

V1.1 (6-26-24):
: Added Help and this version tab

V1.2 (6-26-24):
:Removed unneeded prints I forgot to remove .(oops!)

V1.3 (6-28-24):
:Messed up on a couple things and just fixed that! Sorry for the inconveniences!

V1.4 (7-1-24):
: Renamed the 'Click()' function to add the new variation 'ClickMove()'
: Fixed some unneeded stuff!
: More comment additions
: Removed UI180Loop function (Wasnt needed)

V1.5 (7-7-24):
:On the functions having to do with UIScale, I made it so it automatically adds UIscale object under it! So you don't have to add it to every single object that you want tweened!

:Formatted the comments a tad more organized. Hopefully its more readable!
:Inside Color() I added Type which you can control if you want to recolor the text or the background or image!


V1.6 (7-8-24):

:Changed ShrinkerUI to Appearance and added a debounce because spamming it would break it.

V1.7 (8-30-24):
:Added LoopNickname ?property? for loop functions!
:Added Rock() function! Make your ui rock side to side! (With Loop Nicknames)
:Added Blur() function! Make better immersion by blurring the background when you open your UI!
:Added better.. tooltips? Basically Size:UDim2 so it's easier to read the tooltip when you are mid-typing your function in your script!
:Added --|||||||||||||||||||||||||| for functions that are connected to activate or deactivate.
:Added LoadingText() function that loops dots at the end of the text to signify loading. Try it out sometime!
:Added TypeWriter() function! Typewrite-ify your text!
:Renewed the Spin() function with loop nicknames!
:Formatted the loop functions in their own section for organization
:Formatted everything in a more readable way (I think)
:Added more tips.

V1.8 (8-5-24):
:Added Countdown() function, it just counts down lolz.
:Added FadeWipe() function, Star Wars transition type fade.
:Changed RockAmount name in Rock() to RotateAmount for easier interpretation.
:Added Pop() function.

V1.9 (11/7/24):
:Added FadeAwayList() function, it just has the contents fade away at your set duration.
:Added better tooltips for when writing the functions.
:Split Color() and ColorInDepth() so you can either go simple or configure your desired effect with color with InDepth.
:Optimized a couple functions a tad.

V2.0 (11/25/24):
:Ngl I forgot.

V2.2 (1/1/25):
:Labeled everything better
:FOV and Blur functions
:Changes to Click and Hover pairs to work better.
]]


--v Variable(s) NO TOUCH
local TweenService = game:GetService("TweenService")
local blurObj = nil
local GUIanim = {}
local TprtrLoop = false
local RSZ
local spinTween
local Camera = game.Workspace.CurrentCamera
local Lgt = game:GetService("Lighting")
local blurObj = Lgt:WaitForChild("Blur")
--^



--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> RESIZES the Object on Click.
--<strong>Scale:</strong> ORIGINAL= 0.9
	function GUIanim.ClickSize(Object:GuiButton, Scale:number) 
		
		Object.AnchorPoint = Vector2.new(0.5,0.5)
		
		local size = Object.Size
		if Object:IsA("GuiButton") then 
			Object.MouseButton1Click:Connect(function()
				local twninfo = TweenInfo.new(.1, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
				local goal1 = {Size = UDim2.new(size.X.Scale * Scale, 0, size.Y.Scale * Scale, 0)}
				local shrink = TweenService:Create(Object, twninfo, goal1)
				shrink:Play()
				shrink.Completed:Wait()

				local goal = {Size = UDim2.new(size.X.Scale / Scale, 0, size.Y.Scale / Scale, 0)}
				local expand = TweenService:Create(Object, twninfo, goal)
				expand:Play()
				--^
			end)
		end
	end

--++++++++++++++++++++++++

--<strong>Info:</strong> MOVES the Object on Click.
--<strong>Variation:</strong> The variation on the Y scale when clicked, Try doing 1 first
	function GUIanim.ClickMove(Object:GuiButton, Variation:number) 

		if Object:IsA("GuiButton") then
			Object.MouseButton1Click:Connect(function()
					local orgpos = Object.Position
					local newpos = UDim2.new(orgpos.X.Scale, orgpos.X.Offset, orgpos.Y.Scale + Variation/10, orgpos.Y.Offset)
					local twninfo = TweenInfo.new(.1, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
					local goal1 = {Position = newpos}
					local goal2 = {Position = orgpos}
					local Clicked = TweenService:Create(Object, twninfo, goal1)
					local Return = TweenService:Create(Object, twninfo, goal2)

					Clicked:Play()
					Clicked.Completed:Wait()
					Return:Play()

			end)
		else
			return
		end

	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> RESIZES the Object on Hover.
--<strong>Scale:</strong> ORIGINAL= 0.9
	function GUIanim.HoverSize(object:GuiObject, scale:number)
		
		object.AnchorPoint = Vector2.new(0.5, 0.5)
		-- Store the original size
		local originalSize = object.Size
		local targetSize = UDim2.new(
			originalSize.X.Scale * scale,
			0,
			originalSize.Y.Scale * scale,
			0
		)

		-- Create tween info
		local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)

		-- Create both tweens once and reuse them
		local growTween = TweenService:Create(object, tweenInfo, {Size = targetSize})
		local shrinkTween = TweenService:Create(object, tweenInfo, {Size = originalSize})

		object.MouseEnter:Connect(function()
			if not shrinkTween.Completed then
				shrinkTween:Cancel()
			end
			growTween:Play()
		end)

		object.MouseLeave:Connect(function()
			if not growTween.Completed then
				growTween:Cancel()
			end
			shrinkTween:Play()
		end)

	end

--++++++++++++++++++++++++

--<strong>Info:</strong> MOVES the Object on Hover.
--<strong>Variation:</strong> The variation on the Y scale when clicked, Try 1 first.
	function GUIanim.HoverMove(Object:GuiObject, Variation:number)
		
		local orgpos = Object.Position
		local newpos = UDim2.new(orgpos.X.Scale, orgpos.X.Offset, orgpos.Y.Scale - Variation/10, orgpos.Y.Offset)
		local twninfo = TweenInfo.new(.1, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
		Object.MouseEnter:Connect(function()
			local goal1 = {Position = newpos}
			local Entered = TweenService:Create(Object, twninfo, goal1)
			Entered:Play()
		end)
		
		Object.MouseLeave:Connect(function()
			local goal2 = {Position = orgpos}
			local Return = TweenService:Create(Object, twninfo, goal2)
			Return:Play()
		end)
		
		
		
		
	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> Literally EXPANDS or SHRINKS the Object.
--<strong>Time:</strong> Recommended (0.5), values higher than 1 not recommended!
--<strong>ConfigState:</strong> "Expand" or "Shrink" (Has to be in Quotes cause its a string)
	function GUIanim.Appearance(Object:GuiObject, Time:number, EasingStyle:Enum, ConfigState:string) 
		
		--v Checks if the Object has a UIScale object, you can remove this check if you don't need it!
		local scalefound = false

		for _, child in Object:GetChildren() do

			if child:IsA("UIScale") then
				scalefound = true
				break

			end

		end
		if not scalefound then
			local scaleobj = Instance.new("UIScale")
			scaleobj.Parent = Object
		end
		--^
		
		local twninfo = TweenInfo.new(Time, EasingStyle, Enum.EasingDirection.InOut)
		local Shrink1 = {Scale = 0}
		local Expand1 = {Scale = 1}
		local Shrinkts = TweenService:Create(Object.UIScale, twninfo, Shrink1)
		local Expandts = TweenService:Create(Object.UIScale, twninfo, Expand1)
		
		if ConfigState == "Shrink" and Expandts.PlaybackState == Enum.PlaybackState.Begin then
			Shrinkts:Play()
			Shrinkts.Completed:Wait()
			Object.Visible = false
		end
		
		if ConfigState == "Expand" and Shrinkts.PlaybackState == Enum.PlaybackState.Begin then
			Object.Visible = true
			Expandts:Play()
		end
	
	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> Literally FADES the Object.
--<strong>Trans:</strong> Numbers, or Strings --> "In", "Out", etc (In and Out are 0 and 1, it's just strings lol)
	function GUIanim.Fade(Object:GuiObject, Time:number, Trans:number) 
		
		local twninfo = TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
		
			--Config Transparency
			local FDin = 0
			local FDout = 1
			local NewTrans
			if Trans == "In" then
				NewTrans = FDin
			elseif Trans == "Out" then
				NewTrans = FDout
			else
				NewTrans = Trans
			end
			--^


			--Config Types 
			if Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
				local goalIMG = {ImageTransparency = NewTrans}
				local ActionIMG = TweenService:Create(Object, twninfo, goalIMG)
				
				ActionIMG:Play()
			elseif Object:IsA("TextLabel") or Object:IsA("TextButton") then
				local goalText = {TextTransparency = NewTrans}
				local ActionText = TweenService:Create(Object, twninfo, goalText)
				
				ActionText:Play()
			elseif Object:IsA("Frame") or Object:IsA("ScrollingFrame") then
				
				local goalReg = {BackgroundTransparency = NewTrans}
				local ActionReg = TweenService:Create(Object, twninfo, goalReg)
				
				ActionReg:Play()
			elseif Object:IsA("UIStroke") then

				local goalRegu = {Transparency = NewTrans}
				local ActionReg = TweenService:Create(Object, twninfo, goalRegu)

				ActionReg:Play()
			else 
				return
			end
			--^
	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> Wipe fades your Object like a Star Wars transition.
--<strong>Time:</strong> Recommended (0.8)
--<strong>ConfigState:</strong> "In" or "Out" (Has to be in Quotes cause its a string)
	function GUIanim.FadeWipe(Object:GuiObject, Time:number, ConfigState:string)
		

		local animinfo = TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
		local First = nil
		local Sec = nil
		local Mid = nil
		local AnimFirst, AnimLast = nil, nil

		
		--v Determines the InOrOut function string
		if ConfigState == "In" then
			First = 1
			Mid = .1
			Sec = 0
			AnimFirst, AnimLast = Vector2.new(0,1), Vector2.new(0,-1) 
		elseif ConfigState == "Out" then
			First = 0
			Mid = .9
			Sec = 1
			AnimFirst, AnimLast = Vector2.new(0,1), Vector2.new(0,-1)
		else
			warn("Use In or Out in a string value")
		end
		--^

		
		--v Adds UIGradient
		local GradientFound = false
		for _, child in Object:GetChildren() do

			if child:IsA("UIGradient") then
				GradientFound = true
				child.Rotation = 90
				child.Offset = AnimFirst
				child.Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, First),
					NumberSequenceKeypoint.new(.9, Mid),
					NumberSequenceKeypoint.new(1, Sec)
				})
				break

			end

		end
		if not GradientFound then
			
			local GradObj = Instance.new("UIGradient")
			
			GradObj.Rotation = 90
			GradObj.Offset = AnimFirst
			GradObj.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, First),
				NumberSequenceKeypoint.new(1, Mid),
				NumberSequenceKeypoint.new(1, Sec)
			})
			GradObj.Parent = Object
			
		end
		--^
		
		

		local Goal = {Offset = AnimLast}
		local Action = TweenService:Create(Object.UIGradient, animinfo, Goal)
		Action:Play()

	end
	
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> Literally COLORS the Object. (With LESS control)
--<strong>Color:</strong> Color3.new(255,255,255)
--<strong>Type:</strong> "Text" or "Container" or "Image" (You have to specify what you want adjusted.)
	function GUIanim.Color(Object:GuiObject, Time:number, Color:Color3) 
		
		local twninfo = TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
		local Goal = nil
		
		if Object:IsA("Frame") or Object:IsA("ScrollingFrame") then
			Goal = {BackgroundColor3 = Color}
		elseif Object:IsA("TextLabel") or Object:IsA("TextButton") then
			Goal = {TextColor3 = Color}
		elseif Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
			Goal = {ImageColor3 = Color}
		elseif Object:IsA("UIStroke") then
			Goal = {Color = Color}
		end
		--^
		local Tween = TweenService:Create(Object, twninfo, Goal):Play()
		
	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> Literally COLORS the Object. (With MORE control)
--<strong>Color:</strong> Color3.new(255,255,255)
--<strong>Type:</strong> "Text" or "Container" or "Image" (You have to specify what you want adjusted.)
	function GUIanim.ColorInDepth(Object:GuiObject, Time:number, Color:Color3, Type:string) 

		local twninfo = TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)


		if Type == "Container" then

			local goalCTR = {BackgroundColor3 = Color}
			local ActionText = TweenService:Create(Object, twninfo, goalCTR)
			ActionText:Play()


		elseif Type == "Text" then

			local goalTXT = {TextColor3 = Color}
			local ActionText = TweenService:Create(Object, twninfo, goalTXT)
			ActionText:Play()

		elseif Type == "Image" then

			local goalIMG = {ImageColor3 = Color}
			local ActionText = TweenService:Create(Object, twninfo, goalIMG)
			ActionText:Play()

		elseif Object:IsA("UIStroke") then

			local goalRegu = {Color = Color}
			local ActionReg = TweenService:Create(Object, twninfo, goalRegu)

			ActionReg:Play()
		else
			warn("Something might've not worked with Color()")
			return
		end
		--^
	end
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> Literally MOVES the Object.
--<strong>Goal:</strong> UDim2.new(1,0,1,0) (Do scale ONLY please.)
	function GUIanim.Move(Object:GuiObject, Time:number, EasingStyle:Enum, EasingDirection:Enum, Goal:UDim2)

		local twninfo = TweenInfo.new(Time, EasingStyle, EasingDirection)

		local Goal2 = {Position = Goal}

		local Action = TweenService:Create(Object, twninfo, Goal2)
		Action:Play()

	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> Literally RESIZES the Object.
--<strong>Goal:</strong> UDim2.new(1,0,1,0) (Do scale ONLY please.)
	function GUIanim.Resize(Object:GuiObject, Time:number, EasingStyle:Enum, EasingDirection:Enum, Goal:UDim2)

		local twninfo = TweenInfo.new(Time, EasingStyle, EasingDirection)

		local Goal2 = {Size = Goal}

		local Action = TweenService:Create(Object, twninfo, Goal2)
		Action:Play()

	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> Literally ROTATES the Object.
	function GUIanim.Rotate(Object:GuiObject, Time:number, EasingStyle:Enum, RotateAmount)
		local twninfo = TweenInfo.new(Time, EasingStyle, Enum.EasingDirection.InOut)

		local Goal = {Rotation = RotateAmount}

		local Action = TweenService:Create(Object, twninfo, Goal)
		Action:Play()
	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> Literally blurs the screen.
--<strong>NOTICE:</strong> Ensure that a Blur object is inside Lighting!
	function GUIanim.Blur(Time:number, Size:number)
		

		local twninfo = TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
		local objecttws = TweenService:Create(blurObj, twninfo, {Size = Size}):Play()
		
	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> Literally changes your FOV.
	function GUIanim.FOV(Time:number, FOV:number)

		local twninfo = TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
		local IncreaseFOV = TweenService:Create(Camera, twninfo, {FieldOfView = FOV}):Play()

	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> Literally makes the object pop in and then shrink out, used in the countdown.
--<strong>Time:</strong> Recommended (0.3)
	function GUIanim.Pop(Object:GuiObject, Time:number)
		
	
		--vChecks if the Object has a UIScale object, you can remove this check if you don't need it!
		local scalefound = false

		for _, child in Object:GetChildren() do

			if child:IsA("UIScale") then
				scalefound = true
				child.Scale = 0
				break

			end

		end
			if not scalefound then
				local scaleobj = Instance.new("UIScale")
				scaleobj.Scale = 0
				scaleobj.Parent = Object
			end
		--^
		
		local Shrink = {Scale = 0}
		local Expand = {Scale = 1}
		local twninfo = TweenInfo.new(Time, Enum.EasingStyle.Back, Enum.EasingDirection.InOut)
		local Shrinkts = TweenService:Create(Object.UIScale, twninfo, Shrink)
		local Expandts = TweenService:Create(Object.UIScale, twninfo, Expand)
		
		Expandts:Play()
		Expandts.Completed:Connect(function()
			Shrinkts:Play()
		end)
		
	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> Literally typewrites text.
--<strong>Timing:</strong> Recommended (.05), Time it takes to type each letter.
	function GUIanim.TypeWriter(Object:GuiObject, Timing:number, Writing:string)
		local message = Writing
		local TextLabel = Object

		for i = 1, #message do
			TextLabel.Text = string.sub(message, 1, i)
			wait(Timing)
		end

	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> Literally a countdown
--<strong>CountdownTimer:</strong> How long to Count Down from
	function GUIanim.CountDown(Object:GuiObject, CountdownTimer:number)
		 
	
		
		
		local function Countdown()
			
			Object.Text = CountdownTimer
			GUIanim.Pop(Object, .5)
			wait(.6)
			CountdownTimer = CountdownTimer - 1
			
			if CountdownTimer < 0 then
				Object.Text = " "
			else
				wait(1) -- Wait for 1 second
				Countdown() -- Call the function again to continue the countdown
			end
			
		end
		
		
		Countdown()
		
		
		
	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> Used for kill feeds.
--<strong>ObjectList:</strong> The container that has UIListLayout inside.
--<strong>Frame:</strong> The Frame you want to be inside the list.
	function GUIanim.FadeAwayList(ObjectList:GuiObject, Frame:GuiObject, TimeToFade:number)
		local twninfo = TweenInfo.new(.9, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, TimeToFade)
		
		local CloneFrm = Frame:Clone()
		CloneFrm.Parent = ObjectList
		local Goal = nil

		if Frame:IsA("Frame") then
			Goal = {BackgroundTransparency = 1}
			
		elseif Frame:IsA("TextLabel") or Frame:IsA("TextButton") then
			Goal = {BackgroundTransparency = 1,
				TextTransparency = 1
			}
		elseif Frame:IsA("ImageLabel") or Frame:IsA("ImageButton") then
			Goal = {BackgroundTransparency = 1,
				ImageTransparency = 1
			}
		end
		
		local Action = TweenService:Create(CloneFrm, twninfo, Goal)
		Action:Play()
		
		Action.Completed:Connect(function()
			CloneFrm:Destroy()
		end)
	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>Info:</strong> Makes a popup notification with the GUI object picked.
--<strong>*ATTENTION*</strong> Set your frame at your desired initial location first!!! (Outside screen)
--<strong>Frame:</strong> The Frame you want to be notifying the player with.
--<strong>TimeInMiddle:</strong> How long you want the notification to be stationary after popping in.
--<strong>TimeInMotion:</strong> How fast you want the notification to pop up.
	function GUIanim.PopUpNotification(Frame:GuiObject, TimeInMiddle:number, TimeInMotion:number, SizeInMiddle:UDim2)
		
		local initSize = Frame.Size
		local initPos = Frame.Position
		local twninfo = TweenInfo.new(TimeInMotion, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
		local Goal1 = {Position = UDim2.new(0.5,0,0.5,0),
			Size = SizeInMiddle
		}
		local Goal2 = {Position = initPos,
			Size = initSize
		}
		
		local Action = TweenService:Create(Frame, twninfo, Goal1)
		Action:Play()
		
		Action.Completed:Connect(function()
			task.wait(TimeInMiddle)
			local Action2 = TweenService:Create(Frame, twninfo, Goal2)
			Action2:Play()
		end)
		
	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	--<strong>Info:</strong> Makes a countdown converted to minutes. (1 minute = timeInMinutes = 1)
	function GUIanim.CountdownInMinutes(displayFrame:GuiObject, timeInMinutes:number)
		
		local function toMS(s)
			return string.format("%02i:%02i", s/60%60, s%60)
		end

		local countdownLabel = displayFrame
		
		local seconds = timeInMinutes * 60
		
		for i = seconds, 0, -1 do
			countdownLabel.Text = toMS(i)
			task.wait(1)
		end
		
	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
------------------------LOOP functions
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	function GUIanim.SoftResize(Object:GuiObject, Time:number, Size:number, Toggle:boolean) 
		
		--v Checks if the Object has a UIScale object, you can remove this check if you don't need it!
		local scalefound = false

		for _, child in Object:GetChildren() do

			if child:IsA("UIScale") then
				scalefound = true
				break

			end

		end
		if not scalefound then
			local scaleobj = Instance.new("UIScale")
			scaleobj.Parent = Object
		end
		--^
		
		local twninfo = TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true)
		
		if Toggle == false then
			if RSZ then
				RSZ:Cancel()
				RSZ = nil
			end
			return
		end
		
		local goal = {Scale = Size}
		local goal2 = {Scale = 1}
		RSZ = TweenService:Create(Object.UIScale, twninfo, goal)
		
		RSZ:Play()
	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	function GUIanim.Spin(Object:GuiObject, Time:number, Toggle:boolean)
		

		local tweeninfo = TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1)
		local goal = {Rotation = 360} -- Rotate a full circle for continuous spin
		
		
		if Toggle == false then
			if spinTween then
				spinTween:Cancel()
				spinTween = nil
			end
			return
		end
		
		spinTween = TweenService:Create(Object, tweeninfo, goal)

		-- Reset the rotation to 0 before starting the tween
		Object.Rotation = 0

		spinTween:Play()
		
	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	--<strong>RotateAmount:</strong> Degrees off current rotation to rock back and fourth (EX: 10, would rock 10 degrees Left and Right)
	function GUIanim.Rock(Object:GuiObject, Time:number, EasingStyle:Enum, RotateAmount:number)
		
		local twninfo = TweenInfo.new(Time, EasingStyle, Enum.EasingDirection.InOut)
		local Goal = {Rotation = Object.Rotation + RotateAmount}
		local Goal2 = {Rotation = Object.Rotation - RotateAmount}
		
		
		local RockLft = TweenService:Create(Object, twninfo, Goal)
		local RockRgt = TweenService:Create(Object, twninfo, Goal2)

		
	end

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--<strong>*WARNING*</strong> I suggest not having this function play for two things at once, I know it won't give you desired results.
	function GUIanim.LoadingText(TextLbl:TextLabel, Contents:string)

		local count = 0
		if TprtrLoop then return end
		TprtrLoop = true


		while TprtrLoop do
			TextLbl.Text = Contents .. string.rep(".",count)
			count = (count + 1)
			if count > 3 then
				count = 0
			end
			wait(.5)
		end

	end
	--||||||||||||||||||||||||||
	function GUIanim.LoadingTextSTOP()

		TprtrLoop = false

	end

------------------------LOOP functions end

	
	
return GUIanim






