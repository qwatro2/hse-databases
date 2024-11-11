create or replace procedure UPD_JOBSAL(
    p_job_id varchar(10),
    p_new_min_salary integer,
    p_new_max_salary integer
)
language plpgsql
as $$
    declare
    begin
        if (p_new_max_salary < p_new_min_salary) then
            raise exception 'Maximum salary should be greater or equal to minimum salary';
        end if;

        update jobs
        set min_salary = p_new_min_salary, max_salary = p_new_max_salary
        where job_id = p_job_id;

        exception
            when NO_DATA_FOUND then
                raise notice 'Invalid job_id';
            when sqlstate '55P03' then  -- ресурс заблокирован
                raise notice 'Row in table jobs locked';
    end;
$$;

call UPD_JOBSAL('SY_ANAL', 7000, 140);

alter table employees disable trigger all;
alter table jobs disable trigger all;

begin;
call UPD_JOBSAL('SY_ANAL', 7000, 14000);

select * from jobs;
commit;

alter table employees enable trigger all;
alter table jobs enable trigger all;
