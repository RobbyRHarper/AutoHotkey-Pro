;-------------------------------------------------------------------------------------------------;
;AUTOHOTKEY
;-------------------------------------------------------------------------------------------------;

;Name: AutoHotkey
;Kind: AHK Script
;Purpose: Provide standard automations accessible by the keyboard.
;Author: Robby Harper
;Date: 2021-10-31

;-------------------------------------------------------------------------------------------------;
;READ ME
;-------------------------------------------------------------------------------------------------;

;Refer to https://www.autohotkey.com/docs/AutoHotkey.htm for AutoHotkey documentation.

;This script can be renamed as "AutoHotkey.ahk" and placed into Windows Startup folder:
;	%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

;Windows can run multiple .ahk file simultaneously, each with its own tray icon.
;Files with the .ahk extension are associated with AutoHotkey and can run by double-clicking.
;AutoHotkey can run .ahk files located in any folder.

;-------------------------------------------------------------------------------------------------;
;DEPENDENCIES
;-------------------------------------------------------------------------------------------------;

;This script requires the following libraries, plugins, programs, and references:
;	Executable Program: 'NirSoft NirCmd' - "nircmd.exe"
;		Download Link: https://www.nirsoft.net/utils/nircmd-x64.zip
;		File Path: C:\nircmd.exe

;-------------------------------------------------------------------------------------------------;
;TABLE OF CONTENTS
;-------------------------------------------------------------------------------------------------;

;-------------------------------------------------------------------------------------------------;
;OPTIONS
;-------------------------------------------------------------------------------------------------;
;DECLARATIONS
;-------------------------------------------------------------------------------------------------;
;INSTANCES
;-------------------------------------------------------------------------------------------------;
;HOTKEYS
;-------------------------------------------------------------------------------------------------;
;HOTKEYS - Remapped Keys
;-------------------------------------------------------------------------------------------------;
;HOTKEYS - ALT+CLICK - GUI Commands
;-------------------------------------------------------------------------------------------------;
;HOTKEYS - ALT+SHIFT - Simple Commands
;-------------------------------------------------------------------------------------------------;
;HOTKEYS - CTRL+SHIFT - Process Commands
;-------------------------------------------------------------------------------------------------;
;HOTKEYS - CTRL+ALT+SHIFT - Text Entry
;-------------------------------------------------------------------------------------------------;
;HOTKEYS - WIN+CTRL - Operating System
;-------------------------------------------------------------------------------------------------;
;HOTKEYS - WIN+ALT - Applications
;-------------------------------------------------------------------------------------------------;
;HOTKEYS - WIN+CTRL+SHIFT - Desktop Applications
;-------------------------------------------------------------------------------------------------;
;HOTKEYS - WIN+ALT+SHIFT - Modern Applications
;-------------------------------------------------------------------------------------------------;
;HOTKEYS - WIN+CTRL+ALT - Algorithms
;-------------------------------------------------------------------------------------------------;
;HOTSTRINGS
;-------------------------------------------------------------------------------------------------;
;SUBROUTINES
;-------------------------------------------------------------------------------------------------;
;FUNCTIONS
;-------------------------------------------------------------------------------------------------;
;OPERATORS
;-------------------------------------------------------------------------------------------------;
;LABELS
;-------------------------------------------------------------------------------------------------;
;APPENDIX
;-------------------------------------------------------------------------------------------------;

;-------------------------------------------------------------------------------------------------;
;OPTIONS
;-------------------------------------------------------------------------------------------------;

;-------------------------------------------------------------------------------------------------;
;DECLARATIONS
;-------------------------------------------------------------------------------------------------;

;Declare Sleep Delay values.
Global TEN_MS := 10
Global TENTH_S := 100
Global HALF_S := 500
Global ONE_S := 1000
Global FIVE_S := 5000

;-------------------------------------------------------------------------------------------------;
;INSTANCES
;-------------------------------------------------------------------------------------------------;

;-------------------------------------------------------------------------------------------------;
;HOTKEYS
;-------------------------------------------------------------------------------------------------;

;-------------------------------------------------------------------------------------------------;
;HOTKEYS - Remapped Keys
;-------------------------------------------------------------------------------------------------;

;Reassign Ctrl+Insert to Paste.
^Insert::^v

;;Reassign ` to Backspace.
;$`::Backspace

