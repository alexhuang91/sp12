--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

DROP TABLE public.restaurantphone;
DROP TABLE public.restaurantaddress;
DROP TABLE public.addressphone;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: addressphone; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE addressphone (
    address character varying(100),
    phone character varying(100)
);


--
-- Name: restaurantaddress; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE restaurantaddress (
    name character varying(100),
    address character varying(100)
);


--
-- Name: restaurantphone; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE restaurantphone (
    name character varying(200),
    phone character varying(200)
);


--
-- Data for Name: addressphone; Type: TABLE DATA; Schema: public; Owner: -
--

COPY addressphone (address, phone) FROM stdin;
1000 Front Street Sacramento	(916) 441-4440
1000 Ghent Road Akron	(330) 666-6158
1000 Lancaster St # 1E Baltimore	(410) 332-7373
1000 Osage Street Denver	(303) 534-9505
1000 Penn Avenue Pittsburgh	(412) 281-3700
1001 16th Street Mall Denver	(303) 534-7616
1001 Alaskan Way Seattle	(206) 624-6852
1001 Broadway Nashville	(615) 726-1001
1001 B Street Hayward	(510) 886-8525
1001 Cathedral Street Baltimore	(410) 539-4252
1001 El Camino Real Redwood City	(650) 365-6297
1001 McKinney Street Houston	(713) 659-3700
1001 North Alameda Street Los Angeles	(213) 628-3781
1001 R Street Sacramento	(916) 443-8825
1001 SE Water Ave # 160 Portland	(503) 235-2294
1002 9th Street Durham	(919) 286-3609
1002 West 36th Street Baltimore	(410) 243-1230
10030 S De Anza Blvd Cupertino	(408) 873-1000
10051 Magnolia Ave # A1 Riverside	(951) 688-9000
1007 Bardstown Road Louisville	(502) 452-9244
100 Broadway Nashville	(615) 742-9900
100 Capitol Mall Sacramento	(916) 326-5050
100 East 14th Street Kansas City	(816) 471-2340
100 E Wisconsin Ave # 1 Milwaukee	(414) 272-3199
100 Lafayette Street Baton Rouge	(225) 346-5100
100 Lafayette Street Baton Rouge	(225) 381-8140
100 N. Tryon Street Charlotte	(704) 332-1132
100 Red River Street Austin	(512) 478-4855
100 Renaissance Center Detroit	(313) 567-2622
100 Seawall Drive Berkeley	(510) 549-1900
100 W Broadway # 1000 Long Beach	(562) 432-7463
100 West 14th Avenue Parkway Denver	(720) 865-5000
100 West Station Square Drive Pittsburgh	(412) 261-1717
100 Yacht Club Drive San Rafael	(415) 460-6669
10100 South De Anza Boulevard Cupertino	(408) 252-7427
1010 Lincoln Avenue Napa	(707) 226-2633
1010 Nicollet Mall Minneapolis	(612) 332-1010
1010 W Southern Ave # 1 Mesa	(480) 844-1290
10111 Perkins Rowe # 100 Baton Rouge	(225) 769-0077
1011 North Dobson Road Mesa	(480) 615-1444
10123 North Wolfe Road Cupertino	(408) 996-1680
10123 N. Wolfe Road Cupertino	(408) 253-1605
10145 North De Anza Boulevard Cupertino	(408) 725-8168
1014 N Lamar Blvd Austin	(512) 482-8868
1014 Southwest Stark Street Portland	(503) 228-3333
10155 Perkin Row Avenue Baton Rouge	(225) 766-5353
1015 Front Street Sacramento	(916) 446-6768
1015 Rio Grande Boulevard Northwest Albuquerque	(505) 843-9500
1016 Court Street San Rafael	(415) 721-7700
1017 Howard Omaha	(402) 341-3547
1017 North Flores Street San Antonio	(210) 320-5865
1019 Clay St Oakland	(510) 763-8495
1019 Hendricks Avenue Jacksonville	(904) 306-0100
101 Arlington Street Boston	(617) 423-1112
101 Cyril Magnin Street San Francisco	(415) 982-7874
101 East 13th Street Kansas City	(816) 221-1900
101 East Jackson Street Phoenix	(480) 478-0629
101 Fountaingrove Parkway Santa Rosa	(707) 578-6101
101 Heights Boulevard Houston	(713) 869-6300
101 Hudson St # 1 Jersey City	(201) 200-1867
101 Hudson Street Jersey City	(201) 333-6500
101 N Houston Fort Worth	(817) 391-3966
101 Pine Avenue Long Beach	(562) 491-0066
101 W. 34th Anchorage	(907) 562-8787
101 West 22nd St # 300 Kansas City	(816) 472-7427
101 West 22nd Street Kansas City	(816) 221-3722
1020 16th St, # 2 Sacramento	(916) 233-3633
1020 Main Street Redwood City	(650) 366-1498
1020 W. Arkansas Lane Arlington	(817) 795-2600
1022 Howard Street Omaha	(402) 345-8980
1023 4th Avenue San Diego	(619) 233-9273
10260 Midtown Pkwy Jacksonville	(904) 998-9511
1026 1st Street Napa	(707) 254-8006
10281 Midtown Parkway Jacksonville	(904) 641-3392
1028 E 5th Ave # E Anchorage	(907) 258-3030
1028 East Juneau Avenue Milwaukee	(414) 291-3770
1029 K St Sacramento	(916) 498-9800
102 Pine Ave Long Beach	(562) 628-8866
1031 West Lee Drive Baton Rouge	(225) 766-7823
10330 N. Wolfe Road Cupertino	(408) 446-2222
1033 Van Ness Avenue Fresno	(559) 497-3000
10343 North Wolfe Road Cupertino	(408) 257-2050
1034 B Street Hayward	(510) 888-1092
1034 McCarter Highway Newark	(973) 622-6221
1034 West 4th Avenue Anchorage	(907) 272-2489
10350 South De Anza Boulevard Cupertino	(408) 517-1440
1035 Southwest Stark Street Portland	(503) 226-4171
10367 Midtown Parkway Jacksonville	(904) 380-4360
1036 S Jackson St # A Seattle	(206) 860-1404
10385 South De Anza Boulevard Cupertino	(408) 252-5421
1038 Southwest Stark Street Portland	(503) 222-3354
103 Mcwhorter St # A Newark	(973) 589-4959
103 Montgomery Street Jeresy City	(201) 433-4567
1040 Clinton St Napa	(707) 255-6646
1041 Middlefield Road Redwood City	(650) 701-1000
1041 North Old World 3rd Street Milwaukee	(414) 271-3377
1047 Main Street Buffalo	(716) 883-1134
10500 4th Street Northwest Albuquerque	(505) 898-1771
10525 S. De Anza Blvd. #100 Cupertino	(408) 873-1600
1055 4th Street Santa Rosa	(707) 528-3336
105 North Country Club Drive Mesa	(480) 964-1851
105 North Main Street Akron	(330) 253-2999
105 S 2nd St Memphis	(901) 522-8228
1063 Wisconsin Avenue Northwest Washington D.C.	(202) 338-8800
1064 W Side Ave Jersey City	(201) 432-4111
1065 North Dobson Road Mesa	(480) 844-8629
10690 N. De Anza Blvd. Cupertino	(408) 865-6970
106 King Street Madison	(608) 259-1040
106 South 13th Street Philadelphia	(215) 546-7100
106 W 12th St Kansas City	(816) 221-7000
1071 Celestial Street Cincinnati	(513) 241-4455
1075 California Blvd. Napa	(707) 253-9540
10773 Hole Avenue Riverside	(951) 352-0240
107 D Street Northeast Washington D.C.	(202) 546-4488
107 South Franklin Street Tampa	(813) 225-4288
107 West Main Street Durham	(919) 956-9999
10801 North Wolfe Road Cupertino	(408) 446-3853
1081 Elmwood Avenue Buffalo	(716) 886-9081
1082 B St Hayward	(510) 886-9823
108 East Forsyth Street Jacksonville	(904) 356-8282
1090 Point Lobos Avenue San Francisco	(415) 386-3330
10911 North Wolfe Road Cupertino	(408) 255-6988
1096 Grand Avenue Saint Paul	(651) 222-5878
1099 Middlefield Road Redwood City	(650) 369-4730
109 Bergen Street Newark	(973) 802-1555
109 N Oregon St # 1 El Paso	(915) 545-2233
10 Bosworth Street Boston	(617) 422-0004
10 Mark Lane San Francisco	(415) 788-7152
10 North Illinois Street Indianapolis	(317) 636-7600
10 Northwest 12th Avenue Portland	(503) 227-5320
10 South 2nd Street Philadelphia	(215) 627-0666
10 West Franklin Street Raleigh	(919) 833-7999
10 West Washington Street Indianapolis	(317) 681-8180
10 West Yuma Street Phoenix	(602) 340-1304
1100 Burlingame Avenue Burlingame	(650) 373-7883
1100 Maryland Avenue Baltimore	(410) 385-0318
1100 Nicollet Avenue Minneapolis	(612) 630-1189
1100 Pike Street Seattle	(206) 583-0382
1100 South Flower Street Los Angeles	(213) 763-4600
1100 West 8th Avenue Anchorage	(907) 222-5212
1100 West Katella Avenue Anaheim	(714) 772-0414
11010 Bollinger Canyon Rd # B San Ramon	(925) 964-0444
1101 4th Ave Seattle	(206) 624-7755
1101 Burlingame Ave Burlingame	(650) 343-2075
1101 Geary Boulevard San Francisco	(415) 775-4216
1101 North Highland Street Arlington	(703) 524-7455
1101 North Water Street Milwaukee	(414) 272-1195
1101 Pennsylvania Avenue NW # 1 Washington D.C.	(202) 347-4668
1104 Elmwood Avenue Buffalo	(716) 886-1449
1105 East Katella Avenue Anaheim	(714) 634-2994
1106 East Colonial Drive Orlando	(407) 423-8539
1106 North Charles Street Baltimore	(410) 547-9310
1108 Howard Street Omaha	(402) 342-2050
110 Central Avenue Southwest Albuquerque	(505) 246-9900
110 East Crockett San Antonio	(210) 277-6300
110 East Davie Street Raleigh	(919) 834-6963
110 East Pennington Street Tucson	(520) 622-6400
110 East Washington Street Indianapolis	(317) 822-9990
110 Montrose West Avenue Akron	(330) 665-4849
110 North Illinois Street Indianapolis	(317) 631-9500
110 Soledad Street San Antonio	(210) 223-3913
1110 Front Street Sacramento	(916) 442-8226
1111 J Street Sacramento	(916) 442-8200
1112 2nd Street Sacramento	(916) 442-4772
1114 Grandview Avenue Pittsburgh	(412) 431-3100
1114 Washington Boulevard Detroit	(313) 442-1600
1116 Broad Street Durham	(919) 416-5040
1116 Elmwood Ave # A Buffalo	(716) 886-4000
1116 North Fulton Street Fresno	(559) 266-5510
1116 S Dobson Rd. #111 Mesa	(480) 668-7979
1117 11th Street Sacramento	(916) 447-8900
1119 18th Street Bakersfield	(661) 323-2901
1119 4th Street San Rafael	(415) 258-9202
1119 S. Olive Street Los Angeles	(213) 746-7746
111 Broadway Nashville	(615) 251-4677
111 Country Club Drive Incline Village-Crystal Bay	(775) 886-6899
111 East 3rd Street Fort Worth	(817) 336-0880
111 South Leona Street San Antonio	(210) 225-6060
111 Southwest 5th Avenue # 3000 Portland	(503) 450-0030
111 W Crockett St # 104 San Antonio	(210) 229-1941
111 West Crockett San Antonio	(210) 227-2782
1121 Nuuanu Avenue Honolulu	(808) 521-2900
1121 South Western Avenue Los Angeles	(323) 734-2773
1122 Main Street Napa	(707) 224-6328
112 4th Street Santa Rosa	(707) 525-1690
1126 North High Street Columbus	(614) 294-4900
1126 Queens Highway Long Beach	(562) 435-3511
1127 Connecticut Avenue NW Washington	(202) 347-3000
112 East Hennepin Avenue Minneapolis	(612) 379-2021
112 Krog Street Northeast Atlanta	(404) 524-8280
112 North 3rd St Minneapolis	(612) 343-7696
112 Romero St NW Albuquerque	(505) 247-3545
112 Southwest 2nd Avenue Portland	(503) 227-4057
1130 South Dobson Road Mesa	(480) 962-0036
1131 K St Sacramento	(916) 443-3772
1131 Market St # 31 Philadelphia	(215) 238-1000
113 20th Street North Birmingham	(205) 322-1282
1132 4th Street San Rafael	(415) 456-4677
1135 Airway Boulevard El Paso	(915) 778-9696
11401 Bellflower Rd Cleveland	(216) 791-7880
1140 Main Street Napa	(707) 251-5656
114 28th Avenue North Nashville	(615) 320-4399
1144 Crescent Avenue NE Atlanta	(404) 873-7358
1146 Williamson St Madison	(608) 280-0104
1147 Bardstown Rd Louisville	(502) 451-0447
114 First Avenue S Seattle	(206) 622-2563
114 Halsey Street Newark	(973) 624-7322
1150 Santa Rosa Avenue Santa Rosa	(707) 542-0861
1150 Smallman Street Pittsburgh	(412) 201-5656
1157 Columbia Street San Diego	(619) 234-2739
115 Baker Ave Santa Rosa	(707) 542-2309
115 East Tropicana Avenue Las Vegas	(702) 739-9000
115 Grove Street Tahoe City	(530) 583-8551
1160 Smith Street Houston	(713) 650-0837
116 Brooke Avenue Norfolk	(757) 222-9191
116 S Hamilton St Madison	(608) 256-3570
117 East Washington St # 100 Indianapolis	(317) 638-4000
117 Montgomery Street Jersey City	(201) 915-0062
117 West Adams Street Jacksonville	(904) 355-3793
1185 East Champlain Drive Fresno	(559) 433-3300
11891 Dublin Boulevard Dublin	(925) 828-9380
118 Central Avenue Southwest Albuquerque	(505) 842-5099
118 East 6th Street Los Angeles	(213) 622-4090
118 West Chippewa Street Buffalo	(716) 856-2444
118 W Lafayette Blvd Detroit	(313) 964-8198
119 North 4th Street Minneapolis	(612) 333-7359
11 Cesar Chavez St St Paul	(651) 222-8499
11 G Street San Rafael	(415) 453-6427
11 North Michigan Avenue Chicago	(312) 521-7275
1200 5th Ave N # 100 Nashville	(615) 242-3226
1200 Epcot Resorts Boulevard Lake Buena Vista	(407) 934-3000
1200 South Lake Shore Drive Chicago	(312) 939-2438
1200 Villa Place Nashville	(615) 730-8540
1201 16th St # 100 Denver	(303) 595-0333
1201 1st Street Coronado	(619) 435-4900
1201 24th St # C110 Bakersfield	(661) 325-1500
1201 24th St # D100 Bakersfield	(661) 323-2252
1201 Alaskan Way # 101 Seattle	(206) 623-4340
1201 Gulf Life Drive Jacksonville	(904) 396-6200
1201 Napa Town Ctr Napa	(707) 265-9508
1201 North Pennsylvania Avenue Oklahoma City	(405) 524-0999
1201 Payne Street Louisville	(502) 584-1635
1201 University Road Cleveland	(216) 771-9236
1201 Williamson Street Madison	(608) 442-6207
120 2nd Avenue North Nashville	(615) 256-9453
1202 North Franklin Street Tampa	(813) 275-5000
1203 18th Street Bakersfield	(661) 324-9441
1204 Harmon Place Minneapolis	(612) 288-0138
1205 Broadway Burlingame	(650) 344-3900
1205 E Brady St Milwaukee	(414) 291-5233
120 5th St Santa Rosa	(707) 545-5876
1207 Burlingame Avenue Burlingame	(650) 343-5676
1208 South Howard Avenue Tampa	(813) 251-2421
120 Country Club Dr # 24 Incline Village-Crystal Bay	(775) 832-7778
120 Country Club Dr # 29 Incline Village-Crystal Bay	(775) 831-0800
120 East Wilson Street Madison	(608) 258-8787
120 Huntington Avenue Boston	(617) 424-7000
120 Huntington Avenue Boston	(617) 425-3240
120 Monroe Ave Memphis	(901) 527-7085
1210 E. Main Mesa	(480) 962-4457
1211 Vine Street Cincinnati	(513) 621-1999
1213 Burlingame Avenue Burlingame	(650) 343-5130
1213 K Street Sacramento	(916) 448-8900
1213 U Street Northwest Washington D.C.	(202) 667-0909
1215 Lincoln Avenue Alameda	(510) 865-8000
1216 Burlingame Avenue Burlingame	(650) 342-1357
1218 20th St S Birmingham	(205) 933-0999
1219 South 9th Street Philadelphia	(215) 389-0659
121 East Sheridan Avenue Oklahoma City	(405) 319-9599
121 South 13th Street Philadelphia	(215) 928-9800
1220 East Prince Road Tucson	(520) 323-1022
1220 Southwest 1st Avenue Portland	(503) 227-7342
1221 Northwest 21st Avenue Portland	(503) 248-9663
1221 South Harbor Boulevard Anaheim	(714) 758-0900
1222 Sunland Park Drive El Paso	(915) 581-3371
1225 1st Avenue Seattle	(206) 957-8444
122 North 2nd Street Phoenix	(602) 440-3166
122 West Neal Street Pleasanton	(925) 600-9200
1230 4th Street San Rafael	(415) 456-4455
1230 West 27th Avenue Anchorage	(907) 276-4200
123 2nd Avenue South Nashville	(615) 242-2722
1237 East Passyunk Avenue Philadelphia	(215) 468-1546
1238 4th Street San Rafael	(415) 460-9883
1239 6th Avenue North Nashville	(615) 242-2563
1239 Southwest Broadway Portland	(503) 222-9070
123 E Doty St # 1 Madison	(608) 284-0000
1242 4th Street San Rafael	(415) 455-9777
1244 Weathervane Lane Akron	(330) 836-7777
124 East Sheridan Avenue Oklahoma City	(405) 235-4410
124 Granby Street Norfolk	(757) 624-1906
124 Wonder Street Reno	(775) 324-1864
1250 Library Street Detroit	(313) 962-8800
1250 Old Bayshore Highway Burlingame	(650) 342-6297
1250 South Alma School Road Mesa	(480) 833-4646
1257 Park Street Alameda	(510) 522-8865
125 West Church Street Orlando	(321) 281-8140
125 West Station Square Dr # 106 Pittsburgh	(412) 261-3477
1260 Main Street Napa	(707) 255-5552
1261 Southern Ave Mesa	(480) 964-5166
126 Beale Street Memphis	(901) 527-0166
126 Broadway Oakland	(510) 663-2350
126 East 6th Street Cincinnati	(513) 421-1688
126 North West Street Raleigh	(919) 833-5535
1275 McKinstry Street Napa	(707) 253-2111
1276 West 6th Street Cleveland	(216) 623-1212
1278 Grand Ave St Paul	(651) 696-1666
127 Public Sq. Cleveland	(216) 696-9200
127 South Illinois Street Indianapolis	(317) 635-0636
127 West 4th Street Cincinnati	(513) 721-1345
128 Fremont Street Las Vegas	(702) 366-7397
128 Frontage Road Newark	(973) 690-5500
12903 Hood Landing Road Jacksonville	(904) 268-3474
1293 Bardstown Road Louisville	(502) 451-0700
1299 Olentangy River Road Columbus	(614) 291-3663
129 East Nationwide Boulevard Columbus	(614) 461-0033
12 East California Avenue Oklahoma City	(405) 278-8888
12 E Exchange St # 1 Akron	(330) 253-1888
1300 10th St Berkeley	(510) 527-0099
1300 Battery Street San Francisco	(415) 982-2000
1300 Howard Ave Burlingame	(650) 558-8268
1300 Redgate Avenue Norfolk	(757) 627-8041
1300 West 9th Street Cleveland	(216) 575-0699
1301 4th St San Rafael	(415) 457-4088
1301 Alaskan Way Seattle	(206) 624-1890
1301 Franklin Street Oakland	(510) 893-0383
1301 North State Parkway Chicago	(312) 266-0360
1301 Pennsylvania Avenue Northwest Washington D.C.	(202) 464-4461
1305 7th Street West Saint Paul	(651) 228-1408
1309 South Agnew Avenue Oklahoma City	(405) 236-0416
130 Ferry Street Newark	(973) 589-0550
130 North Central Avenue Phoenix	(602) 258-3069
130 West Street Reno	(775) 323-2227
1310 Burlingame Avenue Burlingame	(650) 344-1310
1310 Drury Street Philadelpiha	(215) 735-5562
1310 Magruder St El Paso	(915) 778-3323
1310 New Hampshire Avenue Northwest Washington D.C.	(202) 861-1310
1310 W Magnolia Avenue Fort Worth	(817) 877-0700
1313 Park Street Alameda	(510) 769-1011
1314 McKinstry Street Napa	(707) 257-5157
1314 Northwest Glisan Street Portland	(503) 228-9535
1314 Prudential Drive Jacksonville	(904) 398-8989
1318 Louisiana Street Houston	(713) 659-8231
131 River Road Louisville	(502) 568-1171
131 West Market Street Louisville	(502) 584-7800
1321 Commerce Street Dallas	(214) 742-8200
1328 Sixth Street Berkeley	(510) 525-3121
1329 Gilman Street Albany	(510) 527-9838
132 E. Trade Street Charlotte	(704) 377-0400
132 Southwest 3rd Avenue Portland	(503) 222-3187
1332 Park St # D Alameda	(510) 769-4828
1332 West Burnside Street Portland	(503) 225-0047
1333 1st Street Coronado	(619) 437-4911
1333 New Hampshire Ave NW Washington	(202) 296-6500
1333 University Avenue Riverside	(951) 682-4580
1335 Baltimore Avenue Kansas City	(816) 303-1686
1339 Pearl St # 104 Napa	(707) 224-9161
1340 S Sanderson Ave Anaheim	(714) 563-4166
13451 Skyline Boulevard Woodside	(650) 851-1229
1345 Park Street Alameda	(510) 522-6200
134 South Wabash Avenue Chicago	(312) 263-4988
1350 Stardust Street Reno	(775) 746-2929
1356 West Southern Avenue Mesa	(480) 833-1144
135 South 6th Avenue Tucson	(520) 629-0191
135 South Wilmington Street Raleigh	(919) 896-8513
1360 North Harbor Drive San Diego	(619) 232-5103
1365 Osage Street Denver	(303) 595-3666
136 East Hargett Street Raleigh	(919) 832-6090
1375 Delaware Avenue Buffalo	(716) 885-0074
137 South Wilmington Street Raleigh	(919) 239-4070
13808 Skyline Boulevard Woodside	(650) 851-8541
1385 Napa Town Center Napa	(707) 251-0100
138 Beale Street Memphis	(901) 526-3637
138 Market Street Philadelphia	(215) 923-6069
138 South 2nd Street Philadelphia	(215) 413-1443
138 St. James Avenue Boston	(617) 267-5300
1390 West 9th Street Cleveland	(216) 687-9494
139 7th Street Pittsburgh	(412) 391-1091
139 East Adams Street Phoenix	(602) 252-2742
139 South Tryon Street Charlotte	(704) 601-4141
13 East Martin Street Raleigh	(919) 832-5714
1400 Arapahoe Denver	(303) 991-2277
1400 North Collins Street Arlington	(817) 275-8973
1400 Smallman Street Pittsburgh	(412) 552-0150
1400 South Harbor Boulevard Anaheim	(714) 956-2223
1400 West 6th Street Cleveland	(216) 696-2767
1401 23rd Street Bakersfield	(661) 324-9100
1401 3rd Avenue Seattle	(206) 623-4450
1401 Curtis Street Denver	(303) 825-6500
1401 K Street Northwest Washington D.C.	(202) 216-5988
1401 Pennsylvania Avenue Northwest Washington D.C.	(202) 628-9100
1401 South Michigan Avenue Chicago	(312) 786-1401
1403 Nance Street Houston	(713) 226-8563
1403 Washington Avenue New Orleans	(504) 899-8221
1405 Central Avenue Northeast Albuquerque	(505) 247-1421
1405 Locust Street Philadelphia	(215) 735-7700
1405 Park Street Alameda	(510) 521-6862
140 5th Avenue South Nashville	(615) 742-7256
1406 South 13th Street Omaha	(402) 342-9838
1406 West 6th Street Cleveland	(216) 623-0055
1408 Colley Avenue Norfolk	(757) 623-3216
140 Homer Avenue Palo Alto	(650) 326-2530
140 Newark Avenue Jersey City	(201) 536-5557
140 North 4th Street Louisville	(502) 568-4239
140 North 4th Street Louisville	(502) 589-5200
140 Northern Avenue Boston	(617) 482-6262
140 South Illinois Street Indianapolis	(317) 955-9900
1415 24th St Bakersfield	(661) 323-8801
1415 L Street Sacramento	(916) 440-8888
1418 East Lincoln Avenue Anaheim	(714) 535-9815
1418 North Central Avenue Phoenix	(602) 257-0380
141 Elm St Newark	(973) 465-1350
141 South Grand Avenue Los Angeles	(213) 972-3331
141 South Meridian St # 10 Indianapolis	(317) 822-9300
1420 5th Ave # 350 Seattle	(206) 623-1300
1420 Sycamore St Cincinnati	(513) 721-6200
1421 17th Place Bakersfield	(661) 323-6889
1421 Farnam Street Omaha	(402) 342-3662
1425 Aliceanna Street Baltimore	(410) 534-7296
1425 First St. Napa	(707) 252-1022
1427 14th Avenue South Birmingham	(205) 933-2133
1430 Larimer Street Denver	(303) 534-2367
1430 Potomac Avenue Pittsburgh	(412) 561-9320
1435 Randolph St Detroit	(313) 962-4180
1437 California Street Denver	(303) 623-4867
143 Beale Street Memphis	(901) 524-5464
1440 Park Street Alameda	(510) 769-9110
1440 San Marco Boulevard Jacksonville	(904) 398-1949
1445 Ross Avenue # 150 Dallas	(214) 965-0055
1447 Burlingame Avenue Burlingame	(650) 348-3277
1448 Burlingame Avenue Burlingame	(650) 375-1000
144 Bourbon Street New Orleans	(504) 522-0111
144 North Blackstone Avenue Fresno	(559) 237-5540
1450 Ala Moana Blvd # 3253 Honolulu	(808) 949-4867
1453 Larimer Street Denver	(303) 534-5855
145 Allen Street Buffalo	(716) 886-0602
145 South Main Street Memphis	(901) 522-8555
1460 E Shaw Avenue Fresno	(559) 221-9495
146 6th Street Pittsburgh	(412) 566-7366
146 East Houston Street San Antonio	(210) 222-2362
146 Sunset Drive San Ramon	(925) 867-1407
14718 Detroit Avenue Lakewood	(216) 226-3699
1475 Shattuck Avenue Berkeley	(510) 848-3354
1480 South Harbor Boulevard Anaheim	(714) 535-6892
# 148, 4200 Conroy Rd Orlando	(407) 226-0333
148 Delancey Street Newark	(973) 274-0600
1492 Bayshore Hwy Burlingame	(650) 375-8804
1496 Old Bayshore Highway Burlingame	(650) 342-5202
149 Union Avenue Memphis	(901) 529-4000
14 E Hargett St Raleigh	(919) 833-0999
1500 Barton Springs Road Austin	(512) 476-1090
1500 Convention Center Drive Arlington	(817) 261-8200
1500 Epcot Resorts Boulevard Lake Buena Vista	(407) 934-4000
1500 S Harbor Blvd Anaheim	(714) 491-0563
1501 Arlington Boulevard Arlington	(703) 524-5000
1501 East Yandell Drive El Paso	(915) 577-0961
1501 Gulf Life Drive Jacksonville	(904) 398-3353
1501 North Saddle Creek Road Omaha	(402) 558-7717
1501 West Magnolia Avenue Fort Worth	(817) 926-3663
1502 South Howard Ave. Tampa	(813) 250-0203
1506 Park Street Alameda	(510) 521-2141
1507 Park Street Alameda	(510) 522-8108
1508 Park Street Alameda	(510) 865-5101
1509 17th St NW # 1 Washington D.C.	(202) 332-9200
150 Montrose West Ave Akron	(330) 666-5522
150 N. Dearborn Chicago	(312) 422-0150
150 Peabody Pl # 103 Memphis	(901) 526-7600
150 South 2nd Street San Jose	(408) 287-9955
150 South 5th Street Louisville	(502) 580-1350
150 West Congress Street Detroit	(313) 965-4970
150 West Main Street Norfolk	(757) 622-3210
1510 Riverplace Blvd. Jacksonville	(904) 399-3933
1512 Commerce Street Dallas	(214) 742-3873
1512 Curtis Street Denver	(303) 534-4842
1512 Shattuck Avenue Berkeley	(510) 549-3183
1512 Stockton Street San Francisco	(415) 392-1700
1515 Market Street Denver	(303) 571-0011
1515 S. Disneyland Drive Anaheim	(714) 772-0413
1516 Sansom Street Philadelphia	(215) 569-9525
1517 Connecticut Avenue Northwest Washington D.C.	(202) 387-1462
1517 Shattuck Avenue Berkeley	(510) 548-5525
1518 Broadway Sacramento	(916) 441-0222
1518 Park Street Alameda	(510) 521-0130
1520 Cental Ave. SE Albuquerque	(505) 243-0023
1520 Elm St # 100 Dallas	(214) 752-0141
1520 Lakeside Drive Oakland	(510) 208-5253
1520 Main Street Dallas	(214) 749-4766
1520 Nolan Ryan Expressway Arlington	(817) 261-4696
1521 Broadway Street Detroit	(313) 963-0497
1523 Southwest Sunset Boulevard Portland	(503) 293-1790
1523 Walnut Street Philadelphia	(215) 567-1000
1525 Blake Street Denver	(303) 623-5432
1530 Disneyland Drive Anaheim	(714) 778-2583
1530 J St # 100 Sacramento	(916) 288-0970
1530 J St # 150 Sacramento	(916) 447-2112
1530 Main Street Dallas	(214) 748-1300
1533 4th Street San Rafael	(415) 456-1011
1535 Kern Street Fresno	(559) 237-2037
1538 Bardstown Road Louisville	(502) 473-8560
153 South Illinois Street Indianapolis	(317) 635-9594
1547 North Jackson Street Milwaukee	(414) 276-9608
1549 El Prado San Diego	(619) 557-9441
154 Jackson Street San Jose	(408) 288-8134
1555 South Wells Avenue Reno	(775) 323-1211
1565 Broadway Street Detroit	(313) 962-1355
1580 S Disneyland Dr # 106 Anaheim	(714) 774-4442
158 Fleming Avenue Newark	(973) 589-4344
1590 Bayshore Hwy Burlingame	(650) 692-3113
1590 s disneyland dr Anaheim	(714) 776-5200
15 Beacon Street Boston	(617) 670-2515
15 East California Avenue Oklahoma City	(405) 235-3533
15 North Robinson Avenue Oklahoma City	(405) 601-3800
15 South Alvernon Way Tucson	(520) 326-4700
1600 17th St Denver	(303) 628-5400
1600 East 8th Avenue # C208 Tampa	(813) 242-6688
1600 Genessee St # 225 Kansas City	(816) 842-2866
1600 Old Bayshore Highway Burlingame	(650) 259-9585
1600 South University Drive Fort Worth	(817) 332-6372
1600 Westheimer Road Houston	(713) 524-7744
1601 Guadalupe Street Austin	(512) 322-5131
1601 McKinney Avenue Dallas	(214) 747-1121
1602 Locust Street Philadelphia	(215) 546-0181
1602 U Street Northwest Washington D.C.	(202) 265-2828
1603 San Pablo Avenue Berkeley	(510) 524-5447
1605 S. Stapley Drive Mesa	(480) 539-0240
1607 San Jacinto Boulevard Austin	(512) 474-1958
160 Greene Street Jersey City	(201) 433-8000
160 Jefferson Street San Francisco	(415) 351-5561
160 State Street Boston	(617) 742-2286
160 Union Avenue Memphis	(901) 525-5491
1610 East Shaw Avenue Fresno	(559) 222-1066
1610 Little Raven Street Denver	(720) 904-0965
1610 S Harbor Blvd Anaheim	(714) 776-3300
1610 West Swann Avenue Tampa	(813) 254-5870
1613 4th Street San Rafael	(415) 256-1818
1614 Camden Road Charlotte	(704) 333-9866
1615 J Street Sacramento	(916) 669-5300
1617 Main Street #100 Kansas City	(816) 221-6272
1619 South 1st Street Austin	(512) 447-7825
1619 Webster Street Alameda	(510) 521-9090
161 North High Street Columbus	(614) 228-0500
1620 Strobridge Avenue Castro Valley	(510) 537-9566
1623 South Stapley Drive Mesa	(480) 635-9500
1623 Walnut Street Philadelphia	(215) 988-1799
1624 Harmon Place Minneapolis	(612) 486-5500
1628 Webster Street Oakland	(510) 268-0170
162 Beale Street Memphis	(901) 521-1851
162 East Superior Street Chicago	(312) 266-3337
1630 Spruce Street Riverside	(951) 781-8840
1632 Lemon Street Anaheim	(714) 992-4500
1634 18th Street Denver	(303) 297-2700
1644 Wyandotte Street Kansas City	(816) 221-4713
1650 Soscol Avenue Napa	(707) 224-2330
1652 K Street Northwest Washington D.C.	(202) 861-2233
1658 Westheimer Road Houston	(713) 523-3800
1666 West Exchange Street Akron	(330) 836-6666
1667 Sebastopol Road Santa Rosa	(707) 525-1905
1667 West Steele Lane Santa Rosa	(707) 546-7147
166 Canal Street Boston	(617) 720-4455
166 Second Avenue N. Nashville	(615) 742-4970
169 East Beck Street Columbus	(614) 228-4343
16 North 6th Street Minneapolis	(612) 338-6621
16th & H Streets, N.W. Washington	(202) 638-6600
1700 Airway Blvd El Paso	(915) 779-6633
1700 Embarcadero Road Palo Alto	(650) 856-7700
1700 Humboldt Street Denver	(303) 831-7310
1700 Summit Street Kansas City	(816) 221-7559
1701 John F Kennedy Blvd # 100 Philadelphia	(215) 567-7111
1701 New Stine Road Bakersfield	(661) 832-1278
1701 Toomey Road Austin	(512) 476-5446
1702 East 7th Avenue Tampa	(813) 248-0099
1704 San Marco Blvd Jacksonville	(904) 398-9500
1704 Van Ness Avenue Fresno	(559) 498-6507
1705 South Stapley Drive Mesa	(480) 632-2699
170 Lt George w Lee Avenue Memphis	(901) 334-5900
170 South Market Street San Jose	(408) 283-7200
170 South Market Street San Jose	(408) 998-1900
1710 Edgewater Drive Orlando	(407) 872-2332
1711 Fulton Street Fresno	(559) 268-3596
1713 Webster Street Alameda	(510) 865-3381
1713 Wilson Boulevard Arlington	(703) 841-0001
1717 North Akard Street Dallas	(214) 720-2020
1721 Church Street Nashville	(615) 322-9932
1722 Frankfort Avenue Louisville	(502) 896-8770
1722 Routh St # 132 Dallas	(214) 720-9111
1722 Saint Marys Ave # 110 Omaha	(402) 344-3040
1723 North Halsted Street Chicago	(312) 867-0110
1724 North Farwell Avenue Milwaukee	(414) 289-8776
1727 Brooklyn Avenue Kansas City	(816) 231-1123
1727 East Pratt Street Baltimore	(410) 732-6399
17288 Skyline Boulevard Woodside	(650) 851-0303
1728 Barton Springs Road Austin	(512) 474-4452
1730 Shattuck St Berkeley	(415) 824-4652
1735 Spruce St # F Riverside	(951) 682-4251
1738 Connecticut Avenue Northwest Washington D.C.	(202) 234-6969
1745 San Pablo Avenue Oakland	(510) 444-2626
1747 India Street San Diego	(619) 232-5094
1749 North Oracle Road Tucson	(520) 623-8659
1760 Hillhurst Avenue Los Angeles	(323) 669-0211
177 Park Avenue San Jose	(408) 947-7000
1782 4th Street Berkeley	(510) 525-1440
1782 Madison Avenue Memphis	(901) 272-1277
1784 West Bullard Avenue Fresno	(559) 439-6900
1785 West Lake Boulevard Tahoe City	(530) 583-0871
1788 Shattuck Ave Berkeley	(510) 704-8003
17900 San Ramon Valley Boulevard San Ramon	(925) 327-1400
1796 21st Avenue South Nashville	(615) 383-9333
1799 University Avenue Berkeley	(510) 849-4681
\.


