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
##L8/UAdDXTlaDjofG5iZk2VnhQGElIMqJvLigxb2T8e/IqSzPTNpZCXVmgyDPHViBetchfMk3uN4SFU4WH8AkyJfkW8GAa4s2ovFwYeCamZE8F1/L3MDI4BqAxo3UDTBHbnnDX4t4Ow6VwXnYKw==
##Kc/BRM3KXhU=
##
##
##fd6a9f26a06ea3bc99616d4851b372ba
#########"SCRIPT permettant de signer un script powershell ############
######### En utilisant le certificat administrateur signe #############

$certificat=Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert
$nomduscript=Read-Host "votre nom de script à signer ?"
$timestampserver="http://timestamp.digicert.com"
#$nomduscript="./"+$nomduscript
write-host $nomduscript

###########Signature du script ###############

Set-AuthenticodeSignature $nomduscript -Certificate $certificat -TimestampServer $timestampserver
