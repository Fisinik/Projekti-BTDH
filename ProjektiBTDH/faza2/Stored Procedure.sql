use MonitorimiPacienteveDB


-- Procedura 1  ( regjistrimi i pacienteve )  --

delimiter //
create procedure RegjistrimiPacientave(i_SSN integer ,i_Pemri varchar(50),i_Pmbiemri varchar(50), i_Pprindi varchar(50), i_Pgjinia varchar(1), i_Pdatelindja varchar(50), i_rruga varchar(50), i_qyteti varchar(50), i_shteti varchar(50), i_kodipostal integer, i_mob integer, i_fix integer, i_email varchar(50), i_Pgrgjakut varchar(2), i_ALemri varchar(50), i_ALsimptomat varchar(50))
begin 
insert into pacienti( SSN, Pemri, Pmbiemri, Pprindi, Pgjinia, Pdatelindja, Pgrgjakut )
values ( i_SSN, i_Pemri, i_Pmbiemri, i_Pprindi, i_Pgjinia, i_Pdatelindja, i_Pgrgjakut );

insert into pacienti_adresa(Aid, Arruga, Aqyteti, Ashteti, Akodipostal )
values ( i_SSN, i_rruga, i_qyteti, i_shteti, i_kodipostal );

insert into pacienti_alergjite(ALid, ALemri, ALsimptomat)
values ( i_SSN, i_ALemri, i_ALsimptomat);
end //
delimiter //

call RegjistrimiPacientave(11, 'Fisnik', 'Spahija', 'Avdyl', 'M', '15/09/1997', 'Londra', 'Gjakove', 'Kosove', 50000, 045447100, 0390455512, 'fisnik.spahijaa@gmail.com', 'A', 'Test', 'Test')

delete from Pacienti_adresa
where Aid = 11

select * from Pacienti

select * from Pacienti_alergjite


-- Procedura 2 ( editimi i sensoreve ) --

delimiter //
create procedure EditoSensoret(i_Sid int ,i_Semri varchar(50),i_Sprodhuesi varchar(50),i_Slloji int, i_Sdata date)
begin
update sensoret 
set
Semri=i_Semri,
Sprodhuesi=i_Sprodhuesi,
Slloji=i_Slloji,
Sdata=i_Sdata
where  Sid=i_Sid;
end //
delimiter //;


call EditoSensoret ( 1, 'Sensori. 1', 'Lenovo', 1, '2017-04-01' )

select * from Sensoret 


-- Procedura 3 ( regjistrimi i reparteve te reja ) --

delimiter //
create procedure RegjistrimiRepartit(i_Rid integer ,i_Remri varchar(50))
begin 
insert  into doktori_reparti(Rid ,Remri) 
values (i_Rid,i_Remri);
end //
delimiter //

call RegjistrimiRepartit ( 8, 'Test' )

select * from doktori_reparti