B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.801
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	Private bmppointer As Bitmap
	Dim reply As String
	Dim test As Boolean
End Sub

Sub Globals

	Private cvsGraph As Canvas	', cvsGraph2
	Private pnl1 As Panel		', pnl2
	Private img1 As ImageView
	Private rect1 As Rect
	Private Button1 As Button
	Private Button2 As Button
	Private text1 As EditText
	Private Label1 As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	If FirstTime Then
		bmppointer.Initialize(File.DirAssets,"point2.png")
	End If

	Activity.LoadLayout("layout1")
	
	cvsGraph.Initialize(pnl1)	' initialize the Canvas for the panel
	pnl1.Left=50%x-200
	img1.Left=50%x-200
	rect1.Initialize(65, 65, 320dip, 320dip)
	cvsGraph.DrawBitmap(bmppointer, Null, rect1)
	pnl1.Invalidate

End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Public Sub UpdateState
	Button1.Enabled = Starter.Manager.ConnectionState
	Button2.Enabled = Starter.Manager.ConnectionState
End Sub

	
Sub Button2_Click
	Dim i=1 As Int
	
	test=False
	Do While i=1
		Starter.Manager.SendMessage("010C" & Chr(13) & Chr(10))
		reply=""
		Sleep(500)
		If test Then Exit
	Loop
End Sub



Sub Button1_Click
	test=True
	Starter.Manager.SendMessage("ATZ" & Chr(13) & Chr(10))
	reply=""
End Sub

Public Sub NewMessage (msg As String)
	reply = reply & msg
	If reply.Contains(">") Then
		text1.Text = reply
		If reply.Length > 18 Then rpm
	End If

End Sub

Sub rpm
	Dim a1=0,a2=0, b1=0, b2=0, a, b As Int
	Dim angle As Float
	Dim rpmD As String
	
	a1=Asc(reply.CharAt(13))
	If a1>64 Then
		a1=a1-55
	Else
		a1=a1-48
	End If
	a2=Asc(reply.CharAt(14))
	If a2>64 Then
		a2=a2-55
	Else
		a2=a2-48
	End If
	a = a1*16+a2
	
	b1=Asc(reply.CharAt(16))
	If b1>64 Then
		b1=b1-55
	Else
		b1=b1-48
	End If
	b2=Asc(reply.CharAt(17))
	If b2>64 Then
		b2=b2-55
	Else
		b2=b2-48
	End If
	b = b1*16+b2
	angle = ((a * 256 + b) / 100) - 120
	rpmD = (a * 256 + b) / 4
	'text1.Text = angle
	Label1.Text=rpmD
	reply = ""
	
	cvsGraph.DrawRect(rect1, Colors.Transparent, True, 3dip)		'refresh screen
	cvsGraph.DrawBitmapRotated(bmppointer, Null, rect1, angle)
	pnl1.Invalidate
	
End Sub
