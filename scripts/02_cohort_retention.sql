-- ==============================================================================
-- PROYECTO: RappiPlus - Análisis Integral de Negocio
-- SCRIPT 02: Matriz de Retención por Cohortes Mensuales
-- OBJETIVO: Evaluar la recurrencia de usuarios suscritos mes a mes (Mes 0 a Mes 5).
-- AUTOR: Edwin Contreras - Business Data Analyst
-- ==============================================================================

-- CTE 1: Asignar a cada usuario su Cohorte de Registro (Mes de Inicio)
WITH user_cohorts AS (
    SELECT 
        user_id,
        DATE_TRUNC('month', MIN(registration_date))::DATE AS cohort_month
    FROM 
        rappiplus_users
    GROUP BY 
        user_id
),

-- CTE 2: Mapear la actividad mensual de los usuarios
user_monthly_activity AS (
    SELECT DISTINCT
        u.user_id,
        u.cohort_month,
        DATE_TRUNC('month', a.activity_date)::DATE AS activity_month,
        -- Cálculo de la diferencia de meses entre actividad y cohorte
        (EXTRACT(YEAR FROM DATE_TRUNC('month', a.activity_date)) - EXTRACT(YEAR FROM u.cohort_month)) * 12 +
        (EXTRACT(MONTH FROM DATE_TRUNC('month', a.activity_date)) - EXTRACT(MONTH FROM u.cohort_month)) AS month_number
    FROM 
        user_cohorts u
    INNER JOIN 
        rappiplus_user_activity a ON u.user_id = a.user_id
    WHERE 
        a.activity_date >= u.cohort_month
),

-- CTE 3: Matriz de recuento de usuarios por cohorte y mes de vida
cohort_size AS (
    SELECT 
        cohort_month,
        COUNT(DISTINCT user_id) AS total_cohort_users
    FROM 
        user_cohorts
    GROUP BY 
        cohort_month
)

-- CONSULTA FINAL: Matriz de Retención Porcentual
SELECT 
    c.cohort_month,
    c.total_cohort_users AS cohort_size_m0,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN m.month_number = 1 THEN m.user_id END) / c.total_cohort_users, 2) AS m1_retention_pct,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN m.month_number = 2 THEN m.user_id END) / c.total_cohort_users, 2) AS m2_retention_pct,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN m.month_number = 3 THEN m.user_id END) / c.total_cohort_users, 2) AS m3_retention_pct,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN m.month_number = 4 THEN m.user_id END) / c.total_cohort_users, 2) AS m4_retention_pct,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN m.month_number = 5 THEN m.user_id END) / c.total_cohort_users, 2) AS m5_retention_pct
FROM 
    cohort_size c
LEFT JOIN 
    user_monthly_activity m ON c.cohort_month = m.cohort_month
GROUP BY 
    c.cohort_month, 
    c.total_cohort_users
ORDER BY 
    c.cohort_month ASC;
