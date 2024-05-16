Add-Type -AssemblyName System.Windows.Forms

$ffmpegPath = Join-Path -Path $PSScriptRoot -ChildPath "mp3library\bin\ffmpeg.exe"

function OpenScriptAndCreateGUI ($scriptContent, $title, $mainMenuForm) {
    $scriptBlock = [ScriptBlock]::Create($scriptContent)
    & $scriptBlock
}

function CreateMainMenuForm {
    $formMainMenu = New-Object System.Windows.Forms.Form
    $formMainMenu.Text = "Hauptmenue"
    $formMainMenu.Size = New-Object System.Drawing.Size(400,300)
    $formMainMenu.StartPosition = "CenterScreen"
    $formMainMenu.BackColor = [System.Drawing.Color]::FromArgb(31, 31, 31) 

    $buttonMp3Convert = New-Object System.Windows.Forms.Button
    $buttonMp3Convert.Location = New-Object System.Drawing.Point(50,50)
    $buttonMp3Convert.Size = New-Object System.Drawing.Size(300,30)
    $buttonMp3Convert.Text = "MP3 konvertieren"
    $buttonMp3Convert.ForeColor = [System.Drawing.Color]::White 
    $buttonMp3Convert.BackColor = [System.Drawing.Color]::FromArgb(64, 64, 64)  
    $buttonMp3Convert.Add_Click({ 
        # Öffne das MP3-Konvertierungsskript 
        OpenScriptAndCreateGUI $mp3ScriptContent "MP3-Konvertierung" $formMainMenu
    })

    $buttonCompress = New-Object System.Windows.Forms.Button
    $buttonCompress.Location = New-Object System.Drawing.Point(50,100)
    $buttonCompress.Size = New-Object System.Drawing.Size(300,30)
    $buttonCompress.Text = "Komprimieren"
    $buttonCompress.ForeColor = [System.Drawing.Color]::White  
    $buttonCompress.BackColor = [System.Drawing.Color]::FromArgb(64, 64, 64)  
    $buttonCompress.Add_Click({ 
        # Öffne das Komprimierungsskript 
        OpenScriptAndCreateGUI $compressScriptContent "Komprimierung" $formMainMenu
    })

    $formMainMenu.Controls.Add($buttonMp3Convert)
    $formMainMenu.Controls.Add($buttonCompress)

    $formMainMenu.ShowDialog() | Out-Null
}

# MP3 Script Kontent
$mp3ScriptContent = @'
Add-Type -AssemblyName System.Windows.Forms

# Hinzufügen des Windows-Formulars
$global:chosenFilePath = $null

# Funktion zum Erstellen eines Dateiauswahl-Dialogfelds
function ChooseFile {
    $fileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $fileDialog.Multiselect = $false
    $fileDialog.Filter = "All files (*.*)|*.*"
    $result = $fileDialog.ShowDialog()
    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        return $fileDialog.FileName
    }
    return $null
}

# Funktion zum Aktualisieren des Datei-Labels
function UpdateFileLabel {
    if ($global:chosenFilePath -ne $null) {
        $labelFile.Text = "Gewählte Datei: $global:chosenFilePath"
    } else {
        $labelFile.Text = "Keine Datei ausgewählt"
    }
}

# Funktion zum Aktualisieren der Aktions-Schaltfläche
function UpdateActionButton {
    if ($global:chosenFilePath -ne $null) {
        $buttonAction.Enabled = $true
    } else {
        $buttonAction.Enabled = $false
    }
}

$darkBackColor = [System.Drawing.Color]::FromArgb(64, 64, 64)
$darkForeColor = [System.Drawing.Color]::White
$form = New-Object System.Windows.Forms.Form
$form.Text = "MP3-Konvertierung"
$form.Size = New-Object System.Drawing.Size(400, 300)
$form.StartPosition = "CenterScreen"
$form.BackColor = $darkBackColor
$form.ForeColor = $darkForeColor

# Label für die ausgewählte Datei
$labelFile = New-Object System.Windows.Forms.Label
$labelFile.Location = New-Object System.Drawing.Point(50, 20)
$labelFile.Size = New-Object System.Drawing.Size(300, 20)
$labelFile.Text = "Keine Datei ausgewaehlt"
$labelFile.ForeColor = $darkForeColor
$form.Controls.Add($labelFile)

