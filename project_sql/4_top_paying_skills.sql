/*
 What are the skills with the highest average pay for data analyst jobs?
 Why? Unlike the previous query this one potentially reveals the skills
 with the highest pay turnout, rather than job opportunities.
 */
SELECT skills_dim.skills AS skill_name,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS average_pay,
    COUNT(*) AS job_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY skills_dim.skills
HAVING COUNT(*) > 10 -- getting rid of outliers
ORDER BY average_pay DESC
LIMIT 25;
/*
 Specialized skills pay more — niche tools like Kafka, PyTorch, and Perl lead salaries, often in roles with fewer openings.
 Big data & ML stay hot — Spark, Snowflake, Databricks, TensorFlow dominate demand and offer strong mid-to-high pay.
 Mix niche + core skills — pairing rare expertise with foundational tools (Linux, Git, SQL) boosts both pay and job options.
 
 "skill_name","average_pay","job_count"
 "kafka","129999","40"
 "pytorch","125226","20"
 "perl","124686","20"
 "tensorflow","120647","24"
 "cassandra","118407","11"
 "atlassian","117966","15"
 "airflow","116387","71"
 "scala","115480","59"
 "linux","114883","58"
 "confluence","114153","62"
 "pyspark","114058","49"
 "mongodb","113608","52"
 "gcp","113065","78"
 "spark","113002","187"
 "splunk","112928","15"
 "databricks","112881","102"
 "git","112250","74"
 "snowflake","111578","241"
 "shell","111496","44"
 "unix","111123","37"
 "hadoop","110888","140"
 "pandas","110767","90"
 "phoenix","109259","23"
 "php","109052","29"
 "neo4j","108646","12"
 
 */