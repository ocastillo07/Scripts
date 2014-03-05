@PowerShell -Command Invoke-Expression $('$args=@(^&{$args} %*);'+[String]::Join(';',(Get-Content '%~f0') -notmatch '^^@PowerShell.*EOF$')) & goto :EOF
$passC1 = ConvertTo-SecureString "password" -AsPlainText -Force; 
$credC1 = New-Object System.Management.Automation.PSCredential("user", $passC1); 
$sC1 = new-pssession -ComputerName Cluster01 -credential $credC1;
$resC1 = invoke-command -session $sC1 -ScriptBlock {
get-Service DD_Clus* | ?{$_.name -like "DD_Cluster_Mon"}  | %{"$($_.status)"}
};
out-File -filepath C:\monitoreo\Clu01out.txt -inputobject $resC1 -encoding "ASCII";
Remove-PSSession $sC1;