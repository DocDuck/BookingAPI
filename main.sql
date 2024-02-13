\cd ../var/lib/postgresql/mdata/
DROP SCHEMA IF EXISTS mimic; CREATE SCHEMA mimic;

-- -------------------------------------------------------------------------------
--
-- Create the MIMIC-III tables
--
-- -------------------------------------------------------------------------------

--------------------------------------------------------
--  File created - Thursday-November-28-2015
--------------------------------------------------------

-- If running scripts individually, you can set the schema where all tables are created as follows:
-- SET search_path TO mimiciii;

-- Restoring the search path to its default value can be accomplished as follows:
--  SET search_path TO "$user",public;

/* Set the mimic_data_dir variable to point to directory containing
   all .csv files. If using Docker, this should not be changed here.
   Rather, when running the docker container, use the -v option
   to have Docker mount a host volume to the container path /mimic_data
   as explained in the README file
*/


--------------------------------------------------------
--  DDL for Table ADMISSIONS
--------------------------------------------------------

DROP TABLE IF EXISTS ADMISSIONS CASCADE;
CREATE TABLE ADMISSIONS
(
  ROW_ID INT NOT NULL,
  SUBJECT_ID INT NOT NULL,
  HADM_ID INT NOT NULL,
  ADMITTIME TIMESTAMP(0) NOT NULL,
  DISCHTIME TIMESTAMP(0) NOT NULL,
  DEATHTIME TIMESTAMP(0),
  ADMISSION_TYPE VARCHAR(50) NOT NULL,
  ADMISSION_LOCATION VARCHAR(50) NOT NULL,
  DISCHARGE_LOCATION VARCHAR(50) NOT NULL,
  INSURANCE VARCHAR(255) NOT NULL,
  LANGUAGE VARCHAR(10),
  RELIGION VARCHAR(50),
  MARITAL_STATUS VARCHAR(50),
  ETHNICITY VARCHAR(200) NOT NULL,
  EDREGTIME TIMESTAMP(0),
  EDOUTTIME TIMESTAMP(0),
  DIAGNOSIS VARCHAR(255),
  HOSPITAL_EXPIRE_FLAG SMALLINT,
  HAS_CHARTEVENTS_DATA SMALLINT NOT NULL,
  CONSTRAINT adm_rowid_pk PRIMARY KEY (ROW_ID),
  CONSTRAINT adm_hadm_unique UNIQUE (HADM_ID)
) ;

--------------------------------------------------------
--  DDL for Table CALLOUT
--------------------------------------------------------

DROP TABLE IF EXISTS CALLOUT CASCADE;
CREATE TABLE CALLOUT
(
  ROW_ID INT NOT NULL,
  SUBJECT_ID INT NOT NULL,
  HADM_ID INT NOT NULL,
  SUBMIT_WARDID INT,
  SUBMIT_CAREUNIT VARCHAR(15),
  CURR_WARDID INT,
  CURR_CAREUNIT VARCHAR(15),
  CALLOUT_WARDID INT,
  CALLOUT_SERVICE VARCHAR(10) NOT NULL,
  REQUEST_TELE SMALLINT NOT NULL,
  REQUEST_RESP SMALLINT NOT NULL,
  REQUEST_CDIFF SMALLINT NOT NULL,
  REQUEST_MRSA SMALLINT NOT NULL,
  REQUEST_VRE SMALLINT NOT NULL,
  CALLOUT_STATUS VARCHAR(20) NOT NULL,
  CALLOUT_OUTCOME VARCHAR(20) NOT NULL,
  DISCHARGE_WARDID INT,
  ACKNOWLEDGE_STATUS VARCHAR(20) NOT NULL,
  CREATETIME TIMESTAMP(0) NOT NULL,
  UPDATETIME TIMESTAMP(0) NOT NULL,
  ACKNOWLEDGETIME TIMESTAMP(0),
  OUTCOMETIME TIMESTAMP(0) NOT NULL,
  FIRSTRESERVATIONTIME TIMESTAMP(0),
  CURRENTRESERVATIONTIME TIMESTAMP(0),
  CONSTRAINT callout_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table CAREGIVERS
--------------------------------------------------------

DROP TABLE IF EXISTS CAREGIVERS CASCADE;
CREATE TABLE CAREGIVERS
(
  ROW_ID INT NOT NULL,
	CGID INT NOT NULL,
	LABEL VARCHAR(15),
	DESCRIPTION VARCHAR(30),
	CONSTRAINT cg_rowid_pk  PRIMARY KEY (ROW_ID),
	CONSTRAINT cg_cgid_unique UNIQUE (CGID)
) ;

--------------------------------------------------------
--  DDL for Table CHARTEVENTS
--------------------------------------------------------

DROP TABLE IF EXISTS chartevents CASCADE;
CREATE TABLE chartevents
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ICUSTAY_ID INT,
	ITEMID INT,
	CHARTTIME TIMESTAMP(0),
	STORETIME TIMESTAMP(0),
	CGID INT,
	VALUE VARCHAR(255),
	VALUENUM DOUBLE PRECISION,
	VALUEUOM VARCHAR(50),
	WARNING INT,
	ERROR INT,
	RESULTSTATUS VARCHAR(50),
	STOPPED VARCHAR(50)
) PARTITION BY RANGE (itemid);

--------------------------------------------------------
--  PARTITION for Table CHARTEVENTS
--------------------------------------------------------


CREATE TABLE chartevents_1 PARTITION OF chartevents
    FOR VALUES FROM (1) TO (27); -- Percentage: 0.0 - Rows: 22204
CREATE TABLE chartevents_2 PARTITION OF chartevents
    FOR VALUES FROM (27) TO (28); -- Percentage: 0.2 - Rows: 737224
CREATE TABLE chartevents_3 PARTITION OF chartevents
    FOR VALUES FROM (28) TO (31); -- Percentage: 0.0 - Rows: 56235
CREATE TABLE chartevents_4 PARTITION OF chartevents
    FOR VALUES FROM (31) TO (32); -- Percentage: 0.4 - Rows: 1442406
CREATE TABLE chartevents_5 PARTITION OF chartevents
    FOR VALUES FROM (32) TO (33); -- Percentage: 0.3 - Rows: 878442
CREATE TABLE chartevents_6 PARTITION OF chartevents
    FOR VALUES FROM (33) TO (49); -- Percentage: 0.5 - Rows: 1659172
CREATE TABLE chartevents_7 PARTITION OF chartevents
    FOR VALUES FROM (49) TO (50); -- Percentage: 0.2 - Rows: 636690
CREATE TABLE chartevents_8 PARTITION OF chartevents
    FOR VALUES FROM (50) TO (51); -- Percentage: 0.1 - Rows: 285028
CREATE TABLE chartevents_9 PARTITION OF chartevents
    FOR VALUES FROM (51) TO (52); -- Percentage: 0.6 - Rows: 2096678
CREATE TABLE chartevents_10 PARTITION OF chartevents
    FOR VALUES FROM (52) TO (53); -- Percentage: 0.6 - Rows: 2072743
CREATE TABLE chartevents_11 PARTITION OF chartevents
    FOR VALUES FROM (53) TO (54); -- Percentage: 0.0 - Rows: 178
CREATE TABLE chartevents_12 PARTITION OF chartevents
    FOR VALUES FROM (54) TO (55); -- Percentage: 0.3 - Rows: 892239
CREATE TABLE chartevents_13 PARTITION OF chartevents
    FOR VALUES FROM (55) TO (80); -- Percentage: 0.4 - Rows: 1181039
CREATE TABLE chartevents_14 PARTITION OF chartevents
    FOR VALUES FROM (80) TO (81); -- Percentage: 0.3 - Rows: 1136214
CREATE TABLE chartevents_15 PARTITION OF chartevents
    FOR VALUES FROM (81) TO (113); -- Percentage: 1.0 - Rows: 3418901
CREATE TABLE chartevents_16 PARTITION OF chartevents
    FOR VALUES FROM (113) TO (114); -- Percentage: 0.4 - Rows: 1198681
CREATE TABLE chartevents_17 PARTITION OF chartevents
    FOR VALUES FROM (114) TO (128); -- Percentage: 0.3 - Rows: 1111444
CREATE TABLE chartevents_18 PARTITION OF chartevents
    FOR VALUES FROM (128) TO (129); -- Percentage: 1.0 - Rows: 3216866
CREATE TABLE chartevents_19 PARTITION OF chartevents
    FOR VALUES FROM (129) TO (154); -- Percentage: 0.5 - Rows: 1669170
CREATE TABLE chartevents_20 PARTITION OF chartevents
    FOR VALUES FROM (154) TO (155); -- Percentage: 0.2 - Rows: 818852
CREATE TABLE chartevents_21 PARTITION OF chartevents
    FOR VALUES FROM (155) TO (159); -- Percentage: 0.3 - Rows: 974476
CREATE TABLE chartevents_22 PARTITION OF chartevents
    FOR VALUES FROM (159) TO (160); -- Percentage: 0.8 - Rows: 2544519
CREATE TABLE chartevents_23 PARTITION OF chartevents
    FOR VALUES FROM (160) TO (161); -- Percentage: 0.0 - Rows: 9458
CREATE TABLE chartevents_24 PARTITION OF chartevents
    FOR VALUES FROM (161) TO (162); -- Percentage: 1.0 - Rows: 3236350
CREATE TABLE chartevents_25 PARTITION OF chartevents
    FOR VALUES FROM (162) TO (184); -- Percentage: 0.6 - Rows: 1837071
CREATE TABLE chartevents_26 PARTITION OF chartevents
    FOR VALUES FROM (184) TO (185); -- Percentage: 0.3 - Rows: 954139
CREATE TABLE chartevents_27 PARTITION OF chartevents
    FOR VALUES FROM (185) TO (198); -- Percentage: 0.4 - Rows: 1456328
CREATE TABLE chartevents_28 PARTITION OF chartevents
    FOR VALUES FROM (198) TO (199); -- Percentage: 0.3 - Rows: 945638
CREATE TABLE chartevents_29 PARTITION OF chartevents
    FOR VALUES FROM (199) TO (210); -- Percentage: 0.5 - Rows: 1545176
CREATE TABLE chartevents_30 PARTITION OF chartevents
    FOR VALUES FROM (210) TO (211); -- Percentage: 0.3 - Rows: 955452
CREATE TABLE chartevents_31 PARTITION OF chartevents
    FOR VALUES FROM (211) TO (212); -- Percentage: 1.6 - Rows: 5180809
CREATE TABLE chartevents_32 PARTITION OF chartevents
    FOR VALUES FROM (212) TO (213); -- Percentage: 1.0 - Rows: 3303151
CREATE TABLE chartevents_33 PARTITION OF chartevents
    FOR VALUES FROM (213) TO (250); -- Percentage: 1.1 - Rows: 3676785
CREATE TABLE chartevents_34 PARTITION OF chartevents
    FOR VALUES FROM (250) TO (425); -- Percentage: 2.4 - Rows: 7811955
CREATE TABLE chartevents_35 PARTITION OF chartevents
    FOR VALUES FROM (425) TO (426); -- Percentage: 0.2 - Rows: 783762
CREATE TABLE chartevents_36 PARTITION OF chartevents
    FOR VALUES FROM (426) TO (428); -- Percentage: 0.1 - Rows: 402022
CREATE TABLE chartevents_37 PARTITION OF chartevents
    FOR VALUES FROM (428) TO (429); -- Percentage: 0.2 - Rows: 786544
CREATE TABLE chartevents_38 PARTITION OF chartevents
    FOR VALUES FROM (429) TO (432); -- Percentage: 0.1 - Rows: 349997
CREATE TABLE chartevents_39 PARTITION OF chartevents
    FOR VALUES FROM (432) TO (433); -- Percentage: 0.3 - Rows: 1032728
CREATE TABLE chartevents_40 PARTITION OF chartevents
    FOR VALUES FROM (433) TO (454); -- Percentage: 0.5 - Rows: 1589945
CREATE TABLE chartevents_41 PARTITION OF chartevents
    FOR VALUES FROM (454) TO (455); -- Percentage: 0.3 - Rows: 950038
CREATE TABLE chartevents_42 PARTITION OF chartevents
    FOR VALUES FROM (455) TO (456); -- Percentage: 0.5 - Rows: 1579681
CREATE TABLE chartevents_43 PARTITION OF chartevents
    FOR VALUES FROM (456) TO (457); -- Percentage: 0.5 - Rows: 1553537
CREATE TABLE chartevents_44 PARTITION OF chartevents
    FOR VALUES FROM (457) TO (467); -- Percentage: 0.1 - Rows: 392595
CREATE TABLE chartevents_45 PARTITION OF chartevents
    FOR VALUES FROM (467) TO (468); -- Percentage: 0.3 - Rows: 1155571
CREATE TABLE chartevents_46 PARTITION OF chartevents
    FOR VALUES FROM (468) TO (478); -- Percentage: 0.3 - Rows: 985720
CREATE TABLE chartevents_47 PARTITION OF chartevents
    FOR VALUES FROM (478) TO (479); -- Percentage: 0.2 - Rows: 774157
CREATE TABLE chartevents_48 PARTITION OF chartevents
    FOR VALUES FROM (479) TO (480); -- Percentage: 0.3 - Rows: 917780
CREATE TABLE chartevents_49 PARTITION OF chartevents
    FOR VALUES FROM (480) TO (547); -- Percentage: 1.4 - Rows: 4595328
CREATE TABLE chartevents_50 PARTITION OF chartevents
    FOR VALUES FROM (547) TO (548); -- Percentage: 0.3 - Rows: 852968
CREATE TABLE chartevents_51 PARTITION OF chartevents
    FOR VALUES FROM (548) TO (550); -- Percentage: 0.3 - Rows: 883558
CREATE TABLE chartevents_52 PARTITION OF chartevents
    FOR VALUES FROM (550) TO (551); -- Percentage: 1.0 - Rows: 3205052
CREATE TABLE chartevents_53 PARTITION OF chartevents
    FOR VALUES FROM (551) TO (581); -- Percentage: 0.3 - Rows: 1022222
CREATE TABLE chartevents_54 PARTITION OF chartevents
    FOR VALUES FROM (581) TO (582); -- Percentage: 0.5 - Rows: 1641889
CREATE TABLE chartevents_55 PARTITION OF chartevents
    FOR VALUES FROM (582) TO (593); -- Percentage: 0.5 - Rows: 1654497
CREATE TABLE chartevents_56 PARTITION OF chartevents
    FOR VALUES FROM (593) TO (594); -- Percentage: 0.2 - Rows: 784361
CREATE TABLE chartevents_57 PARTITION OF chartevents
    FOR VALUES FROM (594) TO (599); -- Percentage: 0.3 - Rows: 913144
CREATE TABLE chartevents_58 PARTITION OF chartevents
    FOR VALUES FROM (599) TO (600); -- Percentage: 0.2 - Rows: 787137
CREATE TABLE chartevents_59 PARTITION OF chartevents
    FOR VALUES FROM (600) TO (614); -- Percentage: 0.4 - Rows: 1251345
CREATE TABLE chartevents_60 PARTITION OF chartevents
    FOR VALUES FROM (614) TO (617); -- Percentage: 0.2 - Rows: 774906
CREATE TABLE chartevents_61 PARTITION OF chartevents
    FOR VALUES FROM (617) TO (618); -- Percentage: 0.3 - Rows: 962191
CREATE TABLE chartevents_62 PARTITION OF chartevents
    FOR VALUES FROM (618) TO (619); -- Percentage: 1.0 - Rows: 3386719
CREATE TABLE chartevents_63 PARTITION OF chartevents
    FOR VALUES FROM (619) TO (621); -- Percentage: 0.2 - Rows: 580529
CREATE TABLE chartevents_64 PARTITION OF chartevents
    FOR VALUES FROM (621) TO (622); -- Percentage: 0.2 - Rows: 666496
CREATE TABLE chartevents_65 PARTITION OF chartevents
    FOR VALUES FROM (622) TO (637); -- Percentage: 0.6 - Rows: 2048955
CREATE TABLE chartevents_66 PARTITION OF chartevents
    FOR VALUES FROM (637) TO (638); -- Percentage: 0.3 - Rows: 954354
CREATE TABLE chartevents_67 PARTITION OF chartevents
    FOR VALUES FROM (638) TO (640); -- Percentage: 0.0 - Rows: 437
CREATE TABLE chartevents_68 PARTITION OF chartevents
    FOR VALUES FROM (640) TO (646); -- Percentage: 0.4 - Rows: 1447426
CREATE TABLE chartevents_69 PARTITION OF chartevents
    FOR VALUES FROM (646) TO (647); -- Percentage: 1.0 - Rows: 3418917
CREATE TABLE chartevents_70 PARTITION OF chartevents
    FOR VALUES FROM (647) TO (663); -- Percentage: 0.6 - Rows: 2135542
CREATE TABLE chartevents_71 PARTITION OF chartevents
    FOR VALUES FROM (663) TO (664); -- Percentage: 0.2 - Rows: 774213
CREATE TABLE chartevents_72 PARTITION OF chartevents
    FOR VALUES FROM (664) TO (674); -- Percentage: 0.1 - Rows: 300570
CREATE TABLE chartevents_73 PARTITION OF chartevents
    FOR VALUES FROM (674) TO (675); -- Percentage: 0.3 - Rows: 1042512
CREATE TABLE chartevents_74 PARTITION OF chartevents
    FOR VALUES FROM (675) TO (677); -- Percentage: 0.1 - Rows: 378549
