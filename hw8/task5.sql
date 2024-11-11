create or replace function GET_JOB_COUNT(
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

        select count(*) into v_result
        from job_history
        where employee_id = p_employee_id;

        return v_result;
    end;
$$;

select GET_JOB_COUNT(176);
