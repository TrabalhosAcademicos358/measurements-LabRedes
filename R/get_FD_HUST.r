library(fractaldim);
library(pracma);
pathStart = '/home/klinsman/Desktop/medições_klinsman/1VRAM/apache2/cubic'
setwd(pathStart)
files = list.files(path=pathStart, pattern='timeseries')

for(x in 1:3){
    message("Hurst para o arquivo: ", files[x])
    readed = scan(files[x])
    b = hurstexp(readed, display=FALSE)
    print(b[["Hs"]])
    message("Dimensão Fractal para o arquivo: ", files[x])
    fractal = fd.estimate(readed, methods='madogram')
    print(fractal[["fd"]][1])
}
