Add-Type -AssemblyName System.Windows.Forms

# Créer le formulaire
$form = New-Object System.Windows.Forms.Form
$form.Text = "Network Diag"
$form.Width = 600
$form.Height = 700

$textBoxComputer = New-Object System.Windows.Forms.TextBox
$textBoxComputer.Width = 100
$textBoxComputer.Height = 20
$textBoxComputer.Location = New-Object System.Drawing.Point(20, 20)

# Créer une TextBox pour afficher les résultats
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Multiline = $true
$textBox.Width = 550
$textBox.Height = 580
$textBox.Location = New-Object System.Drawing.Point(20, 50)
$textBox.ScrollBars = 'Vertical'

# Créer un bouton pour lancer le test
$button = New-Object System.Windows.Forms.Button
$button.Text = "Start"
$button.Width = 70
$button.Height = 22
$button.Location = New-Object System.Drawing.Point(130, 19)

# Ajouter un gestionnaire d'événement au clic du bouton
$button.Add_Click({

    $textBox.clear()

    $computer = $textBoxComputer.Text
    # Exécuter la commande à distance et récupérer le résultat
    $result = Invoke-Command -ComputerName $computer -ScriptBlock {

        param($computer)

        # Récupérer le nom de l'ordinateur
        $Computername = hostname

        $dhcpService = Get-Service -Name Dhcp | Select-Object -ExpandProperty Status
        $dnsService = Get-Service -Name Dnscache | Select-Object -ExpandProperty Status

        # Utilisation de Get-CimInstance pour récupérer les informations de configuration
        $networkAdaptersConfig = Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true -and $_.DNSDomain -eq "YourDomain" }
        
        # Exécuter nslookup
        $nslookup = nslookup 8.8.8.8
        $nslookuplocal = nslookup $networkAdaptersConfig.DNSServerSearchOrder[0]
        
        # Tester la connexion intranet et internet
        $intranetPing = (Test-Connection "YouOwnInternalServerToTest" -Count 1).ResponseTime
        $internetPing = (Test-Connection "google.fr" -Count 1).ResponseTime

        # traceRT
        $tracertInternet = tracert google.com
        $tracertInternet = $tracertInternet[3..($tracertInternet.Count - 2)]
     
        # Créer une chaîne de texte pour afficher les résultats
        $resultText = "NETWORK DIAG`r`n"
        $resultText += "`r`n------------------------------------------------------------------------------------`r`nCOMPUTER $Computername`r`n------------------------------------------------------------------------------------`r`n"
        $resultText += "`r`n■ SERIVCES`r`n"
        $resultText += "`r`nDNS SERVICE : $dnsService`r`nDHCP SERVICE : $dhcpservice`r`n"
        $resultText += "`r`n------------------------------------------------------------------------------------`r`nHARDWARE`r`n------------------------------------------------------------------------------------`r`n"
        $resultText += "`r`n■ NETWORK INTERFACE`r`n"
        $resultText += "`r`nINTERFACE : $($networkAdaptersConfig.description)`r`nMAC : $($networkAdaptersConfig.MACAddress)`r`nIP : $($networkAdaptersConfig.IPAddress)`r`n"
        $resultText += "`r`n■ NETWORK INTERFACE PARAMETERS`r`n"
        $resultText += "`r`nDEFAULT GATEWAY : $($networkAdaptersConfig.DefaultIPGateway)`r`nDNS : $($networkAdaptersConfig.DNSServerSearchOrder)`r`nDHCP : $($networkAdaptersConfig.DHCPServer)`r`nDHCP LEASE OBTENTION : $($networkAdaptersConfig.DHCPLeaseObtained)`r`nDHCP LEASE EXPIRATION : $($networkAdaptersConfig.DHCPLeaseExpires)`r`n"
        $resultText += "`r`n------------------------------------------------------------------------------------`r`nCONNECTIVITY`r`n------------------------------------------------------------------------------------`r`n"
        $resultText += "`r`n■ LATENCY`r`n"
        $resultText += "`r`nINTRANET PING(ms) | YouOwnInternalServerToTest : $intranetPing ms`r`nINTERNET PING(ms) | GOOGLE.COM : $internetPing ms`r`n"
        $resultText += "`r`n■ DNS`r`n"
        $resultText += "`r`nDNS INTERNET :$nslookup`r`nDNS INTERNET : $nslookuplocal`r`n"
        $resultText += "`r`n■ TraceRT (Google.com)`r`n"
        $resultText += "$($tracertInternet -join "`r`n")"
        
        # Retourner la chaîne complète des résultats
        return $resultText

    } -ArgumentList $script:users,$computer

    # Effacer les anciennes données dans la TextBox
    $textBox.Clear()

    # Ajouter les résultats dans la TextBox
    $textBox.AppendText($result)

}) 

# Ajouter le bouton et la TextBox au formulaire
$form.Controls.Add($textBox)
$form.Controls.Add($textBoxComputer)
$form.Controls.Add($button)
$textBox.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right

# Afficher le formulaire
$form.ShowDialog()