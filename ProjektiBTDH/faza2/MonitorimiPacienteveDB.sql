create database MonitorimiPacienteveDB
drop database 
use MonitorimiPacienteveDB

create database DBMonitorimiPacienteve
use DBMonitorimiPacienteve

								-- Pacienti --
create table Pacienti_Adresa (
						Aid integer,
                        Arruga varchar(50) not null,
                        Aqyteti varchar(50) not null,
                        Ashteti varchar(50) not null,
                        Akodipostal integer not null,
                        PRIMARY KEY (Aid)
					  )
                        
create table Pacienti_Kontakti (
						Kid integer,
                        Kmob integer not null,
                        Kfix integer,
                        Kemail varchar(50),
                        PRIMARY KEY (Kid)
					  )
                      
create table Pacienti_Alergjite (
						ALid integer,
                        ALemri varchar(50) not null,
                        ALsimptomat varchar(50) not null,
                        PRIMARY KEY (ALid)
					  )

create table Pacienti (
						SSN  integer,
                        Pemri varchar(50) not null,
                        Pmbiemri varchar(50) not null,
                        Pprindi varchar(50) not null,
                        Pgjinia varchar(1) not null,
                        Pdatelindja varchar(50) not null,
                        Padresa integer not null,
                        Pkontakti integer not null,
                        Pgrgjakut varchar(2) not null,
                        Palergjite integer not null,
                        PRIMARY KEY (SSN),
                        FOREIGN KEY (Padresa) references Pacienti_Adresa(Aid) on delete cascade on update cascade,
                        FOREIGN KEY (Pkontakti) references Pacienti_Kontakti(Kid) on delete cascade on update cascade,
                        FOREIGN KEY (Palergjite) references Pacienti_Alergjite(ALid) on delete cascade on update cascade
					  )
                      
                      
                      
								-- Doktori --
create table Grada 	  (
						Gid integer,
                        Gemri varchar(50) not null,
                        PRIMARY KEY (Gid)
					  )

create table Doktori_Adresa (
						Did integer,
                        Drruga varchar(50) not null,
                        Dqyteti varchar(50) not null,
                        Dshteti varchar(50) not null,
                        Dkodipostal integer not null,
                        PRIMARY KEY (Did)
					  ) 
                        
create table Doktori_Kontakti (
						Did integer,
                        Dmob integer not null,
                        Dfix integer not null,
                        Demail varchar(50) not null,
                        PRIMARY KEY (Did)
					  )
                      
create table Doktori_Reparti (
						Rid integer,
                        Remri varchar(50) not null,
                        PRIMARY KEY (Rid)
					  )
 
create table Doktori_Paga (
						Pid integer,
                        Gid integer not null,	
                        Prroga real not null,
                        PRIMARY KEY (Pid),
                        FOREIGN KEY (Gid) references Grada(Gid) on delete cascade on update cascade
					  )
 
create table Doktori  (
						Did integer,
                        Demri varchar(50) not null,
                        Dmbiemri varchar(50) not null,
                        Dgrada integer not null,
                        Dadresa integer not null,
						Dkontakti integer not null,
                        Dreparti integer not null,
                        Dpaga integer not null,
                        PRIMARY KEY (Did),
                        FOREIGN KEY (Dgrada) references Grada(Gid) on delete cascade on update cascade,
                        FOREIGN KEY (Dadresa) references Doktori_Adresa(Did) on delete cascade on update cascade,
                        FOREIGN KEY (Dkontakti) references Doktori_Kontakti(Did) on delete cascade on update cascade,
                        FOREIGN KEY (Dreparti) references Doktori_Reparti(Rid) on delete  cascade on update cascade,	
                        FOREIGN KEY (Dpaga) references Doktori_Paga(Pid) on delete cascade on update cascade
					  )
          
          
          
								-- Sensoret --
create table Sensoret_Lloji (
						Sid integer,
                        Slloji varchar(50) not null,
                        PRIMARY KEY (Sid)
					  )
                    
