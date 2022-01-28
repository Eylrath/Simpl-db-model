--drop table "PROJEKT"."GG" cascade constraints PURGE;
--drop table "PROJEKT"."GD" cascade constraints PURGE;
--drop table "PROJEKT"."GITARY" cascade constraints PURGE;
--drop table "PROJEKT"."GITARZYSCI" cascade constraints PURGE;
--drop table "PROJEKT"."GPE" cascade constraints PURGE;
--drop table "PROJEKT"."GPR" cascade constraints PURGE;
--drop table "PROJEKT"."MARKI" cascade constraints PURGE;
--drop table "PROJEKT"."PETLE" cascade constraints PURGE;
--drop table "PROJEKT"."PRZESTERY" cascade constraints PURGE;
--drop table "PROJEKT"."STRUNY" cascade constraints PURGE;
--drop table "PROJEKT"."WZMACNIACZE" cascade constraints PURGE;
--drop table "PROJEKT"."ZESPOLY" cascade constraints PURGE;
--drop table "PROJEKT"."DELAYE" cascade constraints PURGE;


CREATE TABLE delaye (
    de_no              NUMBER(4) NOT NULL,
    model              VARCHAR2(30),
    czas_powtarzania   VARCHAR2(30),
    marki_nazwa        VARCHAR2(30) NOT NULL
);

ALTER TABLE delaye ADD CONSTRAINT delaye_pk PRIMARY KEY ( de_no );

CREATE TABLE gd (
    delaye_de_no       NUMBER(4) NOT NULL,
    gitarzysci_id_no   NUMBER(4) NOT NULL
);

ALTER TABLE gd ADD CONSTRAINT gd_pk PRIMARY KEY ( delaye_de_no,
                                                  gitarzysci_id_no );

CREATE TABLE gg (
    gitarzysci_id_no   NUMBER(4) NOT NULL,
    gitary_g_no        NUMBER(4) NOT NULL
);

ALTER TABLE gg ADD CONSTRAINT gg_pk PRIMARY KEY ( gitarzysci_id_no,
                                                  gitary_g_no );

CREATE TABLE gitary (
    g_no                   NUMBER(4) NOT NULL,
    model                  VARCHAR2(30) NOT NULL,
    typ                    VARCHAR2(20) NOT NULL,
    liczba_przetwornikow   NUMBER(3) NOT NULL,
    mostek                 VARCHAR2(20),
    marki_nazwa            VARCHAR2(30) NOT NULL,
    struny_str_no          NUMBER(4) NOT NULL
);

ALTER TABLE gitary ADD CONSTRAINT gitary_pk PRIMARY KEY ( g_no );

CREATE TABLE gitarzysci (
    id_no                NUMBER(4) NOT NULL,
    imie                 VARCHAR2(30) NOT NULL,
    nazwisko             VARCHAR2(30) NOT NULL,
    marki_nazwa          VARCHAR2(30) NOT NULL,
    wzmacniacze_amp_no   NUMBER(4) NOT NULL
);

ALTER TABLE gitarzysci ADD CONSTRAINT gitarzysci_pk PRIMARY KEY ( id_no );

CREATE TABLE gpe (
    gitarzysci_id_no   NUMBER(4) NOT NULL,
    petle_lo_no        NUMBER(4) NOT NULL
);

ALTER TABLE gpe ADD CONSTRAINT gpe_pk PRIMARY KEY ( gitarzysci_id_no,
                                                    petle_lo_no );

CREATE TABLE gpr (
    gitarzysci_id_no   NUMBER(4) NOT NULL,
    przestery_ov_no    NUMBER(4) NOT NULL
);

ALTER TABLE gpr ADD CONSTRAINT gpr_pk PRIMARY KEY ( gitarzysci_id_no,
                                                    przestery_ov_no );

CREATE TABLE marki (
    nazwa     VARCHAR2(30) NOT NULL,
    rok_zal   NUMBER(4)
);

ALTER TABLE marki ADD CONSTRAINT marki_pk PRIMARY KEY ( nazwa );

