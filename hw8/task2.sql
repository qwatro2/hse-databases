create or replace procedure ADD_JOB_HIST(
    p_employee_id integer,
    p_new_job_id varchar(10)
)
language plpgsql
as $$
    declare
        v_employee_department_id integer;
        v_start_date date;
        v_end_date date;
        v_job_min_salary integer;
    begin
        select e.department_id into v_employee_department_id from employees e where e.employee_id = p_employee_id;
        select e.hire_date into v_start_date from employees e where e.employee_id = p_employee_id;
        select current_date into v_end_date;
        select j.min_salary into v_job_min_salary from jobs j where job_id = p_new_job_id;

        insert into job_history values
        (p_employee_id, v_start_date, v_end_date, p_new_job_id, v_employee_department_id);

        update employees
        set hire_date = v_end_date, job_id = p_new_job_id, salary = v_job_min_salary + 500
        where employee_id = p_employee_id;

        exception
            when NOT_NULL_VIOLATION then
                raise notice 'Employee does not exist';
    end
$$;

alter table employees disable trigger all;
alter table jobs disable trigger all;
alter table job_history disable trigger all;

select * from employees;
select * from job_history;

call add_job_hist(106, 'SY_ANAL');

select * from employees;
select * from job_history;

alter table employees enable trigger all;
alter table jobs enable trigger all;
alter table job_history enable trigger all;
