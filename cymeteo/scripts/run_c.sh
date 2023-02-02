# ---------------------------------------------------------------
#       Sorting the data according to the chosen option(s)
# ---------------------------------------------------------------

make > /dev/null
mkdir -p data graph

if $t1_FLAG || $p1_FLAG || $t4_FLAG || $p4_FLAG || $w_FLAG; then
    data_sort_station=$(mktemp)

    # Sorted in ascending order by station ID
    printf "Sorting in ascending order by station ID... "
    ./cymeteo/bin/sort -f $data_filtered -o $data_sort_station -c ID $sort_type > /dev/null
    check_errors $?
    #cat $data_sort_station > data/data_sort_station.csv
    printf "Done\n\n"

    if $t1_FLAG; then
        printf "    Command -t1\n"
        data_t1=$(mktemp)

        # Selects the necessary columns
        printf "        Filtering columns... "
        cut -d';' -f1,11 $data_sort_station > $data_t1
        #cat $data_t1 > data/data_t1.csv
        printf "Done\n"

        # Create a restructured file
        printf "        Restructuring spreadsheet... "
        ./cymeteo/bin/edit -f $data_t1 -o data/t1.dat -t1 > /dev/null
        check_errors $?
        rm $data_t1
        printf "Done\n"

        # Create an error bar graph
        printf "        Creating the graphic... "
        gnuplot -c ./cymeteo/gnu/error_bar.gnu "Temperature" "°C" data/t1.dat graph/t1.png "${locations[$location_FLAG]}" ${OPTION_d[0]} ${OPTION_d[1]} 2> /dev/null
        printf "Done\n\n"
    fi

    if $p1_FLAG; then
        printf "    Command -p1\n"
        data_p1=$(mktemp)

        # Selects the necessary columns
        printf "        Filtering columns... "
        cut -d';' -f1,7 $data_sort_station > $data_p1
        #cat $data_p1 > data/data_p1.csv
        printf "Done\n"

        # Create a restructured file
        printf "        Restructuring spreadsheet... "
        ./cymeteo/bin/edit -f $data_p1 -o data/p1.dat -p1 > /dev/null
        check_errors $?
        rm $data_p1
        printf "Done\n"

        # Create an error bar graph
        printf "        Creating the graphic... "
        gnuplot -c ./cymeteo/gnu/error_bar.gnu "Pressure" "Pa" data/p1.dat graph/p1.png "${locations[$location_FLAG]}" ${OPTION_d[0]} ${OPTION_d[1]} 2> /dev/null
        printf "Done\n\n"
    fi

    if $t4_FLAG; then
        printf "    Command -t4\n"
        data_t4=$(mktemp)

        # Selects the necessary columns
        printf "        Filtering columns... "
        cut -d';' -f1,11 $data_sort_station > $data_t4
        #cat $data_t4 > data/data_t4.csv
        printf "Done\n"

        # Create a restructured file
        printf "        Restructuring spreadsheet... "
        ./cymeteo/bin/edit -f $data_t4 -o data/t4.dat -t4 > /dev/null
        check_errors $?
        rm $data_t4
        printf "Done\n"

        # Create an error bar graph
        printf "        Creating the graphic... "
        gnuplot -c ./cymeteo/gnu/filledcurve.gnu "Temperature" "°C" data/t4.dat graph/t4.png "${locations[$location_FLAG]}" ${OPTION_d[0]} ${OPTION_d[1]} 2> /dev/null
        printf "Done\n\n"
    fi

    if $p4_FLAG; then
        printf "    Command -p4\n"
        data_p4=$(mktemp)

        # Selects the necessary columns
        printf "        Filtering columns... "
        cut -d';' -f1,7 $data_sort_station > $data_p4
        #cat $data_p4 > data/data_p4.csv
        printf "Done\n"

        # Create a restructured file
        printf "        Restructuring spreadsheet... "
        ./cymeteo/bin/edit -f $data_p4 -o data/p4.dat -p4 > /dev/null
        check_errors $?
        rm $data_p4
        printf "Done\n"

        # Create an error bar graph
        printf "        Creating the graphic... "
        gnuplot -c ./cymeteo/gnu/filledcurve.gnu "Pressure" "Pa" data/p4.dat graph/p4.png "${locations[$location_FLAG]}" ${OPTION_d[0]} ${OPTION_d[1]} 2> /dev/null
        printf "Done\n\n"
    fi

    if $w_FLAG; then
        printf "    Command -w\n"
        data_w=$(mktemp)

        # Selects the necessary columns
        printf "        Filtering columns... "
        cut -d';' -f1,4,5,10 $data_sort_station > $data_w
        #cat $data_w > data/data_w.csv
        printf "Done\n"

        # Create a restructured file
        printf "        Restructuring spreadsheet... "
        ./cymeteo/bin/edit -f $data_w -o data/w.dat -w > /dev/null
        check_errors $?
        rm $data_w
        printf "Done\n"

        # Create a vector map
        printf "        Creating the graphic... "
        gnuplot -c ./cymeteo/gnu/vector.gnu "Wind" data/w.dat graph/w.png "${locations[$location_FLAG]}" ${OPTION_d[0]} ${OPTION_d[1]} 2> /dev/null
        printf "Done\n\n"
    fi

    rm $data_sort_station