create table Sensoret (
						Sid integer,
                        Semri varchar(50) not null,
                        Sprodhuesi varchar(50) not null,
                        Slloji integer not null,
                        Sdata varchar(50) not null,
                        PRIMARY KEY (Sid),
                        FOREIGN KEY (Slloji) references Sensoret_Lloji(Sid) on delete cascade on update cascade
					  )
   
	
    
								-- Terminet -- 
create table Terminet_Reparti (
						Rid integer,
                        Temri varchar(50) not null,
                        PRIMARY KEY (Rid)
					  )
                      
create table Terminet_Statusi (
						STid integer,
                        STemri varchar(50) not null,
                        PRIMARY KEY (STid) 
					  )
   
create table Terminet (
						Tid integer,
                        SSN integer not null,
                        Dataterminit date not null,
                        Treparti integer not null,
                        Tstatusi integer not null,
                        Oraterminit time not null,
                        PRIMARY KEY (Tid),
                        FOREIGN KEY (SSN) references Pacienti(SSN) on delete cascade on update  cascade,
                        FOREIGN KEY (Treparti) references Terminet_Reparti(Rid) on delete cascade on update cascade,
                        FOREIGN KEY (Tstatusi) references Terminet_Statusi(STid) on delete cascade on update cascade
					  )            
                      
                      
            
								-- Hospitalizimi --            
create table HospitalizimiPacienteve (
						HPid integer,
                        SSN integer not null,
                        Did integer not null,
                        HPdata date not null,
                        HPdiagnoza varchar(50) not null,
                        HPterapia varchar(50) not null,
                        Tid integer not null,
                        Sid integer not null,
                        PRIMARY KEY (HPid),
                        UNIQUE (SSN,Did,HPdata),
                        FOREIGN KEY (SSN) references Pacienti(SSN) on delete cascade on update cascade,
                        FOREIGN KEY (Did) references Doktori(Did) on delete cascade on update cascade,
                        FOREIGN KEY (Tid) references Terminet(Tid) on delete cascade on update cascade,
                        FOREIGN KEY (Sid) references Sensoret(Sid) on delete cascade on update cascade
					  )
                      
                      
                      
								-- Faturat --
create table Faturat_Pagesa (
						Fid integer,
                        Fbanka varchar(50),
                        Ftarifa integer,
                        PRIMARY KEY (Fid)
					  )
                                
create table Faturat  (
						Fid integer,
                        HPid integer not null,
                        FcmimiPA integer not null,
                        FTVSH	integer not null,
                        Fcmimitotal integer not null,
                        Fbankar integer not null,
                        Fdata varchar(50) not null,
                        Fllojipageses integer not null,
                        PRIMARY KEY (Fid),
                        FOREIGN KEY (HPid) references HospitalizimiPacienteve(HPid) on delete cascade on update cascade,
                        FOREIGN KEY (Fllojipageses) references Faturat_Pagesa(Fid) on delete cascade on update cascade
					  )
                      
                      
								-- Insertimi i te dhenave -- 
                                
                                

         
insert into Pacienti_adresa ( Aid, Arruga, Aqyteti, Ashteti, Akodipostal )
values    (  1,	'Besmir Hoxha',			'Prishtine','Kosove',	'100000' ),
		  (  2,	'Hivzi Sylejmani',		'Prishtine','Kosove',	'100000' ),
		  (  3,	'Gjon Buzuku',			'Gjakove',	'Kosove',	'50000'  ),
		  (  4,	'Adem Jashari',			'Prizren',	'Kosove',	'12000'  ),
		  (  5,	'Isa Boletini',			'Gjilan',	'Kosove',	'20000'  ),
		  (  6,	'Mehmet Gradica',		'Prishtine','Kosove',	'100000' ),
		  (  7,	'Kadri Veseli',			'Malisheve','Kosove',	'30000'  ),
		  (  8,	'Agim Ramadani',		'Prishtine','Kosove',	'100000' ),
		  (  9,	'Garibaldi',			'Prishtine','Kosove',	'100000' ),
		  ( 10,	'Vellezerit Kajtazi',	'Gjakove',	'Kosove',	'50000'  )