CREATE TABLE petle (
    lo_no         NUMBER(4) NOT NULL,
    model         VARCHAR2(30),
    maks_czas     NUMBER(4),
    marki_nazwa   VARCHAR2(30) NOT NULL
);

ALTER TABLE petle ADD CONSTRAINT petle_pk PRIMARY KEY ( lo_no );

CREATE TABLE przestery (
    ov_no              NUMBER(4) NOT NULL,
    model              VARCHAR2(30) NOT NULL,
    rodzaj             VARCHAR2(30 CHAR) NOT NULL,
    zasieg_modulacji   NUMBER(4),
    marki_nazwa        VARCHAR2(30) NOT NULL
);

ALTER TABLE przestery
    ADD CHECK ( rodzaj IN (
        'distortion',
        'fuzz',
        'overdrive'
    ) );

ALTER TABLE przestery ADD CONSTRAINT przestery_pk PRIMARY KEY ( ov_no );

CREATE TABLE struny (
    str_no              NUMBER(4) NOT NULL,
    czas_przydatnosci   NUMBER(4) NOT NULL,
    model               VARCHAR2(30) NOT NULL,
    marki_nazwa         VARCHAR2(30) NOT NULL
);

ALTER TABLE struny ADD CONSTRAINT struny_pk PRIMARY KEY ( str_no );

CREATE TABLE wzmacniacze (
    amp_no          NUMBER(4) NOT NULL,
    model           VARCHAR2(30) NOT NULL,
    jack_input_no   NUMBER(2),
    marki_nazwa     VARCHAR2(30) NOT NULL
);

ALTER TABLE wzmacniacze ADD CONSTRAINT wzmacniacze_pk PRIMARY KEY ( amp_no );

CREATE TABLE zespoly (
    nazwa_zespolu      VARCHAR2(30) NOT NULL,
    rok_zalozenia      NUMBER(4),
    gitarzysci_id_no   NUMBER(4) NOT NULL
);

ALTER TABLE zespoly ADD CONSTRAINT zespoly_pk PRIMARY KEY ( nazwa_zespolu );

ALTER TABLE delaye
    ADD CONSTRAINT delaye_marki_fk FOREIGN KEY ( marki_nazwa )
        REFERENCES marki ( nazwa );

ALTER TABLE gd
    ADD CONSTRAINT gd_delaye_fk FOREIGN KEY ( delaye_de_no )
        REFERENCES delaye ( de_no );

ALTER TABLE gd
    ADD CONSTRAINT gd_gitarzysci_fk FOREIGN KEY ( gitarzysci_id_no )
        REFERENCES gitarzysci ( id_no );

ALTER TABLE gg
    ADD CONSTRAINT gg_gitary_fk FOREIGN KEY ( gitary_g_no )
        REFERENCES gitary ( g_no );

ALTER TABLE gg
    ADD CONSTRAINT gg_gitarzysci_fk FOREIGN KEY ( gitarzysci_id_no )
        REFERENCES gitarzysci ( id_no );

ALTER TABLE gitary
    ADD CONSTRAINT gitary_marki_fk FOREIGN KEY ( marki_nazwa )
        REFERENCES marki ( nazwa );

ALTER TABLE gitary
    ADD CONSTRAINT gitary_struny_fk FOREIGN KEY ( struny_str_no )
        REFERENCES struny ( str_no );

ALTER TABLE gitarzysci
    ADD CONSTRAINT gitarzysci_marki_fk FOREIGN KEY ( marki_nazwa )
        REFERENCES marki ( nazwa );

ALTER TABLE gitarzysci
    ADD CONSTRAINT gitarzysci_wzmacniacze_fk FOREIGN KEY ( wzmacniacze_amp_no )
        REFERENCES wzmacniacze ( amp_no );

ALTER TABLE gpe
    ADD CONSTRAINT gpe_gitarzysci_fk FOREIGN KEY ( gitarzysci_id_no )
        REFERENCES gitarzysci ( id_no );

ALTER TABLE gpe
    ADD CONSTRAINT gpe_petle_fk FOREIGN KEY ( petle_lo_no )
        REFERENCES petle ( lo_no );