;Reassign Ctrl+` to Pause (^CtrlBreak).
$^`::^CtrlBreak

;Reassign Shift+` to ~ Key.
$+`::Send {~}

;Reassign Insert to Right-Click/Context Menu.
Insert::
	SendEvent {Blind}{RButton down}
	KeyWait AppsKey
	SendEvent {Blind}{RButton up}
Return

;-------------------------------------------------------------------------------------------------;
;HOTKEYS - ALT+CLICK - GUI Commands
;-------------------------------------------------------------------------------------------------;

;Reassign Left Alt Button to Set Window and Timer Behavior.
Alt & LButton::
	CoordMode, Mouse
	MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
	WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
	WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin%
	If EWD_WinState = 0
	{
		SetTimer, EWD_WatchMouse, 10
		Return
	}
EWD_WatchMouse:
	GetKeyState, EWD_LButtonState, LButton, P
	If EWD_LButtonState = U
	{
		SetTimer, EWD_WatchMouse, off
		Return
	}
	GetKeyState, EWD_EscapeState, Escape, P
	If EWD_EscapeState = D
	{
		SetTimer, EWD_WatchMouse, off
		WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
		Return
	}
	CoordMode, Mouse
	MouseGetPos, EWD_MouseX, EWD_MouseY
	WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
	SetWinDelay, -1
	WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
	EWD_MouseStartX := EWD_MouseX
	EWD_MouseStartY := EWD_MouseY
Return

;-------------------------------------------------------------------------------------------------;
;HOTKEYS - ALT+SHIFT - Simple Commands
;-------------------------------------------------------------------------------------------------;

;;Reassign Alt+Shift+a to Go Previous Playlist Item.
;!+a::
;	Send {Media_Prev}
;	Sleep, TEN_MS
;	Send {Alt Up}
;	Send {Shift Up}
;	Send {a Up}
;Return

;;Reassign Alt+Shift+d to Go Next Playlist Item.
;!+d::
;	Send {Media_Next}
;	Sleep, TEN_MS
;	Send {Alt Up}
;	Send {Shift Up}
;	Send {d Up}
;Return

;;Reassign Alt+Shift+s to Play Item in Playing Now.
;!+s::
;	Send {Media_Play_Pause}
;	Sleep, TEN_MS
;	Send {Alt Up}
;	Send {Shift Up}
;	Send {s Up}
;Return

;Reassign Alt+Shift+x to Save Link As.
!+x::
	WinGet, Active_ID, ID, A
	WinGet, Active_Process, ProcessName, ahk_id %Active_ID%
	Switch Active_Process
	{
	Case "CHROME.EXE","EDGE.EXE","FIREFOX.EXE","OPERA.EXE":
		BrowserPageSaveLinkAs()
		;BrowserPageNavigateBack()
	Default:
		Goto, ExitHandler
	}
Return

;Reassign Alt+Shift+, to Decrease Volume.
!+,::
	Send {Volume_Down}
	Sleep, TEN_MS
	Send {Alt Up}
	Send {Shift Up}
	Send {, Up}
Return

;Reassign Alt+Shift+. to Increase Volume.
!+.::
	Send {Volume_Up}
	Sleep, TEN_MS
	Send {Alt Up}
	Send {Shift Up}
	Send {. Up}
Return

;Reassign Alt+Shift+/ to Mute Volume.
!+/::
	Send {Volume_Mute}
	Sleep, TEN_MS
	Send {Alt Up}
	Send {Shift Up}
	Send {? Up}
Return

;-------------------------------------------------------------------------------------------------;
;HOTKEYS - CTRL+SHIFT - Process Commands
;-------------------------------------------------------------------------------------------------;