insert into Pacienti_Kontakti ( Kid, Kmob, Kfix, Kemail )
values    (  1,	044452258,	038111111,	'Pkontakt1@gmail.com'  ),
		  (	 2,	049258956,	038111112,	'Pkontakt2@gmail.com'  ),
		  (	 3,	045121489,	038111113,	'Pkontakt3@gmail.com'  ),
		  (	 4,	044562397,	038111114,	'Pkontakt4@gmail.com'  ),
		  (	 5,	044447100,	038111115,	'Pkontakt5@gmail.com'  ),
		  (	 6,	049231963,	038111116,	'Pkontakt6@gmail.com'  ),
		  (	 7,	045123456,	038111117,	'Pkontakt7@gmail.com'  ),
		  (	 8,	049222351,	038111118,	'Pkontakt8@gmail.com'  ),
		  (	 9,	044321654,	038111119,	'Pkontakt9@gmail.com'  ),
		  (	10,	045321222,	038111120,	'Pkontakt10@gmail.com' )


insert into Pacienti_Alergjite ( ALid, ALemri,  ALsimptomat )
values 	  (  1,	'Alergji ne polen',			'Teshtimë' 				),
		  (	 2,	'Alergji ne pluhur',		'Kollitje, Frymëzënie'  ),
		  (	 3,	'Alergji ne injeksioneve',	'Urinim'				),
		  (	 4,	'Alergji ne ushqim',		'Frymëzënie, ënjtje'	)


insert into Pacienti ( SSN, Pemri, Pmbiemri, Pprindi, Pgjinia, Pdatelindja, Padresa, Pkontakti, Pgrgjakut, Palergjite)
values   (   1, 'Shkelqim', 'Rexhepi',  'Ismail', 	'M', 	'01/01/1994',   1,  1,  'A',    1 ),
		 (   2,	'Gazmend',	'Tersholli','Isak',		'M',	'02/02/1993',	2,	2,	'A',	2 ),
		 (   3,	'Sokol',	'Bashota',	'Qemal',	'M',	'05/12/1990',	3,	3,	'B',	3 ),
         (   4,	'Ismail',	'Qemaili',	'Fisnik',	'M', 	'12/17/1987',	4,	4,	'0',	4 ),
		 (   5,	'Ibrahim',	'Sfishta',	'Besnik',	'M',	'25/11/1965',	5,	5,	'A',	1 ),
		 (   6,	'Fadil',	'Neziri',	'Abdyl',	'M',	'12/08/1993',	6,	6,	'0',	4 ),
		 (   7,	'Endrit',	'Krasniqi',	'Hamdi',	'M',	'30/01/2001',	7,	7,	'0',	4 ),
		 (   8,	'Miranda',	'Gashi',	'Gani',		'F',	'12/12/1999',	8,	8,	'B',	3 ),
		 (   9,	'Arta',		'Fetahu',	'Mehdi',	'F',	'13/05/1995',	3,	9,	'A',	2 ),
		 (  10,	'Mirlinda',	'Musliu',	'Isa',		'F', 	'22/03/1995',	10,	10,	'B',	2 )




insert into Grada ( Gid, Gemri )
values  ( 	 1,	'Mrsc.'  ),
		(	 2, 'Dr.'	 ),
		(	 3,	'Spec.'	 )


insert into Doktori_Adresa ( Did, Drruga, Dqyteti, Dshteti, Dkodipostal )
values 	( 	 1,	'Agim Ramadani',	'Prishtine',	'Kosove',	100000 ),
		(	 2,	'Hivzi Sylejmani',	'Prishtine',	'Kosove',	100000 ),
		(	 3,	'Gjergj Fishta',	'Prishtine',	'Kosove',	100000 ),
		(	 4,	'Adem Jashari',		'Prishtine',	'Kosove',	100000 ),
		(	 5,	'Justiniani',		'Prishtine',	'Kosove',	100000 ),
		(	 6,	'Zahir Pajaziti',	'Gjakove',		'Kosove',	50000  ),
		(	 7,	'Gjon Buzuku',		'Gjakove',		'Kosove',	50000  ),
		(	 8,	'Mehmet Gradica',	'Prishtine',	'Kosove',	100000 ),
		(	 9,	'Adem Jashari',		'Prizren',		'Kosove',	12000  ),
		(	10,	'Isa Boletini',		'Gjakove',		'Kosove',	50000  )


