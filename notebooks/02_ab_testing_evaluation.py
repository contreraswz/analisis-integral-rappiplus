"""
==============================================================================
PROYECTO: RappiPlus - Análisis Integral de Negocio
SCRIPT 02: Evaluación Estadística de Experimento A/B (Checkout UI)
AUTOR: Edwin Contreras - Business Data Analyst
==============================================================================
"""

import numpy as np
import pandas as pd
from scipy import stats
from statsmodels.stats.proportion import proportions_ztest

def evaluate_ab_test():
    print("🧪 Evaluando Experimento A/B: Rediseño del Checkout RappiPlus\n")
    
    # Parámetros del Experimento
    alpha = 0.05
    
    # Datos del experimento (Grupo Control A vs Grupo Prueba B)
    n_control = 12500
    success_control = 1525  # Conversión ~12.2%
    
    n_test = 12800
    success_test = 1728     # Conversión ~13.5%
    
    conv_control = success_control / n_control
    conv_test = success_test / n_test
    lift = ((conv_test - conv_control) / conv_control) * 100
    
    print(f"Grupo A (Control): {success_control}/{n_control} convertidos ({conv_control:.4%})")
    print(f"Grupo B (Prueba):  {success_test}/{n_test} convertidos ({conv_test:.4%})")
    print(f"Lift Observado:    +{lift:.2f}%\n")
    
    # Z-Test de Proporciones
    count = np.array([success_test, success_control])
    nobs = np.array([n_test, n_control])
    
    z_stat, p_value = proportions_ztest(count, nobs, alternative='two-sided')
    
    print("--- RESULTADOS DE LA PRUEBA ESTADÍSTICA ---")
    print(f"Z-Statistic: {z_stat:.4f}")
    print(f"P-Value:     {p_value:.6f}")
    print(f"Nivel Alpha: {alpha}")
    
    if p_value < alpha:
        print("\n✅ CONCLUSIÓN: Rechazamos la Hipótesis Nula (H0).")
        print("El nuevo flujo de checkout muestra un incremento ESTADÍSTICAMENTE SIGNIFICATIVO en la conversión.")
        print("🚀 Recomendación: Desplegar la variante B al 100% de los usuarios.")
    else:
        print("\n❌ CONCLUSIÓN: No se puede rechazar la Hipótesis Nula (H0).")
        print("La diferencia observada no es estadísticamente significativa.")

if __name__ == "__main__":
    evaluate_ab_test()
