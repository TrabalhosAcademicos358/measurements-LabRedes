strategies=("cubic" "bic" "westwood" "htcp" "hybla" "vegas" "nv" "scalable" "lp" "veno" "yeah" "illinois" "dctcp" "cdg" "bbr")
vrams=("1vram" "4vram")

for vram in ${vrams[@]}; do 
for strategy in ${strategies[@]}; do
    cd $vram/$strategy
    rm -Rf timeseries
    rm -Rf stats
    rm log.csv
    cd ../..
    done
done

rm medicoes.csv