insert into Doktori_Kontakti ( Did, Dmob, Dfix, Demail )
values 	(	 1,	044432345,	038222220,	'Pkontakt1@gmail.com'  ),
		(	 2,	045932424,	038222221,	'Pkontakt2@gmail.com'  ),
		(	 3,	049145729,	038222222,	'Pkontakt3@gmail.com'  ),
		(	 4,	044250541,	038222223,	'Pkontakt4@gmail.com'  ),
		(	 5,	045111222,	038222224,	'Pkontakt5@gmail.com'  ),
		(	 6,	049329222,	038222225,	'Pkontakt6@gmail.com'  ),
		(	 7,	049993113,	038222226,	'Pkontakt7@gmail.com'  ),
		(	 8,	045447100,	038222227,	'Pkontakt8@gmail.com'  ),
		(	 9,	044329932,	038222228,	'Pkontakt9@gmail.com'  ),
		(	10,	044444433,	038222229,	'Pkontakt10@gmail.com' )


insert into Doktori_Reparti ( Rid, Remri )
values  ( 	 1, 	'Neurologji'	),
		(	 2,		'Kardiologji'	),
		(	 3,		'Oftamologji'	),
		(	 4,		'Kirurgji'		),
		(	 5,		'Urologji'		),
		(	 6,		'Pediatri'		),
		(	 7,		'Radiologji'	)


insert into Doktori_Paga ( Pid, Gid, Prroga )
values  ( 	 1,		1,		500     ),
		(	 2,		2,		700 	),
		(	 3,		2,		700		),
		(	 4,		1,		500		),
		(	 5,		3,	   1000		),
		(	 6,		3,	   1000		),
		(	 7,		3,	   1000		),
		(	 8,		3,	   1000		),
		(	 9,		1,		500		),
		(	10,		2,		700		)


insert into Doktori ( Did, Demri, Dmbiemri, Dgrada, Dadresa, Dkontakti, Dreparti, Dpaga )
values 	( 	 1,		'Selajdin',	'Boshnjaku',	1,	1,	1,	1,	1 	),
		(	 2,		'Avni',		'Fetahu',		2,	2,	2,	2,	2   ),
		(	 3,		'Fatos',	'Haxhosaj',		3,	3,	3,	3,	3	),
		(	 4,		'Jetish',	'Jetishi',		3,	4,	4,	4,	4	),
		(	 5,		'Fatlum',	'Fazliu',		2,	5,	5,	5,	5	),	
		(	 6,		'Mentor',	'Gajtani',		3,	6,	6,	2,	6	),
		(	 7,		'Fatlum',	'Bokshi',		3,	7,	7,	3,	7	),
		(	 8,		'Erudit',	'Morina',		3,	8,	8,	1,	8	),
		(	 9,		'Gezim' ,	'Kamberi',		1,	9,	9,	7,	9	),
		(	 10,	'Lavdim',	'Hasani',		2,	10,	10,	6,	10	)




insert into Sensoret_Lloji ( Sid, Slloji )
values  (	 1,		'Pulsit Zemres' 				),
		(	 2,		'Tensionit Gjakut'				),
		(	 3,		'Temperatures'					),
		(	 4,		'Nivelit te oksigjenit ne gjak'	)


insert into Sensoret ( Sid, Semri, Sprodhuesi, Slloji, Sdata )
values  ( 	 1,		'Senzori 1',	'Micro',	1,	'2012-05-08' 	),
		(	 2,		'Senzori 2',	'Elkos',	2,	'2015-10-10'	),
		(	 3,		'Senzori 3',	'Genius',	1,	'2014-12-25'	),
		(	 4,		'Senzori 4',	'Lenovo',	3,	'2015-03-01'	),
		(	 5,		'Senzori 5',	'Dell',		4,	'2013-07-08'	),
		(	 6,		'Senzori 6',	'Lenovo',	2,	'2013-07-08'	),
		(	 7,		'Senzori 7',	'Micro',	3,	'2013-07-08'	),
		(	 8,		'Senzori 8',	'Lenovo',	1,	'2013-07-08'	),
		(	 9,		'Senzori 9',	'Dell',		2,	'2013-07-08'	),
		(	10,		'Senzori 10',	'Apple',	4,	'2013-07-08'	)




