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
##L8/UAdDXTlaDjofG5iZk2VnhQGElIMqJvLigxb2T8e/IqSzPTNpZCXVmgyDPHViBetchfMk3uN4SFU4WH8AkyJfkW8GAa4s2ovFwYeCamZE8F1/L3MDI4BqAxo3UDTBHbnnDT5d9MGXe3GS9
##Kc/BRM3KXhU=
##
##
##fd6a9f26a06ea3bc99616d4851b372ba
########## Script création Unités ORGANISATION (ADDS) ##############
##########  Groupes / Utilisateurs / Dossiers / Permissions ######
Start-transcript -path "C:\log\AD.log"
clear-host
$nomou=read-host "Votre Ou de BASE pour La création de l'arborescence AD?"
$existeou=Get-ADOrganizationalUnit -Filter {name -eq $nomou}
if (!$existeou)
{
New-ADOrganizationalUnit -name $nomou -ProtectedFromAccidentalDeletion $false -Verbose
}


$nomdomaine=(get-addomain).distinguishedname
$chemin="OU="+$nomou+","+$nomdomaine
$CSVFile = ".\ecoles.csv"  #$liste=Import-Csv -Path ".C:\ToolKIT\ecoles.csv" -Delimiter ";" -Encoding UTF8
$liste = Import-CSV -Path $CSVfile -Delimiter ";" -Encoding UTF8
$chemingroupe="OU=GROUPES,"+$chemin


