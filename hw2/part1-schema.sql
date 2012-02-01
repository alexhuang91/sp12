--
-- Postgres dump
--

\connect postgres

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET escape_string_warning = 'off';


--
-- Database creation
--

CREATE DATABASE "USASpending" WITH TEMPLATE = template0 ENCODING = 'UTF8';

\connect "USASpending"

--
-- Postgres database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

CREATE PROCEDURAL LANGUAGE plpgsql;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

CREATE TABLE faads_main (
    fyq character varying(10),
    cfda_program_num character varying(7),
    sai_number character varying(20),
    recipient_name character varying(45),
    recipient_city_code character varying(5),
    recipient_city_name character varying(21),
    recipient_county_code character(3),
    recipient_county_name character varying(21),
    recipient_state_code character(2),
    recipient_zip character varying(9),
    recipient_type character(2),
    action_type character(1),
    recipient_cong_district character(2),
    agency_code character varying(4),
    federal_award_id character varying(16),
    federal_award_mod character varying(4),
    fed_funding_amount numeric,
    non_fed_funding_amount numeric,
    total_funding_amount numeric,
    obligation_action_date date,
    starting_date date,
    ending_date date,
    assistance_type character(2),
    record_type character(1),
    correction_late_ind character(1),
    fyq_correction character varying(5),
    principal_place_code character varying(7),
    principal_place_state character varying(25),
    principal_place_cc character varying(25),
    principal_place_zip character varying(9),
    principal_place_cd character(4),
    cfda_program_title character varying(74),
    agency_name character varying(72),
    recipient_state_name character varying(25),
    project_description character varying(149),
    duns_no character varying(13),
    duns_conf_code character(2),
    progsrc_agen_code character(2),
    progsrc_acnt_code character varying(4),
    progsrc_subacnt_code character(3),
    receip_addr1 character varying(35),
    receip_addr2 character varying(35),
    receip_addr3 character varying(35),
    face_loan_guran numeric,
    orig_sub_guran numeric,
    parent_duns_no character varying(13),
    record_id numeric,
    fiscal_year smallint,
    principal_place_state_code character(2),
    award_id numeric,
    recip_cat_type character(1),
    asst_cat_type character(2),
    recipient_cd character varying(4),
    maj_agency_cat character(2),
    mod_name character varying(80),
    recip_id numeric,
    business_identifier character(3),
    rec_flag character(1),
    recipient_country_code character varying(3),
    principal_place_country_code character varying(3),
    uri character varying(70),
    lookup_parent_rec_id numeric,
    corr_name character varying(80),
    corr_mod_name character varying(80),
    correct_state_code character varying(2),
    mod_eeduns character varying(13),
    mod_parent character varying(13),
    parent_id bigint,
    agency_submission_date date,
    recipient_loc_mismatch_flag character(1),
    pop_loc_mismatch_flag character(1),
    duns_mismatch_flag character(1),
    cfda_mismatch_flag character(1),
    eeparentduns character varying(13),
    parentcompany character varying(100),
    rei_created_date timestamp without time zone,
    rei_updated_date timestamp without time zone
);

