csv() {
    local items=("$@")

    (
    IFS=,
    echo "${items[*]}"
    )
}

trata_csv() {
    sed -i 1d $1
    cat $1 | cut -d ',' -f2 > timeseries/$1_timeseries.txt
}

collect_sttats() {
    cat $1 | grep Requests\ per\ second > req_per_sec
    awk '{print $4}' req_per_sec > req_per_sec_$1
    rm req_per_sec
    cat $1 | grep concurrent\ request > time_per_req
    awk '{print $4}' time_per_req > time_per_req_$1
    rm time_per_req
    cat $1 | grep Transfer\ rate > transfer_rate
    awk '{print $3}' transfer_rate > transfer_rate_$1
    rm transfer_rate
    cat $1 | grep tests > time_taken
    awk '{print $5}' time_taken > time_taken_for_tests_$1
    rm time_taken
    
    req_per_sec=$(cat req_per_sec_$1) 
    time_per_req=$(cat time_per_req_$1)
    transfer_rate=$(cat transfer_rate_$1)
    time_taken_for_tests=$(cat time_taken_for_tests_$1)

    csv "$1" "$req_per_sec" "$time_per_req" "${transfer_rate}" "$time_taken_for_tests" >> log.csv

    mv req_per_sec_$1 stats
    mv time_per_req_$1 stats
    mv transfer_rate_$1 stats
    mv time_taken_for_tests_$1 stats
 
}

strategies=("cubic" "bic" "westwood" "htcp" "hybla" "vegas" "nv" "scalable" "lp" "veno" "yeah" "illinois" "dctcp" "cdg" "bbr")
vrams=("1vram" "4vram")

for vram in ${vrams[@]}; do 
    for strategy in ${strategies[@]}; do
        cd $vram/$strategy
        mkdir stats/
        mkdir timeseries

        echo "Vram atual $vram; Estrategia atual: $strategy"

        arquives_csv=$(find . -name "*.csv" -printf "%f\n")
        arquives_txt=$(find . -name "*.txt" -printf "%f\n")

        for arquive in $arquives_csv; do
            trata_csv $arquive
        done

        for arquive in $arquives_txt; do
            collect_sttats $arquive
        done

        cd ../..
    done
done

for vram in ${vrams[@]}; do 
    for strategy in ${strategies[@]}; do
        cd $vram/$strategy
        (cat log.csv) >> ../../medicoes.csv
        cd ../..
    done
done

echo "Arquivo contendo todas medições criado"
