import pandas as pd
import pyDEA

# Lendo o arquivo CSV com os dados
data = pd.read_csv("result.csv")

# Selecionando as colunas relevantes
inputs = data[["Nome", "Dimensão Fractal", "Req. Por Segundo", "Tempo levado para testes", "Tempo por Req."]]
outputs = data[["Taxa de Transferencia", "Parâmetro de Hurst"]]

# Executando o modelo DEA input-oriented CCR
model = pyDEA.CCRModel(inputs, outputs, orientation="input")
model.solve()

# Encontrando a DMU mais eficiente e a menos eficiente
best_dmu = model.efficiency_scores.idxmax()
worst_dmu = model.efficiency_scores.idxmin()

print("A DMU mais eficiente segundo o modelo DEA:")
print(best_dmu)
print("A DMU menos eficiente segundo o modelo DEA:")
print(worst_dmu)
