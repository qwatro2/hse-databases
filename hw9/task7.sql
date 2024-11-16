SELECT 
    project,
    commits,
    contributors,
    regexp_replace(address, '\d', '!', 'g') AS address
FROM 
    repositories
