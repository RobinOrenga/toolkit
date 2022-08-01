Start-transcript -path "C:\log\installposte.log"
#UAC
	Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name EnableLUA -Value 0 
			
			Start-Sleep -Seconds 5
#Clé VPN
	REG ADD HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 0x2 /f 
			
			Start-Sleep -Seconds 5   
			
#Install support TeamViewer
   Copy-Item "Support-Aquisys.exe" "C:\Users\Public\Desktop"
			
			Start-Sleep -Seconds 5   
		
#Changement nom du poste
   Write-Host
		Write-Host "*** Rennomage du poste ***" 
	Write-Host
	
				Start-Sleep -Seconds 5
							
	Write-Host
			$input = Read-Host "Renomme ton PC" -Verbose
	Write-Host
	
				Start-Sleep -Seconds 5
				
		Rename-Computer -newname "$input" -Verbose
		
				Start-Sleep -Seconds 5
				
#Creation User Admin
$PASSWORD= ConvertTo-SecureString –AsPlainText -Force -String motdepasseadefinir

	Write-Host
	Write-Host -ForegroundColor Red "NOTE: Création de l'utilisateur Aquisys"
	Write-Host
	
				Start-Sleep -Seconds 2
					
	New-LocalUser -Name "Aquisys" -Description "Aquisys" -Verbose -Password $PASSWORD
	
				Start-Sleep -Seconds 2
				
	Add-LocalGroupMember -Group "Utilisateurs" -Member "Aquisys" -Verbose
	
				Start-Sleep -Seconds 2
				
	Add-LocalGroupMember -Group "Administrateurs" -Member "Aquisys" -Verbose

#MAJ Windows 10
   Install-Module -Name PSWindowsUpdate -Verbose
			
			Start-Sleep -Seconds 2
			
		Get-WindowsUpdate -Verbose
			
			Start-Sleep -Seconds 2
			
		Get-WUlist -Verbose
			
			Start-Sleep -Seconds 2
			
	Install-WindowsUpdate -AcceptAll -Verbose 
			
			Start-Sleep -Seconds 2   

#Lancement EXE
	
#ninite
				start-process -FilePath ninite
					Start-Sleep -Seconds 2
#Foxit
				start-process -FilePath foxit
					Start-Sleep -Seconds 2
#McAfee
				start-process -FilePath McAfee
					Start-Sleep -Seconds 2
#Desinstall365
				start-process -FilePath Desinstall365.diagcab
					Start-Sleep -Seconds 2
Stop-Transcript
