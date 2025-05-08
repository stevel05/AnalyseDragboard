B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.2
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	Private UserOpts As Map
	Private mFilePath As String
	Private mFileName As String
End Sub

Public Sub LoadUserOptions(FilePath As String, FileName As String)
	mFilePath = FilePath
	mFileName = FileName
	If File.Exists(FilePath,FileName) Then
		Dim RAF As RandomAccessFile
		RAF.Initialize(mFilePath,mFileName,True)
		UserOpts = RAF.ReadB4XObject(0)
		RAF.Close
	Else
		UserOpts.Initialize
	End If
	
End Sub

Public Sub SaveUserOptions
	Dim RAF As RandomAccessFile
	RAF.Initialize(mFilePath,mFileName,False)
	RAF.WriteB4XObject(UserOpts,0)
	RAF.Close
End Sub


Public Sub Put(Key As String, OptData As Object)
	UserOpts.Put(Key,OptData)
End Sub
Public Sub Get(Key As String) As Object
	Return UserOpts.Get(Key)
End Sub

Public Sub Exists(Key As String) As Boolean
	Return UserOpts.ContainsKey(Key)
End Sub

Public Sub GetDefault(Key As String, Default As Object) As Object
	Return UserOpts.GetDefault(Key,Default)
End Sub

Public Sub SaveFormMetrics(F As Form, Delim As String)
	If F.Title = "Form" Then
		Log(F.Title & " Cannot set for metrics for a form with an unmodified title")
		Return
	End If
	Dim FormName As String = F.Title
	If Delim <> "" And FormName.Contains(Delim) Then
		FormName = FormName.SubString2(0,FormName.IndexOf(Delim)).Trim
	End If
	UserOpts.Put("FormPos" & FormName & "Left",F.WindowLeft)
	UserOpts.Put("FormPos" & FormName & "Top",F.WindowTop)
	UserOpts.Put("FormPos" & FormName & "Width",F.WindowWidth)
	UserOpts.Put("FormPos" & FormName & "Height",F.WindowHeight)
End Sub

Public Sub SetFormMetrics(F As Form, Delim As String)
	Dim FormName As String = F.Title
	If Delim <> "" And FormName.Contains(Delim) Then
		FormName = FormName.SubString2(0,FormName.IndexOf(Delim)).Trim
	End If
	If UserOpts.ContainsKey("FormPos" & FormName & "Left") Then
		F.WindowLeft = UserOpts.Get("FormPos" & FormName & "Left")
		F.WindowTop = UserOpts.Get("FormPos" & FormName & "Top")
		F.WindowWidth = UserOpts.Get("FormPos" & FormName & "Width")
		F.WindowHeight = UserOpts.Get("FormPos" & FormName & "Height")
	End If
End Sub

Public Sub GetFilePath(Key As String) As String
	Dim FP As String =  GetDefault(Key,GetSystemProperty("user.home","C:\"))
	If File.IsDirectory(FP,"") = False Then FP = GetSystemProperty("user.home","C:\")
	Return FP
End Sub

Public Sub GetFilePathDefault(Key As String, Default As String) As String
	Dim FP As String =  GetDefault(Key,Default)
	If File.IsDirectory(FP,"") = False Then FP = GetSystemProperty("user.home","C:\")
	Return FP
End Sub

Public Sub DoubleArrayToList(Arr() As Double) As List
	Dim L As List
	L.Initialize
	For Each D As Double In Arr
		L.Add(D)
	Next
	Return L
End Sub

Public Sub ListToDoubleArray(L As List) As Double()
	Dim Arr(L.Size) As Double
	For i = 0 To L.Size - 1
		Dim D As Double = L.Get(i)
		Arr(i) = D
	Next
	Return Arr
End Sub