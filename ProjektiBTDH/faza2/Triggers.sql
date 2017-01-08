-- Krijimi i tabelave per ruajtjen e historise --

create table HistorikuHospitalizimeve (
					HPid integer, 
                    SSN integer, 
                    HPdata date,
					primary key (HPid),
                    foreign key (SSN) references pacienti(SSN) on delete cascade on update cascade,
                    foreign key (HPid) references HospitalizimiPacienteve(HPid)
                    )
                    
                    
create table HistorikuSensoreve (
						Sid integer,
                        Semri varchar(50) not null,
                        Sprodhuesi varchar(50) not null,
                        Slloji integer not null,
                        Sdata varchar(50) not null,
                        PRIMARY KEY (Sid),
                        FOREIGN KEY (Slloji) references Sensoret_Lloji(Sid) on delete cascade on update cascade,
                        FOREIGN KEY (Sid) references Sensoret(Sid)
					  )


-- Triggeri per historine e pacientave te spitalit --            
                      
delimiter //
create trigger HistorikuHospitalizimeve
after insert on hospitalizimipacienteve
for each row
begin 
insert into HistorikuHospitalizimeve(HPid, SSN, HPdata)
values (new.HPid,new.SSN,new.HPdata);
end//
delimiter ;


-- Triggeri per ruajtjen e historise se sensoreve te spitalit --

delimiter //
create trigger HistorikuSensoreve
before insert on hospitalizimipacienteve
for each row 
begin
insert into HistorikuSensoreve (SSN,Sid,HPdata)
values(new.SSN,new.Sid,new.HPdata);
end//
delimiter //;