CREATE TABLE chartevents_75 PARTITION OF chartevents
    FOR VALUES FROM (677) TO (678); -- Percentage: 0.2 - Rows: 772277
CREATE TABLE chartevents_76 PARTITION OF chartevents
    FOR VALUES FROM (678) TO (679); -- Percentage: 0.2 - Rows: 773891
CREATE TABLE chartevents_77 PARTITION OF chartevents
    FOR VALUES FROM (679) TO (680); -- Percentage: 0.1 - Rows: 376047
CREATE TABLE chartevents_78 PARTITION OF chartevents
    FOR VALUES FROM (680) TO (681); -- Percentage: 0.2 - Rows: 740176
CREATE TABLE chartevents_79 PARTITION OF chartevents
    FOR VALUES FROM (681) TO (704); -- Percentage: 0.3 - Rows: 1099236
CREATE TABLE chartevents_80 PARTITION OF chartevents
    FOR VALUES FROM (704) TO (705); -- Percentage: 0.3 - Rows: 933238
CREATE TABLE chartevents_81 PARTITION OF chartevents
    FOR VALUES FROM (705) TO (706); -- Percentage: 0.0 - Rows: 20754
CREATE TABLE chartevents_82 PARTITION OF chartevents
    FOR VALUES FROM (706) TO (707); -- Percentage: 0.2 - Rows: 727719
CREATE TABLE chartevents_83 PARTITION OF chartevents
    FOR VALUES FROM (707) TO (708); -- Percentage: 0.3 - Rows: 937064
CREATE TABLE chartevents_84 PARTITION OF chartevents
    FOR VALUES FROM (708) TO (723); -- Percentage: 0.3 - Rows: 1049706
CREATE TABLE chartevents_85 PARTITION OF chartevents
    FOR VALUES FROM (723) TO (724); -- Percentage: 0.3 - Rows: 952177
CREATE TABLE chartevents_86 PARTITION OF chartevents
    FOR VALUES FROM (724) TO (742); -- Percentage: 0.1 - Rows: 321012
CREATE TABLE chartevents_87 PARTITION OF chartevents
    FOR VALUES FROM (742) TO (743); -- Percentage: 1.0 - Rows: 3464326
CREATE TABLE chartevents_88 PARTITION OF chartevents
    FOR VALUES FROM (743) TO (834); -- Percentage: 1.8 - Rows: 5925297
CREATE TABLE chartevents_89 PARTITION OF chartevents
    FOR VALUES FROM (834) TO (835); -- Percentage: 0.5 - Rows: 1716561
CREATE TABLE chartevents_90 PARTITION OF chartevents
    FOR VALUES FROM (835) TO (1046); -- Percentage: 0.4 - Rows: 1417336
CREATE TABLE chartevents_91 PARTITION OF chartevents
    FOR VALUES FROM (1046) TO (1047); -- Percentage: 0.2 - Rows: 803816
CREATE TABLE chartevents_92 PARTITION OF chartevents
    FOR VALUES FROM (1047) TO (1087); -- Percentage: 0.1 - Rows: 423898
CREATE TABLE chartevents_93 PARTITION OF chartevents
    FOR VALUES FROM (1087) TO (1088); -- Percentage: 0.2 - Rows: 592344
CREATE TABLE chartevents_94 PARTITION OF chartevents
    FOR VALUES FROM (1088) TO (1125); -- Percentage: 0.1 - Rows: 250247
CREATE TABLE chartevents_95 PARTITION OF chartevents
    FOR VALUES FROM (1125) TO (1126); -- Percentage: 0.9 - Rows: 2955851
CREATE TABLE chartevents_96 PARTITION OF chartevents
    FOR VALUES FROM (1126) TO (1337); -- Percentage: 0.2 - Rows: 808725
CREATE TABLE chartevents_97 PARTITION OF chartevents
    FOR VALUES FROM (1337) TO (1338); -- Percentage: 0.3 - Rows: 1083809
CREATE TABLE chartevents_98 PARTITION OF chartevents
    FOR VALUES FROM (1338) TO (1484); -- Percentage: 0.4 - Rows: 1281335
CREATE TABLE chartevents_99 PARTITION OF chartevents
    FOR VALUES FROM (1484) TO (1485); -- Percentage: 0.7 - Rows: 2261065
CREATE TABLE chartevents_100 PARTITION OF chartevents
    FOR VALUES FROM (1485) TO (1703); -- Percentage: 1.1 - Rows: 3561885
CREATE TABLE chartevents_101 PARTITION OF chartevents
    FOR VALUES FROM (1703) TO (1704); -- Percentage: 0.4 - Rows: 1174868
CREATE TABLE chartevents_102 PARTITION OF chartevents
    FOR VALUES FROM (1704) TO (1800); -- Percentage: 0.1 - Rows: 293325
CREATE TABLE chartevents_103 PARTITION OF chartevents
    FOR VALUES FROM (1800) TO (2500); -- Percentage: 0.1 - Rows: 249776
CREATE TABLE chartevents_104 PARTITION OF chartevents
    FOR VALUES FROM (2500) TO (3327); -- Percentage: 0.9 - Rows: 3010424
CREATE TABLE chartevents_105 PARTITION OF chartevents
    FOR VALUES FROM (3327) TO (3328); -- Percentage: 0.2 - Rows: 679113
CREATE TABLE chartevents_106 PARTITION OF chartevents
    FOR VALUES FROM (3328) TO (3420); -- Percentage: 1.6 - Rows: 5208156
CREATE TABLE chartevents_107 PARTITION OF chartevents
    FOR VALUES FROM (3420) TO (3421); -- Percentage: 0.2 - Rows: 673719
CREATE TABLE chartevents_108 PARTITION OF chartevents
    FOR VALUES FROM (3421) TO (3450); -- Percentage: 0.8 - Rows: 2785057
CREATE TABLE chartevents_109 PARTITION OF chartevents
    FOR VALUES FROM (3450) TO (3451); -- Percentage: 0.5 - Rows: 1687886
CREATE TABLE chartevents_110 PARTITION OF chartevents
    FOR VALUES FROM (3451) TO (3500); -- Percentage: 0.7 - Rows: 2445808
CREATE TABLE chartevents_111 PARTITION OF chartevents
    FOR VALUES FROM (3500) TO (3550); -- Percentage: 0.7 - Rows: 2433936
CREATE TABLE chartevents_112 PARTITION OF chartevents
    FOR VALUES FROM (3550) TO (3603); -- Percentage: 1.3 - Rows: 4449487
CREATE TABLE chartevents_113 PARTITION OF chartevents
    FOR VALUES FROM (3603) TO (3604); -- Percentage: 0.5 - Rows: 1676872
CREATE TABLE chartevents_114 PARTITION OF chartevents
    FOR VALUES FROM (3604) TO (3609); -- Percentage: 0.1 - Rows: 476670
CREATE TABLE chartevents_115 PARTITION OF chartevents
    FOR VALUES FROM (3609) TO (3610); -- Percentage: 0.5 - Rows: 1621393
CREATE TABLE chartevents_116 PARTITION OF chartevents
    FOR VALUES FROM (3610) TO (3645); -- Percentage: 0.7 - Rows: 2309226
CREATE TABLE chartevents_117 PARTITION OF chartevents
    FOR VALUES FROM (3645) TO (3646); -- Percentage: 0.2 - Rows: 690295
CREATE TABLE chartevents_118 PARTITION OF chartevents
    FOR VALUES FROM (3646) TO (3656); -- Percentage: 0.3 - Rows: 1009254
CREATE TABLE chartevents_119 PARTITION OF chartevents
    FOR VALUES FROM (3656) TO (3657); -- Percentage: 0.2 - Rows: 803881
CREATE TABLE chartevents_120 PARTITION OF chartevents
    FOR VALUES FROM (3657) TO (3700); -- Percentage: 0.7 - Rows: 2367096
CREATE TABLE chartevents_121 PARTITION OF chartevents
    FOR VALUES FROM (3700) TO (5813); -- Percentage: 0.4 - Rows: 1360432
CREATE TABLE chartevents_122 PARTITION OF chartevents
    FOR VALUES FROM (5813) TO (5814); -- Percentage: 0.3 - Rows: 982518
CREATE TABLE chartevents_123 PARTITION OF chartevents
    FOR VALUES FROM (5814) TO (5815); -- Percentage: 0.2 - Rows: 655454
CREATE TABLE chartevents_124 PARTITION OF chartevents
    FOR VALUES FROM (5815) TO (5816); -- Percentage: 0.5 - Rows: 1807316
CREATE TABLE chartevents_125 PARTITION OF chartevents
    FOR VALUES FROM (5816) TO (5817); -- Percentage: 0.0 - Rows: 34909
CREATE TABLE chartevents_126 PARTITION OF chartevents
    FOR VALUES FROM (5817) TO (5818); -- Percentage: 0.4 - Rows: 1378959
CREATE TABLE chartevents_127 PARTITION OF chartevents
    FOR VALUES FROM (5818) TO (5819); -- Percentage: 0.1 - Rows: 178112
CREATE TABLE chartevents_128 PARTITION OF chartevents
    FOR VALUES FROM (5819) TO (5820); -- Percentage: 0.5 - Rows: 1772387
CREATE TABLE chartevents_129 PARTITION OF chartevents
    FOR VALUES FROM (5820) TO (5821); -- Percentage: 0.5 - Rows: 1802684
CREATE TABLE chartevents_130 PARTITION OF chartevents
    FOR VALUES FROM (5821) TO (8000); -- Percentage: 0.5 - Rows: 1622363
CREATE TABLE chartevents_131 PARTITION OF chartevents
    FOR VALUES FROM (8000) TO (8367); -- Percentage: 0.0 - Rows: 43749
CREATE TABLE chartevents_132 PARTITION OF chartevents
    FOR VALUES FROM (8367) TO (8368); -- Percentage: 0.2 - Rows: 601818
CREATE TABLE chartevents_133 PARTITION OF chartevents
    FOR VALUES FROM (8368) TO (8369); -- Percentage: 0.6 - Rows: 2085994
CREATE TABLE chartevents_134 PARTITION OF chartevents
    FOR VALUES FROM (8369) TO (8441); -- Percentage: 1.6 - Rows: 5266438
CREATE TABLE chartevents_135 PARTITION OF chartevents
    FOR VALUES FROM (8441) TO (8442); -- Percentage: 0.5 - Rows: 1573583
CREATE TABLE chartevents_136 PARTITION OF chartevents
    FOR VALUES FROM (8442) TO (8480); -- Percentage: 1.2 - Rows: 3870155
CREATE TABLE chartevents_137 PARTITION OF chartevents
    FOR VALUES FROM (8480) TO (8481); -- Percentage: 0.2 - Rows: 719203
CREATE TABLE chartevents_138 PARTITION OF chartevents
    FOR VALUES FROM (8481) TO (8518); -- Percentage: 0.5 - Rows: 1600973
CREATE TABLE chartevents_139 PARTITION OF chartevents
    FOR VALUES FROM (8518) TO (8519); -- Percentage: 0.5 - Rows: 1687615
CREATE TABLE chartevents_140 PARTITION OF chartevents
    FOR VALUES FROM (8519) TO (8532); -- Percentage: 0.3 - Rows: 1146136
CREATE TABLE chartevents_141 PARTITION OF chartevents
    FOR VALUES FROM (8532) TO (8533); -- Percentage: 0.5 - Rows: 1619782
CREATE TABLE chartevents_142 PARTITION OF chartevents
    FOR VALUES FROM (8533) TO (8537); -- Percentage: 0.1 - Rows: 204405
CREATE TABLE chartevents_143 PARTITION OF chartevents
    FOR VALUES FROM (8537) TO (8538); -- Percentage: 0.2 - Rows: 725866
CREATE TABLE chartevents_144 PARTITION OF chartevents
    FOR VALUES FROM (8538) TO (8547); -- Percentage: 0.0 - Rows: 302
CREATE TABLE chartevents_145 PARTITION OF chartevents
    FOR VALUES FROM (8547) TO (8548); -- Percentage: 0.3 - Rows: 976252
CREATE TABLE chartevents_146 PARTITION OF chartevents
    FOR VALUES FROM (8548) TO (8549); -- Percentage: 0.2 - Rows: 649745
CREATE TABLE chartevents_147 PARTITION OF chartevents
    FOR VALUES FROM (8549) TO (8550); -- Percentage: 0.5 - Rows: 1804988
CREATE TABLE chartevents_148 PARTITION OF chartevents
    FOR VALUES FROM (8550) TO (8551); -- Percentage: 0.0 - Rows: 33554
CREATE TABLE chartevents_149 PARTITION OF chartevents
    FOR VALUES FROM (8551) TO (8552); -- Percentage: 0.4 - Rows: 1375295
CREATE TABLE chartevents_150 PARTITION OF chartevents
    FOR VALUES FROM (8552) TO (8553); -- Percentage: 0.1 - Rows: 174222
CREATE TABLE chartevents_151 PARTITION OF chartevents
    FOR VALUES FROM (8553) TO (8554); -- Percentage: 0.5 - Rows: 1769925
CREATE TABLE chartevents_152 PARTITION OF chartevents
    FOR VALUES FROM (8554) TO (8555); -- Percentage: 0.5 - Rows: 1796313
CREATE TABLE chartevents_153 PARTITION OF chartevents
    FOR VALUES FROM (8555) TO (220000); -- Percentage: 0.0 - Rows: 18753
CREATE TABLE chartevents_154 PARTITION OF chartevents
    FOR VALUES FROM (220000) TO (220045); -- Percentage:  - Rows:
CREATE TABLE chartevents_155 PARTITION OF chartevents
    FOR VALUES FROM (220045) TO (220046); -- Percentage: 0.8 - Rows: 2762225
CREATE TABLE chartevents_156 PARTITION OF chartevents
    FOR VALUES FROM (220046) TO (220048); -- Percentage: 0.1 - Rows: 431909
CREATE TABLE chartevents_157 PARTITION OF chartevents
    FOR VALUES FROM (220048) TO (220049); -- Percentage: 0.6 - Rows: 2023672
CREATE TABLE chartevents_158 PARTITION OF chartevents
    FOR VALUES FROM (220049) TO (220050); -- Percentage:  - Rows:
CREATE TABLE chartevents_159 PARTITION OF chartevents
    FOR VALUES FROM (220050) TO (220051); -- Percentage: 0.3 - Rows: 1149788
CREATE TABLE chartevents_160 PARTITION OF chartevents
    FOR VALUES FROM (220051) TO (220052); -- Percentage: 0.3 - Rows: 1149537
CREATE TABLE chartevents_161 PARTITION OF chartevents
    FOR VALUES FROM (220052) TO (220053); -- Percentage: 0.3 - Rows: 1156173
CREATE TABLE chartevents_162 PARTITION OF chartevents
    FOR VALUES FROM (220053) TO (220074); -- Percentage: 0.2 - Rows: 648200
CREATE TABLE chartevents_163 PARTITION OF chartevents
    FOR VALUES FROM (220074) TO (220179); -- Percentage: 0.2 - Rows: 526472
CREATE TABLE chartevents_164 PARTITION OF chartevents
    FOR VALUES FROM (220179) TO (220180); -- Percentage: 0.4 - Rows: 1290488
CREATE TABLE chartevents_165 PARTITION OF chartevents
    FOR VALUES FROM (220180) TO (220181); -- Percentage: 0.4 - Rows: 1289885
CREATE TABLE chartevents_166 PARTITION OF chartevents
    FOR VALUES FROM (220181) TO (220182); -- Percentage: 0.4 - Rows: 1292916
CREATE TABLE chartevents_167 PARTITION OF chartevents
    FOR VALUES FROM (220182) TO (220210); -- Percentage: 0.0 - Rows: 208
CREATE TABLE chartevents_168 PARTITION OF chartevents
    FOR VALUES FROM (220210) TO (220211); -- Percentage: 0.8 - Rows: 2737105
CREATE TABLE chartevents_169 PARTITION OF chartevents
    FOR VALUES FROM (220211) TO (220277); -- Percentage: 0.1 - Rows: 466344
CREATE TABLE chartevents_170 PARTITION OF chartevents
    FOR VALUES FROM (220277) TO (220278); -- Percentage: 0.8 - Rows: 2671816
CREATE TABLE chartevents_171 PARTITION OF chartevents
    FOR VALUES FROM (220278) TO (222000); -- Percentage: 1.0 - Rows: 3262258
CREATE TABLE chartevents_172 PARTITION OF chartevents
    FOR VALUES FROM (222000) TO (223792); -- Percentage: 1.2 - Rows: 4068153
CREATE TABLE chartevents_173 PARTITION OF chartevents
    FOR VALUES FROM (223792) TO (223793); -- Percentage: 0.2 - Rows: 765274
CREATE TABLE chartevents_174 PARTITION OF chartevents
    FOR VALUES FROM (223793) TO (223800); -- Percentage: 0.3 - Rows: 1139355
CREATE TABLE chartevents_175 PARTITION OF chartevents
    FOR VALUES FROM (223800) TO (223850); -- Percentage: 0.6 - Rows: 1983602
CREATE TABLE chartevents_176 PARTITION OF chartevents
    FOR VALUES FROM (223850) TO (223900); -- Percentage: 0.7 - Rows: 2185541
CREATE TABLE chartevents_177 PARTITION OF chartevents
    FOR VALUES FROM (223900) TO (223912); -- Percentage: 1.1 - Rows: 3552998
