"""
==============================================================================
PROYECTO: RappiPlus - Análisis Integral de Negocio
SCRIPT 01: Limpieza de Datos, Unit Economics y KPIs Comerciales
AUTOR: Edwin Contreras - Business Data Analyst
==============================================================================
"""

import pandas as pd
import numpy as np

def run_etl_and_unit_economics():
    print("🚀 [1/3] Cargando conjuntos de datos de RappiPlus...")
    
    # Generación/Carga de datos sintéticos representativos
    np.random.seed(42)
    n_orders = 10000
    
    orders = pd.DataFrame({
        'order_id': [f"ORD-{10000+i}" for i in range(n_orders)],
        'user_id': np.random.randint(1000, 5000, size=n_orders),
        'category': np.random.choice(['Restaurantes', 'Supermercado', 'Farmacia', 'Express'], size=n_orders, p=[0.45, 0.30, 0.15, 0.10]),
        'order_amount': np.random.normal(loc=25.0, scale=10.0, size=n_orders).round(2),
        'delivery_fee': np.random.choice([0.0, 2.5, 4.0], size=n_orders, p=[0.7, 0.2, 0.1]),
        'is_rappiplus': np.random.choice([1, 0], size=n_orders, p=[0.6, 0.4])
    })
    
    # Limpieza de anomalías (Valores negativos o nulos)
    orders['order_amount'] = np.where(orders['order_amount'] < 5.0, 5.0, orders['order_amount'])
    
    print("📊 [2/3] Calculando Unit Economics & KPIs principales...")
    
    # Métricas Globales
    total_revenue = orders['order_amount'].sum()
    total_orders = len(orders)
    aov = total_revenue / total_orders
    rappiplus_orders_pct = (orders['is_rappiplus'].sum() / total_orders) * 100
    
    print("\n--- RESUMEN EJECUTIVO DE KPIS ---")
    print(f"💰 Ingresos Totales (Revenue):  ${total_revenue:,.2f} USD")
    print(f"📦 Pedidos Totales Evaluados:  {total_orders:,}")
    print(f"💵 Ticket Promedio (AOV):        ${aov:.2f} USD")
    print(f"⭐ Penetracion RappiPlus:       {rappiplus_orders_pct:.2f}%")
    
    # Desglose por Categoría
    print("\n--- PERFORMANCE POR CATEGORÍA ---")
    category_kpis = orders.groupby('category').agg(
        pedidos=('order_id', 'count'),
        ingresos=('order_amount', 'sum'),
        aov=('order_amount', 'mean'),
        suscritos_pct=('is_rappiplus', lambda x: (x.sum() / len(x)) * 100)
    ).reset_index()
    
    print(category_kpis.to_string(index=False))
    
    # Exportar archivo limpio
    orders.to_csv('docs/assets/rappiplus_orders_cleaned.csv', index=False)
    print("\n✅ Dataset procesado guardado exitosamente en 'docs/assets/rappiplus_orders_cleaned.csv'")

if __name__ == "__main__":
    run_etl_and_unit_economics()
