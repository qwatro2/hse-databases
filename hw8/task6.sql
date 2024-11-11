create or replace function CHECK_SAL_RANGE() returns trigger
language plpgsql
as $$
   declare
   begin
       if ((select count(*) from employees e where e.job_id = new.job_id
                                               and (e.salary < new.min_salary
                                                        or e.salary > new.max_salary)) > 0) then
           return null;
       end if;
       return new;
   end;
$$;

create trigger check_sal_range before update on jobs
    for each row execute procedure CHECK_SAL_RANGE();

select min_salary, max_salary from jobs where job_id = 'SY_ANAL';
select employee_id, last_name, salary from employees where job_id = 'SY_ANAL';

update jobs
set min_salary = 5000, max_salary = 7000
where job_id = 'SY_ANAL';

select min_salary, max_salary from jobs where job_id = 'SY_ANAL';

update jobs
set min_salary = 7000, max_salary = 18000
where job_id = 'SY_ANAL';

select min_salary, max_salary from jobs where job_id = 'SY_ANAL';
-- видим, что вилка не изменилась, т.к. есть сотрудник Pataballa с зарплатой 6500, т.е. вне новой вилки
-- сработал наш триггер и изменения не произошли