fi

if $t2_FLAG || $p2_FLAG; then
    data_sort_date=$(mktemp)

    # Sorted in ascending order by date
    printf "Sorting in ascending order by date... "
    ./cymeteo/bin/sort -f $data_filtered -o $data_sort_date -c DATE $sort_type > /dev/null
    check_errors $?
    #cat $data_sort_date > data/data_sort_date.csv
    printf "Done\n\n"

    if $t2_FLAG; then
        printf "    Command -t2\n"
        data_t2=$(mktemp)

        # Selects the necessary columns
        printf "        Filtering columns... "
        cut -d';' -f2,11 $data_sort_date > $data_t2
        #cat $data_t2 > data/data_t2.csv
        printf "Done\n"

        # Create a restructured file
        printf "        Restructuring spreadsheet... "
        ./cymeteo/bin/edit -f $data_t2 -o data/t2.dat -t2 > /dev/null
        check_errors $?
        rm $data_t2
        printf "Done\n"

        # Create a single line graph
        printf "        Creating the graphic... "
        gnuplot -c ./cymeteo/gnu/single_line.gnu "Temperature" "°C" data/t2.dat graph/t2.png "${locations[$location_FLAG]}" ${OPTION_d[0]} ${OPTION_d[1]} 2> /dev/null
        printf "Done\n\n"
    fi

    if $p2_FLAG; then
        printf "    Command -p2\n"
        data_p2=$(mktemp)

        # Selects the necessary columns
        printf "        Filtering columns... "
        cut -d';' -f2,7 $data_sort_date > $data_p2
        #cat $data_p2 > data/data_p2.csv
        printf "Done\n"

        # Create a restructured file
        printf "        Restructuring spreadsheet... "
        ./cymeteo/bin/edit -f $data_p2 -o data/p2.dat -p2 > /dev/null
        check_errors $?
        rm $data_p2
        printf "Done\n"

        # Create a single line graph
        printf "        Creating the graphic... "
        gnuplot -c ./cymeteo/gnu/single_line.gnu "Pressure" "Pa" data/p2.dat graph/p2.png "${locations[$location_FLAG]}" ${OPTION_d[0]} ${OPTION_d[1]} 2> /dev/null
        printf "Done\n\n"
    fi

    rm $data_sort_date

fi

