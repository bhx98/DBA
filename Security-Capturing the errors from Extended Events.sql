IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='MonitorSuspiciousErrors')  
     DROP EVENT SESSION [MonitorSuspiciousErrors] ON SERVER 
  GO
  CREATE EVENT SESSION MonitorSuspiciousErrors
  ON SERVER
    ADD EVENT sqlserver.error_reported --the event we are interested in
      (ACTION --the general global fields ('actions') we want to receive
      (sqlserver.client_app_name, sqlserver.client_connection_id, sqlserver.[database_name],
      sqlserver.nt_username, sqlserver.sql_text, sqlserver.username)
       WHERE  --the filters that we want to use so and to get just the relevant errors
         error_number=(102) OR error_number=(105) OR error_number=(205) OR (error_number=(207) OR
       error_number=(208) OR error_number=(245) OR error_number=(2812) OR error_number=(18456) 
         OR sqlserver.like_i_sql_unicode_string([message],N'%permission%') 
         OR sqlserver.like_i_sql_unicode_string([message],N'%denied%')
       )
     )
    ADD TARGET package0.ring_buffer --define our data storage target
  WITH --all the optional parameters.
    (
    MAX_MEMORY = 4096KB, EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS,
    MAX_DISPATCH_LATENCY = 30 SECONDS, MAX_EVENT_SIZE = 0KB,
    MEMORY_PARTITION_MODE = NONE, TRACK_CAUSALITY = OFF, STARTUP_STATE = ON
    );
  GO


  ---ALTER EVENT SESSION MonitorSuspiciousErrors ON SERVER STATE = START;

  ---ALTER EVENT SESSION MonitorSuspiciousErrors ON SERVER STATE = STOP;

  DECLARE @Target_Data XML =
            (
            SELECT TOP 1 Cast(xet.target_data AS XML) AS targetdata
              FROM sys.dm_xe_session_targets AS xet
                INNER JOIN sys.dm_xe_sessions AS xes
                  ON xes.address = xet.event_session_address
              WHERE xes.name = 'MonitorSuspiciousErrors'
                AND xet.target_name = 'ring_buffer'
            );
  SELECT  Count(*) AS ErrorCount
  FROM @Target_Data.nodes('//RingBufferTarget/event') AS xed (event_data)
  WHERE DateDiff
       ( MINUTE,Convert
          (DATETIME2,
            SwitchOffset(
                Convert(DATETIMEOFFSET,xed.event_data.value('(@timestamp)[1]', 'datetime2')
                       ),
             DateName(TzOffset, SysDateTimeOffset())
                        )
             ),
          GetDate()
         ) <20;