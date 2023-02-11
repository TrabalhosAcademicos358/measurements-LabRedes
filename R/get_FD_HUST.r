library(fractaldim);
library(pracma);

pathStart = '/home/pedro/Área de Trabalho/LabRedes/project/1vram/bbr/timeseries'

setwd(pathStart) # Define o diretorio das suas timeseries, defina o dirtorio correto na variavel pathStart
files = list.files(path=pathStart, pattern='timeseries')

for(x in 1:6){
    message("Hurst para o arquivo: ", files[x])
    readed = scan(files[x])
    b = hurstexp(readed, display=FALSE)
    print(b[["Hs"]])
    message("Dimensão Fractal para o arquivo: ", files[x])
    fractal = fd.estimate(readed, methods='madogram')
    print(fractal[["fd"]][1])
}
