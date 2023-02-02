# ---------------------------------------------------------------
#               Filtering data by date and location
# ---------------------------------------------------------------

data_filtered=$(mktemp)
tmp=$(mktemp)

head -1 $OPTION_f > $data_filtered # First line of the file
tail +2 $OPTION_f > $tmp # File without the first line

if [ $location_FLAG -ne 0 ]; then
    if $d_FLAG; then
        printf "Filtering rows by date and location... "
        awk -F ';' -v start="${OPTION_d[0]}" -v end="${OPTION_d[1]}" '$2 >= start && $2 <= end' $tmp |
        awk -F ';' -v lat_min="$lat_min" -v lat_max="$lat_max" -v lon_min="$lon_min" -v lon_max="$lon_max" '{split($10, coords, ","); lat=coords[1]; lon=coords[2]; if (lat > lat_min && lat < lat_max && lon > lon_min && lon < lon_max) print $0}' >> $data_filtered
    else
        printf "Filtering rows by location... "
        awk -F ';' -v lat_min="$lat_min" -v lat_max="$lat_max" -v lon_min="$lon_min" -v lon_max="$lon_max" '{split($10, coords, ","); lat=coords[1]; lon=coords[2]; if (lat > lat_min && lat < lat_max && lon > lon_min && lon < lon_max) print $0}' $tmp >> $data_filtered
    fi
else
    if $d_FLAG; then
        printf "Filtering rows by date... "
        awk -F ';' -v start="${OPTION_d[0]}" -v end="${OPTION_d[1]}" '$2 >= start && $2 <= end' $tmp >> $data_filtered
    else
        printf "Filtering rows... "
        cat $tmp >> $data_filtered
    fi
fi

rm $tmp

if [[ $(wc -l $data_filtered | awk '{print $1}') -lt 2 ]]; then
    printf "\nERROR: No data found for these options\n"
    exit 1
fi

printf "Done\n\n"
