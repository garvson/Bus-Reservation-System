delimiter %%
create trigger tr_cancel before insert on reservations
for each row
begin

if(new.penaltyy is not null) then
set new.totalfare=((select b.BusFare from busfare b, busschedule bs where bs.SchedID=new.bus and bs.NetBusFare=b.Fareid)-
(select Amt from penalty where PenaltyID=new.penaltyy));
end if;
end %%
delimiter ;