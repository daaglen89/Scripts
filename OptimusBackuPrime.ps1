#########################################################
##			Laget av Daniel A Andersen (Steria AS)		#
##														#
##			<Script som tar maskinnavn og henter de 50 	#
##			siste linjene i dsmerror fila>				#				     
#########################################################

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")  

############################################## Start functions

function Search_dsmerror {
$Computername=$InputBox.text;
$PS_session = Get-Content "\\$Computername\C$\Program Files\Tivoli\TSM\baclient\dsmerror.log" | Select-Object -Last 50
$outputBox.text = $PS_session | Out-GridView
                   } 
				   
function Search_dsmsched {
$Computername2 = $InputBox.text;
$PS_session2 = Get-Content "\\$Computername2\C$\Program Files\Tivoli\TSM\baclient\dsmsched.log" | Select-Object -Last 250
$outputBox.text = $PS_session2 | Out-GridView

				  }
				  
				  
function CreateNewForm {
$Form.Close()
$Form.Dispose()
Remove-Variable $Computername
CreateForm
}

function CreateForm {
$Form = New-Object System.Windows.Forms.Form    
$Form.Size = New-Object System.Drawing.Size(338,350)  
############################################## end functions

############################################## Start text fields

$InputBox = New-Object System.Windows.Forms.TextBox 
$InputBox.Location = New-Object System.Drawing.Size(32,45) 
$InputBox.Size = New-Object System.Drawing.Size(150,20) 
$Form.Controls.Add($InputBox) 

$Form.Text = "Daglig Backupsjekk"

############################################## end text fields

############################################## Start buttons

$Button = New-Object System.Windows.Forms.Button 
$Button.Location = New-Object System.Drawing.Size(183,45) 
$Button.Size = New-Object System.Drawing.Size(86,34) 
$Button.Text = "Søk dsmerror" 
$Button.Add_Click({Search_dsmerror}) 
$Form.Controls.Add($Button) 

$Button1 = New-Object System.Windows.Forms.Button
$Button1.Location = New-Object System.Drawing.Size(183,85)
$Button1.Size = New-Object System.Drawing.Size(86, 33)
$Button1.Text = "Søk dsmsched"
$Button1.Add_Click({Search_dsmsched})

$Button2 = New-Object System.Windows.Forms.Button
$Button2.Location = New-Object System.Drawing.Size(183,246)
$Button2.Size = New-Object System.Drawing.Size(86,33)
$Button2.Text = "Reload Form"
$Button2.Add_Click({CreateNewForm})

$label = New-Object system.Windows.Forms.Label
$label.text = "Skriv inn maskinnavn!"
$label.size = New-Object system.drawing.size(100,23)
$label.location = New-Object system.Drawing.Size(32,19)


$Form.Controls.Add($Button1)
$Form.controls.add($Button2)
$Form.controls.add($label)
############################################## end buttons

$Form.Add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()
}
CreateForm