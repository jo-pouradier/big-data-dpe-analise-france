#/bin/bash

# Download the data from the source
url_part0="https://data.ademe.fr/data-fair/api/v1/datasets/dpe-"
url_part1=/data-files/dep_
url_part2=.csv.gz

file_name_all=dpe-all.csv
# empty the file
echo "" > ./data/$file_name_all

for i in {1..95}
do
    j=$i
    if [ $i -lt 10 ]
    then
        j=0$i
    fi
    url=$url_part0$j$url_part1$i$url_part2
    file_name="./data/dpe-$i.csv.gz"
    echo "Downloading $url"
    curl --progress-bar -s  -o $file_name $url
    echo "Downloaded $file_name"
    mv $file_name ./data/dpe-$i.csv.gz
    echo "Moved data of data/dpe-$i.csv.gz to data/dpe-all.csv"

    # Untar the file
    gunzip ./data/dpe-$i.csv.gz
    echo "Unzipped data/dpe-$i.csv"
    cat ./data/dpe-$i.csv >> ./data/dpe-all.csv

done

echo "Downloaded all data files"