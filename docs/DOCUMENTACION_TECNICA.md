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