function creation_unitaire_OU()
{
 $nomou=Read-Host "Votre nom d'Unité d'Organisation ?"
 Write-host "Voulez-vous créer 1 ECOLE 1 CLASSE OU AUTRE"
 write-host "Choix 1 : CREATION ECOLE"
 write-host "Choix 2 : CREATION CLASSE DANS ECOLE"
 write-host "Choix 3 : CREATION OU DANS LA CLASSE EX ELEVES ORDIS IMP"

$choix = read-host "Votre choix ?"


switch ($choix)
{
    1{
    Write-host "CREATION D'UNE OU ECOLE"
     $cheminou= $chemin 
     New-ADOrganizationalUnit -Name $nomou -Path $cheminou -Verbose -ProtectedFromAccidentalDeletion $false
     }

    2 {write-host "CREATION D'UNE CLASSE"
     $nomecole=Read-Host "Dans quelle ECOLE?"
     $cheminou="OU="+$nomecole+","+$chemin 
     New-ADOrganizationalUnit -Name $nomou -Path $cheminou -Verbose -ProtectedFromAccidentalDeletion $false
     }
    3 {write-host "CREATION D'UNE OU AUTRE"
   $nomecole=Read-Host "Dans quelle ECOLE?"
   $nomclasse=Read-Host "Dans quelle CLASSE?"
     $cheminou=$chemin 
     New-ADOrganizationalUnit -Name $nomou -Path $cheminou -Verbose -ProtectedFromAccidentalDeletion $false
     }
     
}
}
function creation_unitaire_user()
{
$nom=read-host "Votre nom d'utilisateur ?"
$prenom=read-host "Votre prénom d'utilisateur ?"
$prenom=$prenom.Substring(0,1).ToUpper()+$prenom.Substring(1).ToLower()
$nomcomplet=$prenom+" "+$nom
$ecole=read-host "Votre Ecole ?"
$classe=read-host "Votre Classe ?"
$fonction=read-host "Votre Fonction ?"
$cheminuser="OU="+$fonction+",OU="+$classe+",OU="+$ecole+",OU="+$chemin
$sam=$prenom.ToLower()+"."+$nom.ToLower()
$upn=$sam+"@"+$env:USERDNSDOMAIN.ToLower()
$pass=ConvertTo-SecureString("Bordeaux33") -AsPlainText -Force `
 
 
 New-ADOrganizationalUnit -DisplayName:$nomcomplet `
-GivenName:$prenom `
-Name:$nomcomplet `
 -Path:$cheminuser `
 -SamAccountName:$sam `
 -Surname:$nom `
 -Title:$fonction  `
 -UserPrincipalName:$upn -Enabled $true `
 -AccountPassword $Pass -Verbose
 } 
function creation_ous()
{

 

New-ADOrganizationalUnit -name GROUPES -path $chemin -ProtectedFromAccidentalDeletion $false -Verbose

 

### CREATION D'UNE BOUCLE DE PARCOURS D'UNE COLLECTION DE DONNEES####

 

foreach ($ligne in $liste)
        {
         $ouecole=$ligne.ecole.toupper()
         $ouclasse=$ligne.classe.toupper()
         $existeecole=$false
         $existeclasse=$false
         $existe=$false
         
         ######## CREATION OU ECOLE ##############
         $existeecole=Get-ADOrganizationalUnit -SearchBase $chemin -Filter {name -eq $ouecole}
         if (!$existeecole)
         {
         New-ADOrganizationalUnit -Name $ouecole -Path $chemin `
         -ProtectedFromAccidentalDeletion $false -Verbose
         $cheminecole="OU="+$ouecole+","+$chemin
             }
         
         
         ######## CREATION OU CLASSE ##############
         $existeclasse=Get-ADOrganizationalUnit -SearchBase $cheminecole -Filter {name -eq $ouclasse}
         if (!$existeclasse)
         {
         New-ADOrganizationalUnit -Name $ouclasse -Path $cheminecole `
         -ProtectedFromAccidentalDeletion $false  
         $cheminclasse="OU="+$ouclasse+","+$cheminecole
             }
        
        ########### CREATION ENSEIGNANTS ##############
        $existe=Get-ADOrganizationalUnit -SearchBase $cheminclasse -Filter {name -eq "ENSEIGNANT"}
         if (!$existe)
         {
        New-ADOrganizationalUnit -name ENSEIGNANT -path $cheminclasse `
        -ProtectedFromAccidentalDeletion $false 
        }
        
        ########### CREATION DIRECTEURS ##############
        $existe=Get-ADOrganizationalUnit -SearchBase $cheminecole -Filter {name -eq "DIRECTEUR"}
         if (!$existe)
         {
        New-ADOrganizationalUnit -name DIRECTEUR -path $cheminecole `
        -ProtectedFromAccidentalDeletion $false 
        }
         
        ########### CREATION ELEVES ##############
        $existe=Get-ADOrganizationalUnit -SearchBase $cheminclasse -Filter {name -eq "ELEVE"}
         if (!$existe)
         {
        New-ADOrganizationalUnit -name ELEVE -path $cheminclasse `
        -ProtectedFromAccidentalDeletion $false
          }
         
         ########### CREATION ORDIS ##############
        $existe=Get-ADOrganizationalUnit -SearchBase $cheminclasse -Filter {name -eq "ORDINATEURS"}
         if (!$existe)
         {
        New-ADOrganizationalUnit -name ORDINATEURS -path $cheminclasse `
        -ProtectedFromAccidentalDeletion $false
          }
        
        
          ########### CREATION IMPRIMANTES ##############
        $existe=Get-ADOrganizationalUnit -SearchBase $cheminclasse -Filter {name -eq "IMPRIMANTES"}
         if (!$existe)
         {
        New-ADOrganizationalUnit -name IMPRIMANTES -path $cheminclasse `
        -ProtectedFromAccidentalDeletion $false
          }
         
        
        }

 

        

 

}
function creation_groupes()
{ New-ADGroup -GroupCategory Security -GroupScope Global -Name GG_TOUS -path $chemingroupe
  New-ADGroup -GroupCategory Security -GroupScope Universal -Name GU_TOUS -path $chemingroupe
  New-ADGroup -GroupCategory Security -GroupScope DomainLocal -Name GDL_TOUS_R -path $chemingroupe
  New-ADGroup -GroupCategory Security -GroupScope DomainLocal -Name GDL_TOUS_RW -path $chemingroupe
  
  foreach ($ligne in $liste)
    {   $existeecole=$false
        $existeclasse=$false
        $existe=$false
        ################### LES ECOLES ####################
        $gg_ecole="GG_"+$ligne.ecole
        $gu_ecole="GU_"+$ligne.ecole
        $gdl_ecole_r="GDL_"+$ligne.ecole+"_R"
        $gdl_ecole_rw="GDL_"+$ligne.ecole+"_RW"
        $gdl_ecole_m="GDL_"+$ligne.ecole+"_M"
        $gdl_ecole_f="GDL_"+$ligne.ecole+"_F"

 

        ################### LES CLASSES ####################

 

        $gg_classe="GG_"+$ligne.ecole+"_"+$ligne.classe
        $gu_classe="GU_"+$ligne.ecole+"_"+$ligne.classe
        $gdl_classe_r="GDL_"+$ligne.ecole+"_"+$ligne.classe+"_R"
        $gdl_classe_rw="GDL_"+$ligne.ecole+"_"+$ligne.classe+"_RW"
        $gdl_classe_m="GDL_"+$ligne.ecole+"_"+$ligne.classe+"_M"
        $gdl_classe_f="GDL_"+$ligne.ecole+"_"+$ligne.classe+"_F"

 

        ################# CREATION DES GROUPES ECOLES ET CLASSES ####################
        $existeecole=Get-ADOrganizationalUnit -SearchBase $chemingroupe -Filter {name -eq $gg_ecole}
         if (!$existeecole)
         {
        New-ADGroup -GroupCategory Security -GroupScope Global -Name $gg_ecole -path $chemingroupe
        Add-ADGroupMember GG_TOUS -Members $gg_ecole
        }
        
        
        $existeecole=Get-ADOrganizationalUnit -SearchBase $chemingroupe -Filter {name -eq $gu_ecole}
         if (!$existeecole)
         {
        New-ADGroup -GroupCategory Security -GroupScope Universal -Name $gu_ecole -path $chemingroupe
        Add-ADGroupMember $gu_ecole -Members $gg_ecole
        }
        
        $existeecole=Get-ADOrganizationalUnit -SearchBase $chemingroupe -Filter {name -eq $gdl_ecole_r}
         if (!$existeecole)
         {
        New-ADGroup -GroupCategory Security -GroupScope DomainLocal -Name $gdl_ecole_r -path $chemingroupe
        Add-ADGroupMember $gdl_ecole_r -Members $gu_ecole
        }
      
        $existeecole=Get-ADOrganizationalUnit -SearchBase $chemingroupe -Filter {name -eq $gdl_ecole_rw}
         if (!$existeecole)
         {
        
        New-ADGroup -GroupCategory Security -GroupScope DomainLocal -Name $gdl_ecole_rw -path $chemingroupe
        Add-ADGroupMember $gdl_ecole_rw -Members $gu_ecole
        }
        
        
       $existeecole=Get-ADOrganizationalUnit -SearchBase $chemingroupe -Filter {name -eq $gdl_ecole_m}
         if (!$existeecole)
         {
        New-ADGroup -GroupCategory Security -GroupScope DomainLocal -Name $gdl_ecole_m -path $chemingroupe
        Add-ADGroupMember $gdl_ecole_m -Members $gu_ecole
        }
      
        
        $existeecole=Get-ADOrganizationalUnit -SearchBase $chemingroupe -Filter {name -eq $gdl_ecole_f}
         if (!$existeecole)
         {
        New-ADGroup -GroupCategory Security -GroupScope DomainLocal -Name $gdl_ecole_f -path $chemingroupe
        Add-ADGroupMember $gdl_ecole_f -Members $gu_ecole
        }
       

 

        ################## CLASSES ######################"
        $existeclasse=Get-ADOrganizationalUnit -SearchBase $chemingroupe -Filter {name -eq $gg_classe}
         if (!$existeclasse)
         {
        New-ADGroup -GroupCategory Security -GroupScope Global -Name $gg_classe -path $chemingroupe
        Add-ADGroupMember $gg_ecole -Members $gg_classe
        }
        
        
        $existeclasse=Get-ADOrganizationalUnit -SearchBase $chemingroupe -Filter {name -eq $gu_classe}
        if (!$existeclasse)
         {
        New-ADGroup -GroupCategory Security -GroupScope Universal -Name $gu_classe -path $chemingroupe
        Add-ADGroupMember $gu_classe -Members $gg_classe
        }
        
        
        $existe=Get-ADOrganizationalUnit -SearchBase $chemingroupe -Filter {name -eq $gdl_classe_r}
        if (!$existe)
        {
        New-ADGroup -GroupCategory Security -GroupScope DomainLocal -Name $gdl_classe_r -path $chemingroupe
        Add-ADGroupMember $gdl_classe_r -Members $gu_classe
        }
       
        
         $existe=Get-ADOrganizationalUnit -SearchBase $chemingroupe -Filter {name -eq $gdl_classe_rw}
        if (!$existe) {
        New-ADGroup -GroupCategory Security -GroupScope DomainLocal -Name $gdl_classe_rw -path $chemingroupe
        Add-ADGroupMember $gdl_classe_rw -Members $gu_classe
        }
        
         $existe=Get-ADOrganizationalUnit -SearchBase $chemingroupe -Filter {name -eq $gdl_classe_m}
        if (!$existe)
        
        {
        New-ADGroup -GroupCategory Security -GroupScope DomainLocal -Name $gdl_classe_m -path $chemingroupe
        Add-ADGroupMember $gdl_classe_m -Members $gu_classe
        }
       
        
         $existe=Get-ADOrganizationalUnit -SearchBase $chemingroupe -Filter {name -eq $gdl_classe_f}
        if (!$existe)
        {
        New-ADGroup -GroupCategory Security -GroupScope DomainLocal -Name $gdl_classe_f -path $chemingroupe
        Add-ADGroupMember $gdl_classe_f -Members $gu_classe
        }
       
        ####################### AJOUT DES IMBRICATIONS GROUPES ################
        ####################### GG=>GU>GDL_R RW M F############################
        #############IMBRICATION GG_CLASSE DANS LES ECOLES######
        
        

 

    }
     write-host "Groupes OK !"
     Start-Sleep -Seconds 300
 

    Add-ADGroupMember GU_TOUS -Members GG_TOUS
    Add-ADGroupMember GDL_TOUS_R -Members GU_TOUS
    Add-ADGroupMember GDL_TOUS_RW -Members GU_TOUS
}
function menu()
{       clear-host
        write-host "              MENU CHOIX PROJET CUBE"
        write-host ""
        write-host "     Saisir votre choix dans le menu suivant"
        write-host ""
        write-host "  1: CREATION DES UNITES D'ORGANISATION LOTS CSV"
        write-host "  2: CREATION DES GROUPES LOTS CSV"
        write-host "  3: CREATION DES UTILISATEURS LOTS CSV"
        write-host "  4: CREATION DES ORDIS LOTS CSV"
        write-host "  5: CREATION UNITAIRE OU"
        write-host "  6: CREATION UNITAIRE GROUPE"
        write-host "  7: CREATION UNITAIRE UTILISATEUR"
        write-host "  8: CREATION ORDIS EXPORT BINAIRE"
        write-host "  9: MENU AD GENERAL"
        write-host "  10: CREATION DOSSIERS ECOLES CLASSES ELEVES"
        write-host "  11: PERMISSIONS NTFS"
        write-host "  12: SUPPRESSION DOSSIERS"
        write-host "  13: SUPPRESSION AD"
        write-host "  9: MENU AD GENERAL"
        write-host "  Q: MENU AD GENERAL"
        write-host ""
        $choix=read-host "Votre choix SVP?"
        switch ($choix)
        {    1 {creation_ous($chemin);pause;menu}
             2 {creation_groupes($chemingroupe);pause;menu}
             3 {creation_utilisateurs;pause;menu}
             4 {creation_ordis;pause;menu}
             5 {creation_unitaire_OU;pause;menu}
             6 {creation_unitaire_groupe;pause;menu}
             7 {creation_unitaire_user;pause;menu}
             8 {creation_unitaire_ordi;pause;menu}
             9 {C:\ToolKIT\toolkit.ps1}
             10 {creation_dossiers;pause;menu}
             11{permis;pause;menu}
             12 {suppression_dossiers;pause;menu}
             13 {suppression;pause;menu}
             Q {exit}
             default {menu}
        }

 

}
menu
function creation_utilisateurs()
{
    $pass=ConvertTo-SecureString("Form@tion2021") -AsPlainText -Force
    
    foreach ($ligne in $liste)
    {
      $nom=$ligne.nom.toUpper()
      $prenom=$ligne.prenom.substring(0,1).toUpper()+$ligne.prenom.substring(1).toLower()
      $nomcomplet=$prenom+" "+$nom
      $sam=$prenom.toLower()+"."+$nom.toLower()
      $upn=$sam+"@"+$env:USERDNSDOMAIN
      $mail=$upn
      $ecole=$ligne.ecole
      $classe=$ligne.classe
      $groupe="GG_"+$ecole+"_"+$classe
      $fonction=$ligne.fonction.toUpper()
      
      if ($fonction -ne "Directeur")
         {$cheminuser="OU="+$fonction+",OU="+$classe+",OU="+$ecole+","+$chemin}
      else 
         {$cheminuser="OU="+$fonction+",OU="+$ecole+","+$chemin}

 

 

      ##### CREATION DE L'utilisateur ###############
      New-ADUser -name $nomcomplet -Surname $nom -GivenName $prenom `
      -DisplayName $nomcomplet -SamAccountName $sam -UserPrincipalName $upn `
      -Title $fonction -Department $classe -EmailAddress $mail `
      -AccountPassword $pass -ChangePasswordAtLogon $true `
      -enabled $true -path $cheminuser -Verbose

 

      ##### AJOUT UTILISATEURS A SON GG GROUPE ##########
      Add-ADGroupMember $groupe -Members $sam -Verbose
      
    }
    
}
function creation_dossiers()
{   ### Creation du dossier ecole dans le DFS ECOLES ET DIRECTEUR  ET CLASSES ELEVE ENSEIGNANT#####
    New-Item "C:\ecoles" -itemType Directory
    $cheminbase=(get-dfsnroot).path+"\ecoles\"
    foreach ($ligne in $liste)
    { $ecole=$ligne.ecole
      $chemintest=$cheminbase+$ecole
      $cheminecole=$cheminbase+$ecole+"\"  
      $existe=test-path -path $chemintest
      if (!$existe)
      {
      new-item -ItemType Directory -Name $ecole -Path $cheminbase
      $cheminecole=$cheminbase+$ecole
      new-item -ItemType Directory -Name Directeur -Path $cheminecole
      $chemindirecteur=$cheminecole+"\Directeur\"
      }
      $classe=$ligne.classe
      $chemintest=$cheminecole+$classe  
      $existe=test-path -path $chemintest
      ########## VARIABLES UTILES DANS LE CAS OU CLASSE EXISTE #######
      $cheminclasse=$cheminecole+"\"+$classe+"\"
      $chemineleve=$cheminclasse+"\Eleve\"
      
      if (!$existe)
      {
      new-item -ItemType Directory -Name $classe -Path $cheminecole
      $cheminclasse=$cheminecole+"\"+$classe+"\"
       ### Creation du dossier Eleve et Enseignant dans la Classe #####
      new-item -ItemType Directory -Name Eleve -Path $cheminclasse
      new-item -ItemType Directory -Name Enseignant -Path $cheminclasse
      $cheminenseignant=$cheminclasse+"\Enseignant\"
      $chemineleve=$cheminclasse+"\Eleve\"
      }
     ### Creation Des dossiers Perso (Eleve / Enseignant / Directeur) #####
    $fonction=$ligne.fonction
    $sam=$ligne.prenom.ToLower()+"."+$ligne.nom.ToLower()
    if ($fonction -eq "Eleve")
    {
    new-item -ItemType Directory -Name $sam -Path $chemineleve
    }
    if ($fonction -eq "Enseignant")
    {
    new-item -ItemType Directory -Name $sam -Path $cheminenseignant
    }
    if ($fonction -eq "Directeur")
    {
    new-item -ItemType Directory -Name $sam -Path $chemindirecteur
    }
    }
    
    
}
function permissions()
{ 
 foreach ($ligne in $liste)
 {  $ecole=$ligne.ecole
    $classe=$ligne.classe
    $cheminecole=(get-Dfsnroot).path+"\Ecoles\"
    $cheminclasse=$cheminecole+$ecole
    $chemineleve=$cheminclasse+"\"+$classe+"\Eleve\"
    
    $listedossierecole=Get-ChildItem -Path $cheminecole -Directory
    $listedossierclasse=Get-ChildItem -Path $cheminclasse -Directory
    $listedossiereleve=Get-ChildItem -Path $chemineleve -Directory


    #### POUR LES PERMISSIONS DES ECOLES ############
    foreach ($dossierecole in $listedossierecole)
    {
    $cheminecole=$dossierecole.fullname
    $acl=(get-item $cheminecole).GetAccessControl('Access')
        #### POUR LES PERMISSIONS DES CLASSES ############
        foreach ($dossierclasse in $listedossierclasse)
        {
        $cheminclasse=$dossierclasse.fullname
        $aclclasse=(get-item $cheminclasse).GetAccessControl('Access')
        $gdl="GDL_"+$dossierecole.name+"_"+$dossierclasse.name+"_RW"
        $ar=New-Object security.accesscontrol.filesystemaccessrule($gdl,'ReadAndExecute,Write','ContainerInherit,ObjectInherit','none','Allow')
        $aclclasse.SetAccessRule($ar)
        set-acl -Path $cheminclasse -AclObject $aclclasse -Verbose
        }
    $gdl="GDL_"+$dossierecole.name+"_RW"
    $ar=New-Object security.accesscontrol.filesystemaccessrule($gdl,'ReadAndExecute,Write','ContainerInherit,ObjectInherit','none','Allow')
    $acl.SetAccessRule($ar)
    set-acl -Path $cheminecole -AclObject $acl -Verbose

    }

   

    #### POUR LES PERMISSIONS DES ELEVES ############
    foreach ($dossier in $listedossiereleve)
    {
    $chemin=$dossier.fullname
    $acl=(get-item $chemin).GetAccessControl('Access')
    $nomuser=$dossier.name
    $ar=New-Object security.accesscontrol.filesystemaccessrule($nomuser,'Modify','ContainerInherit,ObjectInherit','none','Allow')
    $acl.SetAccessRule($ar)
    set-acl -Path $chemin -AclObject $acl -Verbose
    }

  
    }
}
Stop-Transcript