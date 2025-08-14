/*
 What are most in-demand skills for the data analyst position?
 Why? Provides insights into which skills are most commonly found for the data
 analyst position, giving a good idea which ones can potentially satisfy most
 job postings.
 */
SELECT skills_dim.skills AS skill_name,
    COUNT(*) AS job_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY skills_dim.skills
ORDER BY job_count DESC
LIMIT 10;