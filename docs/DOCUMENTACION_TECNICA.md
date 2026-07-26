# 📄 Documentación Técnica: RappiPlus Analytics

## 1. Métricas Formulación Formal

### Unit Economics
* **Revenue Bruto:** $Revenue = \sum (Monto\_Pedido_i)$
* **Ticket Promedio (AOV):** $AOV = \frac{Revenue}{Total\_Pedidos}$
* **Tasa de Penetración Suscritos:** $Penetration = \frac{Pedidos\_RappiPlus}{Total\_Pedidos} \times 100$

## Embudo de Conversión (Funnel)
* **Tasa de Abandono en Checkout (Drop-Off):**
$$DropOff_{Checkout} = \frac{Usuarios_{Checkout} - Usuarios_{Purchase}}{Usuarios_{Checkout}} \times 100$$

### Experimentación Estadistica (A/B Test)
* **Hipótesis Nula ($H_0$):** $p_B - p_A = 0$ (La nueva UI no altera la tasa de conversión)
* **Hipótesis Alternativa ($H_1$):** $p_B - p_A \neq 0$ (Existe diferencia significativa)
* **Z-Test de Proporciones:**
$$Z = \frac{\hat{p}_B - \hat{p}_A}{\sqrt{\hat{p}(1-\hat{p})\left(\frac{1}{n_B} + \frac{1}{n_A}\right)}}$$
Donde $\hat{p}$ es la proporción combinada. Nivel de significancia fijado en $\alpha = 0.05$.
  

## 🛵 Análisis Integral de Negocio, Funnels y Pruebas A/B - RappiPlus

![SQL]
![Python](https://img.shields.io/badge/Python-3.10+-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-Dashboard-F2C94C?style=for-the-badge&logo=powerbi&logoColor=black)
![A/B Testing](https://img.shields.io/badge/Experimentation-A/B_Test-green?style=for-the-badge)

> ### 🎓 Contexto del Proyecto
> Caso de estudio integrador (*Capstone*) desarrollado dentro del programa de Analítica de Datos de **TripleTen**, enfocado en la plataforma de suscripción **RappiPlus**. Todos los datos y métricas han sido procesados a partir de conjuntos sintéticos con fines educativos y de portafolio.

---

## 🎯 Objetivo General
Evaluar el desempeño comercial, el embudo de conversión y la efectividad del rediseño del flujo de pago en el servicio de suscripción **RappiPlus** mediante un enfoque *end-to-end*:

1. **ETL & Unit Economics (Python):** Limpieza de datasets y cálculo de AOV, Revenue y penetración por categoría.
2. **Funnel de Conversión (SQL):** Identificación del cuello de botella (*drop-off*) en el checkout usando CTEs.
3. **Análisis de Cohortes (SQL):** Construcción de matrices de retención mensual (Mes 0 a Mes 5).
4. **Pruebas A/B (Python):** Evaluación de significancia estadística ($\alpha = 0.05$) del nuevo flujo de compra.
5. **Business Intelligence (Power BI):** Dashboard ejecutivo interactivo para monitoreo continuo.

---

## 📊 Principales Hallazgos (Insights)

* **Rentabilidad por Categoría:** *Restaurantes* y *Supermercado* representan el **75% del volumen de órdenes**, con un ticket promedio (AOV) de **$25.00 USD**.
* **Cuello de Botella en Checkout:** El análisis en SQL reveló una fuga del **28.4% de usuarios** en el paso previo a la confirmación de pago.
* **Resultado del Experimento A/B:** La variante de checkout B incrementó la conversión en un **+10.65% relativo** ($p\text{-value} = 0.0018 < 0.05$), validando su despliegue total.

---

## 📂 Estructura del Repositorio

```text
analisis-integral-rappiplus/
├── README.md                           <-- Ficha técnica y resumen
├── scripts/                            <-- Consultas SQL
│   ├── 01_conversion_funnel.sql        <-- Análisis de Embudo
│   └── 02_cohort_retention.sql         <-- Matriz de Retención
├── notebooks/                          <-- Código en Python
│   ├── 01_data_cleaning_and_kpis.py    <-- ETL & Unit Economics
│   └── 02_ab_testing_evaluation.py     <-- Evaluación A/B Test (SciPy)
└── docs/                               <-- Documentación y capturas
    ├── DOCUMENTACION_TECNICA.md        <-- Formulación matemática
    └── assets/                         <-- Datasets y gráficos

##🛠️ Stack Tecnológico

SQL: CTEs, Subconsultas, Window Functions, DATE_TRUNC.

Python: Pandas, NumPy, SciPy (Proportion Z-Test), Statsmodels.

Visualización: Power BI / Matplotlib.

Documentación: Markdown & TeX/LaTeX.
