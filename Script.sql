--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tabela Completa utilizada no PowerBI
WITH project_status AS (		
    SELECT 
        project_id,
        project_name,
        project_budget,
        'upcoming' AS status
    FROM upcoming_projects 

    UNION ALL 

    SELECT 
        project_id,
        project_name,
        project_budget,
        'completed' AS status
    FROM completed_projects
)
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.job_title,
    e.salary,
    d."Department_Name" ,
    d."Department_Budget",
    d."Department_Goals",
    pa.project_id,
    p.project_name,
    p.project_budget,
    p.status
FROM employees e
INNER JOIN departments d ON e.department_id = d."Department_ID" 
INNER JOIN project_assignments pa ON pa.employee_id = e.employee_id
INNER JOIN project_status p on p.project_id = pa.project_id

-- Foi necessário usar aspas nas colunas de Department, pois elas foram declaradas/inicializadas como Maiúsculas...
-- Como o PostgreSQL é 'case sensitive', foi necessário colocar as Aspas para evitar erro de leitura.
-- Poderíamos, também, rodar um ALTER TABLE para modificar e seguir o padrão minúsculo.

/* Poderia fazer isso para evitar o problema do 'case sensitive':
ALTER TABLE departments 
RENAME COLUMN "Department_ID" TO department_id;
*/

-- Lembrando, UNION e UNION ALL são para combinacão vertical, quando há tabelas em comum (mesmas quantidades e tipos de tabelas)

-- JOINs são para combinacão horizontal, baseados numa Chave Estrangeira... (Quando há relacionamento entre elas)