if $t3_FLAG || $p3_FLAG; then
    data_sort_date_station=$(mktemp)
    sort_temp=$(mktemp)

    # Sorted in ascending order by date then station ID
    printf "Sorting in ascending order by date and station ID... "
    ./cymeteo/bin/sort -f $data_filtered -o $data_sort_date_station -c DATE $sort_type
    check_errors $?
    ./cymeteo/bin/sort -f $data_sort_date_station -o $sort_temp -c HOUR $sort_type > /dev/null
    check_errors $?
    ./cymeteo/bin/sort -f $sort_temp -o $data_sort_date_station -c ID $sort_type > /dev/null
    check_errors $?    
    rm $sort_temp
    #cat $data_sort_date_station > data/data_sort_date_station.csv
    printf "Done\n\n"

    if $t3_FLAG; then
        printf "    Command -t3\n"
        data_t3=$(mktemp)

        # Selects the necessary columns
        printf "        Filtering columns... "
        cut -d';' -f1,2,11 $data_sort_date_station > $data_t3
        #cat $data_t3 > data/data_t3.csv
        printf "Done\n"

        # Create a restructured file
        printf "        Restructuring spreadsheet... "
        ./cymeteo/bin/edit -f $data_t3 -o data/t3.dat -t3 > /dev/null
        check_errors $?
        rm $data_t3
        printf "Done\n"

        # Create a multi-lines graph
        printf "        Creating the graphic... "
        gnuplot -c ./cymeteo/gnu/multi_lines.gnu "Temperature" "°C" data/t3.dat graph/t3.png "${locations[$location_FLAG]}" ${OPTION_d[0]} ${OPTION_d[1]} 2> /dev/null
        printf "Done\n\n"
    fi

    if $p3_FLAG; then
        printf "    Command -p3\n"
        data_p3=$(mktemp)

        # Selects the necessary columns
        printf "        Filtering columns... "
        cut -d';' -f1,2,7 $data_sort_date_station > $data_p3
        #cat $data_p3 > data/data_p3.csv
        printf "Done\n"

        # Create a restructured file
        printf "        Restructuring spreadsheet... "
        ./cymeteo/bin/edit -f $data_p3 -o data/p3.dat -p3 > /dev/null
        check_errors $?
        rm $data_p3
        printf "Done\n"

        # Create a multi-lines graph
        printf "        Creating the graphic... "
        gnuplot -c ./cymeteo/gnu/multi_lines.gnu "Pressure" "Pa" data/p3.dat graph/p3.png "${locations[$location_FLAG]}" ${OPTION_d[0]} ${OPTION_d[1]} 2> /dev/null
        printf "Done\n\n"
    fi

    rm $data_sort_date_station

fi

if $h_FLAG; then
    data_sort_h_r=$(mktemp)

    # Sorted in descending order by height
    printf "Sorting in descending order by height... "
    ./cymeteo/bin/sort -f $data_filtered -o $data_sort_h_r -c HEIGHT $sort_type -r > /dev/null
    check_errors $?
    #cat $data_sort_h_r > data/data_sort_h_r.csv
    printf "Done\n\n"

    printf "    Command -h\n"
    data_h=$(mktemp)

    # Selects the necessary columns
    printf "        Filtering columns... "
    cut -d';' -f1,10,14 $data_sort_h_r > $data_h
    rm $data_sort_h_r
    #cat $data_h > data/data_h.csv
    printf "Done\n"

    # Create a restructured file
    printf "        Restructuring spreadsheet... "
    ./cymeteo/bin/edit -f $data_h -o data/h.dat -h > /dev/null
    check_errors $?
    rm $data_h
    printf "Done\n"

    # Create an interpolated map
    printf "        Creating the graphic... "
    gnuplot -c ./cymeteo/gnu/heat_map.gnu "Height" "m" data/h.dat graph/h.png "${locations[$location_FLAG]}" ${OPTION_d[0]} ${OPTION_d[1]} 2> /dev/null
    printf "Done\n\n"
fi

if $m_FLAG; then
    data_sort_m_r=$(mktemp)

    # Sorted in descending order by humidity
    printf "Sorting in descending order by moisture... "
    ./cymeteo/bin/sort -f $data_filtered -o $data_sort_m_r -c MOISTURE $sort_type -r > /dev/null
    check_errors $?
    #cat $data_sort_m_r > data/data_sort_m_r.csv
    printf "Done\n\n"

    printf "    Command -m\n"
    data_m=$(mktemp)

    # Selects the necessary columns
    printf "        Filtering columns... "
    cut -d';' -f1,10,6 $data_sort_m_r |
    awk -F';' 'BEGIN {OFS=";"} { print $1,$3,$2 }' > $data_m # Switch second and third column
    #cat $data_m > data/data_m.csv
    rm $data_sort_m_r
    printf "Done\n"

    # Create a restructured file
    printf "        Restructuring spreadsheet... "
    ./cymeteo/bin/edit -f $data_m -o data/m.dat -m > /dev/null
    check_errors $?
    rm $data_m
    printf "Done\n"

    # Create an interpolated map
    printf "        Creating the graphic... "
    gnuplot -c ./cymeteo/gnu/heat_map.gnu "Moisture" "%" data/m.dat graph/m.png "${locations[$location_FLAG]}" ${OPTION_d[0]} ${OPTION_d[1]} 2> /dev/null
    printf "Done\n\n"
fi

rm $data_filtered