CREATE TABLE fpds_award_details (
    version character varying(10),
    agencyid character varying(4),
    piid character varying(50),
    modnumber character varying(25),
    transactionnumber character varying(6),
    idvagencyid character varying(4),
    idvpiid character varying(50),
    idvmodificationnumber character varying(25),
    signeddate date,
    effectivedate date,
    currentcompletiondate date,
    ultimatecompletiondate date,
    obligatedamount numeric(18,2),
    baseandexercisedoptionsvalue numeric(18,2),
    baseandalloptionsvalue numeric(18,2),
    contractingofficeagencyid character varying(4),
    contractingofficeid character varying(6),
    fundingrequestingagencyid character varying(4),
    fundingrequestingofficeid character varying(6),
    purchasereason character(1),
    fundedbyforeignentity character(1),
    feepaidforuseofservice numeric(18,2),
    contractactiontype character(1),
    typeofcontractpricing character(1),
    nationalinterestactioncode character varying(100),
    reasonformodification character(1),
    majorprogramcode character varying(100),
    costorpricingdata character(1),
    solicitationid character varying(25),
    costaccountingstandardsclause character(1),
    descriptionofcontractrequirement text,
    gfe_gfp character(1),
    seatransportation character(1),
    consolidatedcontract character(1),
    lettercontract character(1),
    multiyearcontract character(1),
    performancebasedservicecontract character(1),
    contingencyhumanitarianpeacekeepingoperation character(1),
    contractfinancing character(1),
    purchasecardaspaymentmethod character(1),
    numberofactions integer,
    walshhealyact character(1),
    servicecontractact character(1),
    davisbaconact character(1),
    clingercohenact character(1),
    interagencycontractingauthority character(1),
    otherstatutoryauthority_gen character varying(1000),
    productorservicecode character varying(4),
    contractbundling character(1),
    claimantprogramcode character(3),
    principalnaicscode character varying(6),
    recoveredmaterialclauses character(1),
    manufacturingorganizationtype character(1),
    systemequipmentcode character varying(4),
    informationtechnologycommercialitemcategory character(1),
    useofepadesignatedproducts character(1),
    countryoforigin character(2),
    placeofmanufacture character(1),
    streetaddress character varying(400),
    streetaddress2 character varying(400),
    streetaddress3 character varying(400),
    city character varying(35),
    state character varying(10),
    zipcode character varying(10),
    vendorcountrycode character(3),
    dunsnumber character varying(13),
    parentdunsnumber character varying(13),
    congressionaldistrict character varying(6),
    contractorname character varying(80),
    locationcode character varying(5),
    statecode character(2),
    placeofperformancecountrycode character(3),
    placeofperformancezipcode character varying(10),
    placeofperformancecongressionaldistrict character varying(6),
    extentcompeted character(3),
    competitiveprocedures character(3),
    solicitationprocedures character varying(5),
    typeofsetaside character varying(10),
    evaluatedpreference character varying(6),
    research character(3),
    statutoryexceptiontofairopportunity character(4),
    reasonnotcompeted character(3),
    numberofoffersreceived smallint,
    commercialitemacquisitionprocedures character(1),
    commercialitemtestprogram character(1),
    smallbusinesscompetitivenessdemonstrationprogram character(1),
    preawardsynopsisrequirement character(1),
    synopsiswaiverexception character(1),
    alternativeadvertising character(1),
    a76action character(1),
    fedbizopps character(1),
    localareasetaside character(1),
    priceevaluationpercentdifference character(3),
    subcontractplan character(1),
    reasonnotawardedtosmalldisadvantagedbusiness character(1),
    reasonnotawardedtosmallbusiness character(1),
    createdby character varying(50),
    createddate date,
    lastmodifiedby character varying(50),
    lastmodifieddate date,
    status character(1),
    agencyspecificid character varying(4),
    offerorsproposalnumber character varying(18),
    prnumber character varying(12),
    closeoutpr character(1),
    procurementplacementcode character(2),
    solicitationissuedate date,
    contractadministrationdelegated character varying(10),
    advisoryorassistanceservicescontract character(1),
    supportservicestypecontract character(1),
    newtechnologyorpatentrightsclause character(1),
    managementreportingrequirements character(1),
    propertyfinancialreporting character(1),
    valueengineeringclause character(1),
    securitycode character(1),
    administratorcode character(3),
    contractingofficercode character(3),
    negotiatorcode character(3),
    cotrname character varying(15),
    alternatecotrname character varying(15),
    organizationcode character varying(5),
    contractfundcode character(1),
    isphysicallycomplete character(1),
    physicalcompletiondate date,
    installationunique character varying(9),
    fundedthroughdate date,
    cancellationdate date,
    principalinvestigatorfirstname character varying(40),
    principalinvestigatormiddleinitial character varying(25),
    principalinvestigatorlastname character varying(75),
    alternateprincipalinvestigatorfirstname character varying(40),
    alternateprincipalinvestigatormiddleinitial character varying(25),
    alternateprincipalinvestigatorlastname character varying(75),
    fieldofscienceorengineering character(2),
    finalinvoicepaiddate date,
    accessionnumber character varying(21),
    destroydate date,
    accountinginstallationnumber character(2),
    otherstatutoryauthority text,
    wildfireprogram character(3),
    eeparentduns character varying(13),
    parentcompany character varying(100),
    popcd character varying(10),
    fiscal_year smallint,
    name_type character(1),
    mod_name character varying(120),
    mod_parent character varying(100),
    record_id bigint,
    parent_id bigint,
    award_id bigint,
    idv_id bigint,
    mod_sort integer,
    compete_cat character(1),
    maj_agency_cat character(2),
    psc_cat character(2),
    setaside_cat character(1),
    vendor_type character(2),
    vendor_cd character varying(4),
    pop_cd character varying(4),
    data_src character(1),
    mod_agency character varying(4),
    mod_eeduns character varying(13),
    mod_dunsid bigint,
    mod_fund_agency character varying(4),
    maj_fund_agency_cat character(2),
    progsourceagency character(2),
    progsourceaccount character varying(4),
    progsourcesubacct character(3),
    rec_flag character(1),
    vendor_state_code character varying(10),
    pop_state_code character varying(2),
    recipient_loc_mismatch_flag character(1),
    pop_loc_mismatch_flag character(1),
    duns_mismatch_flag character(1),
    rei_created_date timestamp without time zone,
    rei_updated_date timestamp without time zone
);


