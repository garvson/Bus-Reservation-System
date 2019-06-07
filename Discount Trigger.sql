delimiter %%
create trigger tr before insert on reservations
for each row
begin

if(new.discount is not null) then
set new.totalfare=((select b.BusFare from busfare b, busschedule bs where bs.SchedID=new.bus and bs.NetBusFare=b.Fareid)-
(select amount from discounts where Discountid=new.discount));
end if;
end %%
delimiter ;