# Schaltfläche, um zum Hauptmenü zurückzukehren
$buttonBack = New-Object System.Windows.Forms.Button
$buttonBack.Location = New-Object System.Drawing.Point(50, 50)
$buttonBack.Size = New-Object System.Drawing.Size(100, 30)
$buttonBack.Text = "Zurueck"
$buttonBack.BackColor = $darkBackColor
$buttonBack.ForeColor = $darkForeColor
$buttonBack.Add_Click({
    $form.Close()  # Close the current script window
})
$form.Controls.Add($buttonBack)


# Schaltfläche, um eine Datei auszuwählen
$buttonChooseFile = New-Object System.Windows.Forms.Button
$buttonChooseFile.Location = New-Object System.Drawing.Point(50, 100)
$buttonChooseFile.Size = New-Object System.Drawing.Size(150, 30)
$buttonChooseFile.Text = "Datei auswaehlen"
$buttonChooseFile.BackColor = $darkBackColor
$buttonChooseFile.ForeColor = $darkForeColor
$buttonChooseFile.Add_Click({
    $filePath = ChooseFile
    if ($filePath) {
        $global:chosenFilePath = $filePath
        UpdateFileLabel
        UpdateActionButton
        Write-Host "Chosen file path: $global:chosenFilePath"
    }
})
$form.Controls.Add($buttonChooseFile)

# Schaltfläche, um die ausgewählte Datei zu entfernen
$buttonRemoveFile = New-Object System.Windows.Forms.Button
$buttonRemoveFile.Location = New-Object System.Drawing.Point(250, 100)
$buttonRemoveFile.Size = New-Object System.Drawing.Size(150, 30)
$buttonRemoveFile.Text = "Auswahl entfernen"
$buttonRemoveFile.BackColor = $darkBackColor
$buttonRemoveFile.ForeColor = $darkForeColor
$buttonRemoveFile.Add_Click({
    $global:chosenFilePath = $null
    UpdateFileLabel
    UpdateActionButton
})
$form.Controls.Add($buttonRemoveFile)

# Schaltfläche für die Aktion
$buttonAction = New-Object System.Windows.Forms.Button
$buttonAction.Location = New-Object System.Drawing.Point(50, 150)
$buttonAction.Size = New-Object System.Drawing.Size(300, 30)
$buttonAction.Text = "Konvertiere zu MP3!"
$buttonAction.BackColor = $darkBackColor
$buttonAction.ForeColor = $darkForeColor
$buttonAction.Enabled = $false
$buttonAction.Add_Click({
    if ($global:chosenFilePath -ne $null) {
        try {
            # Get the directory of the chosen file
            $directory = [System.IO.Path]::GetDirectoryName($global:chosenFilePath)
            # Create the "converted" subfolder if it doesn't exist
            $outputDirectory = Join-Path -Path $directory -ChildPath "converted"
            if (-not (Test-Path -Path $outputDirectory)) {
                New-Item -ItemType Directory -Path $outputDirectory | Out-Null
            }
            # Build the output file path with the same name as the chosen file but with .mp3 extension
            $outputFilePath = Join-Path -Path $outputDirectory -ChildPath ([System.IO.Path]::GetFileNameWithoutExtension($global:chosenFilePath) + ".mp3")
            # Construct the FFmpeg command to convert the chosen file to MP3
            $ffmpegArgs = @(
                "-i", $global:chosenFilePath,
                "-vn",
                "-ar", "44100",
                "-ac", "2",
                "-b:a", "192k",
                $outputFilePath
            )
            # Execute FFmpeg command
            & $ffmpegPath $ffmpegArgs

            if (Test-Path -Path $outputFilePath) {
                Write-Host "File converted to MP3 and saved at: $outputFilePath"
                [System.Windows.Forms.MessageBox]::Show("Datei erfolgreich in MP3 konvertiert und gespeichert unter: $outputFilePath", "Erfolgreiche Konvertierung", "OK", "Information")
            } else {
                Write-Host "Error: No file created during conversion."
                [System.Windows.Forms.MessageBox]::Show("Fehler: Keine Datei wurde während der Konvertierung erstellt.", "Fehler", "OK", "Error")
            }
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Fehler beim Konvertieren der Datei: $_", "Fehler", "OK", "Error")
        }
    } else {
        Write-Host "No file chosen!"
    }
})
$form.Controls.Add($buttonAction)