ALTER TABLE gpr
    ADD CONSTRAINT gpr_gitarzysci_fk FOREIGN KEY ( gitarzysci_id_no )
        REFERENCES gitarzysci ( id_no );

ALTER TABLE gpr
    ADD CONSTRAINT gpr_przestery_fk FOREIGN KEY ( przestery_ov_no )
        REFERENCES przestery ( ov_no );

ALTER TABLE petle
    ADD CONSTRAINT petle_marki_fk FOREIGN KEY ( marki_nazwa )
        REFERENCES marki ( nazwa );

ALTER TABLE przestery
    ADD CONSTRAINT przestery_marki_fk FOREIGN KEY ( marki_nazwa )
        REFERENCES marki ( nazwa );

ALTER TABLE struny
    ADD CONSTRAINT struny_marki_fk FOREIGN KEY ( marki_nazwa )
        REFERENCES marki ( nazwa );

ALTER TABLE wzmacniacze
    ADD CONSTRAINT wzmacniacze_marki_fk FOREIGN KEY ( marki_nazwa )
        REFERENCES marki ( nazwa );

ALTER TABLE zespoly
    ADD CONSTRAINT zespoly_gitarzysci_fk FOREIGN KEY ( gitarzysci_id_no )
        REFERENCES gitarzysci ( id_no );
        
        

insert into marki(nazwa,rok_zal)values('ibanez',1908);
insert into marki(nazwa,rok_zal)values('kustom',1964);
insert into marki(nazwa,rok_zal)values('epiphone',1915);
insert into marki(nazwa,rok_zal)values('dunlop',1965);
insert into marki(nazwa,rok_zal)values('ernie ball',1970);
insert into marki(nazwa,rok_zal)values('takamine',1944);
insert into marki(nazwa,rok_zal)values('boss',1950);
insert into marki(nazwa,rok_zal)values('peavey',1940);

insert into struny(str_no,czas_przydatnosci,model,marki_nazwa)values(1,30,'DESBN0952','dunlop');
insert into struny(str_no,czas_przydatnosci,model,marki_nazwa)values(2,30,'3331','ernie ball');

insert into gitary(g_no,model,typ,liczba_przetwornikow,mostek,marki_nazwa,struny_str_no)
    values(1,'sgg400', 'elektryczna',2,'staly','epiphone',1);
insert into gitary(g_no,model,typ,liczba_przetwornikow,mostek,marki_nazwa,struny_str_no)
    values(2,'js100', 'elektryczna',2,'floyd rose','ibanez',1);
insert into gitary(g_no,model,typ,liczba_przetwornikow,mostek,marki_nazwa,struny_str_no)
    values(3,'ef450c', 'akustyczna',2,'staly','takamine',1);    
insert into gitary(g_no,model,typ,liczba_przetwornikow,mostek,marki_nazwa,struny_str_no)
    values(4,'frm150', 'elektryczna',2,'staly','ibanez',2); 
    
insert into przestery(ov_no,model,rodzaj,zasieg_modulacji,marki_nazwa)
    values(1,'fat sandwich','overdrive',40,'dunlop'); 
insert into przestery(ov_no,model,rodzaj,zasieg_modulacji,marki_nazwa)
    values(2,'fz mini','fuzz',70,'ibanez');
insert into przestery(ov_no,model,rodzaj,zasieg_modulacji,marki_nazwa)
    values(3,'fz mini','fuzz',70,'ibanez');
insert into przestery(ov_no,model,rodzaj,zasieg_modulacji,marki_nazwa)
    values(4,'distortion','distortion',70,'epiphone');
    
insert into delaye(de_no,model,czas_powtarzania,marki_nazwa)
    values(1,'ep103',100,'dunlop');
insert into delaye(de_no,model,czas_powtarzania,marki_nazwa)
    values(2,'ambient',150,'ernie ball');
insert into delaye(de_no,model,czas_powtarzania,marki_nazwa)
    values(3,'dd-90',150,'epiphone');

