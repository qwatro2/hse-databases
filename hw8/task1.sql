create procedure NEW_JOB(
    p_job_id varchar(10), 
    p_job_title varchar(35), 
    p_min_salary integer
)
language sql
as $$
insert into jobs values (p_job_id, p_job_title, p_min_salary, 2 * p_min_salary);
$$;

call NEW_JOB('SY_ANAL', 'System Analyst', 6000);
