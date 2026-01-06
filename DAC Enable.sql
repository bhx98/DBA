--Dedicated Administrator Connection (DAC)

--1: Enable DAC via SQL CMD OR SSMS

--Enable DAC VIA SQL CMD
Use master
GO
/* ۰ = Allow Local Connection, 1 = Allow Remote Connections*/
sp_configure 'remote admin connections', 1
GO
RECONFIGURE
GO
--Enable DAC VIA SSMS

--Right Click On SQL SERVER Instance->Facet->View Facets->Surface Area Configuration
-- >Remote Dac Enable=True
