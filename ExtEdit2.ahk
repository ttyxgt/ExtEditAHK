#Requires AutoHotkey v2.0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WINTITLE := "作成.* - Thunderbird"
TEMPFILE := "C:\Temp\ExtEditAHK2.eml"
EDITOR := "C:\opt\emacs-29.3\bin\emacsclient.exe -c -a `"`" " . TEMPFILE
EDITORVIS := "Hide"  ;Max/Min/HideK
CLICKX := 50
CLICKY := 500
;MsgBox(EDITOR)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; forcus target window
SetTitleMatchMode("RegEx")
if !WinExist(WINTITLE){
    MsgBox("Not Found Target Window.")
    ExitApp(1)
}
WinActivate(WINTITLE)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; copy text 
Click(CLICKX, CLICKY)
A_Clipboard := ""
Send("^a")
Send("^c")
if !ClipWait(2) {
    MsgBox "Failed to copy text."
    ExitApp(1)
}
;MsgBox(A_Clipboard)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; write text to temp file
try{
    if FileExist(TEMPFILE){
        FileDelete(TEMPFILE)
    }
    FileAppend(A_Clipboard, TEMPFILE)
} catch as e {
    MsgBox("Failed to write text to temp file." . e.message)
    ExitApp(1)
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; invoke external editor and wait
RunWait(EDITOR, , EDITORVIS)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; read text from temp file
A_Clipboard := ""
try{
    A_Clipboard := FileRead(TEMPFILE)
} catch as e {
    MsgBox("Failed to read text from temp file." . e.message)
    ExitApp(1)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; paste text to target window
if !WinExist(WINTITLE){
    MsgBox("Not Found Target Window.")
    ExitApp(1)
}
WinActivate(WINTITLE)
Click(CLICKX, CLICKY)
Send("^a")
Send("^v")
Send("^{Home}")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; clean up
A_Clipboard := ""
;if FileExist(TEMPFILE){
;    FileDelete(TEMPFILE)
;}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; exit
ExitApp(0)
