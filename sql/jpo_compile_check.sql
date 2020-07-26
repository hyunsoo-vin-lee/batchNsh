select jpotocom.mxname,
       jpotocom.compile_flags,
       jpotocom.mxflags,
       adm.mxcrdate,
       adm.mxmoddate,
       'compile prog ' || jpotocom.mxname || ' update;' MQL
  from (select * 
          from (select mxoid,
                       mxname,
                       mxflags,
                       substr ((select lpad (REPLACE (MAX (SYS_CONNECT_BY_PATH (SIGN (BITAND (mxflags, POWER (2, (TRUNC (LOG (2, mxflags) + POWER (10, -20)) + 1 - LEVEL)))),',')),','),32,'0') BIT from DUAL connect by POWER (2, LEVEL - 1) <= mxflags), -9, 1) compile_flags, 
                       (select lpad (REPLACE (MAX (SYS_CONNECT_BY_PATH (SIGN (BITAND (mxflags, POWER (2, (TRUNC (LOG (2, mxflags) + POWER (10, -20)) + 1 - LEVEL)))),',')),','),32,'0') BIT from DUAL connect by POWER (2, LEVEL - 1) <= mxflags) dectobi 
                  from x3dspace.mxprogram prog 
                 where prog.mxismql = 0 -- ismqlprogram=false
                   and not exists (select prog1.mxoid 
                                     from x3dspace.mxprogram prog1 
                                    where prog1.mxname like '%.' || prog.mxname) -- no webservice
               ) jpotab
         where compile_flags = 0
           and substr(dectobi, -8, 1) = '1' -- isjavaprogram=true
           and substr(dectobi, -16, 1) = '1' -- hascode=true
         order by mxname desc) jpotocom,
       x3dspace.mxotheradmin adm
 where adm.mxoid=jpotocom.mxoid
;
