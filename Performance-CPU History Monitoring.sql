;WITH XMLRecords AS (
SELECT 
         DATEADD (ms, r.[timestamp] - sys.ms_ticks,SYSDATETIME()) AS record_time
       , CAST(r.record AS XML) record
       FROM 
         sys.dm_os_ring_buffers r  
           CROSS JOIN 
         sys.dm_os_sys_info sys  
       WHERE   
         ring_buffer_type='RING_BUFFER_SCHEDULER_MONITOR' 
           AND 
         record LIKE '%<SystemHealth>%')
 SELECT 
   100-record.value('(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]', 'int') AS SystemUtilization
 , record.value('(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]', 'int') AS SQLProcessUtilization
 , record_time
 FROM XMLRecords;