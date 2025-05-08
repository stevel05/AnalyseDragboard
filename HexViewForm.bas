B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Dim HVForm As Form
	Private HexView1 As HexView
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	HVForm.Initialize("HV",800,600)
	
	HVForm.RootPane.LoadLayout("hv")
	HVForm.Title = "AnalyseDragboard - HexView"
End Sub

Public Sub Show(Data() As Byte)
	HexView1.AddData(Data,True)
	CallSubDelayed(Me,"SetformMetrics")
	HVForm.ShowAndWait
End Sub

Private Sub SetFormMetrics
	UserOptions.SetFormMetrics(HVForm,"")
End Sub

Public Sub HV_CloseRequest (EventData As Event)
	UserOptions.SaveFormMetrics(HVForm,"")
	HexView1.Close
End Sub