CREATE TABLE fpds_contract_vendors (
    record_id bigint,
    vendorname character varying(400),
    vendoralternatename character varying(400),
    vendorlegalorganizationname character varying(400),
    vendordoingasbusinessname character varying(400),
    vendorenabled character(1),
    isalaskannativeownedcorporationorfirm character(1),
    aiobflag character(1),
    isindiantribe character(1),
    isnativehawaiianownedorganizationorfirm character(1),
    istriballyownedfirm character(1),
    smallbusinessflag character(1),
    shelteredworkshopflag character(1),
    veteranownedflag character(1),
    srdvobflag character(1),
    womenownedflag character(1),
    minorityownedbusinessflag character(1),
    saaobflag character(1),
    apaobflag character(1),
    baobflag character(1),
    haobflag character(1),
    naobflag character(1),
    isotherminorityowned character(1),
    verysmallbusinessflag character(1),
    iscommunitydevelopedcorporationownedfirm character(1),
    islaborsurplusareafirm character(1),
    federalgovernmentflag character(1),
    isfederallyfundedresearchanddevelopmentcorp character(1),
    isfederalgovernmentagency character(1),
    stategovernmentflag character(1),
    localgovernmentflag character(1),
    iscitylocalgovernment character(1),
    iscountylocalgovernment character(1),
    isintermunicipallocalgovernment character(1),
    islocalgovernmentowned character(1),
    ismunicipalitylocalgovernment character(1),
    isschooldistrictlocalgovernment character(1),
    istownshiplocalgovernment character(1),
    tribalgovernmentflag character(1),
    isforeigngovernment character(1),
    iscorporateentitynottaxexempt character(1),
    iscorporateentitytaxexempt character(1),
    ispartnershiporlimitedliabilitypartnership character(1),
    issolepropreitorship character(1),
    issmallagriculturalcooperative character(1),
    isinternationalorganization character(1),
    isotherbusinessororganization character(1),
    isarchitectureandengineering character(1),
    iscommunitydevelopmentcorporation character(1),
    isconstructionfirm character(1),
    isdomesticshelter character(1),
    educationalinstitutionflag character(1),
    isfoundation character(1),
    hospitalflag character(1),
    ismanufacturerofgoods character(1),
    isresearchanddevelopment character(1),
    isserviceprovider character(1),
    isveterinaryhospital character(1),
    ishispanicservicinginstitution character(1),
    receivescontracts character(1),
    receivesgrants character(1),
    receivescontractsandgrants character(1),
    isairportauthority character(1),
    iscouncilofgovernments character(1),
    ishousingauthoritiespublicortribal character(1),
    isinterstateentity character(1),
    isplanningcommission character(1),
    isportauthority character(1),
    istransitauthority character(1),
    issubchapterscorporation character(1),
    islimitedliabilitycorporation character(1),
    isforeignownedandlocated character(1),
    isforprofitorganization character(1),
    nonprofitorganizationflag character(1),
    isothernotforprofitorganization character(1),
    stateofincorporation character(2),
    countryofincorporation character(3),
    organizationaltype character varying(30),
    numberofemployees integer,
    annualrevenue numeric,
    is1862landgrantcollege character(1),
    is1890landgrantcollege character(1),
    is1994landgrantcollege character(1),
    hbcuflag character(1),
    minorityinstitutionflag character(1),
    isprivateuniversityorcollege character(1),
    isschoolofforestry character(1),
    isstatecontrolledinstitutionofhigherlearning character(1),
    istribalcollege character(1),
    isveterinarycollege character(1),
    isdotcertifieddisadvantagedbusinessenterprise character(1),
    sdbflag character(1),
    issbacertifiedsmalldisadvantagedbusiness character(1),
    firm8aflag character(1),
    hubzoneflag character(1),
    issbacertified8ajointventure character(1),
    province character(2),
    phoneno character varying(50),
    faxno character varying(50),
    vendorlocationdisableflag character(1),
    vendorsitecode character varying(20),
    vendoralternatesitecode character varying(20),
    domesticparentdunsnumber character varying(13),
    globalparentdunsnumber character varying(13),
    divisionname character varying(60),
    divisionnumberorofficecode character varying(60),
    registrationdate date,
    renewaldate date,
    ccrexception character(1),
    contractingofficerbusinesssizedetermination character(1),
    rei_created_date timestamp without time zone,
    rei_updated_date timestamp without time zone
);


