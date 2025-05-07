B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.2
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub

Public Sub GetStringCharNames(Str As String) As String
	Return GetStringCharNames2(Str,"")
End Sub

Public Sub GetStringCharNames2(Str As String, Header As String) As String
	Dim SB As StringBuilder
	SB.Initialize
	SB.Append(" ")
	SB.Append(CRLF)
	SB.Append("***** GetStringCharNames *****")
	SB.Append(CRLF)
	If Header <> "" Then
		SB.Append($"*** ${Header} ***"$)
		SB.Append(CRLF)
	End If
	SB.Append("___________________________")
	SB.Append(CRLF)
	SB.Append(Str & " Length : " & Str.Length)
	SB.Append(CRLF)
	SB.Append("___________________________")
	SB.Append(CRLF)
	For i = 0 To Str.Length - 1
		SB.Append(i & " : " & Str.CharAt(i) & " : " & Asc(Str.CharAt(i)) & " : " & GetCharName(Str.CharAt(i)))
		SB.Append(CRLF)
	Next
	SB.Append("___________________________")
	SB.Append(CRLF)
	SB.Append("***** Done *****")
	SB.Append(CRLF)
	SB.Append(" ")
	SB.Append(CRLF)
	Return SB.ToString
End Sub

Public Sub GetCharName(C As Char) As String
	Dim Character As JavaObject
	Character.InitializeStatic("java.lang.Character")
	Dim Name As Object = Character.RunMethod("getName",Array(Asc(C)))
	If Name = Null Then
		Return "Undefined"
	End If
	Return Name
End Sub