--
-- Data for Name: restaurantaddress; Type: TABLE DATA; Schema: public; Owner: -
--

COPY restaurantaddress (name, address) FROM stdin;
112 Eatwy	112 North 3rd St Minneapolis
1515 Restaurant	1515 Market St. Denver
21c Museum Hotel - Liuisville	700 West Main St. Louisville
24t Strewet Cafe	1415 24th St Bakersfield
27 Mix	27 Halsey Street Newark
2900	2900 N Mesa Street # D El Paso
31 Cjb	31 North Johnson Park Buffalo
42nd Street Oyster Bar & Seafood Grill	508 West Jones St. Raleigh
456 Fi	456 Granby St. Norfolk
4th Street Live	401 South 4th Street Louisville
4t Steret Bistro	3065 W 4th Street Reno
518 Wwst Ita;ianh Caf	518 West Jones Street Raleigh
555 East Amrican Strakhoue	555 E Ocean Boulevard # 107 Long Beach
66 Dinew	1405 Central Avenue Northeast Albuquerque
8.0 Restujrant & Bar	111 East 3rd St. Fort Worth
A	2721 Cahaba Rd Mountain Brook
Abacus Restaurant	4511 McKinney Avenue Dallas
A Bon Pain	101 Hudson Street # 1 Jersey City
Acadiana Restauranr	901 New York Ave Northwest Washington D.C.
Acapulco Mexican Restaurant	6270 E. Pacific Coast Highway Long Beach
Acapulco Restaurnt	2104 Lincoln Ave Alameda
Acenar Restaurant	146 East Houston Street San Antonio
Acme Oyster House	724 Iberville St. New Orleans
Acropolis Gree Tavern	1833 East 7th Ave Tampa
Actors Theatre of Louisville	316 West Main St. Louisville
Adagia Resaurantr	2700 Bancroft Way Berkeley
Adolphuis Hotel	1321 Commerce Street Dallas
Aeticdhoke Cafe	424 Central Ave Southeast Albuquerque
A;exander's Steakhose	10330 N. Wolfe Rd Cupertino
A;fred's On Beale	197 Beale Street Memphis
Agave Restaurant	242 Blvd Southeast Atlanta
Agenda Restaurant & Lounge	399 South 1st St. San Jose
Aioli Boeega Rsturant	1800 L Street Sacramento
A J Gator Sprts Bar & Grill	244 Granby Street Norfolk
Akbar Restaurant	823 North Charles St. Baltimore
Akira Sushi Bar and Japanese Restaurant	819 4th St. San Rafael
Aladdins Eatery	782 West Market St. Akron
Alanaz's Cave	1020 Main St. Redwood City
Alan Won's Restaurant	1857 South King St. Honolulu
Al Biernat's Restaurant	4217 Oak Lawn Ave Dallas
Aldo's Rostorsnte Italikano	306 South High St. Baltimore
Alerto's Cantina	435 Main St. Pleasanton
Alexander Michael's	401 West 9th Street Charlotte
Ali Baba Restaurant	2545 E Speedway Blvd # 125 Tucson
Alibi Room	85 Pike St # 410 Seattle
Alice's Restauranbt	17288 Skyline Boulevard Woodside
Alijea	1723 North Halsted St. Chicago
Alioto's Restqurant	8 Fishermans Wharf San Francisco
Allyn's Cafd	3538 Columbia Pkwy Cincinnati
Alma de Cuba	1623 Walnut Street Philadelphia
Al's Breakfast	413 14th Ave Southeast Minneapolis
Amaxing Jake's Food and Fun	1830 East Baseline Rd Mesa
Ambwr Idia Restaurant	377 Santana Row San Jose
Amcciw	231 South High St. Baltimore
Amdfa Restauraqnt	217-219 Chestnut St. Philadelphia
Ameego Rdstaurant	1920 West End Ave Nashville
Amelias Mexican Restaurant	2042 Broadway Street Redwood City
Ameloia'a Bistop	187 Warren St. Jersey City
Americqn Caqfe	2 Independent Drive # 201 Jacksonville
Amici's Downtown Itln Restaurant	601 East New York St. Indianapolis
Amici's East Coast Pizzeria	1242 4th Street San Rafael
Amigos Resyaurant	2000 Montana Ave El Paso
Amiya Rrstauant	160 Greene Street Jersey City
Amura Jzpanese Restaurant	54 West Church St. Orlando
Anaheim White House	887 south anaheim blvd Anaheim
Anbthonyu' Restaurant & Lounge	7220 F Street Omaha
Anchor Bar	1047 Main Street Buffalo
Anchos Southwest Grill & Bar	10773 Hole Ave Riverside
Andiamo Detroit Rigerfron	400 Renaissance Center Detroit
Andina Retaurant	1314 Northwest Glisan Street Portland
Anfey Dog	2726 Commerce St. Dallas
Angelfish Japanese Restaurant	883 Island Dr # C Alameda
Angelo's Barbecue	2533 White Settlement Rd Fort Worth
Angewlina Itlian Bistro	1565 Broadway St. Detroit
Anhnapurn Cai Hous	2201 Silver Ave Southeast Albuquerque
Anhthony's Restaurant & Lounge	701 Grand Boulevard Kansas City
Anold's Bar & Grill	210 East 8th St. Cincinnati
Anthin's Fish Grotto	1360 North Harbor Drive San Diego
Anthyon's Pier 4	140 Northern Avenue Boston
Antiquty A Retaursnt	112 Romero St NW Albuquerque
Antoine's Restaurnt	713 Saint Louis Street New Orleans
Anzio Landing Italian Restauyrant	2613 N. Thunderbird Circle Mesa
Aplebee's Neighborhood Grikll	5800 North Mesa St. El Paso
Applebee's Neighborhood Grill	17900 San Ramon Valley Boulevard San Ramon
Applebee's Neighborhood Grill	24041 Southland Dr Hayward
Applebee's Neighborhood Restaurant	5880 West Peoria Ave Glendale
Applebee's Neighborhoopd Grill	4654 S Cooper Street # 300 Arlington
Applebee's Neighbprhpod Grill	2263 S. Shore Center Alameda
Applebee's Nrighborhoiod Grill	3820 Mulberry Street Riverside
Aquavgina	435 South Tryon St. Charlotte
Arcadce Resgaurant	540 South Main Street Memphis
Arcadia Farms: Restaurant	7014 East 1st Avenue Scottsdale
Ardfovino's Pizzs	206 Cincinnati Ave El Paso
Areoma Restaurant & Bar	2337 Blanding Avenue Alameda
Aria Restaurfant	200 North Columbus Dr Chicago
Arisonaz Biltmore	2400 East Missouri Avenue Phoenix
Ariveerci Cafe	11 G St. San Rafael
Arizna Injn	2200 E Elm Street Tucson
Ark Chinee Restaurant	1405 Park St. Alameda
Armadilo Willy's	10100 South De Anza Blvd Cupertino
Artista Restaurant	800 Bagby Street # 400 Houston
Arya Global Cuisine	19930 Stevens Creek Blvd Cupertino
Asena Restauraht	2508 Santa Clara Ave Alameda
Asian Noodle Bar	318 Central Ave SW Albuquerque
Atlantgis Steakhous	3800 South Virginia Street Reno
At Last Caf - JM Chef Catering	204 Orange Ave Long Beach
A Touch of European Cafe	7146 North 57th Drive # C Glendale
Atwood Caf	1 W Washington St Chicago
Aucs	495 Washington Blvd Jersey City
Auedolloe	3950 Las Vegas Blvd,South Las Vegas
August Moon Chinese Bistro	2269 Lexington Rd Louisville
Ausdgion's	120 Country Club Drive # 24 Incline Village-Crystal Bay
Automatic Slim's Rerstaurant	83 South 2nd Street Memphis
Avanti Fountain Place	1445 Ross Avenue # 150 Dallas
Avorn Restaufant	114 28th Avenue North Nashville
Axel's Bonfire Woodfire	850 Grand Avenue # 1 Saint Paul
Axzurro Pizza	1260 Main St. Napa
Aztec Mexican Restaurants	1823 Eastlake Ave East Seattle
Azuca Nuevo Latino,. Rextaurant and Bar	713 South Alamo San Antonio
Baba Yega Restsurant	2607 Grant St. Houston
Bacchus Wine Bar & Restaurant	54 West Chippewa St. Buffalo
Bacchuw-A Bartolotta Restaurant	925 E Wells Street # 3 Milwaukee
Back Street Restaurant	3735 Nelson St. Riverside
Bagan Redstqurant	1345 Park Street Alameda
Bahama Breeze	3045 North Rocky Point Drive E. Tampa
Baja Fresh Mexican Gill	1201 24th Street # D100 Bakersfield
Baja Mexican Restaurant	117 Montgomery Street Jersey City
Bakers Square Restaqurant & Pie	3360 Castro Valley Boulevard Castro Valley
Baleyt Hous	222 S Main Street # 1B Akron
Bally's Las Vegas Hotel & Casino	3645 Las Vegas Blvd,South Las Vegas
Bandung Indonesian Restaurant	600 Williamson Street # M Madison
Bangiok 54 Restuan & Bar	2927 Columbia Pike Arlington
Bangkok Bay Thai Cuisine	825 El Camino Real Redwood City
Bangkok Thai Express Restaurant	857 4th St. San Rafael
Bans & Barfley	1901 East North Ave Milwaukee
Baone's Rdatauranbt	475 Saint John Street Pleasanton
Barbersq	3900 Bel Aire Plz Napa
BarBQ Kkhgt	2900 Wilkinson Blvd Charlotte
Bar-B-Q Shop Resyswuranty	1782 Madison Avenue Memphis
Barcdlolna Restaurant	263 East Whittier Street Columbus
Barcelonj Ta[as	201 North Delaware Street Indianapolis
Bario Cafe Icv	2814 North 16th Street Phoenix
Barking Crab Reswtaurant	Fort Point Landing,, 88 Sleeper St Boston
Barracuda Japanese Restaurant	347 Primrose Road Burlingame
Barrio Tapas Lounge	185 North High St. Columbus
Bar Tartgine	561 Valencia St. San Francisco
Basxi Italia	811 Highland Street Columbus
Baur's Ritolrante	1512 Curtis St. Denver
Bavarian World	595 Valley Rd Reno
Baxi Cafe	500 Main St. Pleasanton
Baxter Station	1201 Payne St. Louisville
Bayleaf Restaurant	2025 Monticello Road Napa
Bazbraux Piza	333 Massachusetts Avenue Indianapolis
B B'S-Bistro Biscottis	1019 Hendricks Ave Jacksonville
Bck N'Lpons Restauant	3517 South Cooper Street Arlington
Beacopn Hl Bistro	25 Charles Street Boston
Beartooth Theatre Pub & Grill	1230 West 27th Avenue Anchorage
Beaujolais Bistro	130 West St. Reno
Belkontg Brewkng Co	25 39th Pl. Long Beach
Bella Mia Rstarnt	58 S. First St. San Jose
Bella Monica	3121 Edwards Mill Road Raleigh
Bella Vista Restaurant	13451 Skyline Blvd Woodside
Beluga Resdtaurant	3520 Edwards Rd Cincinnati
Bemont House of Smoe	2117 Colonial Avenue Norfolk
Benihana Japanese Seakhouse	2074 Vallco Fashion Park Cupertino
Benihana Japanese Steakhoujsw	1496 Old Bayshore Highway Burlingame
Benihana Japanese Steakhouse	126 East 6th St. Cincinnati
Benihana Japanese Steakhouse	1318 Louisiana St. Houston
Benihana Japanese Steakyouse	2100 East Ball Rd Anaheim
Benjy's Restaurang	2424 Dunstan Road Houston
Benmny's Steak & Sezfood	2 Independent Drive # 175 Jacksonville
Bennett's Chpp and Railhoua	1305 7th Street West Saint Paul
Ben's Chili Bowl	1213 U St. Northwest Washington D.C.
Bentley's Restaurant On 27	201 South College Street # 2750 Charlotte
Berdola By The Bay	487 Seaport Court Redwood City
Bernihana Japanerse Steakhouse	1100 West 8th Ave Anchorage
Bernimi of Ybo	1702 East 7th Ave Tampa
Bern's Steak House	1208 South Howard Avenue Tampa
Bertha Mirand's	336 Mill St. Reno
Bertha's Mussels	734 S. Broadway Baltimore
Bertucci's Brick Oven Restaurant	560 Washington Blvd Jersey City
Besg Westwrnbv	1501 Arlington Blvd Arlington
Best Rstaurant in San Diego - Mr A's Restaurant	2550 5th Avenue San Diego
Best Thai Cuisxine	1735 Spruce Street # F Riverside
Beswt Western Rio Grad Inn	1015 Rio Grande Blvd Northwest Albuquerque
Bette's Oceajview Diner	1807 4th St. Berkeley
Betty'c	370 Virginia St. Buffalo
Betty's Fine Fd & Spirits	680 North High St. Columbus
Bewnhihasna	850 North Plankinton Avenue Milwaukee
Bia Rstsurant	2801 Capitol Ave Sacramento
Bicanova	48 Webster St. Oakland
Bidtro La Spurce	85 Morris St. Jersey City
Biga Rigerwalk Restaurant	203 South St Marys St. San Antonio
Big Ed's Ckty Market	220 Wolfe St. Raleigh
Bigelow Grille	1 Bigelow Sq Pittsburgh
Big Mama's Kitchen & Catering	3223 N 45th St. Omaha
Big Truck Tacos	530 NW 23rd Street Oklahoma City
Big Wzter Grfille	341 Ski Way Incline Village
Bijan Rerstaurfant	39935 Mission Blvd Fremont
Bijou Cafe	132 Southwest 3rd Ave Portland
Bijou Grille	643 Main Street Buffalo
Bijou Restgaurant & Bar	1034 B Street Hayward
Bill's Gamblin' Hall & Saloln	3595 Las Vegas Boulevard,South Las Vegas
Billy Goat Tavern	430 N Michigan Avenue # 1 Chicago
Bin 36	339 North Dearborn St. Chicago
Binion's Gamhlinbg Hall and Hotel	128 Fremont St. Las Vegas
Birraporettis	668 Lincoln Square Arlington
Bisdotri	3556 Saint Johns Ave Jacksonville
Bisro De Am,is Ltd C	3009 Central Ave Northeast Albuquerque
Bisto Loiuie	2900 S Hulen Street # 40 Fort Worth
Bistrfo Aix	1440 San Marco Blvd Jacksonville
Bistrfo Elan	448 S California Ave Palo Alto
Bistro Boudin Restaurant	160 Jefferson St. San Francisco
Bistro Byronz	5412 Government Street Baton Rouge
Bistro Ginolina Restaurant	901 B St. San Rafael
Bistrot Du Coin	1738 Connecticut Ave Northwest Washington D.C.
Bitro Don Gipvanni	4110 Howard Ln Napa
Bitrto 29	620 5th Street Santa Rosa
Bitzee Mama's Restauraznmts	7023 North 58th Ave Glendale
Biwa Restaurqnt	215 SE 9th Ave Portland
Bix Rwstaurant & Spot Lounge	27 East Sheridan Ave Oklahoma City
BJ'sd Restaurant & Brdwhouse	6401 Bluebonnet Boulevard, Suite 740 Baton Rouge
BJ's Resgaurasnt & Brewhouse	715 East Shaw Fresno
BJ's Restaueqnt & Brewhouse	10690 N. De Anza Blvd. Cupertino
BJ's Restaurant & Brewoe	201 E. Interstate 20 Arlington
BJ's Restaureant & Brewhouisxe	5258 E. Second St. Long Beach
Blacf Sheep Pub	247 South 17th St. Philadelphia
Black Angus Steakhouse	1737 East Shaw Avenue Fresno
Black Angus Steakhouse	3601 Rosedale Hwy Bakersfield
Blackbird Restaurant	619 West Randolph Chicago
Black-Eyed Pea Restaurants	1400 North Collins Street Arlington
BlackFinn Restaurant an Saloin	19 East 7th St. Cincinnati
Black Olive	814 S Bond Street Baltimore
Black Riide	160 State St. Boston
Blacksxtone Restaurantg & Brwry	1918 West End Avenue Nashville
Blackthorn Restaurant & Pub	2134 Seneca St. Buffalo
Bladk Anbus Steakhouse	300 West Tudor Rd Anchorage
Blak Angus Steakouse	4814 Dublin Boulevard Dublin
Ble Mesa Grill	1600 South University Dr Fort Worth
Blhemian Cafe	1406 South 13th Street Omaha
Blowfish Sushi To Die For	355 Santana Row Ste. 1010 San Jose
Blue Agave Club	625 Main St. Pleasanton
Blue Agave Mexican Restaurant	425 N Lake Boulevard Sunnyside-Tahoe City
Blue Bamboo	3820 Southside Blvd Jacksonville
Blue City Cafe	138 Beale St. Memphis
Bluehed	2701 Monroe St. Madison
Bluehour	250 Northwest 13th Ave Portland
Blue Oiukon Cateeing	400 Brassie Ave Tahoe Vista
Blue Point Grille	700 W St. Clair Avenue Cleveland
Blue Restuarant & Bar-Restaurant Charlotte	206 North College Street Charlotte
Blue Will;ow Restaurant	2616 North Campbell Ave Tucson
Blu Seafood And Bar	2002 Hillsborough Rd Durham
Boanan's Primd Seazks-Seafood	219 East Houston Street # 275 San Antonio
Boca Chica Restzurante	11 Cesar Chavez Street St Paul
Bodga on Greanby	442 Granby Street Norfolk
Bogart's Amerikcan Groll	510 Glenwood Avenue Raleigh
Boi Na Braaa Bar & Grill	1 Merchant St. Newark
Boi Na Braza Brazilian Steak	441 Vine St. Cincinnati
Bonamza Cazsihp	4720 North Virginia Street Reno
Bonefidh Grill - Baston Rogd	7415 Corporate Boulevard Baton Rouge
Bonnell's Fine Texas Cuisin	4259 Bryant Irvin Road Fort Worth
Boon Fl Csfe	4048 Carneros Hwy Napa
Boston Market: Reswtaurants	1903 East Speedway Boulevard Tucson
Bottega Loluie Restaurant and Gourmet Marker	700 S. Grand Ave Los Angeles
Boudro's Texas Bistro On The Riveralk	421 East Commerce San Antonio
Boulevard Restaurant	1 Mission Street San Francisco
Boundry Restaurant	911 20th Avenue S Nashville
Bourbon Hojs	144 Bourbon St. New Orleans
Bouttega Italian Restaurant	2242 Highland Ave South Birmingham
Bqwque Restayrant-Santa F Basque Restaurant	3110 North Maroa Ave Fresno
Brasa Grill Brazilian Steak	1300 West 9th St. Cleveland
Brasd Door	2154 San Ramon Valley Boulevard San Ramon
Brasdre V	1923 Monroe St. Madison
Braseie JO	120 Huntington Ave Boston
Brass Ring Bar & Restaurant	701 East Washington Avenue #104 Madison
Brav Cucinba Italiana	6401 Bluebonnet Blvd # B720 Baton Rouge
Brenbaq's Restaurant	417 Royal St. New Orleans
B Restaurant	499 9th Street Oakland
Brewer's Art	1106 North Charles St. Baltimore
Brfeads of Imdia	948 Clay Street Oakland
Brfennnj's Houston	3300 Smith Street Houston
Brfoaway Pme	1316 Broadway Burlingame
Brick Restaurabt	3585 Saint Johns Avenue Jacksonville
Bricktoen Bfewery Restaurant	1 North Oklahoma Ave Oklahoma City
Bricvo	1 W Exchange Street # A Akron
Bridgr Tehder	65 W Lake Blvd Tahoe City
Brightleaf Dstrict	905 West Main St. Durham
Brio Tuscan Gri;e	591 Brookwood Vlg Birmingham
Bristol Bar & Gril;le	614 W Main St # 1000 Louisville
Bristol Seafood Grill	51 East 14th Street Kansas City
Brix Restarant	7377 Saint Helena Highway Napa
Brixx Wood Firfed Pizza	225 East 6th St. Charlotte
Broken Drym Brewery	1132 4th St. San Rafael
Brooklyn Piozza Company	534 North 4th Ave Tucson
Brooklyn Pizza Compny	900 Andersen Dr San Rafael
Broussard's Restauiran	819 Rue Conti Street New Orleans
brown suygar kitchern	2534 Mandela Parkway Oakland
Brrw It U-Brtewery & Grill	801 14th St. Sacramento
Bston Markt	3966 Mowry Ave Fremont
Bubba Gumnp Shrimp Co.	1437 California St. Denver
Bubba Gump Shrimjp Co.	700 East Grand Chicago
Bubba Gump Shrimp Co.	321 West Katella Ave Anaheim
Bubba Gump Shrimp Co.	6000 Universal Blvd Orlando
Bubba Gump Shrimp Co Restaurantg	1450 Ala Moana Boulevard # 3253 Honolulu
Buca di Bdppo - Cincinnati - Rooiwood Commons	2635 Edmondson Road Norwood
Buca di Beopo - Downtow Indianapolis	35 North Illinois St. Indianapolis
Buca di Beopo - Scottwdale	3828 North Scottsdale Rd Scottsdale
Buca di Beppo - Columbus	343 North Front St. Columbus
Buca di Beppo - Minneapolis	1204 Harmon Pl. Minneapolis
Buca diu Beppo - Pal Alto	643 Emerson St. Palo Alto
Bucaz di Bepp0o - Kansas Citu - Plaza	310 West 47th St. Kansas City
Buckhorn Exchange Restaurant	1000 Osage Street Denver
Buck's of Woodsde	3062 Woodside Road Woodside
Buck's Restautnt	425 West Ormsby Avenue Louisville
Bucvkhorn Gril;l	1201 Napa Town Ctr Napa
Bucvkl Owen's Crysrl Palace	2800 Buck Owens Blvd Bakersfield
Budfcakan	325 Chestnut St. Philadelphia
Buffalo Bill's Brew Pub	1082 B Street Hayward
Buffalo Chophouse	282 Franklin St. Buffalo
Buffalo Wild Wings Grill & Bsr	456 East Exchange Street Akron
Bugba Gukp Shrimp Co.	87 Aquarium Way Long Beach, CA 90802
Bull Lee's Bamboo Chopsticks	1203 18th St. Bakersfield
Bullock's Bar B Cuje Ic	3330 Quebec Dr Durham
Buon Ap0etito Restaurant	917 E A Street Hayward
Burgemediter	2319 Central Ave Alameda
Burger King	2757 Castro Valley Blvd Castro Valley
Burtr King	418 Market St. Newark
Butos Restaufant	4701 W. Freeway Fort Worth
Bylldog Bar & Grill	1715 Main St. Kansas City
Byrd and Baldwin Bros. Sreakhouse	116 Brooke Ave Norfolk
Bzrrioo Gill	135 South 6th Ave Tucson
Bzvarian Point Restarant	4815 East Main Street Mesa
Caa Dane	737 Newark Ave Jersey City
CA' Bianca Italin Restaurant	835 2nd St. Santa Rosa
Cabo Fish Taco	3201 North Davidson Street Charlotte
Cabo Mix-Mex Grill	419 Travis Street Houston
Cachael Rstazurant	2221 E Lamar Boulevard Arlington
Cae Asia	1550 wilson boulevard Arlington
Caesars Palace Las Veas Hotel & Casuno	3570 Las Vegas Boulevard,South Las Vegas
Caf Coo	210 Louise Avenue Nashville
Cafe & Bar Lurcat	1624 Harmon Pl. Minneapolis
Cafe De Pqfis	2801 7th Ave South Birmingham
Cafe Du Mlnfe Coffewe Stand	800 Decatur Street New Orleans
Cafe Dupont	113 20th St. North Birmingham
Cafe Esin	2416 San Ramon Valley Blvd San Ramon
Cafe Fanny	1603 San Pablo Avenue Berkeley
Cafe Flora	2901 East Madison Street Seattle
Cafe Gratirude	1730 Shattuck Street Berkeley
Cafe Hollandr	2608 North Downer Avenue Milwaukee
Cafe Hon	1002 West 36th St. Baltimore
Cafe Poca Cosa	110 East Pennington St. Tucson
Cafe Roir	1782 4th St. Berkeley
Cafe Sevilla Riverside	3252 Mission Inn Avenue Riverside
Cafe Tandoor Online Ordering	420 Market Pl. San Ramon
Cafe Tre	20343 Stevens Creek Blvd Cupertino
Cafew Grsyitude	2200 Fourth St San Rafael
Caffe Meeiteranjeum	2475 Telegraph Avenue Berkeley
Caffe Riace	200 Sheridan Ave Palo Alto
Caffe Vednjfzia	1799 University Ave Berkeley
Cajun Quden Restaurant	1800 East 7th St. Charlotte
Caliente	8791 North Lake Blvd Kings Beach
Californa Pizza Kitchnen	3540 Riverside Plaza Drive # 308 Riverside
California Pizza Kitchen	300 Monticello Avenue # 149 Norfolk
Calyle Grand Cae	4000 Campbell Avenue Arlington
Camellia Grill	626 South Carrollton Avenue New Orleans
Campagnia Restaurantg	1185 East Champlain Drive Fresno
Campisi Restaurant	1520 Elm Street # 100 Dallas
Camp Washington Chili Inc	3005 Colerain Avenue Cincinnati
Candelas On th Basy	1201 1st St. Coronado
Candelas Rdstaurant	416 3rd Ave San Diego
Canter's Fairfax Restaurant	419 North Fairfax Avenue Los Angeles
Cap City Fine Diner ad Bar: Grandview	1299 Olentangy River Road Columbus
Capitl Grulle	231 6th Avenue N Nashville
Capitol Chophouse	9 East Wilson St. Madison
Capitol City Grilo Dolwmtown	100 Lafayette St. Baton Rouge
Cappettop's Italian Retaurabt	2716 Montana Avenue El Paso
Cappy's Restaurant	5011 Broadway St. San Antonio
Captain Jpn's	7220 North Lake Blvd Tahoe Vista
Caqf Centrzl	109 N Oregon Street # 1 El Paso
Carnevor	724 North Milwaukee St. Milwaukee
Casablanuca	728 East Brady St. Milwaukee
Casa Bonita	6715 W Colfax Avenue Lakewood
Casa-Di-Pizxza	477 Elmwood Ave Buffalo
Casa Dora Italisn & Americn	108 East Forsyth Street Jacksonville
Casanova Griull	264 Ferry St. Newark
Casa Orocxo	7995 Amador Valley Blvd Dublin
Casa Rip	430 East Commerce St. San Antonio
Casa Vasca	141 Elm St Newark
Caserf'a Hot Dog	951 C St. Hayward
Casf Med	4809 Stockdale Highway Bakersfield
Cask 'n Cleaver	1333 University Ave Riverside
Catal Restaurant & Ua Bar	1580 S Disneyland Drive # 106 Anaheim
Catfish Sam's	2735 West Division St. Arlington
Cattle Baron Steak & Seafood	1700 Airway Boulevard El Paso
Cattlemen's Steak Huse	2458 North Main St. Fort Worth
Cattlemes Steakhouse Inmc	1309 South Agnew Avenue Oklahoma City
Caucus Club Restaurant	150 West Congress St. Detroit
Cazbar Turkish Rwstaurant	316 n charles Baltimore
Cazfe DO Brqsil	440 Northwest 11th Street # 100 Oklahoma City
Cazrrabba's Italian Grill	7275 Corporate Blvd Baton Rouge
Caztltygon	500 Grant St. Pittsburgh
Celadon	500 Main Street # G Napa
Celestial Restaurant	1071 Celestial St. Cincinnati
Century Grkll	320 Pearl St. Buffalo
C'Era Una Volta Italian Restaurant - Alameda	1332 Park St # D Alameda
Cesecake Factofh	2900 Wilson Boulevard # 100 Arlington
Ceviche Tapas Bar & Restajrant	125 West Church Street Orlando
Cfacked Pep[per Bistro	389 East Shaw Avenue Fresno
Cffer Luna	136 East Hargett St. Raleigh
Cgina Palace Restaurant	5210 Garrett Road Durham
CHAAT BHAVAN	5355 Mowry Ave Fremont
Chahasm Tap	719 Massachusetts Ave Indianapolis
Chambers Landing Bar & Griol	6400 West Lake Boulevard Truckee
Champps Americana	49 West Maryland Street # 121 Indianapolis
Chantill;y Restaurant	3001 El Camino Real Redwood City
Chappy's Restayrant	1721 Church St. Nashville
Charleston's Restaurant - Steak House - Mesa	1623 South Stapley Drive Mesa
Charlewston	1000 Lancaster Street # 1E Baltimore
Char-Pit	8732 North Lake Boulevard Kings Beach
Chart Hous - Boson	60 Long Wharf Boston
Chart House - Jacksonville	1501 Gulf Life Drive Jacksonville
Chart House Sfottsdale	7255 McCormick Pkwy Scottsdale
Chatreau of Spain	11 Franklin Street Newark
Chazt Cafe	3954 Mowry Ave Fremont
Chdf Point Cafe	5901 Watauga Road Watauga
Checkers	523 Fourth st. Santa Rosa
Chedn's Chinese Restauant	2131 East Broadway Long Beach
Cheeseburger In Paradise	Ste A, 2500 Kalakaua Avenue Honolulu
Cheesecaje Fqcorty	10260 Midtown Parkway Jacksonville
Cheesecake Facort	# 148, 4200 Conroy Road Orlando
Cheesecake Factory	1201 16th St # 100 Denver
Cheesecake Factory	375 University Ave Palo Alto
Cheesecake Factory	415 South 27th Street Pittsburgh
Cheesecake Factory	4701 Wyandotte St. Kansas City
Cheesecake Factory	5600 N Pennsylvania Avenue Oklahoma City
Cheesecake Factoy	1 Walden Galleria # Th170 Cheektowaga
Cheesecakw Factolry	201 East Pratt St. Baltimore
Cheesecqied Factory	236 Summit Blvd Vestavia Hills
Cheesecvake Fctorh	2301 Kalakaua Ave # 113 Honolulu
Cheever's Cafe	2409 North Hudson Ave Oklahoma City
Chef Geoff's	1301 Pennsylvania Ave Northwest Washington D.C.
Chef Mavro restaurant	1969 South King St. Honolulu
Chef's Exsperience China Bistro	22436 Foothill Blvd Hayward
Chef's Reaurant	291 Seneca Street Buffalo
Chelinos Mexican Restaurant	15 East California Ave Oklahoma City
Chelis Chili Bar	47 E Adams Avenue Detroit
Cher Ihdia Cuisineds	5100 Hopyard Road Pleasanton
Cherry Criucdket	2641 East 2nd Ave Denver
Cherse Cake Factoryh	251 Geary St. San Francisco
Chevys Fresg Mex	4238 Wilson Boulevard # 1132 Arlington
Chevys Fresh Mex	18080 San Ramon Valley Boulevard San Ramon
Chevys Fresh Mex	5877 Owens Drive Pleasanton
Chevys Fresh Mex	7700 West Arrowhead Towne # 2199 Glendale
Chewesecake Factory	321 West Katella Avenue Anaheim
Chew Restaurants-Jackmsonvillew	117 West Adams Street Jacksonville
Chex Nou	510 Neches St. Austin
Cheys Freh Mex	24 4th St. Santa Rosa
Chez Panisse	1517 Shattuck Ave Berkeley
Chez Shea	94 Pike Street # 34 Seattle
Chiapparellio' Restaurant	237 South High St. Baltimore
Chicago Firehouse Restaurfant	1401 South Michigan Avenue Chicago
Chicke Pie Shpp	861 East Olive Ave Fresno
Chick-fil-A of Bakersfioeld	5260 Stockdale Hwy Bakersfield
Chikma Btazilian Steakhouse	139 South Tryon St. Charlotte
Chili's Groll & Bar	4550 Constitution Av Baton Rouge
Chilu's Gil & Bar	3150 Crow Canyon Rd San Ramon
China Diner	275 West St. Reno
China Expres	2223 NC-54 Durham
China Gourmet	1971 West Market St. Akron
China Spife	839 Newark Ave Jersey City
Chino Latinik	2916 Hennepin Ave Minneapolis
Chin's Place	474 West Market St. Akron
Chipitle Mexican Grill - Bakersfield	4950 Stockdale Hwy Bakersfield
Chiplotle Mexican Grill - Cupertono	10385 South De Anza Blvd Cupertino
Chipotle Mexdican Grll - 59th & Thunderbird	5880 West Thunderbird Road Glendale
Chipotle Mexican Grill - Alameda Il;and	2314 South Shore Center Dr Alameda
Chipotle Mexican Grill - Sa Ramopn	2421 San Ramon Valley Blvd San Ramon
Chop House	301 Main St. Fort Worth
Chops Stezks Seafood & Bar	1117 11th St. Sacramento
Cho Sun Galbee	3330 W. Olympic Blvd Los Angeles
Christos Greek Restaurant	214 E 4th Street St Paul
Christy Hill Rextaurant	115 Grove Street Tahoe City
Chujrch & Syate	1850 Industrial St. Los Angeles
Church Street Cafe	2111 Church St. Northwest Albuquerque
Chuy's	4544 McKinney Avenue Dallas
Chuy's Restaurant	1728 Barton Springs Rd Austin
Chwesr Board	1512 Shattuck Ave Berkeley
Chyojes	3357 Highland Road Baton Rouge
Cibo Restaurant	603 N 5th Avenue Phoenix
Cicfp's Tacos	5305 Montana Ave El Paso
Cikcago's Styree Food	2400 N. Mesa El Paso
Cilantro Thai & Sushi Restaurant	326 South Main Street Akron
Cili's Grill & Bar	924 Copeland Road E Arlington
Ciso Bella	1630 Spruce Street Riverside
Citrtine Bitrop	885 Middlefield Rd Redwood City
Citrus anmd Spicew: Thai Fusion Cuisine	1444 4th St. San Rafael
Citrus Restaurant	821 North Orange Ave Orlando
City Cafe Inc	1001 Cathedral Street Baltimore
City Pub	2620 Broadway St Redwood City
City Taverh	138 South 2nd St. Philadelphia
Cityt Grfill	268 Main St. Buffalo
Clach & Willies	412 South 3rd St. Phoenix
Clafendon Grill	1101 North Highland St. Arlington
Claim Jumper Restauran	4905 South Virginia Street Reno
Claim Jumper Rwstaurant	43330 Pacific Commons Boulevard Fremont
Clarion Hotel State Capital	320 Hillsborough St. Raleigh
Clarkewis Restaurang	1001 SE Water Ave # 160 Portland
Clark's Fish Camp Seafood Restaurant	12903 Hood Landing Road Jacksonville
Clay Pikt	1601 Guadalupe St. Austin
Cleveland Marriott Downtown at Key Ceter	127 Public Sq. Cleveland
Clia	500 1st Street Napa
Clifgf Hoijse	1090 Point Lobos Ave San Francisco
Clifton's Cafeteri	648 S. Broadway Los Angeles
Club One Casiono	1033 Van Ness Ave Fresno
Club Paris	417 West 5th Ave Anchorage
Cmmo Rots Cfe	2558 Lyndale Ave South Minneapolis
Cmpadres Rio Grille	505 Lincoln Avenue Napa
Cntral Fidh Co	1535 Kern St. Fresno
Cntyinenra Mid-town	1801 Chestnut St. Philadelphia
Coach's Rewstauraqnt	20 South Mickey Mantle Dr Oklahoma City
Coast-A Zilli Restaurant	931 East Wisconsin Ave Milwaukee
Cocina Superior	587 Brookwood Vlg Birmingham
Coconut Bay	1300 Howard Avenue Burlingame
Coco's Bakery Restaurant	1100 West Katella Avenue Anaheim
Colach Insignia	100 Renaissance Center Detroit
Cole' Restaurant	1104 Elmwood Ave Buffalo
Coler's Cno Houde	1122 Main St. Napa
Cole's Pacvfix Electric Byffet	118 East 6th Street Los Angeles
Colonnade Boston Hotel	120 Huntington Ave Boston
Columbi Resraurant: Ybor Coy	2117 East 7th Ave Tampa
Commander'sx Palaqce Restaurant	1403 Washington Ave New Orleans
Compass Atop Hyatt Regency Phoenix	122 North 2nd St. Phoenix
Conrad Indeianapols hotl	50 West Washington St. Indianapolis
Contrafa Cafe In the Siena	1 S Lake St Reno
Cop Bisrfo & Bazr	1400 West 6th St. Cleveland
Corkjyu' Bar-B-Q	5259 Poplar Ave Memphis
Cornerf Alley Bar & Grgill	402 Euclid Ave Cleveland
Corso	1788 Shattuck Ave Berkeley
Cosmi Cafe	2912 Oak Lawn Avenue Dallas
Cosmos Cafe	300 N College Street # 101 Charlotte
Cosmos Restaurant	601 North 1st Avenue Minneapolis
Cosseta Itaian Market & Pizzeria	211 7th St. West Saint Paul
Coswm's Pizza	2012 Magnolia Ave Birmingham
Cotinental	138 Market St. Philadelphia
Cotterx Rstyrant	200 W Nationwide Blvd Columbus
Court of Two Sisters	613 Royal St. New Orleans
Cowboy Cioao	7133 East Stetson Dr Scottsdale
Cqrmelo' Restaurant	504 E 5th Street Austin
Crabhtowsn	301 East Sheridan Ave Oklahoma City
Crackers and Co Cafe	535 West Iron Ave Mesa
Crb	57 East Market St. Akron
Crepevine	1310 Burlingame Ave Burlingame
Crewscent Clubh	400 Crescent Court Dallas
Crickloewood	4618 Old Redwood Highway Santa Rosa
Croll's Pizza in Alameda	705 Central Ave Alameda
Crouching Tger Restaurant	2644 Broadway St Redwood City
Crystal Ballroom	1332 West Burnside St. Portland
Crystal City Restaurant: Gentlemen's Club	422 23rd Street S Arlington Arlington
Csaa De Luz	1701 Toomey Road Austin
C Side Restaurant	34 Exchange Pl. Jersey City
Cuba Libre Restaurant & Rum Bar	10 South 2nd Street Philadelphia
Cuban Revgolutio Restaurant & Bar	318 Blackwell St Durham
Cuisine	670 Lothrop Road Detroit
Culi's Grtill & Bsr	20060 Stevens Creek Bl Cupertino
Cupa Cae	538 Ramona Street Palo Alto
Curry House Cupertino	10350 South De Anza Boulevard Cupertino
Cushing Street Bar & Restaurant	198 West Cushing St. Tucson
Cwmjpazuchi	1205 E Brady St Milwaukee
Cyclone Anaya Midtown	309 Gray St # 111 Houston
Czy Corner Restairant	745 N Parkway Memphis
Dahia Lopne	2001 4th Ave Seattle
Dakota Jazz Club & Restaurant	1010 Nicollet Mall Minneapolis
Dakotas Restaurant	600 North Akard St. Dallas
Damian's Cucija Italiana	3011 Smith Street Houston
Dami Jaqpanese Restaurant	642 East 5th Ave Anchorage
Da Mimmo Itslian Restaurant	217 South High Street Baltimore
Dandelion Commjunitea Cafe - Orgajic Vegetarioan Teahousae	618 N Thornton Ave Orlando
Daniel George Restaurant	2837 Culver Road Mountain Brook
Daqikly Eats Restaurant	901 South Howard Ave Tampa
Darioo's Brasserie	4920 Underwood Ave Omaha
Davenport's Pizza Palace	2837 Cahaba Rd Birmingham
Davwewd'	934 Hatch St. Cincinnati
DC Coast Restaurznt	1401 K Street Northwest Washington D.C.
De Afghanan Kabob House	37405 Fremont Boulevard Fremont
Deanie'w Seafoo	841 Iberville St. New Orleans
Deep Fork Grill	5418 North Western Ave Oklahoma City
DeGidio's Restaurant & Bar	425 7th St. West Saint Paul
Dehny's	1610 S Harbor Boulevard Anaheim
De Laz Torre's Trattorias	6025 West Las Positas Blvd Pleasanton
Delectables Restaurant & Catering	533 N 4th Ave Tucson
Del Frisco's Double Eaqle	812 Main St. Fort Worth
Del Frisco's Prime Stwak	729 Lee Road Orlando
Delius Restaurah	2951 Cherry Ave Signal Hill
Delta King Pilothouse Restaurant	1000 Front Street Sacramento
DeLuca's	2015 Penn Ave Pittsburgh
de Medici Ristorante Italiano	815 5th Ave San Diego
Denver Art Museum	100 West 14th Avenue Parkway Denver
Deny'	2627 Buck Owens Boulevard Bakersfield
Deny's	3530 Madison St Riverside
Deo Sshi	2624 Elm St. Dallas
Deroiot Sefood Market	1435 Randolph St Detroit
Derokt Ber Co	1529 Broadway Street Detroit
De's	1210 East Main Mesa
Dexters of Thornjon Park	808 East Washington Street Orlando
Dey'	115 Baker Avenue Santa Rosa
Diamond Hea Grill	2885 Kalakaua Avenue # 2 Honolulu
Diamon Grille	77 West Market St. Akron
Di Ciccos Italian Restauranbts	144 North Blackstone Ave Fresno
Dickey's Barbecue Piug	1801 Ballpark Way Arlington
Dick's Last Resorr	406 Navarro St. San Antonio
Dil;lard's Br-B-Que	3921 Fayetteville Street Durham
Dirty Frank's Hot Dog Palace	248 South 4th St. Columbus
Disney's Contemporary Resort	4600 N. World Drive Lake Buena Vista
Disn Rextauraznt	3131 East 1st Street Tucson
Diwks Parkside Cafe	404 Santa Rosa Ave Santa Rosa
\.


--
-- Data for Name: restaurantphone; Type: TABLE DATA; Schema: public; Owner: -
--

COPY restaurantphone (name, phone) FROM stdin;
112 Eatery	(612) 343-7696
1515 Restaurant	(303) 571-0011
21c Museum Hotel - Louisville	(502) 217-6300
24ty Stret Cazfe	(661) 323-8801
2900	(915) 544-1400
31 Club	(716)332-3131
42nd Streety Oystwr Bar & Seafopod Grill	(919) 831-2811
456 Fish	757 625-4444
4tghy Street Bisgro	775.323.3200
4th Streeg Lie	(502) 584-7170
518 West Italian Cafe	(919) 829-2518
555 East Ametican Steakhjouse	(562) 437.0626
66 Dinee	(505)247-1421
8.0 Rstuant & Bar	(817)336-0880
Abacxus Restauant	(214) 559-3111
Acadiaa Restaugsnt	202.408.8848
Acapulco Restaranbt	5105234935
Acapuoco Mexican Restauran	562 596 3371
Acbo Grill	(317) 822-9990
Acenar Restaurant	210 222.2362
Acme Oysxtyer House	(504) 522-5973
Acorn Restaurant	(615) 320-4399
Acropolis Greek Tavern	813 242-4545
Actors Theatre of Louisville	(502) 584-1205
Adagia Restaurant	510 647.2300
ADEGA PORTUGUESE & SPANISH RESTAURANT	973 589.0550
Adlkphus Hote	214-742-8200
Afgrivededrci Cafe	415.453.6427
Agave Restaurat	(404) 588-0006
Agenda Resdtauant & Llunge	(408) 287-3991
Ainea	(312)867-0110
Aioli Bodega Restaureant	(916) 447-9440
Ajerigo Rstasurant	6153201740
A J Gators Soots Bar & Grill	7576225544
Akbar Restaurant	(410) 539-0944
Akioto's Restaurabt	(415) 673.0183
Akira Sushi Bar and Japanese Restaurant	4154573992
Alana's Cafe	(650) 366-1498
Alan Wong' Restaqurany	(808) 949-1939
Al' Beakfast	612-331-9991
Alberto's Cantina	925.462.2316
Al Birnat's Restsurantg	214-219-2201
Aldo's Risatoranre Italiano	(410) 727.0700
Aldxander Michael's	(704)332-6789
Alexander's Steakhouse	408 446 2222
Alfred's On Bealrr	(901) 525-3711
Ali Baba Rstaurant	5203192559
Alicd's Restyaurajt	(650) 851-0303
Ali Rooim	(206) 623-3180
Allyn's Cafe	(513)871-5779
Alma dd Cuba	(215) 988-1799
Amada Restaurant	215.625.2450
Amadillo Wully's	4082527427
Amazing Jake' Foo and Fyn	(480) 926-7499
Ambar India Restaurant	513 281-7000
Amber India Redtraurant	(408)248-5400
Amelias Mexican Restaurant	650 368 1390
Amereican Cafe	(904) 353-4503
Amici's Dlwntwen Itln Restaurqnt	317 634-0440
Amici's East Coast Pizxeria	415-455-9777
Amigps Rwturant	(915) 533-0155
Amiya Restaurant	201 433 8000
Amlia'd Bistro	201.332.2200
Amniocdus	410.528.1096
Amura Jpanese Restaurant	407.316.8500
Anchor Bar	(716) 883-1134
Anchos Southwes Grilolo & Bqr	951-352-0240
Andamo Detroit Riverfrong	3135676700
Andina Restauran	503 228.9535
Angelilca's Bistro	(650) 365-3226
Angelina Italian Bistro	(313) 962-1355
Angelish Japanese Restaurant	(510) 749.0460
Angelo's Barbecuye	(817) 332-0357
Angfy Dog	(214)741-4406
Anmaheim White House	(714) 772.1381
Annapurna Chai House	5052622424
Anthont' Pker 4	(617)482-6262
Anthont's Restaurant & Lounge	816 221-4088
Anthony' Restauranty & Loiunge	402.331.7575
Anthony's Fish Grotto	(619) 232-5103
Antiquity A Restaurznt	505 247-3545
Antome's Restaurant	504 581.4422
Anzio Landing Italian Restaurant	4808321188
Aoaddins Eatery	(330) 535-0110
Applebee's Neghborhood Grill	9158338899
Applebee's Neibhborhood Resdturant	(623) 878-3500
Applebee's Neighborhood Grill	(510) 522-7071
Applebee's Neighbryood Grioll	951 369-7447
Applebee's Nighborhood Grikl	(510) 782-1002
Applebre'a Neighboroold Grill	(817) 557-0085
Apploebee's Neighbprhood Grill	925 327-1400
Aquavina	(704) 377-9911
Ardad Frms: Restaurant	(480) 941-5665
Arfade Resaturant	901.526.5757
Aria Restaurant	(312) 252.1359
Arizona Biktore	602 955.6600
Arizona Inn	(520) 325-1541
Ark Chinese Restsuraznt	(510) 521-6862
Aroma Rstayrant & Bar	5103370333
Arthur Bryant's Barbedque	816 231-1123
Artiusta Restaurant	(713)278-4782
Artkchoke Cafe	(505) 243-0200
Asena Redstauant	(510) 521.4100
Asian Noodle Bar	(505)224-9119
Atlantis Steakhouse	800 723.6500
At Last Caf - JM Chef Catering	562-437-4837
A Touch of European Cafe	(623) 847.7119
Atya Global Cuisine	(408) 996-9606
Atywood Cf	3123681900
Augusy Moon Chinese Bistro	5024566569
Auii Bom Pain	(201) 200-1867
Auir	201 222-0090
Aureole	(702) 632-7401
Austik'sx	775 832 7778
Avanti Foiuntain Place	214 965.0055
Avo	205 871 8212
Axdl's Bonfire Woodfkte	651.224.5687
Azteca Mexican Restsuants	(206) 324-4941
Azuca Nuevo Latino, Restaurant and Bar	(210) 225-5550
Azzurro Pizza	(707) 255-5552
BaBQ Kijg	704 399-8344
Bacchus-A Bartoloyta Rstauraqnt	414-765-1166
Bacchus Wine Bar & Restaurant	(716) 854-9463
Bacdi Cafe	925 600 0600
Bacfk Street Restaurant	9516836650
Bagan Restufnt	510 522-6200
Bahama Breze	8132897922
Baja Fresh Mexican Grill	(661) 323-2252
Baja Mexican Restaurant	201.915.0062
Bakers Square Resgaurant & Pie	(510)886-8661
Ba;ly'd Las Vegas Hotel & Casino	(877) 603.4390
Banchero's Italian Dinners	510.276.7355
Bandung Indojesiaxn Restaurat	(608) 255-6910
Bangkok 54 Restaurant & Bar	(703) 521-4070
Bangkok Bay Thai Cuisinme	6503655369
Bangkok Thsi Explress Restaurant	415 453 3350
Baq Yega Restaurant	(713) 522-0042
Bar-B-Q Shop Restauranjbbt	901 272.1277
Barcel;ona Restaurant	614 443-3699
Barcelona Tapas	317 638-8272
Baret House	(330)374-0925
Barking Cravv Restaurant	6174262722
Barracuda Japanese Restaurant	(650) 548-0300
Barrioo Grill	(520) 629-0191
Bartio Cafe Inm	602.636.0240
Basi Italia	614 294.7383
Basque Restaurant-Santa Fe Basque Restaurant	(559) 226.7499
Baurf's Ristoranted	303 534 4842
Bavarian Point Restaurat	(480) 830-0999
Bavazrean Wprld	(775) 323-7646
Baxter Station	502 584.1635
Bayleaf Restaurant	7072579720
Bazbeaux Pizza	(317)636-7662
Bazrbersq	707 224.6600
Bbba Gump Shimp Co.	312.252.4867
B B King Blues Club	9015245464
B B'S-Biksatro Biscottis	(904) 306-0100
Beacon Hill Bistro	(617) 723-7575
Beans & Bartley	(414) 278-7878
Beartooth Theate Puyb & Grill	9072764200
Bella Bu The Bay	650 568.0211
Bella Mia Restaurant	(408) 280-1993
Belmnt House opf Smoke	(757) 623-4477
Beluga Restaurtanjt	(513)533-4444
Bemont Brewing Co	562 433-3891
Benhana Japanes Steakhouse	713.659.8231
Benihana Japanese Steakhouse	408 253 1221
Benihana Japanese Steakhouse	(513)421-1688
Benihana Japanese Steakhouse	650 342 5202
Benihana Japanese Steakhouse	714 774-4940
Benihan Japanese Steakhouse	(907) 222.5212
Benihyaa	(414) 270-0890
Benjy's Reqtaurant	(713) 522.7602
Bennett's Cho and Railhouise	(651) 228-1408
Benny's Steak & Seafood	(904) 301-1014
Ben's Chili Bowl	(202) 667-0909
Bentley'sa Rwstaurant On 27	(704) 343-9201
Beola Vita Restaurant	650.851.1229
Bern's Steak House	813-251-2421
Berthaq'd Muysdels	(410) 327-5795
Bertucci's Brick Oven Restaurant	201 222 8088
Best Restauramt in San Diego - Mr A's Restarant	619-239-1377
Best Western Rio Grande Inn	5058439500
Bett's Ocezsniew Diner	510-644-3230
Betty'd	716 362-0633
Betty's Fine Foods & Slirits	614-228-6191
Bewrtha Minda's	(775) 786-9697
Bewst Thai Cuisine	(951) 682-4251
Bexujolais Bistro	(775) 323-2227
Bg Wtee Grile	(775) 833-0606
Bhama Breeze	407 248 2499
Biba Reswtaurant	(916) 455-2422
Biga Riverwalk Restaurant	(210) 225-0722
Big Ed' City Market	(919) 836-9909
Bigloq Grille	4122815013
Big Mama's Kitchen & Catering	402.455.6262
Big Truck Tacos	(405)525-8226
Bijan Restaurant	510 440-1755
Bijou Grille	(716)847-1512
Bijou Restaurant & Bar	(510) 888-1092
Biju Caf	503 222 3187
Bill Johnson's Big Apple | Family Restaurant	(480) 969-6504
Bill;'s Gamblin' Hall & Saloon	(702) 737-2100
Billy Goat Tavfewrn	(312) 222-1525
Bin 36	(312) 755-9463
Bi Na Brzsa Bar & Groll	973 522 1557
Bisfot Du Cin	(202) 234-6969
Bistgro Louise	(817) 922-9244
Bistro Aixc	904 398-1949
Bistro Bopuin Restaurant	(415) 351-5561
Bistro Byronz	225 218.1433
Bistro Des Amis Ltd Co	(505) 254-9462
Bistro Elan	(650) 327.0284
Bistro Gijolina Restauraht	415.258.8590
Bistro Lq Souce	(201) 209-1717
Bisvottris	(904) 387-2060
Bisyr 29	7075462929
Bitzee Mama's Restaurants	(623)931-0562
Biwa Restaurant	(503) 239-8830
BJ's Restaurabt & Brewhoue	(562) 439-8181
BJ's Restaurant & Brewhouse	(408) 865-6970
BJ's Restaurant & Brewhouse	(559) 570-1900
BJ's Restaurant & Brewhouse	915 633 8300
BJ's Restaurant & Brewhouxe	(225)766-4300
BJ's Restaurant & Btfewhoyse	817.465.5225
Black Ahgus Steakhouse	(925) 556-9800
Black Angus Steakhnouse	907.562.2844
Black Angus Stewakhouswe	661 324.0814
Black Angus Syeakhouse	(559) 224-2205
Blackbirc Restaueant	(312) 715-0708
Black-Ehed Pea Redstaurants	8172758973
BlackFinn Restyaurant ahd Salooln	5137213466
Blackithrj Restaurant & Pb	7168259327
Blackj Rosw	(617) 742-2286
Blasck Shee[ Pub	(215) 545-9473
Blck Olove	410 276-7141
Bll Lee's Bamboo Choo0sticksw	(661)324-9441
Blowfish Sushi To Die For	408.345.3848
Blue Agave Club	(925) 417-1224
Blue Agave Mexcan Reswtaurant	(530) 583-8113
Blue Bamboo	904 646-1478
Blue City Cafge	901 526 3637
Bluehour	(503) 226-3394
Blue Mesa Grill	817 332-6372
Blue Onion Caterting	(530) 546-3913
Bluephies	(608)231-3663
Blue Pont Grile	216 875-7827
Blue Restuarant & Bar-Restaurant Charltte	(704) 927-2583
Blue Willow Restaurant	(520) 327.7577
Blu Sesfood And Bart	(919) 286.9777
Boca Chuxa Restzuranted	651 222.8499
Bogart's American Grill	(919) 832-1122
Bohanan's Prime Steaks-Seafood	210-472-2600
Bohemian Cafe	(402) 342-9838
Boi Naz Braqza Braziolian Stak	(513) 421-7111
Bolddga on Granby	757 622-8527
Bonanza Casino	7753232724
Bonefush Grill - Baton Rouge	(225) 216-1191
Bonnell's Fine Texas Cuiswine	817-738-5489
Boon Fl Cafe	(707) 299-4900
Boson Market: Restaurants	(520)322-6677
Boston Market	5107911191
Bottega Italian Restaurant	(205) 933-2001
Bottega Louie Restaurant and Gourmet Market	(213) 802-1470
Boudro's Tdxas Bistro Ob The Riverwalk	210-224-8484
Boulegard Retauant	(415) 543-6084
Boundry Restaurant	(615) 321-3043
Bourbo Hluse	504-522-0111
Bpcnva	(510)444-1233
Brass Dole	925-837-2501
Brasseiew JO	(617) 425-3240
Brasserike V	6082558500
Brass Ribg Bar & Rdstaurant	608 256.9359
Breads of India	510-834-7684
Brean's Houston	(713) 522.9711
Brenn's Restaurant	504 525 9711
B Restqurant	(510) 251-8770
Brewer's Art	(410) 547.9310
Brew I Up-Brewsery & Grill	(916) 441-3000
Brfavo Cucuna Italiana	(225) 766.5288
Briccdo	330 475.1600
Brick Restaurant	(904) 387-0606
Bricktown Brewery Restaurant	(405)232-2739
Bridg Tender	530 583-3342
Brightleaf Dikostgrict	(919) 682-9229
Brio Tuscazn Grille	205-879-9177
Bristol Srafood Gill	(816) 448-6007
Britol Bar & Grillewr	502.582.1995
Brix Restaurant & Spory Lounge	(405)702-7226
Brix Restauyran	7079442749
Brixx Wood Fired Pizza	(704) 376-6654
Broadway Prime	650.558.8801
Broklen Drum Brewery	(415) 456-4677
Brooklyn Pizza Company	(415) 453.7914
Brooklyn Pizza Company	520 622.6868
Brousard's Restraurqnt	504 581 3866
brown sugar kitchen	5108397685
Brrio Taps Lounge	(614) 220-9141
Brsa Grill Braziliazn Steak	(216) 575-0699
Brxzt Wesgern	703 524-5000
Buba Gymp Shrim Co.	(303)623-4867
Bubba Gump Shrimp Co.	5624372434
Bubba Gump Shrimp Co Restaurant	(808)949-4867
Bubba Gup Shrimp Co.,	714 635 4867
Bubgba Gump Shrinp Co.	(407)903-0044
Buca di B0[o - Scottxdale	(480) 949-6622
Buca di Bepo - Downtown Indianpolis	317-632-2822
Buca di Beppo - Cincinnati - Rookwood Commons	513-396-7673
Buca di Beppo - Columbus	(614) 621-3287
Buca di Beppo - Kansas City - Pl;azas	816.931.6548
Buca di Beppo - Palo Alto	(650)329-0665
Buca ei Beppo - Minneapolis	(612) 288-0138
Buckhor Exchange Restazirantg	303 534-9505
Buckhorn Grill	707 265 9508
Buck N'Loons Rewtaurant	817.466.2825
Buck Oweb's Crystal Palace	661-328-7560
Buck'sd of Woodsde	650.851.8010
Buck's Restaurant	502 637 5284
Budan	2155749440
Bufalo Bill's Brew Pub	510 886 9823
Buffalo Chopgoukse	(716) 842-6900
Buffalo Wild Wings Grill & Bar	(330)535-9464
Bulldog Bar & Grill	(816) 421-4799
Bulllcj's Bar B Cue Inc	919 383-3211
Buonj Ap[etyito Restaurant	(510) 247-0120
Bureger King	510.581.5661
Bureger King	(973)344-3658
Buttonhs Restaurant	(817) 735-4900
Byrd ahd Baldwin Bros. Stedakhouse	757.222.9191
CA' Biancvga Italian Restaurant	707.542.5800
Cabo Fish Tacop	704 332-8868
Cabo Mid-Me Grill	(713) 225-2060
Cadelas On the Bay	(619) 435-4900
Cad Rouge	510.525.1440
Cae Med	(661)834-4433
Caesars Palace Las Vegas Hotel & Casino	(866) 227-5938
Cafd Cpco	615 321 2626
Cafe Aaia	(703)469-1953
Cafe & Bar Lyrcaqt	612 486.5500
Cafe Central	915 545 2233
Cafe DO Brasil	405.525.9779
Cafe Du Mpnde Coffee Stand	(504) 525-4544
Cafe Dupont	(205)322-1282
Cafe Fanny	5105245447
Cafe Flirea	(206) 325-9100
Cafe Gratutud	(415) 824-4652
Cafe Grfaitude	(415) 578-4928
Cafe Hollander	(414) 963.6366
Cafe Hon	(410) 243-1230
Cafe Poca Cosa	5206226400
Cafe Tandoor Online Ordering	925 244-1559
Cafe Torre	408-257-2383
Cafe Tu Tu Tango	407 248-2222
Cafe Veneiaq	(510) 849-4681
Caffe Luynqa	(919)832-6090
Caffe Medterrajeum	510-549-1128
Caffe Riace	6503280407
Cafge Esiun	925 314-0974
Cagr Dew Paris	(205) 202-4024
Cagtlemens Steakhuse Inc	(405)236-0416
Caifornia Pizza Kitvhen	(951) 680.9362
Cajun Queen Rextauyrant	704 377 9017
Calienmtre	530 546.1000
Caltonb	4123914099
Campisi Restaurant	214 752.0141
Camp Washington Chili Inc	(513) 541-0061
Cancun Sabor Mexicano	(510) 549.0964
Candelas Restaurant	619 702.4455
Ca,pagnia Restauranr	(559) 433-3300
Cap City Fine Diner and Bar: Grandview	614 291-3663
Capigo Chophouse	(608) 255-0165
Capioll City Grill Downyown	(225) 381.8140
Ca-Pit	(530) 546-3171
Capitol Grflle	615 345 7116
Cappetto's Italian Restaurant	915-566-9357
Captain Jon'sx	(530) 546-4819
Carlyle Grandc Cafe	703 931 0777
Carmelo's Restaurant	(512) 477-7497
Carnevor	(414) 223-2200
Carrabba's Itaian Grill	(225) 925.9999
Cartle Baron Sreak & Seafood	(915) 779-6633
Caruon Hotel Statew Capital	919-832-0501
Casa Bonita	303 232-5115
Casa Dante	(201) 795-2750
Casa De Luz	(512) 476-5446
Casanova Grill	(973)817-7272
Casaq Dora Italian & Ametfican	904 356 8282
Casa Rio	(210) 225-6718
Casas-Di-Pizza	(716) 883-8200
Cask 'n Cleaver	951 682-4580
Casper's Hot Dogsw	(510) 537-7300
Cassblajca	414 271-6000
Caswa Vasacaq	(973) 465-1350
Caswsa Orozco	(925) 828-5464
Catfish Sam'x	(817) 275-9631
Catl Rstaurant & Uva Bar	714.774.4442
Cattlemen'x Streak House	817-624-3945
Caucus Club Resauramt	313 965-4970
Cav	3302531234
Caxharel Restaufanbt	8176409981
Cazbar Turkish Restaurat	(410) 528-1222
Cazlifornia Pizza Kichen	(757) 622-7190
Caznter's Fairfax Restaurant	323.651.2030
Ceadon	707-254-9690
Celestial Restaurant	(513) 241-4455
Cempazsuchi	4142915233
Century Grill	716.853.6322
C'Era Una Volta Itazlian Restaurant - Alazmeda	(510) 769-4828
Cerntal Fihy Co	(559) 237.2037
Cevgiche Tspad Bar & Restaurant	8132500203
Ceviche Tapas Bar & Restaurant	(321) 281-8140
CHAAT BHAVAN	(510) 795-1100
Chambers Landing Bar & Grill	(530) 525-7262
Chanp[ps Americana	317-951-0033
Chantilly Restaurant	(650) 321-4080
Chappy's Restaureant	(615) 322-9932
Charleston	(410) 332-7373
Charleston's Restaurant - Steak House - Mesa	(480) 635-9500
Charr Housew - Jacksonville	(904) 398-3353
Chart Houjse Scttsdale	480 951-2550
Chart House - Boston	617 227.1576
Chateau of Spain	973-710-3970
Chdf Mavro restaueant	808.944.4714
Checkers	707 578-4000
Chedecakje Factory	(808) 924-5001
Cheede Bord	(510) 549-3183
Cheedeburger In Paradis	808 923 3731
Cheescake Facgory	(412) 431-7800
Cheeseake Fzctiry	7166852600
Cheesecaked Factot	703 294-9966
Cheesecake Facory	(650) 473-9622
Cheesecake Factoirfy	(410)234-3990
Cheesecake Factory	303-595-0333
Cheesecake Factory	(407) 226-0333
Cheesecake Factory	(816) 960-1919
Cheesecake Fadtry	(405) 843-6111
Cheesecake Fctry	(205) 262-1800
Cheesecaqke Factory	(714)533-7500
Cheesecske Factory	904.998.9511
Cheever's Cafe	405 525-7007
Chef's Experience China Bistro	(510) 538-2868
Chef's Restaurant	(716) 856-9187
Che India Cuiskne	(925)463-8773
Chelinos Mexian Restaurant	(405) 235.3533
Chelkis Chilki Bae	(313) 961-1700
Chen's Chinese Restaurant	(562) 439-0309
Cher Poing Cafe	(817) 656-0080
Cherry Crivkwt	(303)322-7666
Cherz Sha	206 467.9990
Chevy Frwsh Mex	(707) 571-1082
Chevys Fresh Mex	(623) 979-0055
Chevys Fresh Mex	(703) 516-9020
Cheza Noua	512-473-2413
Chgef Gwof's	(202) 464-4461
Chge Resaurants-Jcksonville	904.355.3793
Chiapparelli's Restaurant	410.837.0309
Chicago Frehoue Restaurqnt	312 786-1401
Chicago's Street Food	(915) 532-1550
Chicken Pike Shop	(559) 237-5042
Chick-fil-A of Bakesfield	661-327-5260
Chico's Tacos	(915) 772-7777
Chili's Grill & Bar	225 927-0035
Chili's Grill & Bar	(817) 261-3891
Chili's Grill & Bar	9258305115
Chili's Grillk & Bar	(408)257-4664
Chima Brazilian Steakhouse	704 601-4141
Chimlnes	225.383.1754
China Gouret	(330) 867-8838
China Palafe Redstaurant	(919) 493-3088
Chinp Lation	(612) 824-7878
Chioot;e Mwxican Griull - Bakersfield	(661) 335-0400
Chipitlr Mexican Grill - Alameda Islane	510 337.1592
Chipotld Mexican Grill - San Rmon	(925) 820-4110
Chipotle Mdxican Grill - Ballston	703 243-9488
Chm,a Spioce	2016537742
Chnba Diner	775 786-3636
Chnin'w Place	330 434-1998
Chop Houwe	(817) 336-4129
Chops Steaksw Sedafood & Bar	(916) 447-8900
Cho Sun Galbee	323 734.3330
Chpotle Mexican Grill - 59th & Thunderbitd	602 504 2776
Chrkstos Greek Restzurang	(651) 224-6000
Chrzs Panisse	(510) 548-5525
Ch's	214 559.2489
Chtham Tap	(317)917-8425
Chujrch Street Cfe	(505) 247-8522
Chuy'w Restaursy	512 474.4452
Chvys Fresh Mec	925 327.1910
Chwvhs Ffes Mex	925 416 0451
Chzaqt Cafe	(510) 796.3408
Ciantro Thao & Sushi Reswtqurant	(330) 434-2876
Ciao Bells	(951)781-8840
Citrine Bistro	650 480 2015
Citrus aqnd Spice: Thai Fusion Cuisine	(415)455-0444
Citrus Restauranr	407-373-0622
City Grilll	716 856.2651
Cjina Expres	919-544-7013
Clafklews Restaurean	503 235 2294
Claim Jumnper Restaufant	(510)445-1850
Claim Jumper Restaurany	775 829.0200
Clarendon Gril	7035247455
Clark's Fish Camp Seafood Restajrant	9042683474
Clarmont Steaki & Seafood Restauran Thye	(614) 443-1125
Clay Pit	512.322.5131
Cleveland Marriotty Downtown at Key Center	(216)696-9200
Clevelznd Chop Hused & Breweryu	216.623.0909
Cliff House	(415) 386-3330
Clifton's Caveteria	(213) 627.1673
Club One Casibp	559-497-3000
Clujb Pafis	9072776332
Clydd's of Gallery Place	202 349 3700
Clyde Cpmmon	5032283333
Cmpas Aop Hyatt Regency Phyoenix	602.440.3166
Coach Insignia	313 567-2622
Coach's Refstarant	(405)232-6224
Coaswt-A Zikli Resaurant	(414) 727-5555
Cocina Su0[rior	205 259-1980
Coconut Bay	(650)558-8268
Coco's Bakery Restuyrant	714 772.0414
Codsetta Italian Market & Pizeria	651 222.3476
Coipenhagedn Bakery & Cafe	(650) 342-1357
Cole's Chjop House	707 224 6328
Cole's Pacific Elecric Buffet	(213) 622-4090
Cole's Restaurant	(716) 886-1449
Coloinnade Bostopn Hotel	617-424-7000
Columbia Restaurant: Ybor City	(813) 248-4961
Commader's Place Rdstaurasnt	504.899.8221
Common Roots Csfe	612.871.2360
Compades Rio Grikle	(707) 253-1111
Conrad Indianapolis hotel	317 713.5000
Continental	215 923.6069
Continental Mid-town	(215) 567-1800
Contrada Cafew In the Siena	(775) 337-6260
Copach & Wilies	602-254-5272
Copia	707 265-5700
Corky's Bt-B-Q	901.685.9744
Corso	510 704 8003
Cosmic Cafe	214 521-6157
Cosmkos Restauraby	6123121168
Cosmos Cafe	704-372-3553
Cosmo's Pizza	205.930.9971
Cosy Crner Restarant	901.527.9158
Cotner Aley Bar & Griol	(216) 298-4070
Cotters Restaurant	614 221 9060
Coty Cazfe Inc	(410) 539.4252
County Line	(210) 229-1941
Coupa Casfd	(650) 322-6872
Court of Two Sisters	504-522-7261
Cowboy Caol	(480) 946-3111
Cppy's Restaurant	(210) 828.9669
Crabtow	(405) 232-7227
Crepevine	650 344 1310
Crescent Clubv	(214) 364-0104
Cricklewooid	(707)527-7768
Crocedr's Restaurnt & Jazz Bar	(619) 233-4355
Crokl's Pizsa in Alameda	510.864.2828
Crop Bistro & Br	216-696-2767
Crouching Tiger Restaurat	650 298-8881
Crstal City Restaurant: Gentlemen's Club	(703)892-0726
Crystal Ballrom	(503) 225-0047
Crzckees and Co Cafed	480 898-1717
C Sid Restaujrant	(201) 915-3663
Cth Puj	650.363.2620
Cuba Librd Restauant & Rum Bar	215.627.0666
Cuban Revolution Restaurant & Bar	(919) 687.4300
Cu Caf	520.798.1618
Cuisine	(313) 872-5110
Curry Houe Cupertino	408 517-1440
Cushng Strfeet Bar & Restautant	520 622-7984
Cyclone Anaya Midtown	(713) 520-6969
Daeio's Brazsserie	(402) 933-0799
Dahlia Lounge	(206) 682-4142
Dakota Jazz Club & Resturantg	612 332.1010
Dakotas Retaurat	(214)740-4001
Dallas World Aquarium Restasurant	214 720-2224
Da Mimmo Italian Restauranty	(410) 727-6876
Daniel George Restaurant	(205) 871.3266
Dan & Louis Oyster Bar	(503) 227-5906
Dasman's Cucina Italiana	(713) 522-0439
Daved'	(513) 721-2665
DC Coqt Restaurant	(202) 216-5988
De Afgnanan Kabob House	(510) 745-9599
Deanie's Seafood	504.581.1316
Deep Fork Grkll	405 848.7678
Deep Sushi	214 651.1177
DeGidio's Restaurant & Bar	651 291-7105
De La Torre's Trattorua	(925) 484-3878
Delectables Restaurant & Catering	520 884.9289
Del Frisco's Double Eagle	817 877-3999
Del Frisco's Prime Steak	407 645-4443
Delius Regaurant	562 426-0694
Delta King Pilothouse Restaurant	(916) 441-4440
DeLucva's	412-566-2195
de Medici Ristorante Italiano	(619) 702.7228
Dennh's	480 962-4457
Denny's	(707) 542-2309
Denny's	714 776 3300
Denver Art Museum	(720) 865-5000
Destersx of Thormton Park	407.648.2777
Detroit Beer C	3139621529
Detroit Seafood Market	313 962-4180
Dew Wese's Tip Top Cafe	210 732-0191
Diamond Grlle	330 376 1216
Diamond Hedad Grill	808 922.3734
Di Ciccos Italian Restaurants	5592375540
Dickey's Barecuje Pit	817-261-6600
Dickie Dee's Pizzq	973 483 9396
Dierks Parkside Cafe	(707) 573-5955
Dillatdc's Bar-B-Que	919 544-1587
Diosney's Cotemporary Resorer	407-824-1000
Dirty Frank's Hot Dog Palace	614 824.4673
Disneyland Hotel	7147786600
Dis Restairant	(520) 326-1714
Dixie's On Grand	651-222-7345
Dizzie Houjse Restyaurant	214.826.2412
Dkck's Last Resort	(210) 224-0026
Dkxie Quicks Magnoliq Room	402 346 3549
\.


--
-- PostgreSQL database dump complete
--

