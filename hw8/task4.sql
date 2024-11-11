create or replace function GET_YEARS_SERVICE(
    p_employee_id integer
) returns integer
language plpgsql
as $$
    declare
        v_result integer;
    begin
        if ((select count(*) from job_history where employee_id = p_employee_id) = 0) then
            raise notice 'Invalid employee_id';
            return null;
        end if;

        select sum(jh.end_date - jh.start_date) / 365 into v_result
        from job_history jh
        where jh.employee_id = p_employee_id;

        return v_result;
    end;
$$;

select GET_YEARS_SERVICE(999);  -- DBMS_OUTPUT.PUT_LINE не получается :(

select GET_YEARS_SERVICE(106);

select * from employees where employee_id = 106;
select * from job_history where employee_id = 106;