insert into Terminet_Reparti ( Rid, Temri )
values  ( 	 1, 	'Neurologji'	),
		(	 2,		'Kardiologji'	),
		(	 3,		'Oftamologji'	),
		(	 4,		'Kirurgji'		),
		(	 5,		'Urologji'		),
		(	 6,		'Pediatri'		),
		(	 7,		'Radiologji'	)


insert into Terminet_Statusi ( STid, STemri )
values  (    1,	'I paperfunduar' 	),
		(	 2,	'I perfunduar'		),
		(	 3,	'I anuluar'  		)


insert into Terminet ( 	Tid, SSN, Dataterminit, Treparti, Tstatusi, Oraterminit )
values  (	 1,		1,	'2016-11-13',	1,	1,	'15:00:00'	 ),
		(	 2,		2,	'2016-11-12',	2,	2,	'16:00:00'	 ),
		(	 3,		3,	'2015-02-25',	5,	1,	'16:00:00'	 ),
		(	 4,		4,	'2016-10-10',	4,	3,	'16:00:00'	 ),
		(	 5,		5,	'2015-10-09',	6,	1,	'16:00:00'	 ),
		(	 6,		6,	'2015-11-18',	7,	1,	'8:00:00'	 ),
		(	 7,		7,	'2016-11-27',	4,	2,	'9:00:00'	 ),
		(	 8,		8,	'2016-11-30',	2,	3,	'11:00:00'	 ),
		(	 9,		9,	'2016-12-02',	5,	3,	'16:00:00'	 ),
		(	10,	   10,	'2016-11-25',	4,	2,	'13:00:00'	 )
	

insert into HospitalizimiPacienteve ( HPid, SSN, Did, HPdata, HPterapia, HPdiagnoza, Tid, Sid )
values  (  	 1,	1,	1,	'2016-11-20', 	'Terapia 1',	'Diagnoza 1',	1,	4	),
		(	 2,	2,	2,	'2016-10-20',	'Terapia 2',	'Diagnoza 2',	2,	1	),
		(	 4,	4,	2,	'2016-11-23',	'Terapia 3',	'Diagnoza 3',	3,	3	),
		(	 5,	5,	2,	'2016-11-23',	'Terapia 4',	'Diagnoza 4',	4,	9	),
		(	 6,	6,	6,	'2015-11-20',	'Terapia 1',	'Diagnoza 1',	5,	4	),
		(	 7,	7,	6,	'2016-11-30',	'Terapia 2',	'Diagnoza 2',	6,	3	),
		(	 8,	8,	6,	'2016-11-29',	'Terapia 4',	'Diagnoza 4',	7,	2	),
		(	 9,	9,	3,	'2016-12-05',	'Terapia 4',	'Diagnoza 4',	8,	1	),
		(	 3,	3,	2,	'2016-12-01',	'Terapia 1',	'Diagnoza 1',	9,	1	),
		(	10,	10,	1,	'2016-12-03',	'Terapia 2',	'Diagnoza 2',	10,	4	)
		
insert into Faturat_Pagesa ( Fid, Fbanka, Ftarifa )
values  (	 1,  'Raifaissen Bank', 	1.5 	),
		(	 2,  'BKT',					 1 		),
		(	 3,  'Banka Ekonomike',	 	 1		),
		(	 4,  'NLB Prishtina',	 	1.5		),
		(    5,  'TEB', 				1.5		)
             
             