# Function to start the main form
function StartForm {
    $form.ShowDialog() | Out-Null
}

StartForm
'@



# Compression Script Kontent
$compressScriptContent = @'
Add-Type -AssemblyName System.Windows.Forms

# Hinzufügen des Windows-Formulars
$global:chosenFilePath = $null

# Funktion zum Erstellen eines Dateiauswahl-Dialogfelds
function ChooseFile {
    $fileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $fileDialog.Multiselect = $false
    $fileDialog.Filter = "All files (*.*)|*.*"
    $result = $fileDialog.ShowDialog()
    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        return $fileDialog.FileName
    }
    return $null
}

# Funktion zum Aktualisieren des Datei-Labels
function UpdateFileLabel {
    if ($global:chosenFilePath -ne $null) {
        $labelFile.Text = "Gewählte Datei: $global:chosenFilePath"
    } else {
        $labelFile.Text = "Keine Datei ausgewaehlt"
    }
}

# Funktion zum Aktualisieren der Aktions-Schaltflächen
function UpdateActionButtons {
    if ($global:chosenFilePath -ne $null) {
        $buttonKomprimieren.Enabled = $true
        $buttonDekomprimieren.Enabled = $true
    } else {
        $buttonKomprimieren.Enabled = $false
        $buttonDekomprimieren.Enabled = $false
    }
}

$darkBackColor = [System.Drawing.Color]::FromArgb(64, 64, 64)
$darkForeColor = [System.Drawing.Color]::White
$form = New-Object System.Windows.Forms.Form
$form.Text = "Komprimierung"
$form.Size = New-Object System.Drawing.Size(400, 300)
$form.StartPosition = "CenterScreen"
$form.BackColor = $darkBackColor
$form.ForeColor = $darkForeColor

# Label für die ausgewählte Datei
$labelFile = New-Object System.Windows.Forms.Label
$labelFile.Location = New-Object System.Drawing.Point(50, 20)
$labelFile.Size = New-Object System.Drawing.Size(300, 20)
$labelFile.Text = "Keine Datei ausgewählt"
$labelFile.ForeColor = $darkForeColor
$form.Controls.Add($labelFile)

# Schaltfläche, um zum Hauptmenü zurückzukehren
$buttonBack = New-Object System.Windows.Forms.Button
$buttonBack.Location = New-Object System.Drawing.Point(50, 50)
$buttonBack.Size = New-Object System.Drawing.Size(100, 30)
$buttonBack.Text = "Zurueck"
$buttonBack.BackColor = $darkBackColor
$buttonBack.ForeColor = $darkForeColor
$buttonBack.Add_Click({
    $form.Close()  # Close the current script window
})
$form.Controls.Add($buttonBack)


# Schaltfläche, um eine Datei auszuwählen
$buttonChooseFile = New-Object System.Windows.Forms.Button
$buttonChooseFile.Location = New-Object System.Drawing.Point(50, 100)
$buttonChooseFile.Size = New-Object System.Drawing.Size(150, 30)
$buttonChooseFile.Text = "Datei auswaehlen"
$buttonChooseFile.BackColor = $darkBackColor
$buttonChooseFile.ForeColor = $darkForeColor
$buttonChooseFile.Add_Click({
    $filePath = ChooseFile
    if ($filePath) {
        $global:chosenFilePath = $filePath
        UpdateFileLabel
        UpdateActionButtons
    }
})
$form.Controls.Add($buttonChooseFile)

# Schaltfläche, um die ausgewählte Datei zu entfernen
$buttonRemoveFile = New-Object System.Windows.Forms.Button
$buttonRemoveFile.Location = New-Object System.Drawing.Point(250, 100)
$buttonRemoveFile.Size = New-Object System.Drawing.Size(150, 30)
$buttonRemoveFile.Text = "Auswahl entfernen"
$buttonRemoveFile.BackColor = $darkBackColor
$buttonRemoveFile.ForeColor = $darkForeColor
$buttonRemoveFile.Add_Click({
    $global:chosenFilePath = $null
    UpdateFileLabel
    UpdateActionButtons
})
$form.Controls.Add($buttonRemoveFile)

