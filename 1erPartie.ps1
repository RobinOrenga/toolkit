#Start-transcript -path "C:\log\installposte.log"
function menu()
{ 
    Write-Host 
    Clear-host
    Write-Host ""
    Write-Host ""
    Write-Host "1: UAC "
    Write-Host "2: Clé VPN "
    Write-Host "3: Support Aquisys "
    Write-Host "4: Changement nom du poste "
    Write-Host "5: Creation User Admin"
    Write-Host "6: MAJ Windows 10 "
    Write-Host "7: Lancement EXE NINITE"
    Write-Host "8: Creation vpn"
	Write-Host "9: Ajout poste sur le domaine"
    write-Host "10: SCAN MATERIEL DU POSTE"
    write-Host "11: Ajout lecteur réseau"
	write-Host "20: ARRET POSTE"
    Write-Host ""
    Write-Host "12: RETOUR MENU GENERAL  "
    Write-Host ""
    Write-Host "0: QUITTER le Script"
        $choix=Read-Host " Votre Choix "
    switch ($choix)
    
    {
        1 {UAC;pause;menu}
        2 {CléVPN;pause;menu}
        3 {supportAquisys;pause;menu}
        4 {nomduposte;pause;menu}
        5 {CreationUserAdmin;pause;menu}
        6 {MAJWindows10;pause;menu}
        7 {exeninite;pause;menu}
		8 {creationvpn;pause;menu}
		9 {ajout_domaine}
        10 {scanposte;pause;menu}
		11 {lecteurreseau;pause;menu}
		20 {arretposte;pause;menu}
        12 {C:\ToolKIT\toolkit.ps1}
        0 {exit}
      
    }   
}
#UAC
function UAC()
{ 

	Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name EnableLUA -Value 0 
			
			Start-Sleep -Seconds 5
}

#Clé VPN
function CléVPN()
{ 
   
	REG ADD HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 0x2 /f 
			
			Start-Sleep -Seconds 5   
}
				
#Install support Aquisys
function supportAquisys()
{ 
   Copy-Item "C:\script\Support-Aquisys.exe" "C:\Users\Public\Desktop"
			
			Start-Sleep -Seconds 5   
}
			
#Changement nom du poste
function nomduposte()
{ 
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
}
			
#Creation User Admin
function CreationUserAdmin()
{ 
	Write-Host
	Write-Host -ForegroundColor Red "NOTE: Création de l'utilisateur Aquisys"
	Write-Host
	
				Start-Sleep -Seconds 2
					
	New-LocalUser -Name "Aquisys" -Description "Aquisys" -Verbose
	
				Start-Sleep -Seconds 2
				
	Add-LocalGroupMember -Group "Utilisateurs" -Member "Aquisys" -Verbose
	
				Start-Sleep -Seconds 2
				
	Add-LocalGroupMember -Group "Administrateurs" -Member "Aquisys" -Verbose
}

#MAJ Windows 10
function MAJWindows10()
{ 
   Install-Module -Name PSWindowsUpdate -Verbose
			
			Start-Sleep -Seconds 2
			
		Get-WindowsUpdate -Verbose
			
			Start-Sleep -Seconds 2
			
		Get-WUlist -Verbose
			
			Start-Sleep -Seconds 2
			
	Install-WindowsUpdate -AcceptAll -Verbose 
			
			Start-Sleep -Seconds 2   
}