insert into Faturat ( Fid, HPid, FcmimiPA, FTVSH, Fcmimitotal, Fbankar, Fdata, Fllojipageses )
values  ( 	 1,		1,	250,	18,	295,	1,	'2016-11-30', 	1	),
		(	 2,		2,	100,	20,	120,	1,	'2016-10-31',	1	),
		(	 3,		3,	100,	10,	110,	2,	'2016-12-05',	1	),
		(	 4,		4,	200,	10,	210,	2,	'2016-11-24',	1	),
		(	 5,		5,	250,	20,	305,	1,	'2016-11-25',	1	),
		(	 6,		6,	300,	20,	360,	1,	'2016-11-27',	1	),
		(	 7,		7,	100,	20,	120,	1,	'2016-12-05',	1	),
		(	 8,		8,	250,	18,	295,	1,	'2016-12-03',	1	),
		(	 9,		9,	250,	20,	305,	1,	'2016-12-22',	1	),
		( 	10,    10,	 20,	19,	280,	1,	'2016-12-04',	1	)






									-- Querit -- 
-- Query 1: 	Listoni te gjithe sensoret te cilet nuk jane ne perdorim nga pacientet                                    

select * from Sensoret 
where Sid not  in 
(
 select Sid from HospitalizimiPacienteve
)

-- Query 2:		Cilet paciente ( SSN-te dhe emrat e tyre ) kane paguar fatura ne vlere mbi 150 Euro?

select p.SSN,p.Pemri
 from Faturat f 
 inner join HospitalizimiPacienteve h
  on f.HPid=h.HPid 
  inner join Pacienti P on P.SSN=h.SSN
  where Fcmimitotal>150

-- Query 3:		Paraqitni te gjithe terminet qe jane caktuar per neser per Kirurgji

SELECT t.Tid FROM Terminet t
inner join Terminet_Reparti r on t.Tid=r.Rid
 WHERE t.dataterminit = date_add('2016-11-26',interval 1 day)

-- Query 4: 	Listoni ID-te e doktoreve (primar) te cilet dje kane pasur dy ose me shume hospitalizime te pacienteve ndersa sot nuk kane pasur asnje

select h.Did
from HospitalizimiPacienteve h,HospitalizimiPacienteve p
where h.HPdata=date_add('2016-11-24',interval -1 day)
and h.HPid<>p.HPid
and h.Did=p.Did
group by h.Did
having COUNT(*)>=2
and h.Did not in 
(select h.Did 
from HospitalizimiPacienteve h,HospitalizimiPacienteve p
where h.HPdata=date_add('2016-11-24',interval 0 day))


-- Query 5: 	Listoni top 5 doktoret me numer maksimal te hospitalizimeve te pacienteve ne 3 muajt e fundit.
-- 				Lista te paraqes te dhenat e doktorit duke perfshire edhe emrin e repartit ku punon dhe numrin e hospitalizimeve te pacienteve qe ka realizuar si doktor primar

select  d.Did as IdDoktorit, count(h.HPid) as NumriHospitalizimeve ,r.Remri as EmriRepartit
from HospitalizimiPacienteve h
 inner join Doktori d on d.Did=h.Did
 inner join Doktori_Reparti r  on d.DReparti=r.Rid
 where h.HPdata>=now() - interval 3 month
 group by d.Did,r.Remri
 order by NumriHospitalizimeve desc
 limit 5


-- Query 6: 	Per secilin repart paraqitni:

-- Query 6.1  	Numri i doktoreve qe punojne ne ate repart



-- Query 6.2 	Pagesa Mesatare

select  D.Dreparti as Reparti,r.Remri ,AVG(p.Prroga) as RrogaMesatare,COUNT(D.Did) as NumriDoktoreve
 from doktori d,doktori_paga p ,doktori_reparti r
where d.Did=p.Pid and r.Rid=d.Did
group by D.Dreparti;


-- Query 6.3 	Numri hospitalizimeve te pacienteve te realizuar kete vit

select r.Remri,count(*) as NumriHospitalizimeve
from HospitalizimiPacienteve h ,doktori_reparti r
where year(HPdata)=year('2016-01-01')and h.Did=r.Rid
group by r.Rid;


-- Query 6.4	Shumen e faturuar ( vleren pa TVSH dhe me TVSH) nga hospitalizimi i pacienteve te realizuar kete vit



-- Query 6.5	Shuma e pagesave te realizuara kete vit


