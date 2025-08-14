/*
 Identifying the top paying data analyst jobs
 - Top 10 in Warsaw, or remotely.
 - Removing nulls, since we're interested in concrete salaries only
 - Why? Getting some guidance towards what might be a good path to take as an data analyst.
 */
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_location IN ('Warsaw, Poland', 'Anywhere')
    AND job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;