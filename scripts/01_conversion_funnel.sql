-- ==============================================================================
-- PROYECTO: RappiPlus - Análisis Integral de Negocio
-- SCRIPT 01: Análisis de Embudo de Conversión (Funnel Analysis)
-- OBJETIVO: Cuantificar usuarios y porcentaje de abandono (drop-off) por etapa.
-- AUTOR: Edwin Contreras - Business Data Analyst
-- ==============================================================================

-- CTE 1: Identificación de eventos únicos por usuario y etapa del funnel
WITH user_funnel_stages AS (
    SELECT 
        user_id,
        category,
        MAX(CASE WHEN event_type = 'home_view' THEN 1 ELSE 0 END) AS stage_1_home,
        MAX(CASE WHEN event_type = 'search_item' THEN 1 ELSE 0 END) AS stage_2_search,
        MAX(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS stage_3_cart,
        MAX(CASE WHEN event_type = 'checkout_start' THEN 1 ELSE 0 END) AS stage_4_checkout,
        MAX(CASE WHEN event_type = 'purchase_success' THEN 1 ELSE 0 END) AS stage_5_purchase
    FROM 
        rappiplus_events
    WHERE 
        event_date BETWEEN '2026-01-01' AND '2026-06-30'
    GROUP BY 
        user_id, 
        category
),

-- CTE 2: Consolidación de métricas de usuarios absolutos por etapa
funnel_counts AS (
    SELECT 
        category,
        COUNT(DISTINCT CASE WHEN stage_1_home = 1 THEN user_id END) AS users_home,
        COUNT(DISTINCT CASE WHEN stage_2_search = 1 THEN user_id END) AS users_search,
        COUNT(DISTINCT CASE WHEN stage_3_cart = 1 THEN user_id END) AS users_cart,
        COUNT(DISTINCT CASE WHEN stage_4_checkout = 1 THEN user_id END) AS users_checkout,
        COUNT(DISTINCT CASE WHEN stage_5_purchase = 1 THEN user_id END) AS users_purchase
    FROM 
        user_funnel_stages
    GROUP BY 
        category
)

-- CONSULTA FINAL: Cálculo de Conversion Rates y Drop-Off Rates
SELECT 
    category,
    users_home,
    users_search,
    ROUND(100.0 * users_search / NULLIF(users_home, 0), 2) AS conv_home_to_search_pct,
    
    users_cart,
    ROUND(100.0 * users_cart / NULLIF(users_search, 0), 2) AS conv_search_to_cart_pct,
    
    users_checkout,
    ROUND(100.0 * users_checkout / NULLIF(users_cart, 0), 2) AS conv_cart_to_checkout_pct,
    
    users_purchase,
    ROUND(100.0 * users_purchase / NULLIF(users_checkout, 0), 2) AS conv_checkout_to_purchase_pct,
    
    -- Conversión Global (Home -> Purchase)
    ROUND(100.0 * users_purchase / NULLIF(users_home, 0), 2) AS total_conversion_rate_pct,
    
    -- Abandono Crítico en Checkout
    ROUND(100.0 * (users_checkout - users_purchase) / NULLIF(users_checkout, 0), 2) AS checkout_dropoff_rate_pct
FROM 
    funnel_counts
ORDER BY 
    users_home DESC;