CREATE TABLE chartevents_178 PARTITION OF chartevents
    FOR VALUES FROM (223912) TO (223925); -- Percentage: 0.7 - Rows: 2289753
CREATE TABLE chartevents_179 PARTITION OF chartevents
    FOR VALUES FROM (223925) TO (223950); -- Percentage: 0.5 - Rows: 1610057
CREATE TABLE chartevents_180 PARTITION OF chartevents
    FOR VALUES FROM (223950) TO (223974); -- Percentage: 0.1 - Rows: 395061
CREATE TABLE chartevents_181 PARTITION OF chartevents
    FOR VALUES FROM (223974) TO (224000); -- Percentage: 1.5 - Rows: 4797667
CREATE TABLE chartevents_182 PARTITION OF chartevents
    FOR VALUES FROM (224000) TO (224020); -- Percentage: 1.0 - Rows: 3317320
CREATE TABLE chartevents_183 PARTITION OF chartevents
    FOR VALUES FROM (224020) TO (224040); -- Percentage: 0.8 - Rows: 2611372
CREATE TABLE chartevents_184 PARTITION OF chartevents
    FOR VALUES FROM (224040) TO (224080); -- Percentage: 1.2 - Rows: 4089672
CREATE TABLE chartevents_185 PARTITION OF chartevents
    FOR VALUES FROM (224080) TO (224083); -- Percentage: 0.5 - Rows: 1559194
CREATE TABLE chartevents_186 PARTITION OF chartevents
    FOR VALUES FROM (224083) TO (224087); -- Percentage: 0.6 - Rows: 2089736
CREATE TABLE chartevents_187 PARTITION OF chartevents
    FOR VALUES FROM (224087) TO (224093); -- Percentage: 0.4 - Rows: 1465008
CREATE TABLE chartevents_188 PARTITION OF chartevents
    FOR VALUES FROM (224093) TO (224094); -- Percentage: 0.2 - Rows: 717326
CREATE TABLE chartevents_189 PARTITION OF chartevents
    FOR VALUES FROM (224094) TO (224300); -- Percentage: 0.9 - Rows: 2933324
CREATE TABLE chartevents_190 PARTITION OF chartevents
    FOR VALUES FROM (224300) TO (224642); -- Percentage: 0.9 - Rows: 3110922
CREATE TABLE chartevents_191 PARTITION OF chartevents
    FOR VALUES FROM (224642) TO (224643); -- Percentage: 0.2 - Rows: 618565
CREATE TABLE chartevents_192 PARTITION OF chartevents
    FOR VALUES FROM (224643) TO (224650); -- Percentage: 0.0 - Rows: 1165
CREATE TABLE chartevents_193 PARTITION OF chartevents
    FOR VALUES FROM (224650) TO (224651); -- Percentage: 0.6 - Rows: 1849287
CREATE TABLE chartevents_194 PARTITION OF chartevents
    FOR VALUES FROM (224651) TO (224700); -- Percentage: 1.2 - Rows: 4059618
CREATE TABLE chartevents_195 PARTITION OF chartevents
    FOR VALUES FROM (224700) TO (224800); -- Percentage: 1.0 - Rows: 3154406
CREATE TABLE chartevents_196 PARTITION OF chartevents
    FOR VALUES FROM (224800) TO (224900); -- Percentage: 0.9 - Rows: 2873716
CREATE TABLE chartevents_197 PARTITION OF chartevents
    FOR VALUES FROM (224900) TO (225000); -- Percentage: 0.8 - Rows: 2659813
CREATE TABLE chartevents_198 PARTITION OF chartevents
    FOR VALUES FROM (225000) TO (225500); -- Percentage: 1.1 - Rows: 3763143
CREATE TABLE chartevents_199 PARTITION OF chartevents
    FOR VALUES FROM (225500) TO (226000); -- Percentage: 0.5 - Rows: 1718572
CREATE TABLE chartevents_200 PARTITION OF chartevents
    FOR VALUES FROM (226000) TO (226500); -- Percentage: 0.8 - Rows: 2662741
CREATE TABLE chartevents_201 PARTITION OF chartevents
    FOR VALUES FROM (226500) TO (227000); -- Percentage: 0.5 - Rows: 1605091
CREATE TABLE chartevents_202 PARTITION OF chartevents
    FOR VALUES FROM (227000) TO (227500); -- Percentage: 1.7 - Rows: 5553957
CREATE TABLE chartevents_203 PARTITION OF chartevents
    FOR VALUES FROM (227500) TO (227958); -- Percentage: 1.7 - Rows: 5627006
CREATE TABLE chartevents_204 PARTITION OF chartevents
    FOR VALUES FROM (227958) TO (227959); -- Percentage: 0.2 - Rows: 716961
CREATE TABLE chartevents_205 PARTITION OF chartevents
    FOR VALUES FROM (227959) TO (227969); -- Percentage: 0.2 - Rows: 816157
CREATE TABLE chartevents_206 PARTITION OF chartevents
    FOR VALUES FROM (227969) TO (227970); -- Percentage: 0.6 - Rows: 1862707
CREATE TABLE chartevents_207 PARTITION OF chartevents
    FOR VALUES FROM (227970) TO (1000000); -- Percentage: 0.7 - Rows: 2313406

--------------------------------------------------------
--  DDL for Table CPTEVENTS
--------------------------------------------------------

DROP TABLE IF EXISTS CPTEVENTS CASCADE;
CREATE TABLE CPTEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	COSTCENTER VARCHAR(10) NOT NULL,
	CHARTDATE TIMESTAMP(0),
	CPT_CD VARCHAR(10) NOT NULL,
	CPT_NUMBER INT,
	CPT_SUFFIX VARCHAR(5),
	TICKET_ID_SEQ INT,
	SECTIONHEADER VARCHAR(50),
	SUBSECTIONHEADER VARCHAR(255),
	DESCRIPTION VARCHAR(200),
	CONSTRAINT cpt_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table DATETIMEEVENTS
--------------------------------------------------------

DROP TABLE IF EXISTS DATETIMEEVENTS CASCADE;
CREATE TABLE DATETIMEEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ICUSTAY_ID INT,
	ITEMID INT NOT NULL,
	CHARTTIME TIMESTAMP(0) NOT NULL,
	STORETIME TIMESTAMP(0) NOT NULL,
	CGID INT NOT NULL,
	VALUE TIMESTAMP(0),
	VALUEUOM VARCHAR(50) NOT NULL,
	WARNING SMALLINT,
	ERROR SMALLINT,
	RESULTSTATUS VARCHAR(50),
	STOPPED VARCHAR(50),
	CONSTRAINT datetime_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table DIAGNOSES_ICD
--------------------------------------------------------

DROP TABLE IF EXISTS DIAGNOSES_ICD CASCADE;
CREATE TABLE DIAGNOSES_ICD
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	SEQ_NUM INT,
	ICD9_CODE VARCHAR(10),
	CONSTRAINT diagnosesicd_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table DRGCODES
--------------------------------------------------------

DROP TABLE IF EXISTS DRGCODES CASCADE;
CREATE TABLE DRGCODES
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	DRG_TYPE VARCHAR(20) NOT NULL,
	DRG_CODE VARCHAR(20) NOT NULL,
	DESCRIPTION VARCHAR(255),
	DRG_SEVERITY SMALLINT,
	DRG_MORTALITY SMALLINT,
	CONSTRAINT drg_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table D_CPT
--------------------------------------------------------

