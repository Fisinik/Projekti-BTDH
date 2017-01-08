create view pacientiView as 
select SSN, Pemri, Pmbiemri
from pacienti

select * from pacientiView

create view DoktoriView as
select Did, Demri, Dmbiemri
from doktori

select * from doktoriview