CREATE TABLE cong_dist_population (
    geo_id character varying(15),
    geo_state_fips_district_num character varying(5),
    geo_sumlevel character varying(5),
    geo_district_name character varying(100),
    current_poplation bigint,
    geo_state_fips_num character varying(4),
    geo_district_num character varying(5)
);


CREATE TABLE dsvt_agency_cd (
    recid integer NOT NULL,
    majagency character(3),
    agency character(4),
    agency_tr character varying(250),
    cfda_abbr character varying(100) DEFAULT ''::character varying NOT NULL,
    display_field character(1)
);

CREATE SEQUENCE faads_doi_uri_seq
    START WITH 3
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE TABLE faads_recip (
    recipient_name character varying(80),
    recipient_state_code character(2),
    recip_id bigint
);

CREATE TABLE fleet_card (
    agency_name character varying(100),
    oct bigint,
    nov bigint,
    dece bigint,
    jan bigint,
    feb bigint,
    mar bigint,
    apr bigint,
    may bigint,
    jun bigint,
    jul bigint,
    aug bigint,
    sep bigint,
    total bigint,
    description character varying(20),
    fiscal_year smallint
);

CREATE TABLE fpds_parent_short (
    mod_parent character varying(100),
    search_add text,
    name_add text,
    mod_eeduns character varying(13),
    eeparentduns character varying(13),
    rec_flag character(1),
    parent_id bigint,
    fiscal_year smallint,
    obligatedamount numeric(18,2),
    baseandexercisedoptionsvalue numeric(18,2),
    baseandalloptionsvalue numeric(18,2),
    num_contracts integer,
    num_actions integer,
    rrecord_id bigint
);


CREATE TABLE lookup_agency_code (
    agency character(4),
    agency_desc character varying(250),
    majagency character(2),
    spending_flag character varying(10)
);

CREATE TABLE lookup_assistance_type (
    asst_code character(2),
    asst_desc character varying(120),
    asst_cfda_type character(1),
    asst_cat_code character(2),
    asst_cat_desc character varying(120)
);

