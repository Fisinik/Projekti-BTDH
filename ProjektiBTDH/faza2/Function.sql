delimiter //
create function CmimiTotal(FcmimiPA real, Ftvsh integer) 
returns real
begin 
declare cmimi real;
set cmimi=FcmimiPA+FcmimiPA*Ftvsh/100;
return cmimi;
end//
delimiter //

select CmimiTotal( 100, 2 )