;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Edit bellow lines.
WINTITLE = 作成.* - Thunderbird
TEMPFILE = C:\Temp\ExtEditAKH.eml
EDITOR = C:\opt\emacs-29.3\bin\emacsclient.exe -c -a "" %TEMPFILE%
EDITORVIS = Hide ; Max/Min/Hide
CLICKX = 50
CLICKY = 500

;;;;; copy text to temp file.
SetTitleMatchMode, RegEx
IfWinNotExist %WINTITLE%
{
  MsgBox Not Found Target Window.
  Return
}
WinActivate 
Click %CLICKX%, %CLICKY%, 1
Send ^a
Send ^c
;MsgBox %Clipboard%

;;;;; write clipboard to temp file
FileDelete %TEMPFILE%
FileAppend %Clipboard%, %TEMPFILE%

;;;;; invoke external editor
RunWait %EDITOR%, , %EDITORVIS%
FileRead Clipboard, *t %TEMPFILE%

;;;;; copy from file and paste to thunderbird
IfWinNotExist %WINTITLE%
{
  MsgBox Not Found Target Window.
  Return
}
WinActivate 
Click %CLICKX%, %CLICKY%, 1
Send ^a
Send ^v
Send ^{Home}

;;;;; delete temp file
; FileDelete %TEMPFILE%

Return