DROP TABLE IF EXISTS D_CPT CASCADE;
CREATE TABLE D_CPT
(
  ROW_ID INT NOT NULL,
	CATEGORY SMALLINT NOT NULL,
	SECTIONRANGE VARCHAR(100) NOT NULL,
	SECTIONHEADER VARCHAR(50) NOT NULL,
	SUBSECTIONRANGE VARCHAR(100) NOT NULL,
	SUBSECTIONHEADER VARCHAR(255) NOT NULL,
	CODESUFFIX VARCHAR(5),
	MINCODEINSUBSECTION INT NOT NULL,
	MAXCODEINSUBSECTION INT NOT NULL,
	CONSTRAINT dcpt_ssrange_unique UNIQUE (SUBSECTIONRANGE),
	CONSTRAINT dcpt_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table D_ICD_DIAGNOSES
--------------------------------------------------------

DROP TABLE IF EXISTS D_ICD_DIAGNOSES CASCADE;
CREATE TABLE D_ICD_DIAGNOSES
(
  ROW_ID INT NOT NULL,
	ICD9_CODE VARCHAR(10) NOT NULL,
	SHORT_TITLE VARCHAR(50) NOT NULL,
	LONG_TITLE VARCHAR(255) NOT NULL,
	CONSTRAINT d_icd_diag_code_unique UNIQUE (ICD9_CODE),
	CONSTRAINT d_icd_diag_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table D_ICD_PROCEDURES
--------------------------------------------------------

DROP TABLE IF EXISTS D_ICD_PROCEDURES CASCADE;
CREATE TABLE D_ICD_PROCEDURES
(
  ROW_ID INT NOT NULL,
	ICD9_CODE VARCHAR(10) NOT NULL,
	SHORT_TITLE VARCHAR(50) NOT NULL,
	LONG_TITLE VARCHAR(255) NOT NULL,
	CONSTRAINT d_icd_proc_code_unique UNIQUE (ICD9_CODE),
	CONSTRAINT d_icd_proc_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table D_ITEMS
--------------------------------------------------------

DROP TABLE IF EXISTS D_ITEMS CASCADE;
CREATE TABLE D_ITEMS
(
  ROW_ID INT NOT NULL,
	ITEMID INT NOT NULL,
	LABEL VARCHAR(200),
	ABBREVIATION VARCHAR(100),
	DBSOURCE VARCHAR(20),
	LINKSTO VARCHAR(50),
	CATEGORY VARCHAR(100),
	UNITNAME VARCHAR(100),
	PARAM_TYPE VARCHAR(30),
	CONCEPTID INT,
	CONSTRAINT ditems_itemid_unique UNIQUE (ITEMID),
	CONSTRAINT ditems_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table D_LABITEMS
--------------------------------------------------------

DROP TABLE IF EXISTS D_LABITEMS CASCADE;
CREATE TABLE D_LABITEMS
(
  ROW_ID INT NOT NULL,
	ITEMID INT NOT NULL,
	LABEL VARCHAR(100) NOT NULL,
	FLUID VARCHAR(100) NOT NULL,
	CATEGORY VARCHAR(100) NOT NULL,
	LOINC_CODE VARCHAR(100),
	CONSTRAINT dlabitems_itemid_unique UNIQUE (ITEMID),
	CONSTRAINT dlabitems_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table ICUSTAYS
--------------------------------------------------------

DROP TABLE IF EXISTS ICUSTAYS CASCADE;
CREATE TABLE ICUSTAYS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	ICUSTAY_ID INT NOT NULL,
	DBSOURCE VARCHAR(20) NOT NULL,
	FIRST_CAREUNIT VARCHAR(20) NOT NULL,
	LAST_CAREUNIT VARCHAR(20) NOT NULL,
	FIRST_WARDID SMALLINT NOT NULL,
	LAST_WARDID SMALLINT NOT NULL,
	INTIME TIMESTAMP(0) NOT NULL,
	OUTTIME TIMESTAMP(0),
	LOS DOUBLE PRECISION,
	CONSTRAINT icustay_icustayid_unique UNIQUE (ICUSTAY_ID),
	CONSTRAINT icustay_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table INPUTEVENTS_CV
--------------------------------------------------------

DROP TABLE IF EXISTS INPUTEVENTS_CV CASCADE;
CREATE TABLE INPUTEVENTS_CV
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ICUSTAY_ID INT,
	CHARTTIME TIMESTAMP(0),
	ITEMID INT,
	AMOUNT DOUBLE PRECISION,
	AMOUNTUOM VARCHAR(30),
	RATE DOUBLE PRECISION,
	RATEUOM VARCHAR(30),
	STORETIME TIMESTAMP(0),
	CGID INT,
	ORDERID INT,
	LINKORDERID INT,
	STOPPED VARCHAR(30),
	NEWBOTTLE INT,
	ORIGINALAMOUNT DOUBLE PRECISION,
	ORIGINALAMOUNTUOM VARCHAR(30),
	ORIGINALROUTE VARCHAR(30),
	ORIGINALRATE DOUBLE PRECISION,
	ORIGINALRATEUOM VARCHAR(30),
	ORIGINALSITE VARCHAR(30),
	CONSTRAINT inputevents_cv_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table INPUTEVENTS_MV
--------------------------------------------------------

DROP TABLE IF EXISTS INPUTEVENTS_MV CASCADE;
CREATE TABLE INPUTEVENTS_MV
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ICUSTAY_ID INT,
	STARTTIME TIMESTAMP(0),
	ENDTIME TIMESTAMP(0),
	ITEMID INT,
	AMOUNT DOUBLE PRECISION,
	AMOUNTUOM VARCHAR(30),
	RATE DOUBLE PRECISION,
	RATEUOM VARCHAR(30),
	STORETIME TIMESTAMP(0),
	CGID INT,
	ORDERID INT,
	LINKORDERID INT,
	ORDERCATEGORYNAME VARCHAR(100),
	SECONDARYORDERCATEGORYNAME VARCHAR(100),
	ORDERCOMPONENTTYPEDESCRIPTION VARCHAR(200),
	ORDERCATEGORYDESCRIPTION VARCHAR(50),
	PATIENTWEIGHT DOUBLE PRECISION,
	TOTALAMOUNT DOUBLE PRECISION,
	TOTALAMOUNTUOM VARCHAR(50),
	ISOPENBAG SMALLINT,
	CONTINUEINNEXTDEPT SMALLINT,
	CANCELREASON SMALLINT,
	STATUSDESCRIPTION VARCHAR(30),
	COMMENTS_EDITEDBY VARCHAR(30),
	COMMENTS_CANCELEDBY VARCHAR(40),
	COMMENTS_DATE TIMESTAMP(0),
	ORIGINALAMOUNT DOUBLE PRECISION,
	ORIGINALRATE DOUBLE PRECISION,
	CONSTRAINT inputevents_mv_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table LABEVENTS
--------------------------------------------------------

DROP TABLE IF EXISTS LABEVENTS CASCADE;
CREATE TABLE LABEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ITEMID INT NOT NULL,
	CHARTTIME TIMESTAMP(0),
	VALUE VARCHAR(200),
	VALUENUM DOUBLE PRECISION,
	VALUEUOM VARCHAR(20),
	FLAG VARCHAR(20),
	CONSTRAINT labevents_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table MICROBIOLOGYEVENTS
--------------------------------------------------------

DROP TABLE IF EXISTS MICROBIOLOGYEVENTS CASCADE;
CREATE TABLE MICROBIOLOGYEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	CHARTDATE TIMESTAMP(0),
	CHARTTIME TIMESTAMP(0),
	SPEC_ITEMID INT,
	SPEC_TYPE_DESC VARCHAR(100),
	ORG_ITEMID INT,
	ORG_NAME VARCHAR(100),
	ISOLATE_NUM SMALLINT,
	AB_ITEMID INT,
	AB_NAME VARCHAR(30),
	DILUTION_TEXT VARCHAR(10),
	DILUTION_COMPARISON VARCHAR(20),
	DILUTION_VALUE DOUBLE PRECISION,
	INTERPRETATION VARCHAR(5),
	CONSTRAINT micro_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table NOTEEVENTS
--------------------------------------------------------

DROP TABLE IF EXISTS NOTEEVENTS CASCADE;
CREATE TABLE NOTEEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	CHARTDATE TIMESTAMP(0),
	CHARTTIME TIMESTAMP(0),
	STORETIME TIMESTAMP(0),
	CATEGORY VARCHAR(50),
	DESCRIPTION VARCHAR(255),
	CGID INT,
	ISERROR CHAR(1),
	TEXT TEXT,
	CONSTRAINT noteevents_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table OUTPUTEVENTS
--------------------------------------------------------

DROP TABLE IF EXISTS OUTPUTEVENTS CASCADE;
CREATE TABLE OUTPUTEVENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT,
	ICUSTAY_ID INT,
	CHARTTIME TIMESTAMP(0),
	ITEMID INT,
	VALUE DOUBLE PRECISION,
	VALUEUOM VARCHAR(30),
	STORETIME TIMESTAMP(0),
	CGID INT,
	STOPPED VARCHAR(30),
	NEWBOTTLE CHAR(1),
	ISERROR INT,
	CONSTRAINT outputevents_cv_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table PATIENTS
--------------------------------------------------------

DROP TABLE IF EXISTS PATIENTS CASCADE;
CREATE TABLE PATIENTS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	GENDER VARCHAR(5) NOT NULL,
	DOB TIMESTAMP(0) NOT NULL,
	DOD TIMESTAMP(0),
	DOD_HOSP TIMESTAMP(0),
	DOD_SSN TIMESTAMP(0),
	EXPIRE_FLAG INT NOT NULL,
	CONSTRAINT pat_subid_unique UNIQUE (SUBJECT_ID),
	CONSTRAINT pat_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table PRESCRIPTIONS
--------------------------------------------------------

DROP TABLE IF EXISTS PRESCRIPTIONS CASCADE;
CREATE TABLE PRESCRIPTIONS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	ICUSTAY_ID INT,
	STARTDATE TIMESTAMP(0),
	ENDDATE TIMESTAMP(0),
	DRUG_TYPE VARCHAR(100) NOT NULL,
	DRUG VARCHAR(100) NOT NULL,
	DRUG_NAME_POE VARCHAR(100),
	DRUG_NAME_GENERIC VARCHAR(100),
	FORMULARY_DRUG_CD VARCHAR(120),
	GSN VARCHAR(200),
	NDC VARCHAR(120),
	PROD_STRENGTH VARCHAR(120),
	DOSE_VAL_RX VARCHAR(120),
	DOSE_UNIT_RX VARCHAR(120),
	FORM_VAL_DISP VARCHAR(120),
	FORM_UNIT_DISP VARCHAR(120),
	ROUTE VARCHAR(120),
	CONSTRAINT prescription_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table PROCEDUREEVENTS_MV
--------------------------------------------------------

DROP TABLE IF EXISTS PROCEDUREEVENTS_MV CASCADE;
CREATE TABLE PROCEDUREEVENTS_MV
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	ICUSTAY_ID INT,
	STARTTIME TIMESTAMP(0),
	ENDTIME TIMESTAMP(0),
	ITEMID INT,
	VALUE DOUBLE PRECISION,
	VALUEUOM VARCHAR(30),
	LOCATION VARCHAR(30),
	LOCATIONCATEGORY VARCHAR(30),
	STORETIME TIMESTAMP(0),
	CGID INT,
	ORDERID INT,
	LINKORDERID INT,
	ORDERCATEGORYNAME VARCHAR(100),
	SECONDARYORDERCATEGORYNAME VARCHAR(100),
	ORDERCATEGORYDESCRIPTION VARCHAR(50),
	ISOPENBAG SMALLINT,
	CONTINUEINNEXTDEPT SMALLINT,
	CANCELREASON SMALLINT,
	STATUSDESCRIPTION VARCHAR(30),
	COMMENTS_EDITEDBY VARCHAR(30),
	COMMENTS_CANCELEDBY VARCHAR(30),
	COMMENTS_DATE TIMESTAMP(0),
	CONSTRAINT procedureevents_mv_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table PROCEDURES_ICD
--------------------------------------------------------

DROP TABLE IF EXISTS PROCEDURES_ICD CASCADE;
CREATE TABLE PROCEDURES_ICD
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	SEQ_NUM INT NOT NULL,
	ICD9_CODE VARCHAR(10) NOT NULL,
	CONSTRAINT proceduresicd_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table SERVICES
--------------------------------------------------------

DROP TABLE IF EXISTS SERVICES CASCADE;
CREATE TABLE SERVICES
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	TRANSFERTIME TIMESTAMP(0) NOT NULL,
	PREV_SERVICE VARCHAR(20),
	CURR_SERVICE VARCHAR(20),
	CONSTRAINT services_rowid_pk PRIMARY KEY (ROW_ID)
) ;

--------------------------------------------------------
--  DDL for Table TRANSFERS
--------------------------------------------------------

DROP TABLE IF EXISTS TRANSFERS CASCADE;
CREATE TABLE TRANSFERS
(
  ROW_ID INT NOT NULL,
	SUBJECT_ID INT NOT NULL,
	HADM_ID INT NOT NULL,
	ICUSTAY_ID INT,
	DBSOURCE VARCHAR(20),
	EVENTTYPE VARCHAR(20),
	PREV_CAREUNIT VARCHAR(20),
	CURR_CAREUNIT VARCHAR(20),
	PREV_WARDID SMALLINT,
	CURR_WARDID SMALLINT,
	INTIME TIMESTAMP(0),
	OUTTIME TIMESTAMP(0),
	LOS DOUBLE PRECISION,
	CONSTRAINT transfers_rowid_pk PRIMARY KEY (ROW_ID)
) ;

\copy ADMISSIONS FROM PROGRAM 'gzip -dc ADMISSIONS.csv.gz' DELIMITER ',' CSV HEADER;


\copy CALLOUT from PROGRAM 'gzip -dc CALLOUT.csv.gz' delimiter ',' csv header;



\copy CAREGIVERS from PROGRAM 'gzip -dc CAREGIVERS.csv.gz' delimiter ',' csv header;


\copy CHARTEVENTS from PROGRAM 'gzip -dc CHARTEVENTS.csv.gz' delimiter ',' csv header;


\copy CPTEVENTS from PROGRAM 'gzip -dc CPTEVENTS.csv.gz' delimiter ',' csv header;



\copy DATETIMEEVENTS from PROGRAM 'gzip -dc DATETIMEEVENTS.csv.gz' delimiter ',' csv header;



-- \copy DIAGNOSES_ICD from PROGRAM 'gzip -dc DIAGNOSES_ICD.csv.gz' delimiter ',' csv header;


\copy DRGCODES from PROGRAM 'gzip -dc DRGCODES.csv.gz' delimiter ',' csv header;



\copy D_CPT from PROGRAM 'gzip -dc D_CPT.csv.gz' delimiter ',' csv header;



\copy D_ICD_DIAGNOSES from PROGRAM 'gzip -dc D_ICD_DIAGNOSES.csv.gz' delimiter ',' csv header;



-- \copy D_ICD_PROCEDURES from PROGRAM 'gzip -dc D_ICD_PROCEDURES.csv.gz' delimiter ',' csv header;



\copy D_ITEMS from PROGRAM 'gzip -dc D_ITEMS.csv.gz' delimiter ',' csv header;



\copy D_LABITEMS from PROGRAM 'gzip -dc D_LABITEMS.csv.gz' delimiter ',' csv header;



\copy ICUSTAYS from PROGRAM 'gzip -dc ICUSTAYS.csv.gz' delimiter ',' csv header;


\copy INPUTEVENTS_CV from PROGRAM 'gzip -dc INPUTEVENTS_CV.csv.gz' delimiter ',' csv header;



\copy INPUTEVENTS_MV from PROGRAM 'gzip -dc INPUTEVENTS_MV.csv.gz' delimiter ',' csv header;



\copy LABEVENTS from PROGRAM 'gzip -dc LABEVENTS.csv.gz' delimiter ',' csv header;



\copy MICROBIOLOGYEVENTS from PROGRAM 'gzip -dc MICROBIOLOGYEVENTS.csv.gz' delimiter ',' csv header;


\copy NOTEEVENTS from PROGRAM 'gzip -dc NOTEEVENTS.csv.gz' delimiter ',' csv header;


\copy OUTPUTEVENTS from PROGRAM 'gzip -dc OUTPUTEVENTS.csv.gz' delimiter ',' csv header;


\copy PATIENTS from PROGRAM 'gzip -dc PATIENTS.csv.gz' delimiter ',' csv header;


\copy PRESCRIPTIONS from PROGRAM 'gzip -dc PRESCRIPTIONS.csv.gz' delimiter ',' csv header;



\copy PROCEDUREEVENTS_MV from PROGRAM 'gzip -dc PROCEDUREEVENTS_MV.csv.gz' delimiter ',' csv header;

-- \copy PROCEDURES_ICD from PROGRAM 'gzip -dc PROCEDURES_ICD.csv.gz' delimiter ',' csv header;


\copy SERVICES from PROGRAM 'gzip -dc SERVICES.csv.gz' delimiter ',' csv header;



\copy TRANSFERS from PROGRAM 'gzip -dc TRANSFERS.csv.gz' delimiter ',' csv header;



DROP INDEX IF EXISTS ADMISSIONS_idx01;
CREATE INDEX ADMISSIONS_IDX01
  ON ADMISSIONS (SUBJECT_ID);

DROP INDEX IF EXISTS ADMISSIONS_idx02;
CREATE INDEX ADMISSIONS_IDX02
  ON ADMISSIONS (HADM_ID);


DROP INDEX IF EXISTS CALLOUT_idx01;
CREATE INDEX CALLOUT_IDX01
  ON CALLOUT (SUBJECT_ID);

DROP INDEX IF EXISTS CALLOUT_idx02;
CREATE INDEX CALLOUT_IDX02
  ON CALLOUT (HADM_ID);


DROP INDEX IF EXISTS chartevents_1_idx01;
CREATE INDEX chartevents_1_idx01 ON chartevents_1 (itemid);
DROP INDEX IF EXISTS chartevents_2_idx01;
CREATE INDEX chartevents_2_idx01 ON chartevents_2 (itemid);
DROP INDEX IF EXISTS chartevents_3_idx01;
CREATE INDEX chartevents_3_idx01 ON chartevents_3 (itemid);
DROP INDEX IF EXISTS chartevents_4_idx01;
CREATE INDEX chartevents_4_idx01 ON chartevents_4 (itemid);
DROP INDEX IF EXISTS chartevents_5_idx01;
CREATE INDEX chartevents_5_idx01 ON chartevents_5 (itemid);
DROP INDEX IF EXISTS chartevents_6_idx01;
CREATE INDEX chartevents_6_idx01 ON chartevents_6 (itemid);
DROP INDEX IF EXISTS chartevents_7_idx01;
CREATE INDEX chartevents_7_idx01 ON chartevents_7 (itemid);
DROP INDEX IF EXISTS chartevents_8_idx01;
CREATE INDEX chartevents_8_idx01 ON chartevents_8 (itemid);
DROP INDEX IF EXISTS chartevents_9_idx01;
CREATE INDEX chartevents_9_idx01 ON chartevents_9 (itemid);
DROP INDEX IF EXISTS chartevents_10_idx01;
CREATE INDEX chartevents_10_idx01 ON chartevents_10 (itemid);
DROP INDEX IF EXISTS chartevents_11_idx01;
CREATE INDEX chartevents_11_idx01 ON chartevents_11 (itemid);
DROP INDEX IF EXISTS chartevents_12_idx01;
CREATE INDEX chartevents_12_idx01 ON chartevents_12 (itemid);
DROP INDEX IF EXISTS chartevents_13_idx01;
CREATE INDEX chartevents_13_idx01 ON chartevents_13 (itemid);
DROP INDEX IF EXISTS chartevents_14_idx01;
CREATE INDEX chartevents_14_idx01 ON chartevents_14 (itemid);
DROP INDEX IF EXISTS chartevents_15_idx01;
CREATE INDEX chartevents_15_idx01 ON chartevents_15 (itemid);
DROP INDEX IF EXISTS chartevents_16_idx01;
CREATE INDEX chartevents_16_idx01 ON chartevents_16 (itemid);
DROP INDEX IF EXISTS chartevents_17_idx01;
CREATE INDEX chartevents_17_idx01 ON chartevents_17 (itemid);


DO $$
BEGIN

IF EXISTS (
    SELECT 1
    FROM         pg_class c
    INNER JOIN   pg_namespace n
      ON n.oid = c.relnamespace
    WHERE  c.relname = 'chartevents_207'
  ) THEN

  DROP INDEX IF EXISTS chartevents_18_idx01;
  CREATE INDEX chartevents_18_idx01 ON chartevents_18 (itemid);
  DROP INDEX IF EXISTS chartevents_19_idx01;
  CREATE INDEX chartevents_19_idx01 ON chartevents_19 (itemid);
  DROP INDEX IF EXISTS chartevents_20_idx01;
  CREATE INDEX chartevents_20_idx01 ON chartevents_20 (itemid);
  DROP INDEX IF EXISTS chartevents_21_idx01;
  CREATE INDEX chartevents_21_idx01 ON chartevents_21 (itemid);
  DROP INDEX IF EXISTS chartevents_22_idx01;
  CREATE INDEX chartevents_22_idx01 ON chartevents_22 (itemid);
  DROP INDEX IF EXISTS chartevents_23_idx01;
  CREATE INDEX chartevents_23_idx01 ON chartevents_23 (itemid);
  DROP INDEX IF EXISTS chartevents_24_idx01;
  CREATE INDEX chartevents_24_idx01 ON chartevents_24 (itemid);
  DROP INDEX IF EXISTS chartevents_25_idx01;
  CREATE INDEX chartevents_25_idx01 ON chartevents_25 (itemid);
  DROP INDEX IF EXISTS chartevents_26_idx01;
  CREATE INDEX chartevents_26_idx01 ON chartevents_26 (itemid);
  DROP INDEX IF EXISTS chartevents_27_idx01;
  CREATE INDEX chartevents_27_idx01 ON chartevents_27 (itemid);
  DROP INDEX IF EXISTS chartevents_28_idx01;
  CREATE INDEX chartevents_28_idx01 ON chartevents_28 (itemid);
  DROP INDEX IF EXISTS chartevents_29_idx01;
  CREATE INDEX chartevents_29_idx01 ON chartevents_29 (itemid);
  DROP INDEX IF EXISTS chartevents_30_idx01;
  CREATE INDEX chartevents_30_idx01 ON chartevents_30 (itemid);
  DROP INDEX IF EXISTS chartevents_31_idx01;
  CREATE INDEX chartevents_31_idx01 ON chartevents_31 (itemid);
  DROP INDEX IF EXISTS chartevents_32_idx01;
  CREATE INDEX chartevents_32_idx01 ON chartevents_32 (itemid);
  DROP INDEX IF EXISTS chartevents_33_idx01;
  CREATE INDEX chartevents_33_idx01 ON chartevents_33 (itemid);
  DROP INDEX IF EXISTS chartevents_34_idx01;
  CREATE INDEX chartevents_34_idx01 ON chartevents_34 (itemid);
  DROP INDEX IF EXISTS chartevents_35_idx01;
  CREATE INDEX chartevents_35_idx01 ON chartevents_35 (itemid);
  DROP INDEX IF EXISTS chartevents_36_idx01;
  CREATE INDEX chartevents_36_idx01 ON chartevents_36 (itemid);
  DROP INDEX IF EXISTS chartevents_37_idx01;
  CREATE INDEX chartevents_37_idx01 ON chartevents_37 (itemid);
  DROP INDEX IF EXISTS chartevents_38_idx01;
  CREATE INDEX chartevents_38_idx01 ON chartevents_38 (itemid);
  DROP INDEX IF EXISTS chartevents_39_idx01;
  CREATE INDEX chartevents_39_idx01 ON chartevents_39 (itemid);
  DROP INDEX IF EXISTS chartevents_40_idx01;
  CREATE INDEX chartevents_40_idx01 ON chartevents_40 (itemid);
  DROP INDEX IF EXISTS chartevents_41_idx01;
  CREATE INDEX chartevents_41_idx01 ON chartevents_41 (itemid);
  DROP INDEX IF EXISTS chartevents_42_idx01;
  CREATE INDEX chartevents_42_idx01 ON chartevents_42 (itemid);
  DROP INDEX IF EXISTS chartevents_43_idx01;
  CREATE INDEX chartevents_43_idx01 ON chartevents_43 (itemid);
  DROP INDEX IF EXISTS chartevents_44_idx01;
  CREATE INDEX chartevents_44_idx01 ON chartevents_44 (itemid);
  DROP INDEX IF EXISTS chartevents_45_idx01;
  CREATE INDEX chartevents_45_idx01 ON chartevents_45 (itemid);
  DROP INDEX IF EXISTS chartevents_46_idx01;
  CREATE INDEX chartevents_46_idx01 ON chartevents_46 (itemid);
  DROP INDEX IF EXISTS chartevents_47_idx01;
  CREATE INDEX chartevents_47_idx01 ON chartevents_47 (itemid);
  DROP INDEX IF EXISTS chartevents_48_idx01;
  CREATE INDEX chartevents_48_idx01 ON chartevents_48 (itemid);
  DROP INDEX IF EXISTS chartevents_49_idx01;
  CREATE INDEX chartevents_49_idx01 ON chartevents_49 (itemid);
  DROP INDEX IF EXISTS chartevents_50_idx01;
  CREATE INDEX chartevents_50_idx01 ON chartevents_50 (itemid);
  DROP INDEX IF EXISTS chartevents_51_idx01;
  CREATE INDEX chartevents_51_idx01 ON chartevents_51 (itemid);
  DROP INDEX IF EXISTS chartevents_52_idx01;
  CREATE INDEX chartevents_52_idx01 ON chartevents_52 (itemid);
  DROP INDEX IF EXISTS chartevents_53_idx01;
  CREATE INDEX chartevents_53_idx01 ON chartevents_53 (itemid);
  DROP INDEX IF EXISTS chartevents_54_idx01;
  CREATE INDEX chartevents_54_idx01 ON chartevents_54 (itemid);
  DROP INDEX IF EXISTS chartevents_55_idx01;
  CREATE INDEX chartevents_55_idx01 ON chartevents_55 (itemid);
  DROP INDEX IF EXISTS chartevents_56_idx01;
  CREATE INDEX chartevents_56_idx01 ON chartevents_56 (itemid);
  DROP INDEX IF EXISTS chartevents_57_idx01;
  CREATE INDEX chartevents_57_idx01 ON chartevents_57 (itemid);
  DROP INDEX IF EXISTS chartevents_58_idx01;
  CREATE INDEX chartevents_58_idx01 ON chartevents_58 (itemid);
  DROP INDEX IF EXISTS chartevents_59_idx01;
  CREATE INDEX chartevents_59_idx01 ON chartevents_59 (itemid);
  DROP INDEX IF EXISTS chartevents_60_idx01;
  CREATE INDEX chartevents_60_idx01 ON chartevents_60 (itemid);
  DROP INDEX IF EXISTS chartevents_61_idx01;
  CREATE INDEX chartevents_61_idx01 ON chartevents_61 (itemid);
  DROP INDEX IF EXISTS chartevents_62_idx01;
  CREATE INDEX chartevents_62_idx01 ON chartevents_62 (itemid);
  DROP INDEX IF EXISTS chartevents_63_idx01;
  CREATE INDEX chartevents_63_idx01 ON chartevents_63 (itemid);
  DROP INDEX IF EXISTS chartevents_64_idx01;
  CREATE INDEX chartevents_64_idx01 ON chartevents_64 (itemid);
  DROP INDEX IF EXISTS chartevents_65_idx01;
  CREATE INDEX chartevents_65_idx01 ON chartevents_65 (itemid);
  DROP INDEX IF EXISTS chartevents_66_idx01;
  CREATE INDEX chartevents_66_idx01 ON chartevents_66 (itemid);
  DROP INDEX IF EXISTS chartevents_67_idx01;
  CREATE INDEX chartevents_67_idx01 ON chartevents_67 (itemid);
  DROP INDEX IF EXISTS chartevents_68_idx01;
  CREATE INDEX chartevents_68_idx01 ON chartevents_68 (itemid);
  DROP INDEX IF EXISTS chartevents_69_idx01;
  CREATE INDEX chartevents_69_idx01 ON chartevents_69 (itemid);
  DROP INDEX IF EXISTS chartevents_70_idx01;
  CREATE INDEX chartevents_70_idx01 ON chartevents_70 (itemid);
  DROP INDEX IF EXISTS chartevents_71_idx01;
  CREATE INDEX chartevents_71_idx01 ON chartevents_71 (itemid);
  DROP INDEX IF EXISTS chartevents_72_idx01;
  CREATE INDEX chartevents_72_idx01 ON chartevents_72 (itemid);
  DROP INDEX IF EXISTS chartevents_73_idx01;
  CREATE INDEX chartevents_73_idx01 ON chartevents_73 (itemid);
  DROP INDEX IF EXISTS chartevents_74_idx01;
  CREATE INDEX chartevents_74_idx01 ON chartevents_74 (itemid);
  DROP INDEX IF EXISTS chartevents_75_idx01;
  CREATE INDEX chartevents_75_idx01 ON chartevents_75 (itemid);
  DROP INDEX IF EXISTS chartevents_76_idx01;
  CREATE INDEX chartevents_76_idx01 ON chartevents_76 (itemid);
  DROP INDEX IF EXISTS chartevents_77_idx01;
  CREATE INDEX chartevents_77_idx01 ON chartevents_77 (itemid);
  DROP INDEX IF EXISTS chartevents_78_idx01;
  CREATE INDEX chartevents_78_idx01 ON chartevents_78 (itemid);
  DROP INDEX IF EXISTS chartevents_79_idx01;
  CREATE INDEX chartevents_79_idx01 ON chartevents_79 (itemid);
  DROP INDEX IF EXISTS chartevents_80_idx01;
  CREATE INDEX chartevents_80_idx01 ON chartevents_80 (itemid);
  DROP INDEX IF EXISTS chartevents_81_idx01;
  CREATE INDEX chartevents_81_idx01 ON chartevents_81 (itemid);
  DROP INDEX IF EXISTS chartevents_82_idx01;
  CREATE INDEX chartevents_82_idx01 ON chartevents_82 (itemid);
  DROP INDEX IF EXISTS chartevents_83_idx01;
  CREATE INDEX chartevents_83_idx01 ON chartevents_83 (itemid);
  DROP INDEX IF EXISTS chartevents_84_idx01;
  CREATE INDEX chartevents_84_idx01 ON chartevents_84 (itemid);
  DROP INDEX IF EXISTS chartevents_85_idx01;
  CREATE INDEX chartevents_85_idx01 ON chartevents_85 (itemid);
  DROP INDEX IF EXISTS chartevents_86_idx01;
  CREATE INDEX chartevents_86_idx01 ON chartevents_86 (itemid);
  DROP INDEX IF EXISTS chartevents_87_idx01;
  CREATE INDEX chartevents_87_idx01 ON chartevents_87 (itemid);
  DROP INDEX IF EXISTS chartevents_88_idx01;
  CREATE INDEX chartevents_88_idx01 ON chartevents_88 (itemid);
  DROP INDEX IF EXISTS chartevents_89_idx01;
  CREATE INDEX chartevents_89_idx01 ON chartevents_89 (itemid);
  DROP INDEX IF EXISTS chartevents_90_idx01;
  CREATE INDEX chartevents_90_idx01 ON chartevents_90 (itemid);
  DROP INDEX IF EXISTS chartevents_91_idx01;
  CREATE INDEX chartevents_91_idx01 ON chartevents_91 (itemid);
  DROP INDEX IF EXISTS chartevents_92_idx01;
  CREATE INDEX chartevents_92_idx01 ON chartevents_92 (itemid);
  DROP INDEX IF EXISTS chartevents_93_idx01;
  CREATE INDEX chartevents_93_idx01 ON chartevents_93 (itemid);
  DROP INDEX IF EXISTS chartevents_94_idx01;
  CREATE INDEX chartevents_94_idx01 ON chartevents_94 (itemid);
  DROP INDEX IF EXISTS chartevents_95_idx01;
  CREATE INDEX chartevents_95_idx01 ON chartevents_95 (itemid);
  DROP INDEX IF EXISTS chartevents_96_idx01;
  CREATE INDEX chartevents_96_idx01 ON chartevents_96 (itemid);
  DROP INDEX IF EXISTS chartevents_97_idx01;
  CREATE INDEX chartevents_97_idx01 ON chartevents_97 (itemid);
  DROP INDEX IF EXISTS chartevents_98_idx01;
  CREATE INDEX chartevents_98_idx01 ON chartevents_98 (itemid);
  DROP INDEX IF EXISTS chartevents_99_idx01;
  CREATE INDEX chartevents_99_idx01 ON chartevents_99 (itemid);
  DROP INDEX IF EXISTS chartevents_100_idx01;
  CREATE INDEX chartevents_100_idx01 ON chartevents_100 (itemid);
  DROP INDEX IF EXISTS chartevents_101_idx01;
  CREATE INDEX chartevents_101_idx01 ON chartevents_101 (itemid);
  DROP INDEX IF EXISTS chartevents_102_idx01;
  CREATE INDEX chartevents_102_idx01 ON chartevents_102 (itemid);
  DROP INDEX IF EXISTS chartevents_103_idx01;
  CREATE INDEX chartevents_103_idx01 ON chartevents_103 (itemid);
  DROP INDEX IF EXISTS chartevents_104_idx01;
  CREATE INDEX chartevents_104_idx01 ON chartevents_104 (itemid);
  DROP INDEX IF EXISTS chartevents_105_idx01;
  CREATE INDEX chartevents_105_idx01 ON chartevents_105 (itemid);
  DROP INDEX IF EXISTS chartevents_106_idx01;
  CREATE INDEX chartevents_106_idx01 ON chartevents_106 (itemid);
  DROP INDEX IF EXISTS chartevents_107_idx01;
  CREATE INDEX chartevents_107_idx01 ON chartevents_107 (itemid);
  DROP INDEX IF EXISTS chartevents_108_idx01;
  CREATE INDEX chartevents_108_idx01 ON chartevents_108 (itemid);
  DROP INDEX IF EXISTS chartevents_109_idx01;
  CREATE INDEX chartevents_109_idx01 ON chartevents_109 (itemid);
  DROP INDEX IF EXISTS chartevents_110_idx01;
  CREATE INDEX chartevents_110_idx01 ON chartevents_110 (itemid);
  DROP INDEX IF EXISTS chartevents_111_idx01;
  CREATE INDEX chartevents_111_idx01 ON chartevents_111 (itemid);
  DROP INDEX IF EXISTS chartevents_112_idx01;
  CREATE INDEX chartevents_112_idx01 ON chartevents_112 (itemid);
  DROP INDEX IF EXISTS chartevents_113_idx01;
  CREATE INDEX chartevents_113_idx01 ON chartevents_113 (itemid);
  DROP INDEX IF EXISTS chartevents_114_idx01;
  CREATE INDEX chartevents_114_idx01 ON chartevents_114 (itemid);
  DROP INDEX IF EXISTS chartevents_115_idx01;
  CREATE INDEX chartevents_115_idx01 ON chartevents_115 (itemid);
  DROP INDEX IF EXISTS chartevents_116_idx01;
  CREATE INDEX chartevents_116_idx01 ON chartevents_116 (itemid);
  DROP INDEX IF EXISTS chartevents_117_idx01;
  CREATE INDEX chartevents_117_idx01 ON chartevents_117 (itemid);
  DROP INDEX IF EXISTS chartevents_118_idx01;
  CREATE INDEX chartevents_118_idx01 ON chartevents_118 (itemid);
  DROP INDEX IF EXISTS chartevents_119_idx01;
  CREATE INDEX chartevents_119_idx01 ON chartevents_119 (itemid);
  DROP INDEX IF EXISTS chartevents_120_idx01;
  CREATE INDEX chartevents_120_idx01 ON chartevents_120 (itemid);
  DROP INDEX IF EXISTS chartevents_121_idx01;
  CREATE INDEX chartevents_121_idx01 ON chartevents_121 (itemid);
  DROP INDEX IF EXISTS chartevents_122_idx01;
  CREATE INDEX chartevents_122_idx01 ON chartevents_122 (itemid);
  DROP INDEX IF EXISTS chartevents_123_idx01;
  CREATE INDEX chartevents_123_idx01 ON chartevents_123 (itemid);
  DROP INDEX IF EXISTS chartevents_124_idx01;
  CREATE INDEX chartevents_124_idx01 ON chartevents_124 (itemid);
  DROP INDEX IF EXISTS chartevents_125_idx01;
  CREATE INDEX chartevents_125_idx01 ON chartevents_125 (itemid);
  DROP INDEX IF EXISTS chartevents_126_idx01;
  CREATE INDEX chartevents_126_idx01 ON chartevents_126 (itemid);
  DROP INDEX IF EXISTS chartevents_127_idx01;
  CREATE INDEX chartevents_127_idx01 ON chartevents_127 (itemid);
  DROP INDEX IF EXISTS chartevents_128_idx01;
  CREATE INDEX chartevents_128_idx01 ON chartevents_128 (itemid);
  DROP INDEX IF EXISTS chartevents_129_idx01;
  CREATE INDEX chartevents_129_idx01 ON chartevents_129 (itemid);
  DROP INDEX IF EXISTS chartevents_130_idx01;
  CREATE INDEX chartevents_130_idx01 ON chartevents_130 (itemid);
  DROP INDEX IF EXISTS chartevents_131_idx01;
  CREATE INDEX chartevents_131_idx01 ON chartevents_131 (itemid);
  DROP INDEX IF EXISTS chartevents_132_idx01;
  CREATE INDEX chartevents_132_idx01 ON chartevents_132 (itemid);
  DROP INDEX IF EXISTS chartevents_133_idx01;
  CREATE INDEX chartevents_133_idx01 ON chartevents_133 (itemid);
  DROP INDEX IF EXISTS chartevents_134_idx01;
  CREATE INDEX chartevents_134_idx01 ON chartevents_134 (itemid);
  DROP INDEX IF EXISTS chartevents_135_idx01;
  CREATE INDEX chartevents_135_idx01 ON chartevents_135 (itemid);
  DROP INDEX IF EXISTS chartevents_136_idx01;
  CREATE INDEX chartevents_136_idx01 ON chartevents_136 (itemid);
  DROP INDEX IF EXISTS chartevents_137_idx01;
  CREATE INDEX chartevents_137_idx01 ON chartevents_137 (itemid);
  DROP INDEX IF EXISTS chartevents_138_idx01;
  CREATE INDEX chartevents_138_idx01 ON chartevents_138 (itemid);
  DROP INDEX IF EXISTS chartevents_139_idx01;
  CREATE INDEX chartevents_139_idx01 ON chartevents_139 (itemid);
  DROP INDEX IF EXISTS chartevents_140_idx01;
  CREATE INDEX chartevents_140_idx01 ON chartevents_140 (itemid);
  DROP INDEX IF EXISTS chartevents_141_idx01;
  CREATE INDEX chartevents_141_idx01 ON chartevents_141 (itemid);
  DROP INDEX IF EXISTS chartevents_142_idx01;
  CREATE INDEX chartevents_142_idx01 ON chartevents_142 (itemid);
  DROP INDEX IF EXISTS chartevents_143_idx01;
  CREATE INDEX chartevents_143_idx01 ON chartevents_143 (itemid);
  DROP INDEX IF EXISTS chartevents_144_idx01;
  CREATE INDEX chartevents_144_idx01 ON chartevents_144 (itemid);
  DROP INDEX IF EXISTS chartevents_145_idx01;
  CREATE INDEX chartevents_145_idx01 ON chartevents_145 (itemid);
  DROP INDEX IF EXISTS chartevents_146_idx01;
  CREATE INDEX chartevents_146_idx01 ON chartevents_146 (itemid);
  DROP INDEX IF EXISTS chartevents_147_idx01;
  CREATE INDEX chartevents_147_idx01 ON chartevents_147 (itemid);
  DROP INDEX IF EXISTS chartevents_148_idx01;
  CREATE INDEX chartevents_148_idx01 ON chartevents_148 (itemid);
  DROP INDEX IF EXISTS chartevents_149_idx01;
  CREATE INDEX chartevents_149_idx01 ON chartevents_149 (itemid);
  DROP INDEX IF EXISTS chartevents_150_idx01;
  CREATE INDEX chartevents_150_idx01 ON chartevents_150 (itemid);
  DROP INDEX IF EXISTS chartevents_151_idx01;
  CREATE INDEX chartevents_151_idx01 ON chartevents_151 (itemid);
  DROP INDEX IF EXISTS chartevents_152_idx01;
  CREATE INDEX chartevents_152_idx01 ON chartevents_152 (itemid);
  DROP INDEX IF EXISTS chartevents_153_idx01;
  CREATE INDEX chartevents_153_idx01 ON chartevents_153 (itemid);
  DROP INDEX IF EXISTS chartevents_154_idx01;
  CREATE INDEX chartevents_154_idx01 ON chartevents_154 (itemid);
  DROP INDEX IF EXISTS chartevents_155_idx01;
  CREATE INDEX chartevents_155_idx01 ON chartevents_155 (itemid);
  DROP INDEX IF EXISTS chartevents_156_idx01;
  CREATE INDEX chartevents_156_idx01 ON chartevents_156 (itemid);
  DROP INDEX IF EXISTS chartevents_157_idx01;
  CREATE INDEX chartevents_157_idx01 ON chartevents_157 (itemid);
  DROP INDEX IF EXISTS chartevents_158_idx01;
  CREATE INDEX chartevents_158_idx01 ON chartevents_158 (itemid);
  DROP INDEX IF EXISTS chartevents_159_idx01;
  CREATE INDEX chartevents_159_idx01 ON chartevents_159 (itemid);
  DROP INDEX IF EXISTS chartevents_160_idx01;
  CREATE INDEX chartevents_160_idx01 ON chartevents_160 (itemid);
  DROP INDEX IF EXISTS chartevents_161_idx01;
  CREATE INDEX chartevents_161_idx01 ON chartevents_161 (itemid);
  DROP INDEX IF EXISTS chartevents_162_idx01;
  CREATE INDEX chartevents_162_idx01 ON chartevents_162 (itemid);
  DROP INDEX IF EXISTS chartevents_163_idx01;
  CREATE INDEX chartevents_163_idx01 ON chartevents_163 (itemid);
  DROP INDEX IF EXISTS chartevents_164_idx01;
  CREATE INDEX chartevents_164_idx01 ON chartevents_164 (itemid);
  DROP INDEX IF EXISTS chartevents_165_idx01;
  CREATE INDEX chartevents_165_idx01 ON chartevents_165 (itemid);
  DROP INDEX IF EXISTS chartevents_166_idx01;
  CREATE INDEX chartevents_166_idx01 ON chartevents_166 (itemid);
  DROP INDEX IF EXISTS chartevents_167_idx01;
  CREATE INDEX chartevents_167_idx01 ON chartevents_167 (itemid);
  DROP INDEX IF EXISTS chartevents_168_idx01;
  CREATE INDEX chartevents_168_idx01 ON chartevents_168 (itemid);
  DROP INDEX IF EXISTS chartevents_169_idx01;
  CREATE INDEX chartevents_169_idx01 ON chartevents_169 (itemid);
  DROP INDEX IF EXISTS chartevents_170_idx01;
  CREATE INDEX chartevents_170_idx01 ON chartevents_170 (itemid);
  DROP INDEX IF EXISTS chartevents_171_idx01;
  CREATE INDEX chartevents_171_idx01 ON chartevents_171 (itemid);
  DROP INDEX IF EXISTS chartevents_172_idx01;
  CREATE INDEX chartevents_172_idx01 ON chartevents_172 (itemid);
  DROP INDEX IF EXISTS chartevents_173_idx01;
  CREATE INDEX chartevents_173_idx01 ON chartevents_173 (itemid);
  DROP INDEX IF EXISTS chartevents_174_idx01;
  CREATE INDEX chartevents_174_idx01 ON chartevents_174 (itemid);
  DROP INDEX IF EXISTS chartevents_175_idx01;
  CREATE INDEX chartevents_175_idx01 ON chartevents_175 (itemid);
  DROP INDEX IF EXISTS chartevents_176_idx01;
  CREATE INDEX chartevents_176_idx01 ON chartevents_176 (itemid);
  DROP INDEX IF EXISTS chartevents_177_idx01;
  CREATE INDEX chartevents_177_idx01 ON chartevents_177 (itemid);
  DROP INDEX IF EXISTS chartevents_178_idx01;
  CREATE INDEX chartevents_178_idx01 ON chartevents_178 (itemid);
  DROP INDEX IF EXISTS chartevents_179_idx01;
  CREATE INDEX chartevents_179_idx01 ON chartevents_179 (itemid);
  DROP INDEX IF EXISTS chartevents_180_idx01;
  CREATE INDEX chartevents_180_idx01 ON chartevents_180 (itemid);
  DROP INDEX IF EXISTS chartevents_181_idx01;
  CREATE INDEX chartevents_181_idx01 ON chartevents_181 (itemid);
  DROP INDEX IF EXISTS chartevents_182_idx01;
  CREATE INDEX chartevents_182_idx01 ON chartevents_182 (itemid);
  DROP INDEX IF EXISTS chartevents_183_idx01;
  CREATE INDEX chartevents_183_idx01 ON chartevents_183 (itemid);
  DROP INDEX IF EXISTS chartevents_184_idx01;
  CREATE INDEX chartevents_184_idx01 ON chartevents_184 (itemid);
  DROP INDEX IF EXISTS chartevents_185_idx01;
  CREATE INDEX chartevents_185_idx01 ON chartevents_185 (itemid);
  DROP INDEX IF EXISTS chartevents_186_idx01;
  CREATE INDEX chartevents_186_idx01 ON chartevents_186 (itemid);
  DROP INDEX IF EXISTS chartevents_187_idx01;
  CREATE INDEX chartevents_187_idx01 ON chartevents_187 (itemid);
  DROP INDEX IF EXISTS chartevents_188_idx01;
  CREATE INDEX chartevents_188_idx01 ON chartevents_188 (itemid);
  DROP INDEX IF EXISTS chartevents_189_idx01;
  CREATE INDEX chartevents_189_idx01 ON chartevents_189 (itemid);
  DROP INDEX IF EXISTS chartevents_190_idx01;
  CREATE INDEX chartevents_190_idx01 ON chartevents_190 (itemid);
  DROP INDEX IF EXISTS chartevents_191_idx01;
  CREATE INDEX chartevents_191_idx01 ON chartevents_191 (itemid);
  DROP INDEX IF EXISTS chartevents_192_idx01;
  CREATE INDEX chartevents_192_idx01 ON chartevents_192 (itemid);
  DROP INDEX IF EXISTS chartevents_193_idx01;
  CREATE INDEX chartevents_193_idx01 ON chartevents_193 (itemid);
  DROP INDEX IF EXISTS chartevents_194_idx01;
  CREATE INDEX chartevents_194_idx01 ON chartevents_194 (itemid);
  DROP INDEX IF EXISTS chartevents_195_idx01;
  CREATE INDEX chartevents_195_idx01 ON chartevents_195 (itemid);
  DROP INDEX IF EXISTS chartevents_196_idx01;
  CREATE INDEX chartevents_196_idx01 ON chartevents_196 (itemid);
  DROP INDEX IF EXISTS chartevents_197_idx01;
  CREATE INDEX chartevents_197_idx01 ON chartevents_197 (itemid);
  DROP INDEX IF EXISTS chartevents_198_idx01;
  CREATE INDEX chartevents_198_idx01 ON chartevents_198 (itemid);
  DROP INDEX IF EXISTS chartevents_199_idx01;
  CREATE INDEX chartevents_199_idx01 ON chartevents_199 (itemid);
  DROP INDEX IF EXISTS chartevents_200_idx01;
  CREATE INDEX chartevents_200_idx01 ON chartevents_200 (itemid);
  DROP INDEX IF EXISTS chartevents_201_idx01;
  CREATE INDEX chartevents_201_idx01 ON chartevents_201 (itemid);
  DROP INDEX IF EXISTS chartevents_202_idx01;
  CREATE INDEX chartevents_202_idx01 ON chartevents_202 (itemid);
  DROP INDEX IF EXISTS chartevents_203_idx01;
  CREATE INDEX chartevents_203_idx01 ON chartevents_203 (itemid);
  DROP INDEX IF EXISTS chartevents_204_idx01;
  CREATE INDEX chartevents_204_idx01 ON chartevents_204 (itemid);
  DROP INDEX IF EXISTS chartevents_205_idx01;
  CREATE INDEX chartevents_205_idx01 ON chartevents_205 (itemid);
  DROP INDEX IF EXISTS chartevents_206_idx01;
  CREATE INDEX chartevents_206_idx01 ON chartevents_206 (itemid);
  DROP INDEX IF EXISTS chartevents_207_idx01;
  CREATE INDEX chartevents_207_idx01 ON chartevents_207 (itemid);
END IF;

END$$;


DROP INDEX IF EXISTS CPTEVENTS_idx01;
CREATE INDEX CPTEVENTS_idx01
  ON CPTEVENTS (SUBJECT_ID);

DROP INDEX IF EXISTS CPTEVENTS_idx02;
CREATE INDEX CPTEVENTS_idx02
  ON CPTEVENTS (CPT_CD);


DROP INDEX IF EXISTS D_ICD_DIAG_idx01;
CREATE INDEX D_ICD_DIAG_idx01
  ON D_ICD_DIAGNOSES (ICD9_CODE);

DROP INDEX IF EXISTS D_ICD_DIAG_idx02;
CREATE INDEX D_ICD_DIAG_idx02
  ON D_ICD_DIAGNOSES (LONG_TITLE);


DROP INDEX IF EXISTS D_ICD_PROC_idx01;
CREATE INDEX D_ICD_PROC_idx01
  ON D_ICD_PROCEDURES (ICD9_CODE);

DROP INDEX IF EXISTS D_ICD_PROC_idx02;
CREATE INDEX D_ICD_PROC_idx02
  ON D_ICD_PROCEDURES (LONG_TITLE);



DROP INDEX IF EXISTS D_ITEMS_idx01;
CREATE INDEX D_ITEMS_idx01
  ON D_ITEMS (ITEMID);

DROP INDEX IF EXISTS D_ITEMS_idx02;
CREATE INDEX D_ITEMS_idx02
  ON D_ITEMS (LABEL);



DROP INDEX IF EXISTS D_LABITEMS_idx01;
CREATE INDEX D_LABITEMS_idx01
  ON D_LABITEMS (ITEMID);

DROP INDEX IF EXISTS D_LABITEMS_idx02;
CREATE INDEX D_LABITEMS_idx02
  ON D_LABITEMS (LABEL);

DROP INDEX IF EXISTS D_LABITEMS_idx03;
CREATE INDEX D_LABITEMS_idx03
  ON D_LABITEMS (LOINC_CODE);



DROP INDEX IF EXISTS DATETIMEEVENTS_idx01;
CREATE INDEX DATETIMEEVENTS_idx01
  ON DATETIMEEVENTS (SUBJECT_ID);

DROP INDEX IF EXISTS DATETIMEEVENTS_idx02;
CREATE INDEX DATETIMEEVENTS_idx02
  ON DATETIMEEVENTS (ITEMID);

DROP INDEX IF EXISTS DATETIMEEVENTS_idx03;
CREATE INDEX DATETIMEEVENTS_idx03
  ON DATETIMEEVENTS (ICUSTAY_ID);

DROP INDEX IF EXISTS DATETIMEEVENTS_idx04;
CREATE INDEX DATETIMEEVENTS_idx04
  ON DATETIMEEVENTS (HADM_ID);



DROP INDEX IF EXISTS DIAGNOSES_ICD_idx01;
CREATE INDEX DIAGNOSES_ICD_idx01
  ON DIAGNOSES_ICD (SUBJECT_ID);

DROP INDEX IF EXISTS DIAGNOSES_ICD_idx02;
CREATE INDEX DIAGNOSES_ICD_idx02
  ON DIAGNOSES_ICD (ICD9_CODE);

DROP INDEX IF EXISTS DIAGNOSES_ICD_idx03;
CREATE INDEX DIAGNOSES_ICD_idx03
  ON DIAGNOSES_ICD (HADM_ID);



DROP INDEX IF EXISTS DRGCODES_idx01;
CREATE INDEX DRGCODES_idx01
  ON DRGCODES (SUBJECT_ID);

DROP INDEX IF EXISTS DRGCODES_idx02;
CREATE INDEX DRGCODES_idx02
  ON DRGCODES (DRG_CODE);

DROP INDEX IF EXISTS DRGCODES_idx03;
CREATE INDEX DRGCODES_idx03
  ON DRGCODES (DESCRIPTION);



DROP INDEX IF EXISTS ICUSTAYS_idx01;
CREATE INDEX ICUSTAYS_idx01
  ON ICUSTAYS (SUBJECT_ID);

DROP INDEX IF EXISTS ICUSTAYS_idx02;
CREATE INDEX ICUSTAYS_idx02
  ON ICUSTAYS (ICUSTAY_ID);



DROP INDEX IF EXISTS ICUSTAYS_idx06;
CREATE INDEX ICUSTAYS_IDX06
  ON ICUSTAYS (HADM_ID);


DROP INDEX IF EXISTS INPUTEVENTS_CV_idx01;
CREATE INDEX INPUTEVENTS_CV_idx01
  ON INPUTEVENTS_CV (SUBJECT_ID);

  DROP INDEX IF EXISTS INPUTEVENTS_CV_idx02;
  CREATE INDEX INPUTEVENTS_CV_idx02
    ON INPUTEVENTS_CV (HADM_ID);

DROP INDEX IF EXISTS INPUTEVENTS_CV_idx03;
CREATE INDEX INPUTEVENTS_CV_idx03
  ON INPUTEVENTS_CV (ICUSTAY_ID);

DROP INDEX IF EXISTS INPUTEVENTS_CV_idx04;
CREATE INDEX INPUTEVENTS_CV_idx04
  ON INPUTEVENTS_CV (CHARTTIME);

DROP INDEX IF EXISTS INPUTEVENTS_CV_idx05;
CREATE INDEX INPUTEVENTS_CV_idx05
  ON INPUTEVENTS_CV (ITEMID);

DROP INDEX IF EXISTS INPUTEVENTS_MV_idx01;
CREATE INDEX INPUTEVENTS_MV_idx01
  ON INPUTEVENTS_MV (SUBJECT_ID);

DROP INDEX IF EXISTS INPUTEVENTS_MV_idx02;
CREATE INDEX INPUTEVENTS_MV_idx02
  ON INPUTEVENTS_MV (HADM_ID);

DROP INDEX IF EXISTS INPUTEVENTS_MV_idx03;
CREATE INDEX INPUTEVENTS_MV_idx03
  ON INPUTEVENTS_MV (ICUSTAY_ID);



DROP INDEX IF EXISTS INPUTEVENTS_MV_idx05;
CREATE INDEX INPUTEVENTS_MV_idx05
  ON INPUTEVENTS_MV (ITEMID);



DROP INDEX IF EXISTS LABEVENTS_idx01;
CREATE INDEX LABEVENTS_idx01
  ON LABEVENTS (SUBJECT_ID);

DROP INDEX IF EXISTS LABEVENTS_idx02;
CREATE INDEX LABEVENTS_idx02
  ON LABEVENTS (HADM_ID);

DROP INDEX IF EXISTS LABEVENTS_idx03;
CREATE INDEX LABEVENTS_idx03
  ON LABEVENTS (ITEMID);


DROP INDEX IF EXISTS MICROBIOLOGYEVENTS_idx01;
CREATE INDEX MICROBIOLOGYEVENTS_idx01
  ON MICROBIOLOGYEVENTS (SUBJECT_ID);

DROP INDEX IF EXISTS MICROBIOLOGYEVENTS_idx02;
CREATE INDEX MICROBIOLOGYEVENTS_idx02
  ON MICROBIOLOGYEVENTS (HADM_ID);



DROP INDEX IF EXISTS NOTEEVENTS_idx01;
CREATE INDEX NOTEEVENTS_idx01
  ON NOTEEVENTS (SUBJECT_ID);

DROP INDEX IF EXISTS NOTEEVENTS_idx02;
CREATE INDEX NOTEEVENTS_idx02
  ON NOTEEVENTS (HADM_ID);


DROP INDEX IF EXISTS NOTEEVENTS_idx05;
CREATE INDEX NOTEEVENTS_idx05
  ON NOTEEVENTS (CATEGORY);


DROP INDEX IF EXISTS OUTPUTEVENTS_idx01;
CREATE INDEX OUTPUTEVENTS_idx01
  ON OUTPUTEVENTS (SUBJECT_ID);


DROP INDEX IF EXISTS OUTPUTEVENTS_idx02;
CREATE INDEX OUTPUTEVENTS_idx02
  ON OUTPUTEVENTS (ITEMID);


DROP INDEX IF EXISTS OUTPUTEVENTS_idx03;
CREATE INDEX OUTPUTEVENTS_idx03
  ON OUTPUTEVENTS (ICUSTAY_ID);


DROP INDEX IF EXISTS OUTPUTEVENTS_idx04;
CREATE INDEX OUTPUTEVENTS_idx04
  ON OUTPUTEVENTS (HADM_ID);


DROP INDEX IF EXISTS PRESCRIPTIONS_idx01;
CREATE INDEX PRESCRIPTIONS_idx01
  ON PRESCRIPTIONS (SUBJECT_ID);

DROP INDEX IF EXISTS PRESCRIPTIONS_idx02;
CREATE INDEX PRESCRIPTIONS_idx02
  ON PRESCRIPTIONS (ICUSTAY_ID);

DROP INDEX IF EXISTS PRESCRIPTIONS_idx03;
CREATE INDEX PRESCRIPTIONS_idx03
  ON PRESCRIPTIONS (DRUG_TYPE);

DROP INDEX IF EXISTS PRESCRIPTIONS_idx04;
CREATE INDEX PRESCRIPTIONS_idx04
  ON PRESCRIPTIONS (DRUG);

DROP INDEX IF EXISTS PRESCRIPTIONS_idx05;
CREATE INDEX PRESCRIPTIONS_idx05
  ON PRESCRIPTIONS (HADM_ID);


DROP INDEX IF EXISTS PROCEDUREEVENTS_MV_idx01;
CREATE INDEX PROCEDUREEVENTS_MV_idx01
  ON PROCEDUREEVENTS_MV (SUBJECT_ID);

DROP INDEX IF EXISTS PROCEDUREEVENTS_MV_idx02;
CREATE INDEX PROCEDUREEVENTS_MV_idx02
  ON PROCEDUREEVENTS_MV (HADM_ID);

DROP INDEX IF EXISTS PROCEDUREEVENTS_MV_idx03;
CREATE INDEX PROCEDUREEVENTS_MV_idx03
  ON PROCEDUREEVENTS_MV (ICUSTAY_ID);


DROP INDEX IF EXISTS PROCEDUREEVENTS_MV_idx05;
CREATE INDEX PROCEDUREEVENTS_MV_idx05
  ON PROCEDUREEVENTS_MV (ITEMID);


DROP INDEX IF EXISTS PROCEDURES_ICD_idx01;
CREATE INDEX PROCEDURES_ICD_idx01
  ON PROCEDURES_ICD (SUBJECT_ID);

DROP INDEX IF EXISTS PROCEDURES_ICD_idx02;
CREATE INDEX PROCEDURES_ICD_idx02
  ON PROCEDURES_ICD (ICD9_CODE);

DROP INDEX IF EXISTS PROCEDURES_ICD_idx03;
CREATE INDEX PROCEDURES_ICD_idx03
  ON PROCEDURES_ICD (HADM_ID);


-------------
-- SERVICES
-------------

DROP INDEX IF EXISTS SERVICES_idx01;
CREATE INDEX SERVICES_idx01
  ON SERVICES (SUBJECT_ID);

DROP INDEX IF EXISTS SERVICES_idx02;
CREATE INDEX SERVICES_idx02
  ON SERVICES (HADM_ID);

DROP INDEX IF EXISTS TRANSFERS_idx01;
CREATE INDEX TRANSFERS_idx01
  ON TRANSFERS (SUBJECT_ID);

DROP INDEX IF EXISTS TRANSFERS_idx02;
CREATE INDEX TRANSFERS_idx02
  ON TRANSFERS (ICUSTAY_ID);

DROP INDEX IF EXISTS TRANSFERS_idx03;
CREATE INDEX TRANSFERS_idx03
  ON TRANSFERS (HADM_ID);


-- Table
COMMENT ON TABLE ADMISSIONS IS
   'Hospital admissions associated with an ICU stay.';

-- Columns
COMMENT ON COLUMN ADMISSIONS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN ADMISSIONS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN ADMISSIONS.HADM_ID is
   'Primary key. Identifies the hospital stay.';
COMMENT ON COLUMN ADMISSIONS.ADMITTIME is
   'Time of admission to the hospital.';
COMMENT ON COLUMN ADMISSIONS.DISCHTIME is
   'Time of discharge from the hospital.';
COMMENT ON COLUMN ADMISSIONS.DEATHTIME is
   'Time of death.';
COMMENT ON COLUMN ADMISSIONS.ADMISSION_TYPE is
   'Type of admission, for example emergency or elective.';
COMMENT ON COLUMN ADMISSIONS.ADMISSION_LOCATION is
   'Admission location.';
COMMENT ON COLUMN ADMISSIONS.DISCHARGE_LOCATION is
   'Discharge location';
COMMENT ON COLUMN ADMISSIONS.INSURANCE is
   'Insurance type.';
COMMENT ON COLUMN ADMISSIONS.LANGUAGE is
   'Language.';
COMMENT ON COLUMN ADMISSIONS.RELIGION is
   'Religon.';
COMMENT ON COLUMN ADMISSIONS.MARITAL_STATUS is
   'Marital status.';
COMMENT ON COLUMN ADMISSIONS.ETHNICITY is
   'Ethnicity.';
COMMENT ON COLUMN ADMISSIONS.DIAGNOSIS is
   'Diagnosis.';
COMMENT ON COLUMN ADMISSIONS.HAS_CHARTEVENTS_DATA is
   'Hospital admission has at least one observation in the CHARTEVENTS table.';

-----------
--CALLOUT--
-----------

-- Table
COMMENT ON TABLE CALLOUT IS
  'Record of when patients were ready for discharge (called out), and the actual time of their discharge (or more generally, their outcome).';

-- Columns
COMMENT ON COLUMN CALLOUT.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN CALLOUT.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN CALLOUT.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN CALLOUT.SUBMIT_WARDID is
   'Identifies the ward where the call out request was submitted.';
COMMENT ON COLUMN CALLOUT.SUBMIT_CAREUNIT is
   'If the ward where the call was submitted was an ICU, the ICU type is listed here.';
COMMENT ON COLUMN CALLOUT.CURR_WARDID is
   'Identifies the ward where the patient is currently residing.';
COMMENT ON COLUMN CALLOUT.CURR_CAREUNIT is
   'If the ward where the patient is currently residing is an ICU, the ICU type is listed here.';
COMMENT ON COLUMN CALLOUT.CALLOUT_WARDID is
   'Identifies the ward where the patient is to be discharged to. A value of 1 indicates the first available ward. A value of 0 indicates home.';
COMMENT ON COLUMN CALLOUT.CALLOUT_SERVICE is
   'Identifies the service that the patient is called out to.';
COMMENT ON COLUMN CALLOUT.REQUEST_TELE is
   'Indicates if special precautions are required.';
COMMENT ON COLUMN CALLOUT.REQUEST_RESP is
   'Indicates if special precautions are required.';
COMMENT ON COLUMN CALLOUT.REQUEST_CDIFF is
   'Indicates if special precautions are required.';
COMMENT ON COLUMN CALLOUT.REQUEST_MRSA is
   'Indicates if special precautions are required.';
COMMENT ON COLUMN CALLOUT.REQUEST_VRE is
   'Indicates if special precautions are required.';
COMMENT ON COLUMN CALLOUT.CALLOUT_STATUS is
   'Current status of the call out request.';
COMMENT ON COLUMN CALLOUT.CALLOUT_OUTCOME is
   'The result of the call out request; either a cancellation or a discharge.';
COMMENT ON COLUMN CALLOUT.DISCHARGE_WARDID is
   'The ward to which the patient was discharged.';
COMMENT ON COLUMN CALLOUT.ACKNOWLEDGE_STATUS is
   'The status of the response to the call out request.';
COMMENT ON COLUMN CALLOUT.CREATETIME is
   'Time at which the call out request was created.';
COMMENT ON COLUMN CALLOUT.UPDATETIME is
   'Last time at which the call out request was updated.';
COMMENT ON COLUMN CALLOUT.ACKNOWLEDGETIME is
   'Time at which the call out request was acknowledged.';
COMMENT ON COLUMN CALLOUT.OUTCOMETIME is
   'Time at which the outcome (cancelled or discharged) occurred.';
COMMENT ON COLUMN CALLOUT.FIRSTRESERVATIONTIME is
   'First time at which a ward was reserved for the call out request.';
COMMENT ON COLUMN CALLOUT.CURRENTRESERVATIONTIME is
   'Latest time at which a ward was reserved for the call out request.';

--------------
--CAREGIVERS--
--------------

-- Table
COMMENT ON TABLE CAREGIVERS IS
   'List of caregivers associated with an ICU stay.';

-- Columns
COMMENT ON COLUMN CAREGIVERS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN CAREGIVERS.CGID is
   'Unique caregiver identifier.';
COMMENT ON COLUMN CAREGIVERS.LABEL is
   'Title of the caregiver, for example MD or RN.';
COMMENT ON COLUMN CAREGIVERS.DESCRIPTION is
   'More detailed description of the caregiver, if available.';

---------------
--CHARTEVENTS--
---------------

-- Table
COMMENT ON TABLE CHARTEVENTS IS
   'Events occuring on a patient chart.';

-- Columns
COMMENT ON COLUMN CHARTEVENTS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN CHARTEVENTS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN CHARTEVENTS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN CHARTEVENTS.ICUSTAY_ID is
   'Foreign key. Identifies the ICU stay.';
COMMENT ON COLUMN CHARTEVENTS.ITEMID is
   'Foreign key. Identifies the charted item.';
COMMENT ON COLUMN CHARTEVENTS.CHARTTIME is
   'Time when the event occured.';
COMMENT ON COLUMN CHARTEVENTS.STORETIME is
   'Time when the event was recorded in the system.';
COMMENT ON COLUMN CHARTEVENTS.CGID is
   'Foreign key. Identifies the caregiver.';
COMMENT ON COLUMN CHARTEVENTS.VALUE is
   'Value of the event as a text string.';
COMMENT ON COLUMN CHARTEVENTS.VALUENUM is
   'Value of the event as a number.';
COMMENT ON COLUMN CHARTEVENTS.VALUEUOM is
   'Unit of measurement.';
COMMENT ON COLUMN CHARTEVENTS.WARNING is
   'Flag to highlight that the value has triggered a warning.';
COMMENT ON COLUMN CHARTEVENTS.ERROR is
   'Flag to highlight an error with the event.';
COMMENT ON COLUMN CHARTEVENTS.RESULTSTATUS is
   'Result status of lab data.';
COMMENT ON COLUMN CHARTEVENTS.STOPPED is
   'Text string indicating the stopped status of an event (i.e. stopped, not stopped).';

-------------
--CPTEVENTS--
-------------

-- Table
COMMENT ON TABLE CPTEVENTS IS
   'Events recorded in Current Procedural Terminology.';

-- Columns
COMMENT ON COLUMN CPTEVENTS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN CPTEVENTS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN CPTEVENTS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN CPTEVENTS.COSTCENTER is
   'Center recording the code, for example the ICU or the respiratory unit.';
COMMENT ON COLUMN CPTEVENTS.CHARTDATE is
   'Date when the event occured, if available.';
COMMENT ON COLUMN CPTEVENTS.CPT_CD is
   'Current Procedural Terminology code.';
COMMENT ON COLUMN CPTEVENTS.CPT_NUMBER is
   'Numerical element of the Current Procedural Terminology code.';
COMMENT ON COLUMN CPTEVENTS.CPT_SUFFIX is
   'Text element of the Current Procedural Terminology, if any. Indicates code category.';
COMMENT ON COLUMN CPTEVENTS.TICKET_ID_SEQ is
   'Sequence number of the event, derived from the ticket ID.';
COMMENT ON COLUMN CPTEVENTS.SECTIONHEADER is
   'High-level section of the Current Procedural Terminology code.';
COMMENT ON COLUMN CPTEVENTS.SUBSECTIONHEADER is
   'Subsection of the Current Procedural Terminology code.';
COMMENT ON COLUMN CPTEVENTS.DESCRIPTION is
   'Description of the Current Procedural Terminology, if available.';

----------
--D_CPT---
----------

-- Table
COMMENT ON TABLE D_CPT IS
   'High-level dictionary of the Current Procedural Terminology.';

-- Columns
COMMENT ON COLUMN D_CPT.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN D_CPT.CATEGORY is
   'Code category.';
COMMENT ON COLUMN D_CPT.SECTIONRANGE is
   'Range of codes within the high-level section.';
COMMENT ON COLUMN D_CPT.SECTIONHEADER is
   'Section header.';
COMMENT ON COLUMN D_CPT.SUBSECTIONRANGE is
   'Range of codes within the subsection.';
COMMENT ON COLUMN D_CPT.SUBSECTIONHEADER is
   'Subsection header.';
COMMENT ON COLUMN D_CPT.CODESUFFIX is
   'Text element of the Current Procedural Terminology, if any.';
COMMENT ON COLUMN D_CPT.MINCODEINSUBSECTION is
   'Minimum code within the subsection.';
COMMENT ON COLUMN D_CPT.MAXCODEINSUBSECTION is
   'Maximum code within the subsection.';

----------
--D_ICD_DIAGNOSES--
----------

-- Table
COMMENT ON TABLE D_ICD_DIAGNOSES IS
   'Dictionary of the International Classification of Diseases, 9th Revision (Diagnoses).';

-- Columns
COMMENT ON COLUMN D_ICD_DIAGNOSES.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN D_ICD_DIAGNOSES.ICD9_CODE is
   'ICD9 code - note that this is a fixed length character field, as whitespaces are important in uniquely identifying ICD-9 codes.';
COMMENT ON COLUMN D_ICD_DIAGNOSES.SHORT_TITLE is
   'Short title associated with the code.';
COMMENT ON COLUMN D_ICD_DIAGNOSES.LONG_TITLE is
   'Long title associated with the code.';

----------
--D_ICD_PROCEDURES--
----------

-- Table
COMMENT ON TABLE D_ICD_PROCEDURES  IS
   'Dictionary of the International Classification of Diseases, 9th Revision (Procedures).';

-- Columns
COMMENT ON COLUMN D_ICD_PROCEDURES.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN D_ICD_PROCEDURES.ICD9_CODE is
   'ICD9 code - note that this is a fixed length character field, as whitespaces are important in uniquely identifying ICD-9 codes.';
COMMENT ON COLUMN D_ICD_PROCEDURES.SHORT_TITLE is
   'Short title associated with the code.';
COMMENT ON COLUMN D_ICD_PROCEDURES.LONG_TITLE is
   'Long title associated with the code.';

-----------
--D_ITEMS--
-----------

-- Table
COMMENT ON TABLE D_ITEMS IS
   'Dictionary of non-laboratory-related charted items.';

-- Columns
COMMENT ON COLUMN D_ITEMS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN D_ITEMS.ITEMID is
   'Primary key. Identifies the charted item.';
COMMENT ON COLUMN D_ITEMS.LABEL is
   'Label identifying the item.';
COMMENT ON COLUMN D_ITEMS.ABBREVIATION is
   'Abbreviation associated with the item.';
COMMENT ON COLUMN D_ITEMS.DBSOURCE is
   'Source database of the item.';
COMMENT ON COLUMN D_ITEMS.LINKSTO is
   'Table which contains data for the given ITEMID.';
COMMENT ON COLUMN D_ITEMS.CATEGORY is
   'Category of data which the concept falls under.';
COMMENT ON COLUMN D_ITEMS.UNITNAME is
   'Unit associated with the item.';
COMMENT ON COLUMN D_ITEMS.PARAM_TYPE is
   'Type of item, for example solution or ingredient.';
COMMENT ON COLUMN D_ITEMS.CONCEPTID is
   'Identifier used to harmonize concepts identified by multiple ITEMIDs. CONCEPTIDs are planned but not yet implemented (all values are NULL).';

---------------
--D_LABITEMS--
---------------

-- Table
COMMENT ON TABLE D_LABITEMS  IS
   'Dictionary of laboratory-related items.';

-- Columns
COMMENT ON COLUMN D_LABITEMS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN D_LABITEMS.ITEMID is
   'Foreign key. Identifies the charted item.';
COMMENT ON COLUMN D_LABITEMS.LABEL is
   'Label identifying the item.';
COMMENT ON COLUMN D_LABITEMS.FLUID is
   'Fluid associated with the item, for example blood or urine.';
COMMENT ON COLUMN D_LABITEMS.CATEGORY is
   'Category of item, for example chemistry or hematology.';
COMMENT ON COLUMN D_LABITEMS.LOINC_CODE is
   'Logical Observation Identifiers Names and Codes (LOINC) mapped to the item, if available.';

------------------
--DATETIMEEVENTS--
------------------

-- Table
COMMENT ON TABLE DATETIMEEVENTS IS
   'Events relating to a datetime.';

-- Columns
COMMENT ON COLUMN DATETIMEEVENTS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN DATETIMEEVENTS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN DATETIMEEVENTS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN DATETIMEEVENTS.ICUSTAY_ID is
   'Foreign key. Identifies the ICU stay.';
COMMENT ON COLUMN DATETIMEEVENTS.ITEMID is
   'Foreign key. Identifies the charted item.';
COMMENT ON COLUMN DATETIMEEVENTS.CHARTTIME is
   'Time when the event occured.';
COMMENT ON COLUMN DATETIMEEVENTS.STORETIME is
   'Time when the event was recorded in the system.';
COMMENT ON COLUMN DATETIMEEVENTS.CGID is
   'Foreign key. Identifies the caregiver.';
COMMENT ON COLUMN DATETIMEEVENTS.VALUE is
   'Value of the event as a text string.';
COMMENT ON COLUMN DATETIMEEVENTS.VALUEUOM is
   'Unit of measurement.';
COMMENT ON COLUMN DATETIMEEVENTS.WARNING is
   'Flag to highlight that the value has triggered a warning.';
COMMENT ON COLUMN DATETIMEEVENTS.ERROR is
   'Flag to highlight an error with the event.';
COMMENT ON COLUMN DATETIMEEVENTS.RESULTSTATUS is
   'Result status of lab data.';
COMMENT ON COLUMN DATETIMEEVENTS.STOPPED is
   'Event was explicitly marked as stopped. Infrequently used by caregivers.';

-----------------
--DIAGNOSES_ICD--
-----------------

-- Table
COMMENT ON TABLE DIAGNOSES_ICD IS
   'Diagnoses relating to a hospital admission coded using the ICD9 system.';

-- Columns
COMMENT ON COLUMN DIAGNOSES_ICD.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN DIAGNOSES_ICD.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN DIAGNOSES_ICD.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN DIAGNOSES_ICD.SEQ_NUM is
   'Priority of the code. Sequence 1 is the primary code.';
COMMENT ON COLUMN DIAGNOSES_ICD.ICD9_CODE is
   'ICD9 code for the diagnosis.';

--------------
---DRGCODES---
--------------

-- Table
COMMENT ON TABLE DRGCODES IS
   'Hospital stays classified using the Diagnosis-Related Group system.';

-- Columns
COMMENT ON COLUMN DRGCODES.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN DRGCODES.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN DRGCODES.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN DRGCODES.DRG_TYPE is
   'Type of Diagnosis-Related Group, for example APR is All Patient Refined';
COMMENT ON COLUMN DRGCODES.DRG_CODE is
   'Diagnosis-Related Group code';
COMMENT ON COLUMN DRGCODES.DESCRIPTION is
   'Description of the Diagnosis-Related Group';
COMMENT ON COLUMN DRGCODES.DRG_SEVERITY is
   'Relative severity, available for type APR only.';
COMMENT ON COLUMN DRGCODES.DRG_MORTALITY is
   'Relative mortality, available for type APR only.';

-----------------
--ICUSTAYS--
-----------------

-- Table
COMMENT ON TABLE ICUSTAYS IS
   'List of ICU admissions.';

-- Columns
COMMENT ON COLUMN ICUSTAYS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN ICUSTAYS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN ICUSTAYS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN ICUSTAYS.ICUSTAY_ID is
   'Primary key. Identifies the ICU stay.';
COMMENT ON COLUMN ICUSTAYS.DBSOURCE is
   'Source database of the item.';
COMMENT ON COLUMN ICUSTAYS.INTIME is
   'Time of admission to the ICU.';
COMMENT ON COLUMN ICUSTAYS.OUTTIME is
   'Time of discharge from the ICU.';
COMMENT ON COLUMN ICUSTAYS.LOS is
   'Length of stay in the ICU measured in fractional days.';
COMMENT ON COLUMN ICUSTAYS.FIRST_CAREUNIT is
   'First careunit associated with the ICU stay.';
COMMENT ON COLUMN ICUSTAYS.LAST_CAREUNIT is
   'Last careunit associated with the ICU stay.';
COMMENT ON COLUMN ICUSTAYS.FIRST_WARDID is
   'Identifier for the first ward the patient was located in.';
COMMENT ON COLUMN ICUSTAYS.LAST_WARDID is
   'Identifier for the last ward the patient is located in.';

-- -------------- --
-- INPUTEVENTS_CV --
-- -------------- --

-- Table
COMMENT ON TABLE INPUTEVENTS_CV IS
   'Events relating to fluid input for patients whose data was originally stored in the CareVue database.';

-- Columns
COMMENT ON COLUMN INPUTEVENTS_CV.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN INPUTEVENTS_CV.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN INPUTEVENTS_CV.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN INPUTEVENTS_CV.ICUSTAY_ID is
   'Foreign key. Identifies the ICU stay.';
COMMENT ON COLUMN INPUTEVENTS_CV.CHARTTIME is
   'Time that the input was started or received.';
COMMENT ON COLUMN INPUTEVENTS_CV.ITEMID is
   'Foreign key. Identifies the charted item.';
COMMENT ON COLUMN INPUTEVENTS_CV.AMOUNT is
   'Amount of the item administered to the patient.';
COMMENT ON COLUMN INPUTEVENTS_CV.AMOUNTUOM is
   'Unit of measurement for the amount.';
COMMENT ON COLUMN INPUTEVENTS_CV.RATE is
   'Rate at which the item is being administered to the patient.';
COMMENT ON COLUMN INPUTEVENTS_CV.RATEUOM is
   'Unit of measurement for the rate.';
COMMENT ON COLUMN INPUTEVENTS_CV.STORETIME is
   'Time when the event was recorded in the system.';
COMMENT ON COLUMN INPUTEVENTS_CV.CGID is
   'Foreign key. Identifies the caregiver.';
COMMENT ON COLUMN INPUTEVENTS_CV.ORDERID is
   'Identifier linking items which are grouped in a solution.';
COMMENT ON COLUMN INPUTEVENTS_CV.LINKORDERID is
   'Identifier linking orders across multiple administrations. LINKORDERID is always equal to the first occuring ORDERID of the series.';
COMMENT ON COLUMN INPUTEVENTS_CV.STOPPED is
   'Event was explicitly marked as stopped. Infrequently used by caregivers.';
COMMENT ON COLUMN INPUTEVENTS_CV.NEWBOTTLE is
   'Indicates when a new bottle of the solution was hung at the bedside.';
COMMENT ON COLUMN INPUTEVENTS_CV.ORIGINALAMOUNT is
   'Amount of the item which was originally charted.';
COMMENT ON COLUMN INPUTEVENTS_CV.ORIGINALAMOUNTUOM is
   'Unit of measurement for the original amount.';
COMMENT ON COLUMN INPUTEVENTS_CV.ORIGINALROUTE is
   'Route of administration originally chosen for the item.';
COMMENT ON COLUMN INPUTEVENTS_CV.ORIGINALRATE is
   'Rate of administration originally chosen for the item.';
COMMENT ON COLUMN INPUTEVENTS_CV.ORIGINALRATEUOM is
   'Unit of measurement for the rate originally chosen.';
COMMENT ON COLUMN INPUTEVENTS_CV.ORIGINALSITE is
   'Anatomical site for the original administration of the item.';

----------------- --
-- INPUTEVENTS_MV --
----------------- --

-- Table
COMMENT ON TABLE INPUTEVENTS_MV IS
   'Events relating to fluid input for patients whose data was originally stored in the MetaVision database.';

-- Columns
COMMENT ON COLUMN INPUTEVENTS_MV.ROW_ID is
  'Unique row identifier.';
COMMENT ON COLUMN INPUTEVENTS_MV.SUBJECT_ID is
  'Foreign key. Identifies the patient.';
COMMENT ON COLUMN INPUTEVENTS_MV.HADM_ID is
  'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN INPUTEVENTS_MV.ICUSTAY_ID is
  'Foreign key. Identifies the ICU stay.';
COMMENT ON COLUMN INPUTEVENTS_MV.STARTTIME is
  'Time when the event started.';
COMMENT ON COLUMN INPUTEVENTS_MV.ENDTIME is
  'Time when the event ended.';
COMMENT ON COLUMN INPUTEVENTS_MV.ITEMID is
  'Foreign key. Identifies the charted item.';
COMMENT ON COLUMN INPUTEVENTS_MV.AMOUNT is
  'Amount of the item administered to the patient.';
COMMENT ON COLUMN INPUTEVENTS_MV.AMOUNTUOM is
  'Unit of measurement for the amount.';
COMMENT ON COLUMN INPUTEVENTS_MV.RATE is
  'Rate at which the item is being administered to the patient.';
COMMENT ON COLUMN INPUTEVENTS_MV.RATEUOM is
  'Unit of measurement for the rate.';
COMMENT ON COLUMN INPUTEVENTS_MV.STORETIME is
  'Time when the event was recorded in the system.';
COMMENT ON COLUMN INPUTEVENTS_MV.CGID is
  'Foreign key. Identifies the caregiver.';
COMMENT ON COLUMN INPUTEVENTS_MV.ORDERID is
  'Identifier linking items which are grouped in a solution.';
COMMENT ON COLUMN INPUTEVENTS_MV.LINKORDERID is
  'Identifier linking orders across multiple administrations. LINKORDERID is always equal to the first occuring ORDERID of the series.';
COMMENT ON COLUMN INPUTEVENTS_MV.ORDERCATEGORYNAME is
  'A group which the item corresponds to.';
COMMENT ON COLUMN INPUTEVENTS_MV.SECONDARYORDERCATEGORYNAME is
  'A secondary group for those items with more than one grouping possible.';
COMMENT ON COLUMN INPUTEVENTS_MV.ORDERCOMPONENTTYPEDESCRIPTION is
  'The role of the item administered in the order.';
COMMENT ON COLUMN INPUTEVENTS_MV.ORDERCATEGORYDESCRIPTION is
  'The type of item administered.';
COMMENT ON COLUMN INPUTEVENTS_MV.PATIENTWEIGHT is
  'For drugs dosed by weight, the value of the weight used in the calculation.';
COMMENT ON COLUMN INPUTEVENTS_MV.TOTALAMOUNT is
  'The total amount in the solution for the given item.';
COMMENT ON COLUMN INPUTEVENTS_MV.TOTALAMOUNTUOM is
  'Unit of measurement for the total amount in the solution.';
COMMENT ON COLUMN INPUTEVENTS_MV.ISOPENBAG is
  'Indicates whether the bag containing the solution is open.';
COMMENT ON COLUMN INPUTEVENTS_MV.CONTINUEINNEXTDEPT is
  'Indicates whether the item will be continued in the next department where the patient is transferred to.';
COMMENT ON COLUMN INPUTEVENTS_MV.CANCELREASON is
  'Reason for cancellation, if cancelled.';
COMMENT ON COLUMN INPUTEVENTS_MV.STATUSDESCRIPTION is
  'The current status of the order: stopped, rewritten, running or cancelled.';
COMMENT ON COLUMN INPUTEVENTS_MV.COMMENTS_EDITEDBY is
  'The title of the caregiver who edited the order.';
COMMENT ON COLUMN INPUTEVENTS_MV.COMMENTS_CANCELEDBY is
  'The title of the caregiver who canceled the order.';
COMMENT ON COLUMN INPUTEVENTS_MV.COMMENTS_DATE is
  'Time at which the caregiver edited or cancelled the order.';
COMMENT ON COLUMN INPUTEVENTS_MV.ORIGINALAMOUNT is
  'Amount of the item which was originally charted.';
COMMENT ON COLUMN INPUTEVENTS_MV.ORIGINALRATE is
  'Rate of administration originally chosen for the item.';

-------------
--LABEVENTS--
-------------

-- Table
COMMENT ON TABLE LABEVENTS IS
   'Events relating to laboratory tests.';

-- Columns
COMMENT ON COLUMN LABEVENTS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN LABEVENTS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN LABEVENTS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN LABEVENTS.ITEMID is
   'Foreign key. Identifies the charted item.';
COMMENT ON COLUMN LABEVENTS.CHARTTIME is
   'Time when the event occured.';
COMMENT ON COLUMN LABEVENTS.VALUE is
   'Value of the event as a text string.';
COMMENT ON COLUMN LABEVENTS.VALUENUM is
   'Value of the event as a number.';
COMMENT ON COLUMN LABEVENTS.VALUEUOM is
   'Unit of measurement.';
COMMENT ON COLUMN LABEVENTS.FLAG is
   'Flag indicating whether the lab test value is considered abnormal (null if the test was normal).';

----------------------
--MICROBIOLOGYEVENTS--
----------------------

-- Table
COMMENT ON TABLE MICROBIOLOGYEVENTS IS
   'Events relating to microbiology tests.';

-- Columns
COMMENT ON COLUMN MICROBIOLOGYEVENTS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.CHARTDATE is
   'Date when the event occured.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.CHARTTIME is
   'Time when the event occured, if available.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.SPEC_ITEMID is
   'Foreign key. Identifies the specimen.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.SPEC_TYPE_DESC is
   'Description of the specimen.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.ORG_ITEMID is
   'Foreign key. Identifies the organism.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.ORG_NAME is
   'Name of the organism.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.ISOLATE_NUM is
   'Isolate number associated with the test.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.AB_ITEMID is
   'Foreign key. Identifies the antibody.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.AB_NAME is
   'Name of the antibody used.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.DILUTION_TEXT is
   'The dilution amount tested for and the comparison which was made against it (e.g. <=4).';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.DILUTION_COMPARISON is
   'The comparison component of DILUTION_TEXT: either <= (less than or equal), = (equal), or >= (greater than or equal), or null when not available.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.DILUTION_VALUE is
   'The value component of DILUTION_TEXT: must be a floating point number.';
COMMENT ON COLUMN MICROBIOLOGYEVENTS.INTERPRETATION is
   'Interpretation of the test.';

--------------
--NOTEEVENTS--
--------------

-- Table
COMMENT ON TABLE NOTEEVENTS IS
   'Notes associated with hospital stays.';

-- Columns
COMMENT ON COLUMN NOTEEVENTS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN NOTEEVENTS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN NOTEEVENTS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN NOTEEVENTS.CHARTDATE is
   'Date when the note was charted.';
COMMENT ON COLUMN NOTEEVENTS.CHARTTIME is
   'Date and time when the note was charted. Note that some notes (e.g. discharge summaries) do not have a time associated with them: these notes have NULL in this column.';
COMMENT ON COLUMN NOTEEVENTS.CATEGORY is
   'Category of the note, e.g. Discharge summary.';
COMMENT ON COLUMN NOTEEVENTS.DESCRIPTION is
   'A more detailed categorization for the note, sometimes entered by free-text.';
COMMENT ON COLUMN NOTEEVENTS.CGID is
   'Foreign key. Identifies the caregiver.';
COMMENT ON COLUMN NOTEEVENTS.ISERROR is
   'Flag to highlight an error with the note.';
COMMENT ON COLUMN NOTEEVENTS.TEXT is
   'Content of the note.';

------------
--PATIENTS--
------------

-- Table
COMMENT ON TABLE OUTPUTEVENTS IS
   'Outputs recorded during the ICU stay.';

-- Columns
COMMENT ON COLUMN OUTPUTEVENTS.ROW_ID is
  'Unique row identifier.';
COMMENT ON COLUMN OUTPUTEVENTS.SUBJECT_ID is
  'Foreign key. Identifies the patient.';
COMMENT ON COLUMN OUTPUTEVENTS.HADM_ID is
  'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN OUTPUTEVENTS.ICUSTAY_ID is
  'Foreign key. Identifies the ICU stay.';
COMMENT ON COLUMN OUTPUTEVENTS.CHARTTIME is
  'Time when the output was recorded/occurred.';
COMMENT ON COLUMN OUTPUTEVENTS.ITEMID is
  'Foreign key. Identifies the charted item.';
COMMENT ON COLUMN OUTPUTEVENTS.VALUE is
  'Value of the event as a float.';
COMMENT ON COLUMN OUTPUTEVENTS.VALUEUOM is
  'Unit of measurement.';
COMMENT ON COLUMN OUTPUTEVENTS.STORETIME is
  'Time when the event was recorded in the system.';
COMMENT ON COLUMN OUTPUTEVENTS.CGID is
  'Foreign key. Identifies the caregiver.';
COMMENT ON COLUMN OUTPUTEVENTS.STOPPED is
  'Event was explicitly marked as stopped. Infrequently used by caregivers.';
COMMENT ON COLUMN OUTPUTEVENTS.NEWBOTTLE is
  'Not applicable to outputs - column always null.';
COMMENT ON COLUMN OUTPUTEVENTS.ISERROR is
  'Flag to highlight an error with the measurement.';

------------
--PATIENTS--
------------

-- Table
COMMENT ON TABLE PATIENTS IS
   'Patients associated with an admission to the ICU.';

-- Columns
COMMENT ON COLUMN PATIENTS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN PATIENTS.SUBJECT_ID is
   'Primary key. Identifies the patient.';
COMMENT ON COLUMN PATIENTS.GENDER is
   'Gender.';
COMMENT ON COLUMN PATIENTS.DOB is
   'Date of birth.';
COMMENT ON COLUMN PATIENTS.DOD is
   'Date of death. Null if the patient was alive at least 90 days post hospital discharge.';
COMMENT ON COLUMN PATIENTS.DOD_HOSP is
   'Date of death recorded in the hospital records.';
COMMENT ON COLUMN PATIENTS.DOD_SSN is
   'Date of death recorded in the social security records.';
COMMENT ON COLUMN PATIENTS.EXPIRE_FLAG is
   'Flag indicating that the patient has died.';

----------------------
--PROCEDUREEVENTS_MV--
----------------------


COMMENT ON TABLE PROCEDUREEVENTS_MV IS
   'Procedure start and stop times recorded for MetaVision patients.';

-----------------
--PRESCRIPTIONS--
-----------------

-- Table
COMMENT ON TABLE PRESCRIPTIONS IS
   'Medicines prescribed.';

-- Columns
COMMENT ON COLUMN PRESCRIPTIONS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN PRESCRIPTIONS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN PRESCRIPTIONS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN PRESCRIPTIONS.ICUSTAY_ID is
   'Foreign key. Identifies the ICU stay.';
COMMENT ON COLUMN PRESCRIPTIONS.STARTDATE is
   'Date when the prescription started.';
COMMENT ON COLUMN PRESCRIPTIONS.ENDDATE is
   'Date when the prescription ended.';
COMMENT ON COLUMN PRESCRIPTIONS.DRUG_TYPE is
   'Type of drug.';
COMMENT ON COLUMN PRESCRIPTIONS.DRUG is
   'Name of the drug.';
COMMENT ON COLUMN PRESCRIPTIONS.DRUG_NAME_POE is
   'Name of the drug on the Provider Order Entry interface.';
COMMENT ON COLUMN PRESCRIPTIONS.DRUG_NAME_GENERIC is
   'Generic drug name.';
COMMENT ON COLUMN PRESCRIPTIONS.FORMULARY_DRUG_CD is
   'Formulary drug code.';
COMMENT ON COLUMN PRESCRIPTIONS.GSN is
   'Generic Sequence Number.';
COMMENT ON COLUMN PRESCRIPTIONS.NDC is
   'National Drug Code.';
COMMENT ON COLUMN PRESCRIPTIONS.PROD_STRENGTH is
   'Strength of the drug (product).';
COMMENT ON COLUMN PRESCRIPTIONS.DOSE_VAL_RX is
   'Dose of the drug prescribed.';
COMMENT ON COLUMN PRESCRIPTIONS.DOSE_UNIT_RX is
   'Unit of measurement associated with the dose.';
COMMENT ON COLUMN PRESCRIPTIONS.FORM_VAL_DISP is
   'Amount of the formulation dispensed.';
COMMENT ON COLUMN PRESCRIPTIONS.FORM_UNIT_DISP is
   'Unit of measurement associated with the formulation.';
COMMENT ON COLUMN PRESCRIPTIONS.ROUTE is
   'Route of administration, for example intravenous or oral.';

------------------
--PROCEDURES_ICD--
------------------

-- Table
COMMENT ON TABLE PROCEDURES_ICD IS
   'Procedures relating to a hospital admission coded using the ICD9 system.';

-- Columns
COMMENT ON COLUMN PROCEDURES_ICD.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN PROCEDURES_ICD.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN PROCEDURES_ICD.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN PROCEDURES_ICD.SEQ_NUM is
   'Lower procedure numbers occurred earlier.';
COMMENT ON COLUMN PROCEDURES_ICD.ICD9_CODE is
   'ICD9 code associated with the procedure.';

------------
--SERVICES--
------------

-- Table
COMMENT ON TABLE SERVICES IS
  'Hospital services that patients were under during their hospital stay.';

-- Columns
COMMENT ON COLUMN SERVICES.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN SERVICES.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN SERVICES.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN SERVICES.TRANSFERTIME is
   'Time when the transfer occured.';
COMMENT ON COLUMN SERVICES.PREV_SERVICE is
   'Previous service type.';
COMMENT ON COLUMN SERVICES.CURR_SERVICE is
   'Current service type.';

-------------
--TRANSFERS--
-------------

-- Table
COMMENT ON TABLE TRANSFERS IS
   'Location of patients during their hospital stay.';

-- Columns
COMMENT ON COLUMN TRANSFERS.ROW_ID is
   'Unique row identifier.';
COMMENT ON COLUMN TRANSFERS.SUBJECT_ID is
   'Foreign key. Identifies the patient.';
COMMENT ON COLUMN TRANSFERS.HADM_ID is
   'Foreign key. Identifies the hospital stay.';
COMMENT ON COLUMN TRANSFERS.ICUSTAY_ID is
   'Foreign key. Identifies the ICU stay.';
COMMENT ON COLUMN TRANSFERS.DBSOURCE is
   'Source database of the item.';
COMMENT ON COLUMN TRANSFERS.EVENTTYPE is
   'Type of event, for example admission or transfer.';
COMMENT ON COLUMN TRANSFERS.PREV_WARDID is
   'Identifier for the previous ward the patient was located in.';
COMMENT ON COLUMN TRANSFERS.CURR_WARDID is
   'Identifier for the current ward the patient is located in.';
COMMENT ON COLUMN TRANSFERS.PREV_CAREUNIT is
   'Previous careunit.';
COMMENT ON COLUMN TRANSFERS.CURR_CAREUNIT is
   'Current careunit.';
COMMENT ON COLUMN TRANSFERS.INTIME is
   'Time when the patient was transferred into the unit.';
COMMENT ON COLUMN TRANSFERS.OUTTIME is
   'Time when the patient was transferred out of the unit.';
COMMENT ON COLUMN TRANSFERS.LOS is
   'Length of stay in the unit in minutes.';