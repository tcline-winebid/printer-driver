 $outZip = 'C:\Windows\LTSvc\XeroxB610Drivers\'
 $finalUnzip = 'C:\Windows\LTSvc\FinalZip_Xerox\'
 $PrintDriver = "Xerox VersaLink B600 PCL6"
 $printPort = "192.168.40.168"
 $printName = "Xerox VersaLink B600"
 $repo = 'https://github.com/tcline-winebid/printer-driver/archive/8109db7ece3643f08ae7c454fa422ec3fc999905.zip'
 $repoOut = 'C:\Windows\LTSvc\VersaLink_B600_B605_B610_B615_7.95.0.0_PCL6_x64.zip'
 


 Expand-Archive -Path $repoOut -DestinationPath $outZip

 $contentsZip = (Get-ChildItem $outZip).name

 $zipName = Get-ChildItem $outZip\$contentsZip | where Name -Match ".zip"

 $actualZipName = $zipName.Name

 Expand-Archive $outZip\$contentsZip\$actualZipName -DestinationPath $finalUnzip

 pnputil.exe -i -a $finalUnzip\*.inf

Add-PrinterDriver $PrintDriver

Add-PrinterPort -Name $printPort -PrinterHostAddress $printPort

Add-Printer -Name $printName -DriverName $PrintDriver -PortName $printPort
