#/bin/bash

output_file="./data_aggregated/dpe-all.csv"
header_written=false
echo "" > $output_file

for file in ./data/*.csv
do
    if [ "$file" != "$output_file" ]; then
        if [ "$header_written" = false ]; then
            head -n 1 "$file" >> $output_file
            header_written=true
        fi
        echo "Aggregating $file"
        tail -n +2 "$file" >> $output_file
    fi
done

echo "Tous les fichiers CSV ont été agrégés dans $output_file"