;Reassign Ctrl+Shift+` to Send Keys in a Controlled Loop for a Given Active Process.
$^+`::
	WinGet, Active_ID, ID, A
	WinGet, Active_Process, ProcessName, ahk_id %Active_ID%
	Switch Active_Process
	{
	Case "CHROME.EXE","EDGE.EXE","FIREFOX.EXE","OPERA.EXE":
		;Confluence Page Find Replace String:
		InputBox, LoopCount1, AutoHotkey Alert, Enter Number of Loop Iterations:,,,,,,,,1
		If ErrorLevel
		{
			Goto, ErrorHandler_Cancel
		}
		InputBox, FindString, AutoHotkey Alert, Enter Find String:,,,,,,,,Find String
		If ErrorLevel
		{
			Goto, ErrorHandler_Cancel
		}
		InputBox, ReplaceString, AutoHotkey Alert, Enter Replace String:,,,,,,,,Replace String
		If ErrorLevel
		{
			Goto, ErrorHandler_Cancel
		}
		Sleep, ONE_S
		Loop, %LoopCount1%
		{
			ConfluencePageFindReplaceString(FindString,ReplaceString)
		}
;		;Browser Page Find String:
;		InputBox, LoopCount1, AutoHotkey Alert, Enter Number of Loop Iterations:,,,,,,,,1
;		If ErrorLevel
;		{
;			Goto, ErrorHandler_Cancel
;		}
;		InputBox, FindString, AutoHotkey Alert, Enter Find String:,,,,,,,,Find String
;		If ErrorLevel
;		{
;			Goto, ErrorHandler_Cancel
;		}
;		Sleep, ONE_S
;		Loop, %LoopCount1%
;		{
;			BrowserPageFindString(FindString)
;		}
	Case "OUTLOOK.EXE":
		InputBox, LoopCount1, AutoHotkey Alert, Enter Number of Loop Iterations:,,,,,,,,1
		If ErrorLevel
		{
			Goto, ErrorHandler_Cancel
		}
		InputBox, ItemsName, AutoHotkey Alert, Enter Items Name:,,,,,,,,Items Name
		If ErrorLevel
		{
			Goto, ErrorHandler_Cancel
		}
		Loop, %LoopCount1%
		{
			LineBackpaceReplace(ItemsName)
		}
	Default:
		Goto, ExitHandler
	}
Return

;-------------------------------------------------------------------------------------------------;
;HOTKEYS - CTRL+ALT+SHIFT - Text Entry
;-------------------------------------------------------------------------------------------------;