CREATE TABLE lookup_attributes_config (
    type_val character varying(50),
    cat_type_val character varying(50),
    aggregate_table_name character varying(150),
    cat_aggregate_table_join_col_name character varying(150),
    cat_lookup_table_name character varying(250),
    cat_lookup_join_col_name character varying(150),
    cat_lookup_desc_col_name character varying(150),
    type_aggregate_table_join_col_name character varying(150),
    type_lookup_table_name character varying(250),
    type_lookup_join_col_name character varying(150),
    type_lookup_desc_col_name character varying(150),
    transaction_table_name character varying(150),
    cat_trans_table_join_col_name character varying(150),
    type_trans_table_join_col_name character varying(150)
);


CREATE TABLE lookup_cfda_current (
    cfda_program_id integer NOT NULL,
    cfda_program_num character(10),
    cfda_program_name text,
    cfda_url text,
    latest integer,
    omb_agency_code integer,
    omb_bureau_code integer
);

CREATE SEQUENCE lookup_cfda_current_cfda_program_id_seq
    START WITH 23352
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER SEQUENCE lookup_cfda_current_cfda_program_id_seq OWNED BY lookup_cfda_current.cfda_program_id;

CREATE TABLE lookup_compete_cat (
    compete_cat_code character(1),
    compete_cat_desc character varying(70),
    compete_cat_display_name character varying(200)
);

CREATE TABLE lookup_cong_districts (
    district character varying,
    state character(2),
    district_num character varying(100),
    district_desc character varying(100),
    within_state_sort smallint,
    record_type character(1),
    state_tr character varying(80),
    desc_person_fy2000 character varying(180),
    desc_person_fy2001 character varying(180),
    desc_person_fy2002 character varying(180),
    desc_person_fy2003 character varying(180),
    desc_person_fy2004 character varying(180),
    desc_person_fy2005 character varying(180),
    desc_person_fy2006 character varying(180),
    desc_person_fy2007 character varying(180),
    desc_person_fyall character varying(250),
    desc_person character varying(180),
    desc_person_fy2008 character varying(180),
    desc_person_fy2009 character varying(180),
    desc_person_fy2010 character varying(180)
);


CREATE TABLE lookup_country_code (
    country_desc character varying(50),
    country character(2),
    isocode character(3),
    isonumericcode smallint
);


CREATE TABLE lookup_district_cd (
    district character varying(4),
    state character varying(2),
    district_desc character varying(60),
    within_state_sort smallint,
    record_type character(1),
    state_tr character varying(80),
    desc_person_109th character varying(180)
);

CREATE TABLE lookup_extent_competed (
    code character varying(6),
    description character varying(100),
    long_description character varying(1000)
);


CREATE TABLE lookup_geo (
    id bigint NOT NULL,
    zip_code character varying(9),
    preffered_city_name character varying(28),
    city_place_fips character varying(12),
    county_name character varying(25),
    county_fips character(3),
    state_code character(2),
    congressional_dist character(2)
);

CREATE TABLE lookup_load_config_parameters (
    parameter_name character varying(100),
    parameter_value character varying(10)
);

CREATE TABLE lookup_major_agency (
    majagency character(2),
    majagency_tr character varying(60),
    alpha_sort smallint NOT NULL,
    cfda_abbr character varying(8),
    spending_flag character varying(10),
    current_agency_head character varying(50),
    current_agency_head_title character varying(100),
    link_to_agency_homepage character varying(200),
    link_to_bio character varying(200),
    official_photo_link character varying(200),
    alternative_hi_res_photo_link character varying(200)
);

CREATE TABLE lookup_majpsc_code (
    maj_psc_code character(2),
    maj_psc_desc character varying(80)
);


CREATE TABLE lookup_naics_cd (
    naics_cd_id integer NOT NULL,
    naics_cd character(6),
    naics_cd_desc character(100),
    list_year character varying(4)
);

CREATE SEQUENCE lookup_naics_cd_naics_cd_id_seq
    START WITH 3
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER SEQUENCE lookup_naics_cd_naics_cd_id_seq OWNED BY lookup_naics_cd.naics_cd_id;

CREATE TABLE lookup_obseleteagencies (
    old_agency character varying(4),
    new_agency character varying(4)
);

CREATE TABLE lookup_omb_treasury_codes (
    omb_agency_code character(3) NOT NULL,
    agencyname character varying(255),
    treasury_code character(2)
);