insert into petle(lo_no,model,maks_czas,marki_nazwa)
    values(1,'rc1',1000,'boss');
insert into petle(lo_no,model,maks_czas,marki_nazwa)
    values(2,'rc2',1000,'boss');
insert into petle(lo_no,model,maks_czas,marki_nazwa)
    values(3,'rc3',1000,'boss');
    
insert into wzmacniacze(amp_no,model,jack_input_no,marki_nazwa)
    values(1,'jsx10',4,'peavey');
insert into wzmacniacze(amp_no,model,jack_input_no,marki_nazwa)
    values(2,'ibz15gr',3,'ibanez');
insert into wzmacniacze(amp_no,model,jack_input_no,marki_nazwa)
    values(3,'hv100',3,'kustom');
    
insert into gitarzysci(id_no,imie,nazwisko,marki_nazwa,wzmacniacze_amp_no)
    values(1,'Joe','Satriani','ibanez',1);
insert into gitarzysci(id_no,imie,nazwisko,marki_nazwa,wzmacniacze_amp_no)
    values(2,'Steve','Vai','ibanez',1);
insert into gitarzysci(id_no,imie,nazwisko,marki_nazwa,wzmacniacze_amp_no)
    values(3,'John','Petrucci','ibanez',3);
    
insert into zespoly(nazwa_zespolu,rok_zalozenia,gitarzysci_id_no)
    values('Dream Theater',1990,3);
insert into zespoly(nazwa_zespolu,rok_zalozenia,gitarzysci_id_no)
    values('Chickenfoot',2000,1);
    
insert into gd(delaye_de_no,gitarzysci_id_no)values(1,2);
insert into gd(delaye_de_no,gitarzysci_id_no)values(2,3);
insert into gd(delaye_de_no,gitarzysci_id_no)values(3,1);
insert into gd(delaye_de_no,gitarzysci_id_no)values(1,3);


insert into gpr(przestery_ov_no,gitarzysci_id_no)values(1,2);
insert into gpr(przestery_ov_no,gitarzysci_id_no)values(2,3);
insert into gpr(przestery_ov_no,gitarzysci_id_no)values(2,1);
insert into gpr(przestery_ov_no,gitarzysci_id_no)values(1,3);
insert into gpr(przestery_ov_no,gitarzysci_id_no)values(3,3);

insert into gpe(petle_lo_no,gitarzysci_id_no)values(1,2);
insert into gpe(petle_lo_no,gitarzysci_id_no)values(2,3);
insert into gpe(petle_lo_no,gitarzysci_id_no)values(2,1);
insert into gpe(petle_lo_no,gitarzysci_id_no)values(1,3);
insert into gpe(petle_lo_no,gitarzysci_id_no)values(3,3);

insert into gg(gitary_g_no,gitarzysci_id_no)values(1,2);
insert into gg(gitary_g_no,gitarzysci_id_no)values(2,3);
insert into gg(gitary_g_no,gitarzysci_id_no)values(2,1);
insert into gg(gitary_g_no,gitarzysci_id_no)values(3,3);
insert into gg(gitary_g_no,gitarzysci_id_no)values(4,1);
insert into gg(gitary_g_no,gitarzysci_id_no)values(3,2);

select imie,nazwisko,model,gitary.marki_nazwa from gitarzysci join gg on gitarzysci_id_no=id_no join gitary on gitary_g_no=g_no;
select model,marki_nazwa, typ, mostek from gitary join gg on gitary_g_no=g_no where gitarzysci_id_no=2;

select imie,nazwisko, gitary.model,gitary.marki_nazwa, delaye.marki_nazwa, delaye.model
    from gd full outer join gitarzysci on gd.gitarzysci_id_no=id_no 
        full outer join delaye on de_no=delaye_de_no 
            full outer join gg on gg.gitarzysci_id_no=id_no
               full outer join gitary on gitary_g_no=g_no;
                
select model, nazwa from gitary join marki on nazwa=marki_nazwa where rok_zal>1930;

select gitary.model, gitary.marki_nazwa from gitary join struny on struny_str_no=str_no order by czas_przydatnosci;