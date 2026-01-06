--DAC 

--Connect To DAC Via SSMS
-->Before Instance Name needs to type Admin:(for example localhost)
-->Login:sa pass:***


-->Connect to DAC via SQLCMD
sqlcmd -S [server name] -U [user name] -P [password] -A

-->DAC lOGIN Linux
sqlcmd -I -S admin:localhost -U sa


