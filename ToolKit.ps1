##[Ps1 To Exe]
##
##Kd3HDZOFADWE8uK1
##Nc3NCtDXThU=
##Kd3HFJGZHWLWoLaVvnQnhQ==
##LM/RF4eFHHGZ7/K1
##K8rLFtDXTiW5
##OsHQCZGeTiiZ4tI=
##OcrLFtDXTiW5
##LM/BD5WYTiiZ4tI=
##McvWDJ+OTiiZ4tI=
##OMvOC56PFnzN8u+Vs1Q=
##M9jHFoeYB2Hc8u+Vs1Q=
##PdrWFpmIG2HcofKIo2QX
##OMfRFJyLFzWE8uK1
##KsfMAp/KUzWJ0g==
##OsfOAYaPHGbQvbyVvnQX
##LNzNAIWJGmPcoKHc7Do3uAuO
##LNzNAIWJGnvYv7eVvnQX
##M9zLA5mED3nfu77Q7TV64AuzAgg=
##NcDWAYKED3nfu77Q7TV64AuzAgg=
##OMvRB4KDHmHQvbyVvnQX
##P8HPFJGEFzWE8tI=
##KNzDAJWHD2fS8u+Vgw==
##P8HSHYKDCX3N8u+Vgw==
##LNzLEpGeC3fMu77Ro2k3hQ==
##L97HB5mLAnfMu77Ro2k3hQ==
##P8HPCZWEGmaZ7/K1
##L8/UAdDXTlaDjofG5iZk2VnhQGElIMqJvLigxb2T8e/IqSzPTNpZCXVmgyDPHViBetchfMk3uN4SFU4WH8AkyJfkW8GAa4s2ovFwYeCamZE8F1/L3MDI4BqAxo3UDTBHbnnDWK1QGQDS0C/YU2j6
##Kc/BRM3KXhU=
##
##
##fd6a9f26a06ea3bc99616d4851b372ba
####################TROUSSE A OUTILS POWERSHELL####################
Start-transcript -path "C:\log\toolkit.log"
function menu_ad()
{ 
    Clear-host
    Write-Host "Menu Active Directory"
    Write-Host ""
    Write-Host "A: Menu Cube"
    Write-Host "1: CREATION EN BLOC OU à partir de fichier csv"
    Write-Host "2: CREATION EN BLOC GROUPES à partir de fichier csv"
    Write-Host "3: CREATION EN BLOC USER à partir de fichier csv imbrication groupes"
    Write-Host "4: CREATION EN BLOC ORDIS à partir de fichier csv imbrication groupes"
    Write-Host "5: CREATION UNITAIRE OU"
    Write-Host "6: CREATION UNITAIRE GROUPE"
    Write-Host "7: CREATION UNITAIRE USER"
    Write-Host "8: CREATION UNITAIRE OU PAR BLOC ORDIS EXPORT BINAIRE POUR DEPLOIMENT Hors connexion"
    Write-Host ""
    Write-Host "9: RETOUR MENU GENERAL "
    Write-Host ""
    Write-Host "0: QUITTER le Script"
        $choix=Read-Host " Votre Choix "
    switch ($choix)   
    {
        A {C:\ToolKIT\cube.ps1;creation_unitaire_user}
        1 {menu_bloc_ous}
        2 {menu_bloc_groupes}
        3 {menu_bloc_user}
        4 {menu_bloc_ordis}
        5 {menu_unitaire_ou}
        6 {menu_unitaire_groupe}
        7 {menu_unitaire_user}
        8 {menu_unitaire_ordi}
        9 {menu_general}
        0 {exit}
        default {menu_ad}
}}
function menu_vm()
{ 
    Clear-host
    Write-Host "Menu Machine Virtuelles"
    Write-Host ""
    Write-Host "1: CREATION MACHINE Virtuelles HYPERV"
    Write-Host "2: CREATION MACHINE Virtuelles VMWARE"
    Write-Host "3: INSTALLATION MACHINE Windows Serveur Core 2019"
    Write-Host "4: INSTALLATION MACHINE Windows Serveur Graphique 2019"
    Write-Host "5: INSTALLATION MACHINE Linux DEBIAN 11"
    Write-Host ""
    Write-Host "9: RETOUR MENU GENERAL "
    Write-Host ""
    Write-Host "0: QUITTER le Script"
        $choix=Read-Host " Votre Choix "
    switch ($choix)
    {
        1 {menu_vm_hyperv}
        2 {menu_vm_vmware}
        3 {menu_bloc_install_ws2019core}
        4 {menu_bloc_install_ws2019gui}
        5 {menu_unitaire_linux}
        9 {menu_general}
        0 {exit}
        default {menu_vms}
    } 
}  
function menu_()
{ 
    Write-Host 
    Clear-host
    Write-Host ""
    Write-Host ""
    Write-Host "1: "
    Write-Host "2: "
    Write-Host "3: "
    Write-Host "4: "
    Write-Host "5: "
    Write-Host ""
    Write-Host "9: RETOUR MENU GENERAL  "
    Write-Host ""
    Write-Host "0: QUITTER le Script"
        $choix=Read-Host " Votre Choix "
    switch ($choix)
    
    {
        1 {menu_}
        2 {menu_}
        3 {menu_}
        4 {menu_}
        5 {menu_}
        9 {menu_general}
        0 {exit}
        default {menu_}
    }   
}
function menu_monitor()
{ 
    Write-Host 
    Clear-host
    Write-Host "Monitoring de capacité par serveurs ou machines"
    Write-Host "Exemples exercices / Process / SERVICES / DISQUEs / CPU / MEM / RESEAU "
    Write-Host "1: Processus et CPU "
    Write-Host "2: SERVICES"
    Write-Host "3: Disques "
    Write-Host "4: Mémoire"
    Write-Host "5: Réseau "
    Write-Host "6: Prise en main administrateur à distance"
    Write-Host "7: SCAN POSTE"
    Write-Host ""
    Write-Host "9: Retour MENU GENERAL "
    Write-Host ""
    Write-Host "0: QUITTER le Script"
        $choix=Read-Host " Votre Choix "
    switch ($choix)
    
    {
        1 {menu_proc}
        2 {menu_services}
        3 {menu_disques}
        4 {menu_memoire}
        5 {menu_reseau}
        6 {menu_prise_en_main}
        7 {.\Toolkit.ps1;scanposte}
        9 {menu_general}
        0 {exit}
        default {menu_}
    }   

}
function menu_modules()
{  
    Clear-host
    Write-Host "MODULES MSO / AZURE / VMWARE / SHAREPOINT"
    Write-Host ""
    Write-Host "1: Connexion module MSO office 365 "
    Write-Host "2: Connexion module Azure"
    Write-Host "3: Connexion module VMWARE"
    Write-Host "4: Autres 365 (SHAREPOINT / TEAMS / Onedrive"
    Write-Host "5: Exchange "
    Write-Host "6: LINUX "
    write-host ""
    Write-Host "9: Retour MENU GENERAL "
    Write-Host ""
    Write-Host "0: QUITTER le Script"
        $choix=Read-Host " Votre Choix "
    switch ($choix)
    
    {
        1 {menu_}
        2 {menu_}
        3 {menu_}
        4 {menu_}
        5 {menu_}
        5 {menu_}
        9 {menu_general}
        0 {exit}
        default {menu_}
    }   
}
function menu_sauve()
{  
    Clear-host
    Write-Host "Sauvegarde et PRA / PCA "
    Write-Host "1: Connexion module Veeam "
    Write-Host "2: PRA HYPEV HYPERV REPLICA "
    Write-Host "3: PRA VMWARE site recovery"
    Write-Host "4: PCA CLUSTER Hyperv"
    Write-Host "5: PCA CLUSTER HA FT VMWARE"
    Write-Host "6: STARWIN VSAN"
    Write-Host ""
    Write-Host "9: RETOUR MENU GENERAL "
    Write-Host ""
    Write-Host "0: QUITTER le Script"
        $choix=Read-Host " Votre Choix "
    switch ($choix)
    
    {
        1 {menu_veeam}
        2 {menu_hyper_replica}
        3 {menu_vcenter_siterecovery}
        4 {menu_cluster_365}
        5 {menu_exchange}
        5 {menu_linux}
        9 {menu_general}
        0 {exit}
        default {menu_}
    }   
}
function menu_general()
{
    Clear-Host
          
    Write-host "menu general"
    write-host "1: Active Directory"
    write-host "2: Machine Virtuelles"
    write-host "3: Serveurs"
    write-host "4: Monitoring"
    write-host "5: Modules (MSO,AZURE,EXCHANGE,..."
    write-host "6: Sauvagarde"
    write-host "7: Signature srcipt powershell"
    write-host "8: preparation poste"
    write-host ""
    write-host "0: Quitter le script"
    write-host ""
    $choix=Read-Host "Votre Choix"
    switch ($choix)
    {
       1{menu_ad}
       2{menu_vm}
       3{menu_serv}
       4{menu_monitor}
       5{menu_modules}
       6{menu_sauve}
       7{C:\ToolKIT\SIGNE.ps1}
       8{prep_poste}
       0{exit}
       default {menu_general}

    }
}
function menu_ous()
{ 
    Write-Host 
    Clear-host
    Write-Host ""
    Write-Host ""
    Write-Host "1: "
    Write-Host "2: "
    Write-Host "3: "
    Write-Host "4: "
    Write-Host "5: "
    Write-Host ""
    Write-Host "9: RETOUR MENU GENERAL  "
    Write-Host ""
    Write-Host "0: QUITTER le Script"
        $choix=Read-Host " Votre Choix "
    switch ($choix)
    
    {
        1 {menu_}
        2 {menu_}
        3 {menu_}
        4 {menu_}
        5 {menu_}
        9 {menu_general}
        0 {exit}
        default {menu_}
    }   
}
function prep_poste()
{ 
    Write-Host 
    Clear-host
    Write-Host ""
    Write-Host ""
    Write-Host "1:Preparation des postes "
    Write-Host ""
	Write-Host ""
    Write-Host "9: RETOUR MENU GENERAL  "
    Write-Host ""
    Write-Host "0: QUITTER le Script"
        $choix=Read-Host " Votre Choix "
    switch ($choix)
    
    {
        1 {C:\ToolKIT\1erPartie.ps1}
        9 {menu_general}
        0 {exit}
        default {menu_}
    }   
}

menu_general
