
isDate() {
    date "+%Y-%m-%d" -d $1 > /dev/null  2>&1
        is_valid=$?
    echo "$is_valid"
}

check_errors() {
    val=$1
    if [ $val -eq 0 ];then
        return 0
    fi
    case $val in
    1)
        printf "\nERROR: The options activated in program C do not work\n"
        ;;
    2)
        printf "\nERROR: The input data file has a problem\n"
        ;;
    3)
        printf "\nERROR: The output data file has a problem\n"
        ;;
    4)
        printf "\nERROR: The execution did not work properly\n"
        ;;
    esac
    exit 1
}

help() {
    echo "Usage: ./scripts/script.sh [--help] [-f FILENAME] [-d MIN MAX] [-F] [-G] [-S] [-A] [-O] [-Q] [--all] [-t MODE] [-p MODE] [-w] [-h] [-m] [--tab] [--abr] [--avl]"
    echo
    echo "Generate weather graphs for a given time interval and a given geographical area."
    echo
    echo "Options:"
    echo "  --help            Show this help message and exit"
    echo
    echo "  -f FILENAME       The CSV file used by the application"
    echo
    echo "  -d MIN MAX        The time interval for which the data should be processed."
    echo "                    Must be in YYYY-MM-DD format, excluding MAX."
    echo
    echo "  -F                The geographical area used is metropolitan France."
    echo "  -G                The geographical area used is Guyana."
    echo "  -S                The geographical area used is Saint-Pierre and Miquelon."
    echo "  -A                The geographical area used is French Antilles."
    echo "  -O                The geographical area used is Indian Ocean."
    echo "  -Q                The geographical area used is Antartic."
    echo
    echo "  --all             Selects all data type options (-t MODE, -p MODE, -w, -h and -m),"
    echo "                    and outputs all corresponding charts."
    echo "  -t MODE           Outputs a temperature graph according to the MODE"
    echo "                    (1: error bar, 2: single line, 3: multi-lines, 4: errbar + filledcurve)"
    echo "  -p MODE           Outputs a pressure graph according to the MODE"
    echo "                    (1: error bar, 2: single line, 3: multi-lines, 4: errbar + filledcurve)"
    echo "  -w                Outputs a vector wind map"
    echo "  -h                Outputs an interpolated and coloured map of the height"
    echo "  -m                Outputs an interpolated and coloured map of the moisture"
    echo
    echo "  --tab             A chained list will be used to sort the data."
    echo "  --abr             A binary tree will be used to sort the data."
    echo "  --avl             A balanced binary tree will be used to sort the data."
    echo
    echo "By default, the --avl option will be used to process the data."
    echo "To process the data, the file and at least one data type arguments are needed."
    exit 1
}