#Lancement EXE
function exeninite()
{ 	
    Write-Host ""
    Write-Host ""
    Write-Host "1: NINITE"
    Write-Host "2: Reader"
    Write-Host "3: McAfee"
	Write-Host "4: AgentMAX"
	Write-Host "5: Desinstall365"
	Write-Host""
	Write-Host "6: Menu"
	Write-Host""
$choixexe=Read-Host " Votre Choix "
    switch ($choixexe)
    
    {
        1 {ninite;pause;exeninite}
        2 {Reader;pause;exeninite}
        3 {McAfee;pause;exeninite}
		4 {AgentMAX;pause;exeninite}
		5 {Desinstall365;pause;exeninite}
        6 {menu;pause;menu}
     
    }
	function ninite
	{
    $ninite = C:\script\Ninite.exe
				start-process -FilePath $ninite
					Start-Sleep -Seconds 2
	}
	function Reader 
	{
    $Reader = C:\script\Reader.exe
				start-process -FilePath $Reader
					Start-Sleep -Seconds 2
	}
	function McAfee
	{
    $McAfee = C:\script\McAfee_desinstall_MCPR.exe
				start-process -FilePath $McAfee
					Start-Sleep -Seconds 2				
	}
	function AgentMAX
	{
    $AgentMAX = C:\script\AgentMAX.exe
				start-process -FilePath $AgentMAX
					Start-Sleep -Seconds 2
	}
	function Desinstall365
	{
    $Desinstall365 = C:\script\o15-ctrremove.diagcab
				start-process -FilePath $Desinstall365
					Start-Sleep -Seconds 2	
	}
}
function creationvpn()
{ 

    $ServerAddress = "snts.local" 
    $ConnectionName = "VPN SNTS" 
    $PresharedKey = "tjf9E546RFepunf6uW*@hcdH&24cM63*x7qDRTRB!AYw2" 
    Add-VpnConnection -Name "$ConnectionName" -ServerAddress "$ServerAddress" -TunnelType L2tp -AllUserConnection -L2tpPsk "$PresharedKey" -AuthenticationMethod Pap -Force 
               Start-Sleep -Seconds 5				
}

# Ajout poste sur le domaine
function ajout_domaine()
{
 
	Add-Computer -DomainName snts.local -DomainCredential \administrateur

             Start-Sleep -Seconds 5
}

#SCAN MATERIEL DU POSTE
function scanposte()
{
    New-Item "C:Documents\SCAN MATERIEL POSTE\" -itemType Directory
    #Propriété de la carte réseau
    Get-NetAdapter -Name Ethernet| Out-File -Append "C:Documents\SCAN MATERIEL POSTE\SCAN.txt"
    #Propriété du Bios 
    Get-WmiObject -Class Win32_Bios | select SerialNumber | OUt-File -Append "C:Documents\SCAN MATERIEL POSTE\SCAN.txt"
    #Propriété du  Poste
    Get-CimInstance -ClassName Win32_ComputerSystem | select Domain,Manufactturer,Model,Name | Out-File -Append "C:Documents\SCAN MATERIEL POSTE\SCAN.txt"
    #Propriété du Système
    Get-WmiObject win32_Computersystem | Select-Object SystemSKUNumber | OUt-File -Append "C:Documents\SCAN MATERIEL POSTE\SCAN.txt"
    #Propriété du Processeur
    Get-CimInstance -ClassName Win32_Processor | Select-Object -ExcludeProperty "CIM*"| OUt-File -Append "C:Documents\SCAN MATERIEL POSTE\SCAN.txt"
    #Information User
    Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property NumberOfLicensedUsers,NumberOfUsers,RegisteredUser | OUt-File -Append "C:Documents\SCAN MATERIEL POSTE\SCAN.txt"
    #Propriété des disques
    Get-CimInstance -ClassName Win32_LogicalDisk | Out-File -Append "C:Documents\SCAN MATERIEL POSTE\SCAN.txt"
    #Propriéte de la RAM
    Get-CimInstance win32_physicalmemory | Format-Table Manufacturer,Banklabel,Configuredclockspeed,Devicelocator,Capacity,Serialnumber -autosize | Out-File -Append "C:Documents\SCAN MATERIEL POSTE\SCAN.txt"

    Start-Sleep -Seconds 5
   
    Write-Host ""
    Write-Host ""
    Write-Host "OK"





    }
function lecteurreseau()
	{
	New-PSDrive -Name P -Root \\WIN-CPEF1VNHL2C\Partages -PSProvider FileSystem -Persist -Credential $name@labo.lan
	Get-ChildItem P:
	Start-Sleep -Seconds 5
	#Remove-PSDrive P	
		
	}

function arretposte()
{
		Stop-Computer -Force
}
Stop-Transcript
menu