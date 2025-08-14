/*
 Which skills are both high in demand and provide high average pay.
 Why? Find skills that grant both many job opportunities and high pay.
 */
WITH average_salary AS (
    SELECT skills_dim.skills AS skill_name,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS average_pay,
        COUNT(*) AS job_count
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_postings_fact.job_title_short = 'Data Analyst'
        AND job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skills
    HAVING COUNT(*) > 10
),
normalized AS (
    SELECT skill_name,
        job_count,
        average_pay,
        (job_count * 1.0 / MAX(job_count) OVER()) AS demand_score,
        (average_pay * 1.0 / MAX(average_pay) OVER()) AS pay_score
    FROM average_salary
)
SELECT skill_name,
    job_count,
    average_pay,
    ROUND((demand_score + pay_score) / 2, 3) AS skill_score
FROM normalized
ORDER BY skill_score DESC
LIMIT 20;