;Text Entry Legend:
;	Systems:	SET1	SET2	SET3	SET4 	SET5
;	Param 1:	Q		W		E		R		T
;	Param 2:	A		S		D		F		G
;	Param 3:	U		I		O		P		[
;	Param 4:	J		K		L		;		'

;Reassign Ctrl+Alt+Shift+q to Send SET1 System Parameter 1.
^!+q::
	Send Entry1
	Send {Tab}
	Sleep, ONE_S
	Send {Enter}
Return

;Reassign Ctrl+Alt+Shift+w to Send SET2 System Parameter 1.
^!+w::
	Send Entry2
	Send {Tab}
	Sleep, ONE_S
	Send {Enter}
Return

;Reassign Ctrl+Alt+Shift+e to Send SET3 System Parameter 1.
^!+e::
	Send Entry3
	Send {Tab}
	Sleep, ONE_S
	Send {Enter}
Return

;Reassign Ctrl+Alt+Shift+r to Send SET4 System Parameter 1.
^!+r::
	Send Entry4
	Send {Tab}
	Sleep, ONE_S
	Send {Enter}
Return

;Reassign Ctrl+Alt+Shift+t to Send SET5 System Parameter 1.
^!+t::
	Send Entry5
	Send {Tab}
	Sleep, ONE_S
	Send {Enter}
Return

;Reassign Ctrl+Alt+Shift+a to Send SET1 System Parameter 2.
^!+a::
	Send Entry1
Return

;Reassign Ctrl+Alt+Shift+s to Send SET2 System Parameter 2.
^!+s::
	Send Entry2
Return

;Reassign Ctrl+Alt+Shift+d to Send SET3 System Parameter 2.
^!+d::
	Send Entry3
Return

;Reassign Ctrl+Alt+Shift+f to Send SET4 System Parameter 2.
^!+f::
	Send Entry4
Return

;Reassign Ctrl+Alt+Shift+g to Send SET5 System Parameter 2.
^!+g::
	Send Entry5
Return

;Reassign Ctrl+Alt+Shift+u to Send SET1 System Parameter 3.
^!+u::
	Send Entry1
Return

;Reassign Ctrl+Alt+Shift+i to Send SET2 System Parameter 3.
^!+i::
	Send Entry2
Return

;Reassign Ctrl+Alt+Shift+o to Send SET3 System Parameter 3.
^!+o::
	Send Entry3
Return

;Reassign Ctrl+Alt+Shift+p to Send SET4 System Parameter 3.
^!+p::
	Send Entry4
Return

;Reassign Ctrl+Alt+Shift+[ to Send SET5 System Parameter 3.
^!+[::
	Send Entry5
Return

;Reassign Ctrl+Alt+Shift+j to Send SET1 System Parameter 4.
^!+j::
	Send Entry1
Return

;Reassign Ctrl+Alt+Shift+k to Send SET2 System Parameter 4.
^!+k::
	Send Entry2
Return

;Reassign Ctrl+Alt+Shift+l to Send SET3 System Parameter 4.
^!+l::
	Send Entry3
Return

;Reassign Ctrl+Alt+Shift+;to Send SET4 System Parameter 4.
^!+`;::
	Send Entry4
Return

;Reassign Ctrl+Alt+Shift+' to Send SET5 System Parameter 4.
^!+'::
	Send Entry5
Return

;Reassign Ctrl+Alt+Shift+c to Comment in Varying Applications.
^!+c::
	SetTitleMatchMode, 2
	;If Active Window is MATLAB:
	#IfWinActive ahk_class SunAwtFrame
		Send ^r
	;If Active Window is Notepad++:
	#IfWinActive ahk_class Notepad++
		Send {Home 3}
		Send `;
		Send {Down}
	;If Active Window is Notepad:
	#IfWinActive ahk_class Notepad
		Send {Home 1}
		Send `;
		Send {Down}
	#IfWinActive
Return

;;Reassign Ctrl+Alt+Shift+h to Send the Current Time.
;^!+h::
;	EnvAdd, CurrentDateTime, +0, days
;	FormatTime, CurrentDateTime, %CurrentDateTime%, HH:mm:ss
;	SendInput %CurrentDateTime%
;Return

;;Reassign Ctrl+Alt+Shift+m to Send "N/A" Then {Tab} Key.
;^!+m::
;	Send N/A
;	Sleep, TENTH_S
;	Send {Tab}
;Return

;Reassign Ctrl+Alt+Shift+n to Merge Two Lines in a Text Editor.
^!+n::
	LineTextMerge()
Return

;;Reassign Ctrl+Alt+Shift+y to Send the Current Date.
;^!+y::
;	EnvAdd, CurrentDateTime, +0, days
;	FormatTime, CurrentDateTime, %CurrentDateTime%, dd-MMMM-yyyy
;	SendInput %CurrentDateTime%
;Return

;-------------------------------------------------------------------------------------------------;
;HOTKEYS - WIN+CTRL - Operating System
;-------------------------------------------------------------------------------------------------;

;Reassign Win+Ctrl+Space to Set the Active Window Z Layer to Always On Top.
#^SPACE::
	Winset, Alwaysontop, , A
Return

;Reassign Win+Ctrl+g to Show the Window Settings for the Window Currently Under the Cursor.
#^g::
	ShowWindowSettingsUnderCursor()
Return

;Reassign Win+Ctrl+o to Set the Active Window Transparency to Off.
#^o::
	SetWindowTransparencyOpaque()
Return

;Reassign Win+Ctrl+t to Set the Active Window Transparency to Translucent.
#^t::
	SetWindowTransparencyTranslucent()
Return

;Reassign Win+Ctrl+w to Recursively Set the Active Window Transparency to Decreasing Values.
#^w::
	LoopSetWindowTransparency()
Return

;Reassign Win+Ctrl+End to Command Monitors Off.
#^End::
	Run C:\nircmd.exe cmdwait 1000 monitor off
Return

;;Reassign Win+Ctrl+PgUp to Increase Operating System Volume.
;#^PgUp::
;	Send {Volume_Up}
;Return

;;Reassign Win+Ctrl+PgDn to Decrease Operating System Volume.
;#^PgDn::
;	Send {Volume_Down}
;Return

;;Reassign Win+Ctrl+Numpad0 to Mute Operating System Volume.
;#^Numpad0::
;	Send {Volume_Mute}
;Return

;-------------------------------------------------------------------------------------------------;
;HOTKEYS - WIN+ALT - Applications
;-------------------------------------------------------------------------------------------------;

;Reassign Win+Alt+d to Define Named Ranges as Selected in Microsoft Excel.
#!d::
	WinGet, Active_ID, ID, A
	WinGet, Active_Process, ProcessName, ahk_id %Active_ID%
	Switch Active_Process
	{
	Case "EXCEL.EXE":
		InputBox, LoopCount1, AutoHotkey Alert, Enter Number of Loop Iterations:,,,,,,,,1
		If ErrorLevel
		{
			Goto, ErrorHandler_Cancel
		}
		InputBox, WorksheetScopeIndex, AutoHotkey Alert, Enter Scope OR Worksheet Number:,,,,,,,,Workbook
		If ErrorLevel
		{
			Goto, ErrorHandler_Cancel
		}
		SavedClipboard := ClipboardAll
		Loop, %LoopCount1%
		{
			KeyWait Alt
			Send {Alt Down}
			Sleep, TEN_MS
			Send m
			Sleep, TEN_MS
			Send {Alt Up}
			Sleep, HALF_S
			Send m
			Sleep, HALF_S
			Send d
			Sleep, HALF_S
			Clipboard =
			NameString = ""
			Send ^c{left}
			Sleep, HALF_S
			NameString := clipboard
			If (NameString = "")
			{
				Send {ESC}
				Sleep, HALF_S
				Send {Enter}
			}
			Else
			{
				Send {Tab}
				If WorksheetScopeIndex is digit
				{
					LoopCount2 := ((WorksheetScopeIndex) + 1)
					Loop, %LoopCount2%
					{
						Sleep, TENTH_S
						Send {Down}
					}
				}
				Else If WorksheetScopeIndex is alnum
				{
					Send %WorksheetScopeIndex%
				}
				Else
				{
					Loop, %LoopCount2%
					{
						Sleep, TENTH_S
						Send {Down}
					}
				}
				Sleep, HALF_S
				Send {Tab}
				Sleep, HALF_S
				Send {Enter}
				Sleep, HALF_S
				Send {Enter}
			}
			Clipboard := SavedClipboard
			SavedClipboard =
		}
	Default:
		Goto, ExitHandler
	}
Return

;Reassign Win+Alt+h to Toggle Text to Superscript as Selected in Microsoft Office Applications.
#!h::
	DefaultHotkey := "e"
	SuperHotkey := DefaultHotkey
	WinGet, Active_ID, ID, A
	WinGet, Active_Process, ProcessName, ahk_id %Active_ID%
	Switch Active_Process
	{
	Case "EXCEL.EXE":
		InputBox, LoopCount1, AutoHotkey Alert, Enter Number of Loop Iterations:,,,,,,,,1
		If ErrorLevel
		{
			Goto, ErrorHandler_Cancel
		}
		InputBox, SendCount1, AutoHotkey Alert, Enter char length of base symbol:,,,,,,,,1
		If ErrorLevel
		{
			Goto, ErrorHandler_Cancel
		}
		SuperHotkey := "e"
		Loop, %LoopCount1%
		{
			Send {F2}
			Sleep, HALF_S
			Send {Home}
			Sleep, HALF_S
			Loop, %SendCount1%
			{
				Sleep, TENTH_S
				Send {Right}
			}
			Send {Shift Down}
			Sleep, TEN_MS
			Send {End}
			Sleep, TEN_MS
			Send {Shift Up}
			Sleep, HALF_S
			Send {Ctrl Down}
			Sleep, TEN_MS
			Send {Shift Down}
			Sleep, TEN_MS
			Send f
			Sleep, TEN_MS
			Send {Shift Up}
			Sleep, TEN_MS
			Send {Ctrl Up}
			Sleep, HALF_S
			Send {Alt Down}
			Sleep, TEN_MS
			Send %SuperHotkey%
			Sleep, TEN_MS
			Send {Alt Up}
			Sleep, HALF_S
			Send {Enter}
			Sleep, HALF_S
			Send {Enter}
		}
	Case "WINWORD.EXE":
		SuperHotkey := "p"
		Send {Ctrl Down}
		Sleep, TEN_MS
		Send {Shift Down}
		Sleep, TEN_MS
		Send f
		Sleep, TEN_MS
		Send {Shift Up}
		Sleep, TEN_MS
		Send {Ctrl Up}
		Sleep, HALF_S
		Send {Alt Down}
		Sleep, TEN_MS
		Send %SuperHotkey%
		Sleep, TEN_MS
		Send {Alt Up}
		Sleep, HALF_S
		Send {Enter}
	Default:
		Goto, ExitHandler
	}
Return

;Reassign Win+Alt+i to Export Playlist... in iTunes.
#!i::
	SendEvent {Blind}{RButton down}
	KeyWait AppsKey
	SendEvent {Blind}{RButton up}
	Sleep, HALF_S
	Send e
	Sleep, HALF_S
	Send {Enter}
Return

;;Reassign Win+Alt+i to Import Playlist... in iTunes.
;#!i::
;	Send {Alt Down}
;	Sleep, TEN_MS
;	Send {Alt Up}
;	Sleep, HALF_S
;	Send f
;	Sleep, HALF_S
;	Send b
;	Sleep, HALF_S
;	Send i
;Return

;Reassign Win+Alt+l to Toggle Text to Subscript as Selected in Microsoft Office Applications.
#!l::
	DefaultHotkey := "b"
	SubHotkey := DefaultHotkey
	WinGet, Active_ID, ID, A
	WinGet, Active_Process, ProcessName, ahk_id %Active_ID%
	Switch Active_Process
	{
	Case "EXCEL.EXE":
		InputBox, LoopCount1, AutoHotkey Alert, Enter Number of Loop Iterations:,,,,,,,,1
		If ErrorLevel
		{
			Goto, ErrorHandler_Cancel
		}
		InputBox, SendCount1, AutoHotkey Alert, Enter char length of base symbol:,,,,,,,,1
		If ErrorLevel
		{
			Goto, ErrorHandler_Cancel
		}
		SubHotkey := "b"
		Loop, %LoopCount1%
		{
			Send {F2}
			Sleep, HALF_S
			Send {Home}
			Sleep, HALF_S
			Loop, %SendCount1%
			{
				Sleep, TENTH_S
				Send {Right}
			}
			Send {Shift Down}
			Sleep, TEN_MS
			Send {End}
			Sleep, TEN_MS
			Send {Shift Up}
			Sleep, HALF_S
			Send {Ctrl Down}
			Sleep, TEN_MS
			Send {Shift Down}
			Sleep, TEN_MS
			Send f
			Sleep, TEN_MS
			Send {Shift Up}
			Sleep, TEN_MS
			Send {Ctrl Up}
			Sleep, HALF_S
			Send {Alt Down}
			Sleep, TEN_MS
			Send %SubHotkey%
			Sleep, TEN_MS
			Send {Alt Up}
			Sleep, HALF_S
			Send {Enter}
			Sleep, HALF_S
			Send {Enter}
		}
	Case "WINWORD.EXE":
		SubHotkey := "b"
		Send {Ctrl Down}
		Sleep, TEN_MS
		Send {Shift Down}
		Sleep, TEN_MS
		Send f
		Sleep, TEN_MS
		Send {Shift Up}
		Sleep, TEN_MS
		Send {Ctrl Up}
		Sleep, HALF_S
		Send {Alt Down}
		Sleep, TEN_MS
		Send %SubHotkey%
		Sleep, TEN_MS
		Send {Alt Up}
		Sleep, HALF_S
		Send {Enter}
	Default:
		Goto, ExitHandler
	}
Return

;Reassign Win+Alt+m to Send Key and Arrow Repeatedly.
#!m::
	InputBox, LoopCount1, AutoHotkey Alert, Enter Number of Loop Iterations:,,,,,,,,1
	If ErrorLevel
	{
		Goto, ErrorHandler_Cancel
	}
	Sleep, ONE_S
	Loop, %LoopCount1%
	{
		Send, {a Down}{a Up}
		Sleep, HALF_S
		Send, {Right Down}{Right Up}
		Sleep, HALF_S
	}
Return

;Reassign Win+Alt+Numpad2 to Stop Playing Item in Playing Now.
#!Numpad2::
	Send {Media_Stop}
Return

;Reassign Win+Alt+Numpad4 to Go Previous Playlist Item.
#!Numpad4::
	Send {Media_Prev}
Return

;Reassign Win+Alt+Numpad5 to Play Item in Playing Now.
#!Numpad5::
	Send {Media_Play_Pause}
Return

;Reassign Win+Alt+Numpad6 to Go Next Playlist Item.
#!Numpad6::
	Send {Media_Next}
Return

;-------------------------------------------------------------------------------------------------;
;HOTKEYS - WIN+CTRL+SHIFT - Desktop Applications
;-------------------------------------------------------------------------------------------------;

;Reassign Win+Ctrl+Shift+c to Run Calculator.
#^+c::
	SetTitleMatchMode, 2
	IfWinExist, Calculator
	{
		WinActivate, Calculator
	}
	IfWinNotExist, Calculator
	{
		Run Calc
	}
Return

;;Reassign Win+Ctrl+Shift+f to Run Firefox.
;#^+f::
;	SetTitleMatchMode, 2
;	IfWinExist, - Mozilla Firefox
;	{
;		WinActivate, - Mozilla Firefox
;	}
;	IfWinNotExist, - Mozilla Firefox
;	{
;		Run C:\Program Files\Mozilla Firefox\firefox.exe
;	}
;Return

;;Reassign Win+Ctrl+Shift+g to Run Google Chrome.
;	#^+g::
;	SetTitleMatchMode, 2
;	IfWinExist, - Google Chrome
;	{
;		WinActivate, - Google Chrome
;	}
;	IfWinNotExist, - Google Chrome
;	{
;		Run C:\Program Files\Google\Chrome\Application\chrome.exe
;	}
;Return

;Reassign Win+Ctrl+Shift+n to Run Notepad++ or Notepad.
#^+n::
	SetTitleMatchMode, 2
	IfWinExist, Notepad++
	{
		WinActivate, Notepad++
	}
	IfWinNotExist, Notepad++
	{
		Run Notepad++
	}
Return

;-------------------------------------------------------------------------------------------------;
;HOTKEYS - WIN+ALT+SHIFT - Modern Applications
;-------------------------------------------------------------------------------------------------;

;;Reassign Win+Alt+Shift+o to Run OneNote
;#!+o::
;	SetTitleMatchMode, 2
;	IfWinExist, OneNote
;	{
;		WinActivate, OneNote
;	}
;	IfWinNotExist, OneNote
;	{
;		Run OneNote
;	}
;Return

;-------------------------------------------------------------------------------------------------;
;HOTKEYS - WIN+CTRL+ALT - Algorithms
;-------------------------------------------------------------------------------------------------;

;-------------------------------------------------------------------------------------------------;
;HOTSTRINGS
;-------------------------------------------------------------------------------------------------;

;-------------------------------------------------------------------------------------------------;
;SUBROUTINES
;-------------------------------------------------------------------------------------------------;

;-------------------------------------------------------------------------------------------------;
;FUNCTIONS
;-------------------------------------------------------------------------------------------------;

;Define Function to Display the Window Settings for the Window Currently Under the Cursor.
ShowWindowSettingsUnderCursor()
{
	MouseGetPos,,, MouseWin
	WinGet, Transparent, Transparent, ahk_id %MouseWin%
	WinGet, TransColor, TransColor, ahk_id %MouseWin%
	ToolTip Translucency:`t%Transparent%`nTransColor:`t%TransColor%
}

;Define Function to Set the Active Window Transparency to Opaque.
SetWindowTransparencyOpaque()
{
	WinSet, Transparent, 255, A
	WinSet, Transparent, OFF, A
}

;Define Function to Set the Active Window Transparency to Translucent.
SetWindowTransparencyTranslucent()
{
	DetectHiddenWindows, on
	WinSet, Transparent, 128, A
}

;Define Function to Recursively Set the Active Window Transparency to Decreasing Values.
LoopSetWindowTransparency()
{
	DetectHiddenWindows, on
	WinGet, CurrentTransparency, Transparent, A
	If ! CurrentTransparency
		CurrentTransparency = 255
		NewTransparency := CurrentTransparency - 16
	If NewTransparency > 0
	{
		WinSet, Transparent, %NewTransparency%, A
	}
	Else
	{
		SetWindowTransparencyOpaque()
	}
}

;Define Function to Run Or Activate Or Minimize Application Window.
RunOrActivateOrMinimizeProgram(Program, WorkingDir="", WindowSize="")
{
	SplitPath Program, ExeFile
	Process, Exist, %ExeFile%
	PID = %ErrorLevel%
	If (PID = 0)
	{
		Run, %Program%, %WorkingDir%, %WindowSize%
	}
	Else
	{
		SetTitleMatchMode,2
		DetectHiddenWindows, Off
		IfWinActive, ahk_pid %PID%
		WinMinimize, ahk_pid %PID%
		Else
		IfWinExist, ahk_pid %PID%
		WinActivate, ahk_pid %PID%
		Return
	}
}

;Define Function to Find and Replace Text in Confluence.
ConfluencePageFindReplaceString(FindString,ReplaceString)
{
	Send e
	Sleep, FIVE_S
	KeyWait Ctrl
	Send {Ctrl Down}
	Sleep, TEN_MS
	Send ^{f}
	Sleep, TEN_MS
	Send {Ctrl Up}
	Sleep, HALF_S
	Send %FindString%
	Sleep, ONE_S
	Send {TAB}
	Sleep, HALF_S
	Send %ReplaceString%
	Sleep, ONE_S
	Send {TAB 3}
	Sleep, HALF_S
	Send {SPACE}
	Sleep, HALF_S
	Send +{TAB}
	Sleep, HALF_S
	Send +{TAB}
	Sleep, HALF_S
	Send +{TAB}
	Sleep, HALF_S
	Send +{TAB}
	Sleep, HALF_S
	Send +{TAB}
	Sleep, HALF_S
	Send +{TAB}
	Sleep, HALF_S
	Send +{TAB}
	Sleep, HALF_S
	Send +{TAB}
	Sleep, HALF_S
	Send, {SPACE}
	Sleep, HALF_S
	Send {TAB}
	Sleep, HALF_S
	KeyWait Ctrl
	Send {Ctrl Down}
	Sleep, TEN_MS
	Send ^{s}
	Sleep, TEN_MS
	Send {Ctrl Up}
	Sleep, FIVE_S
	KeyWait Ctrl
	Send {Ctrl Down}
	Sleep, TEN_MS
	Send {PgDn}
	Sleep, TEN_MS
	Send {Ctrl Up}
	Sleep, ONE_S
}

;Define Function to Find Text in Browser.
BrowserPageFindString(FindString)
{
	KeyWait Ctrl
	Send {Ctrl Down}
	Sleep, TEN_MS
	Send ^{f}
	Sleep, TEN_MS
	Send {Ctrl Up}
	Sleep, HALF_S
	Send %FindString%
	Sleep, ONE_S
	Send {Ctrl Down}
	Sleep, TEN_MS
	Send {PgDn}
	Sleep, TEN_MS
	Send {Ctrl Up}
	Sleep, ONE_S
}

;Define Function to Navigate Back in Browser.
BrowserPageNavigateBack()
{
	Send {Backspace}
	Sleep, HALF_S
}

;Define Function to Save Link As in Browser.
BrowserPageSaveLinkAs()
{
	MouseClick, Right
	Sleep, ONE_S
	Send k
	Sleep, FIVE_S
	Send {Alt Down}
	Sleep, TEN_MS
	Send s
	Sleep, TEN_MS
	Send {Alt Up}
	Sleep, ONE_S
}

;Define Function to Backspace and Replace Line of Text.
LineBackpaceReplace(ReplaceString)
{
	KeyWait Ctrl
	Send {Ctrl Down}
	Sleep, TEN_MS
	Send {BackSpace}
	Sleep, TEN_MS
	Send {Ctrl Up}
	Sleep, HALF_S
	Send %ReplaceString%
	Sleep, ONE_S
	Send {Enter}
	Sleep, ONE_S
}

;Define Function to Merge Two Lines in a Text Editor.
LineTextMerge()
{
	Send {Home}
	Sleep, HALF_S
	Send {Home}
	Sleep, HALF_S
	Send {End}
	Sleep, HALF_S
	Send {End}
	Sleep, HALF_S
	Send {Delete}
	Sleep, HALF_S
	Send {Space}
	Sleep, HALF_S
	Send {Home}
}

;-------------------------------------------------------------------------------------------------;
;OPERATORS
;-------------------------------------------------------------------------------------------------;

;-------------------------------------------------------------------------------------------------;
;LABELS
;-------------------------------------------------------------------------------------------------;

ExitHandler:
    Return

ErrorHandler_Cancel:
    MsgBox, CANCEL was pressed.
    Goto, ExitHandler

ErrorHandler_Unspecified:
    MsgBox, Unspecified error.
    Goto, ExitHandler

;-------------------------------------------------------------------------------------------------;
;APPENDIX
;-------------------------------------------------------------------------------------------------;