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
\.


--
-- PostgreSQL database dump complete
--

