/*
 Finding the skills required for top-paying data analyst jobs.
 - Use query for top-paying job postings from previous file
 - Adding the skills required to them
 Why? To understand which skills tend to trend at highest salaried jobs.
 */
WITH top_paying_jobs AS (
    SELECT job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_location IN ('Warsaw, Poland', 'Anywhere')
        AND job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT top_paying_jobs.*,
    skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY salary_year_avg DESC
/*
Key findings

SQL is universal — appears in 100% of the jobs.
Python is the next most common — in 87.5% of the jobs.
Tableau appears in 75% of jobs; R in 50%.
Top skill pair is Python + SQL (present in 7 of 8 jobs → 87.5%).
Cloud / big-data tools (Snowflake, AWS, Azure, Databricks, PySpark) appear across listings — Databricks / PySpark / Jupyter are concentrated in the single highest-paid role.
*/