library("Benchmarking");library("downloader");library("csv");library("ggplot2");

pathStart = '/home/pedro/Área de Trabalho/LabRedes'
setwd(pathStart);

data = read.csv("result.csv",header=TRUE) 
Names = as.character(data[["name"]]) 

FractalDim = data[["fractal_dimension"]]
TimeTakenForTests = data[["time_taken_for_tests"]]
TimePerRequest =  data[["time_for_request"]]
TransferRate = data[["transfer_rate"]]
Hurst = data[["hurst_parameter"]]
RequestsPerSecond = data[["request_for_second"]]

dataMatrix = cbind(FractalDim,TimeTakenForTests,TimePerRequest,TransferRate,Hurst,RequestsPerSecond) # creates the data matrix
rownames(dataMatrix) = Names

delete.na <- function(DF, n=0) { DF[rowSums(is.na(DF)) <= n,] }
data_dea = delete.na(dataMatrix)

inputs = data_dea[,c(1,6,2,3)]
outputs = data_dea[,c(4,5)]

CCR_I = dea(inputs,outputs,RTS="CRS",ORIENTATION="IN", SLACK=TRUE)

SCCR_I = sdea(inputs,outputs,RTS="CRS",ORIENTATION="IN")

CCR_O = dea(inputs,outputs,RTS="CRS",ORIENTATION="OUT", SLACK=TRUE)

bestDMU = which.max(SCCR_I$eff)
badDMU = which.min(SCCR_I$eff)

print("A DMU mais eficiente segundo o modelo DEA:")
print(bestDMU)
print("A DMU menos eficiente segundo o modelo DEA:")
print(badDMU)

# data.frame(SCCR_I$eff)
# dea.plot(inputs,outputs,RTS="crs",ORIENTATION="in");
# write.xlsx2(SCCR_I$eff, file='eficiencia.xlsx') #exporta os dados de eficiencia