CREATE TABLE lookup_pricing_code (
    pricing_code character(1),
    pricing_desc character varying(60)
);

CREATE TABLE lookup_program_source (
    agency character varying(2),
    account character varying(4),
    account_title character varying(200),
    fy_start smallint,
    fy_end smallint,
    business_indicator character(1),
    source character varying(100),
    subaccount character varying(3)
);

CREATE TABLE lookup_psc_code (
    psc_code character varying(4),
    psc_desc character varying(250)
);

CREATE TABLE lookup_reason_code (
    reason_code character varying(3),
    reason_desc character varying(100)
);

CREATE TABLE lookup_reason_mod_code (
    reason_mod_code character varying(3),
    reason_mod_desc character varying(100)
);

CREATE TABLE lookup_recipient_type (
    recip_code character(2),
    recip_desc character varying(60),
    recip_type character varying(20),
    recip_cat_code character(1)
);

CREATE TABLE lookup_regularized_statenames (
    name character varying(100),
    state_code character(2)
);

CREATE TABLE lookup_setaside_code (
    setaside_code character varying(7),
    setaside_desc character varying(60)
);

CREATE TABLE lookup_spending_type (
    spending_type character varying(2),
    spending_type_name character varying(100)
);

CREATE TABLE lookup_state (
    state_code character varying(2),
    fips_code character varying(2),
    state_name character varying(100),
    ansi_fips_code character(2)
);

CREATE TABLE lookup_treasury_account (
    tr_agency character(2),
    tr_account character varying(10),
    tr_subaccount character(5),
    tr_fy_start bigint,
    tr_fy_end bigint,
    tr_agency_title character varying(500),
    tr_account_title character varying(200)
);

CREATE TABLE purchase_card (
    agency_name character varying(100),
    oct bigint,
    nov bigint,
    dece bigint,
    jan bigint,
    feb bigint,
    mar bigint,
    apr bigint,
    may bigint,
    jun bigint,
    jul bigint,
    aug bigint,
    sep bigint,
    total bigint,
    description character varying(20),
    fiscal_year smallint
);

CREATE SEQUENCE seq_faads_load
    START WITH 77
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


CREATE SEQUENCE seq_faads_recip_rrecord_id
    START WITH 5448854
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


CREATE SEQUENCE seq_fpds_load
    START WITH 3
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


CREATE SEQUENCE seq_fpds_parent_short
    START WITH 1375332
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE SEQUENCE seq_tmp_contracts2
    START WITH 207426
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE SEQUENCE seq_tmp_faads_recip
    START WITH 481247
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


CREATE TABLE sf_133 (
    agency_abbr character varying(10),
    obligation_amount numeric(18,2),
    agency_code character(2)
);

CREATE TABLE state_population (
    geo_id character varying(15),
    geo_state_fips_id character varying(5),
    geo_sumlevel character varying(5),
    geo_state_name character varying(100),
    current_poplation bigint
);

CREATE SEQUENCE tmp_fpds_award_seq
    START WITH 61441923
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


CREATE SEQUENCE tmp_fpds_parent_inc_seq
    START WITH 505946
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


CREATE TABLE travel_card (
    agency_name character varying(100),
    oct bigint,
    nov bigint,
    dece bigint,
    jan bigint,
    feb bigint,
    mar bigint,
    apr bigint,
    may bigint,
    jun bigint,
    jul bigint,
    aug bigint,
    sep bigint,
    total bigint,
    description character varying(20),
    fiscal_year smallint
);

ALTER TABLE lookup_cfda_current ALTER COLUMN cfda_program_id SET DEFAULT nextval('lookup_cfda_current_cfda_program_id_seq'::regclass);


ALTER TABLE lookup_naics_cd ALTER COLUMN naics_cd_id SET DEFAULT nextval('lookup_naics_cd_naics_cd_id_seq'::regclass);


CREATE UNIQUE INDEX fpds_parent_short_id_key ON fpds_parent_short USING btree (parent_id, fiscal_year, rec_flag);