# Schaltfläche zum Komprimieren
$buttonKomprimieren = New-Object System.Windows.Forms.Button
$buttonKomprimieren.Location = New-Object System.Drawing.Point(50, 150)
$buttonKomprimieren.Size = New-Object System.Drawing.Size(150, 30)
$buttonKomprimieren.Text = "Komprimieren"
$buttonKomprimieren.Enabled = $false
$buttonKomprimieren.BackColor = $darkBackColor
$buttonKomprimieren.ForeColor = $darkForeColor
$buttonKomprimieren.Add_Click({
    if ($global:chosenFilePath -ne $null) {
        try {
            $directory = [System.IO.Path]::GetDirectoryName($global:chosenFilePath)
            $fileName = [System.IO.Path]::GetFileNameWithoutExtension($global:chosenFilePath)
            $compressedFilePath = "$directory\$fileName.zip"
            
            if (Test-Path -Path $compressedFilePath) {
                $confirmResult = [System.Windows.Forms.MessageBox]::Show("Die Datei $($compressedFilePath) existiert bereits. Möchten Sie sie überschreiben?", "Bestätigung", "YesNo", "Warning")
                
                if ($confirmResult -eq "Yes") {
                    Compress-Archive -Path $global:chosenFilePath -DestinationPath $compressedFilePath -Force

                    [System.Windows.Forms.MessageBox]::Show("Komprimierung abgeschlossen. Die Datei wurde als $($compressedFilePath) gespeichert.", "Hinweis", "OK", "Information")
                }
            } else {
                Compress-Archive -Path $global:chosenFilePath -DestinationPath $compressedFilePath -Force

                [System.Windows.Forms.MessageBox]::Show("Komprimierung abgeschlossen. Die Datei wurde als $($compressedFilePath) gespeichert.", "Hinweis", "OK", "Information")
            }
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Fehler beim Komprimieren der Datei: $_", "Fehler", "OK", "Error")
        }
    }
})
$form.Controls.Add($buttonKomprimieren)

# Schaltfläche zum Dekomprimieren
$buttonDekomprimieren = New-Object System.Windows.Forms.Button
$buttonDekomprimieren.Location = New-Object System.Drawing.Point(250, 150)
$buttonDekomprimieren.Size = New-Object System.Drawing.Size(150, 30)
$buttonDekomprimieren.Text = "Dekomprimieren"
$buttonDekomprimieren.Enabled = $false
$buttonDekomprimieren.BackColor = $darkBackColor
$buttonDekomprimieren.ForeColor = $darkForeColor
$buttonDekomprimieren.Add_Click({
    if ($global:chosenFilePath -ne $null) {
        try {
            $directory = [System.IO.Path]::GetDirectoryName($global:chosenFilePath)
            $extractedFilePath = "$directory\Decompressed"
            
            if (Test-Path -Path $extractedFilePath) {
                $confirmResult = [System.Windows.Forms.MessageBox]::Show("Der Ordner $($extractedFilePath) existiert bereits. Möchten Sie ihn überschreiben?", "Bestätigung", "YesNo", "Warning")
                
                if ($confirmResult -eq "Yes") {
                    Expand-Archive -Path $global:chosenFilePath -DestinationPath $extractedFilePath -Force

                    [System.Windows.Forms.MessageBox]::Show("Dekomprimierung abgeschlossen. Die Datei wurde in den Ordner $($extractedFilePath) extrahiert.", "Hinweis", "OK", "Information")
                }
            } else {
                Expand-Archive -Path $global:chosenFilePath -DestinationPath $extractedFilePath -Force

                [System.Windows.Forms.MessageBox]::Show("Dekomprimierung abgeschlossen. Die Datei wurde in den Ordner $($extractedFilePath) extrahiert.", "Hinweis", "OK", "Information")
            }
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Fehler beim Dekomprimieren der Datei: $_", "Fehler", "OK", "Error")
        }
    }
})
$form.Controls.Add($buttonDekomprimieren)

$form.ShowDialog() | Out-Null
'@

CreateMainMenuForm

