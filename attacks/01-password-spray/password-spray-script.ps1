$passwords = @("Winter2026!", "Spring2026!", "Welcome2026!")
$users = @("bwayne", "jsmith", "sconnor", "jdoe", "labadmin")

foreach ($u in $users) { 
    foreach ($p in $passwords) { 
        $sec = ConvertTo-SecureString $p -AsPlainText -Force
        $cred = New-Object System.Management.Automation.PSCredential("lab\$u", $sec)
        Start-Process powershell -Credential $cred -ArgumentList "-Command exit" -NoNewWindow 2>$null 
    } 
}