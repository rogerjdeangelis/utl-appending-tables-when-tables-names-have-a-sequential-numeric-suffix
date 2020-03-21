Appending tables when tables names have a sequential numeric sequence

github
https://tinyurl.com/qkkj3oe
https://github.com/rogerjdeangelis/utl-appending-tables-when-tables-names-have-a-sequential-numeric-suffix

When it works and when it does not;

Work on 'set' and 'merge',  statement with limitations.

Does not work on 'data' statement(ie data a1-a5).

Does not work with modify, update, sql, proc datasets, proc append?

Comments
   1. If you data is large but not big (over a 1TB). It is better to have
     'partitions', ie separate tables and use a view if you need to append
.
   2. With partitions you can mutitask. Most workstations and laptops are often more
      powerful than even the grid on an EG server.

SAS Forum
https://communities.sas.com/t5/Statistical-Procedures/bd-p/statistical_procedures

Novinosrin Profile
https://communities.sas.com/t5/user/viewprofilepage/user-id/138205

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

proc datasets lib=work kill;
run;quit;

data a1 a2 a3 a4 a5;
   set sashelp.class;
run;quit;

*         _           _             ____
 ___  ___| |_    __ _/ |       __ _| ___|
/ __|/ _ \ __|  / _` | |_____ / _` |___ \
\__ \  __/ |_  | (_| | |_____| (_| |___) |
|___/\___|\__|  \__,_|_|      \__,_|____/

;
data as;
  set a1-a5;   *== nice;
run;quit;

NOTE: There were 19 observations read from the data set SASHELP.CLASS.
NOTE: The data set WORK.A1 has 19 observations and 5 variables.
NOTE: The data set WORK.A2 has 19 observations and 5 variables.
NOTE: The data set WORK.A3 has 19 observations and 5 variables.
NOTE: The data set WORK.A4 has 19 observations and 5 variables.
NOTE: The data set WORK.A5 has 19 observations and 5 variables.
NOTE: DATA statement used (Total process time):

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

* Suppose a3 is missing;

proc datasets lib=work kill;
run;quit;

data a1 a2 a4 a5;
   set sashelp.class;
run;quit;

*         _           _             ____          _  _               ____
 ___  ___| |_    __ _/ |       __ _|___ \    __ _| || |         __ _| ___|
/ __|/ _ \ __|  / _` | |_____ / _` | __) |  / _` | || |_ _____ / _` |___ \
\__ \  __/ |_  | (_| | |_____| (_| |/ __/  | (_| |__   _|_____| (_| |___) |
|___/\___|\__|  \__,_|_|      \__,_|_____|  \__,_|  |_|        \__,_|____/

data as;
  set a1-a2 a4-a5; *==> nice;
run;quit;

NOTE: There were 19 observations read from the data set WORK.A1.
NOTE: There were 19 observations read from the data set WORK.A2.
                                                                  * no A3 nice;
NOTE: There were 19 observations read from the data set WORK.A4.
NOTE: There were 19 observations read from the data set WORK.A5.
NOTE: The data set WORK.AS has 76 observations and 5 variables.


*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

proc datasets lib=work kill;
run;quit;

data a1 a2 a3 a4 a5;
   set sashelp.class;
run;quit;

*                                      _             ____
 _ __ ___   ___ _ __ __ _  ___    __ _/ |       __ _| ___|
| '_ ` _ \ / _ \ '__/ _` |/ _ \  / _` | |_____ / _` |___ \
| | | | | |  __/ | | (_| |  __/ | (_| | |_____| (_| |___) |
|_| |_| |_|\___|_|  \__, |\___|  \__,_|_|      \__,_|____/
                    |___/
;

data mrg;
  merge a1-a5;
run;quit;


NOTE: There were 19 observations read from the data set WORK.A1.
NOTE: There were 19 observations read from the data set WORK.A2.
NOTE: There were 19 observations read from the data set WORK.A3.
NOTE: There were 19 observations read from the data set WORK.A4.
NOTE: There were 19 observations read from the data set WORK.A5.
NOTE: The data set WORK.MRG has 19 observations and 5 variables.


* Suppose a3 is missing;

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

proc datasets lib=work kill;
run;quit;

data a1 a2 a4 a5;
   set sashelp.class;
run;quit;

* __       _ _             _             ____
 / _| __ _(_) |___    __ _/ |       __ _| ___|
| |_ / _` | | / __|  / _` | |_____ / _` |___ \
|  _| (_| | | \__ \ | (_| | |_____| (_| |___) |
|_|  \__,_|_|_|___/  \__,_|_|      \__,_|____/

;

* when misssing one rable in the sequence;

data as;
  set a1-a5;
run;quit;

121   data as;

ERROR: File WORK.A3.DATA does not exist.   *==> nice error

122     set a1-a5; *==> nice;
123   run;


