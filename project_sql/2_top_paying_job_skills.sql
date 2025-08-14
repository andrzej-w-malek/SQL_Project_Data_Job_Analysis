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

"job_id","job_title","salary_year_avg","company_name","skills"
552322,"Associate Director- Data Insights","255829.5","AT&T","sql"
552322,"Associate Director- Data Insights","255829.5","AT&T","python"
552322,"Associate Director- Data Insights","255829.5","AT&T","r"
552322,"Associate Director- Data Insights","255829.5","AT&T","azure"
552322,"Associate Director- Data Insights","255829.5","AT&T","databricks"
552322,"Associate Director- Data Insights","255829.5","AT&T","aws"
552322,"Associate Director- Data Insights","255829.5","AT&T","pandas"
552322,"Associate Director- Data Insights","255829.5","AT&T","pyspark"
552322,"Associate Director- Data Insights","255829.5","AT&T","jupyter"
552322,"Associate Director- Data Insights","255829.5","AT&T","excel"
552322,"Associate Director- Data Insights","255829.5","AT&T","tableau"
552322,"Associate Director- Data Insights","255829.5","AT&T","power bi"
552322,"Associate Director- Data Insights","255829.5","AT&T","powerpoint"
99305,"Data Analyst, Marketing","232423.0","Pinterest Job Advertisements","sql"
99305,"Data Analyst, Marketing","232423.0","Pinterest Job Advertisements","python"
99305,"Data Analyst, Marketing","232423.0","Pinterest Job Advertisements","r"
99305,"Data Analyst, Marketing","232423.0","Pinterest Job Advertisements","hadoop"
99305,"Data Analyst, Marketing","232423.0","Pinterest Job Advertisements","tableau"
1021647,"Data Analyst (Hybrid/Remote)","217000.0","Uclahealthcareers","sql"
1021647,"Data Analyst (Hybrid/Remote)","217000.0","Uclahealthcareers","crystal"
1021647,"Data Analyst (Hybrid/Remote)","217000.0","Uclahealthcareers","oracle"
1021647,"Data Analyst (Hybrid/Remote)","217000.0","Uclahealthcareers","tableau"
1021647,"Data Analyst (Hybrid/Remote)","217000.0","Uclahealthcareers","flow"
168310,"Principal Data Analyst (Remote)","205000.0","SmartAsset","sql"
168310,"Principal Data Analyst (Remote)","205000.0","SmartAsset","python"
168310,"Principal Data Analyst (Remote)","205000.0","SmartAsset","go"
168310,"Principal Data Analyst (Remote)","205000.0","SmartAsset","snowflake"
168310,"Principal Data Analyst (Remote)","205000.0","SmartAsset","pandas"
168310,"Principal Data Analyst (Remote)","205000.0","SmartAsset","numpy"
168310,"Principal Data Analyst (Remote)","205000.0","SmartAsset","excel"
168310,"Principal Data Analyst (Remote)","205000.0","SmartAsset","tableau"
168310,"Principal Data Analyst (Remote)","205000.0","SmartAsset","gitlab"
731368,"Director, Data Analyst - HYBRID","189309.0","Inclusively","sql"
731368,"Director, Data Analyst - HYBRID","189309.0","Inclusively","python"
731368,"Director, Data Analyst - HYBRID","189309.0","Inclusively","azure"
731368,"Director, Data Analyst - HYBRID","189309.0","Inclusively","aws"
731368,"Director, Data Analyst - HYBRID","189309.0","Inclusively","oracle"
731368,"Director, Data Analyst - HYBRID","189309.0","Inclusively","snowflake"
731368,"Director, Data Analyst - HYBRID","189309.0","Inclusively","tableau"
731368,"Director, Data Analyst - HYBRID","189309.0","Inclusively","power bi"
731368,"Director, Data Analyst - HYBRID","189309.0","Inclusively","sap"
731368,"Director, Data Analyst - HYBRID","189309.0","Inclusively","jenkins"
731368,"Director, Data Analyst - HYBRID","189309.0","Inclusively","bitbucket"
731368,"Director, Data Analyst - HYBRID","189309.0","Inclusively","atlassian"
731368,"Director, Data Analyst - HYBRID","189309.0","Inclusively","jira"
731368,"Director, Data Analyst - HYBRID","189309.0","Inclusively","confluence"
310660,"Principal Data Analyst, AV Performance Analysis","189000.0","Motional","sql"
310660,"Principal Data Analyst, AV Performance Analysis","189000.0","Motional","python"
310660,"Principal Data Analyst, AV Performance Analysis","189000.0","Motional","r"
310660,"Principal Data Analyst, AV Performance Analysis","189000.0","Motional","git"
310660,"Principal Data Analyst, AV Performance Analysis","189000.0","Motional","bitbucket"
310660,"Principal Data Analyst, AV Performance Analysis","189000.0","Motional","atlassian"
310660,"Principal Data Analyst, AV Performance Analysis","189000.0","Motional","jira"
310660,"Principal Data Analyst, AV Performance Analysis","189000.0","Motional","confluence"
1749593,"Principal Data Analyst","186000.0","SmartAsset","sql"
1749593,"Principal Data Analyst","186000.0","SmartAsset","python"
1749593,"Principal Data Analyst","186000.0","SmartAsset","go"
1749593,"Principal Data Analyst","186000.0","SmartAsset","snowflake"
1749593,"Principal Data Analyst","186000.0","SmartAsset","pandas"
1749593,"Principal Data Analyst","186000.0","SmartAsset","numpy"
1749593,"Principal Data Analyst","186000.0","SmartAsset","excel"
1749593,"Principal Data Analyst","186000.0","SmartAsset","tableau"
1749593,"Principal Data Analyst","186000.0","SmartAsset","gitlab"
387860,"ERM Data Analyst","184000.0","Get It Recruit - Information Technology","sql"
387860,"ERM Data Analyst","184000.0","Get It Recruit - Information Technology","python"
387860,"ERM Data Analyst","184000.0","Get It Recruit - Information Technology","r"
*/