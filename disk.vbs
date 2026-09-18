Option Explicit

Dim objFSO, objShell, objDrives, objDrive
Dim driveLetter, newID
Randomize ' Initialize random number generator
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("WScript.Shell")
Set objDrives = objFSO.Drives

For Each objDrive In objDrives
    If objDrive.DriveType = 2 Then ' Only fixed drives
        driveLetter = objDrive.DriveLetter & ":"
        newID = GenerateRandomID()
        objShell.Run "cmd /c volumeid.exe " & driveLetter & " " & newID, 0, True
    End If
Next

Function GenerateRandomID()
    Dim randomPart1, randomPart2
    randomPart1 = Right("0000" & Hex(Int((65535 - 1 + 1) * Rnd)), 4)
    randomPart2 = Right("0000" & Hex(Int((65535 - 1 + 1) * Rnd)), 4)
    GenerateRandomID = randomPart1 & "-" & randomPart2
End Function
