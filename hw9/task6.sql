SELECT
    left(project, commits) as project,
    right(address, contributors) as address
FROM
    repositories
