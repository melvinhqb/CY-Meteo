# ---------------------------------------------------------------
#                      Checking the options
# ---------------------------------------------------------------

# Checks that the command --help is active
if [[ "$@" == *"--help"* ]]; then
    help
fi

printf "Checking input parameters... "

while getopts $OPTIONS opt; do
    case $opt in
    f)
        if [ -n "$OPTION_f" ]; then
            printf "\nERROR: The -f option can only be used once\n" >&2
            exit 1
        fi
        if ! $(file "$OPTARG" | grep -q "csv"); then
            printf "\nERROR: -f option must be a file with the 'csv' extension\n"
            exit 1
        fi
        if ! [[ -f $OPTARG ]]; then
            printf "\nERROR: The file '$OPTARG' does not exist or its address is wrong\n"
            exit 1
        fi
        if [[ $(wc -l $OPTARG | awk '{print $1}') -lt 2 ]]; then
            printf "\nERROR: The file must contain at least 2 lines (including titles)\n"
            exit 1
        fi
        ARG_COUNTER=1
        until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
            OPTIND=$((OPTIND + 1))
            ARG_COUNTER=$((ARG_COUNTER+1))
        done
        if [ $ARG_COUNTER -ne 1 ]; then
            printf "\nERROR: -f option has one argument\n"
            exit 1
        fi
        OPTION_f=$OPTARG
        f_FLAG=true
        ;;
    d)
        if [ -n "$OPTION_d" ]; then
            printf "\nERROR: The -d option can only be used once\n" >&2
            exit 1
        fi
        OPTION_d=("$OPTARG")
        ARG_COUNTER=1
        until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
            OPTION_d+=($(eval "echo \${$OPTIND}"))
            OPTIND=$((OPTIND + 1))
            ARG_COUNTER=$((ARG_COUNTER+1))
        done
        if [ $ARG_COUNTER -ne 2 ]; then
            printf "\nERROR: -d option has two arguments\n"
            exit 1
        elif ! [[ ${OPTION_d[0]} =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]] || ! [[ ${OPTION_d[1]} =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
            printf "\nERROR: -d arguments format is YYYY-MM-DD\n"
            exit 1
        elif [ $(isDate ${OPTION_d[0]}) -eq 1 ] || [ $(isDate ${OPTION_d[1]}) -eq 1 ]; then
            printf "\nERROR: -d arguments are invalid\n"
            exit 1
        elif [[ ${OPTION_d[0]} > ${OPTION_d[1]} ]] || [[ ${OPTION_d[0]} == ${OPTION_d[1]} ]]; then
            printf "\nERROR: The order of the -d option is incorrect\n"
            exit 1
        fi
        d_FLAG=true
        ;;
    F)
        if [ $location_FLAG -ne 0 ]; then
            printf "\nERROR: One location option at a time can be used\n"
            exit 1
        fi
        ARG_COUNTER=1
        until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
            OPTIND=$((OPTIND + 1))
            ARG_COUNTER=$((ARG_COUNTER+1))
        done
        if [ $ARG_COUNTER -ne 1 ]; then
            printf "\nERROR: -F option has any argument\n"
            exit 1
        fi
        lat_max=$F_LAT_LT
        lon_min=$F_LON_LT
        lat_min=$F_LAT_RB
        lon_max=$F_LON_RB
        location_FLAG=1
        ;;
    G)
        if [ $location_FLAG -ne 0 ]; then
            printf "\nERROR: One location option at a time can be used\n"
            exit 1
        fi
        ARG_COUNTER=1
        until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
            OPTIND=$((OPTIND + 1))
            ARG_COUNTER=$((ARG_COUNTER+1))
        done
        if [ $ARG_COUNTER -ne 1 ]; then
            printf "\nERROR: -G option has any argument\n"
            exit 1
        fi
        lat_max=$G_LAT_LT
        lon_min=$G_LON_LT
        lat_min=$G_LAT_RB
        lon_max=$G_LON_RB
        location_FLAG=2
        ;;
    S)
        if [ $location_FLAG -ne 0 ]; then
            printf "\nERROR: One location option at a time can be used\n"
            exit 1
        fi
        ARG_COUNTER=1
        until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
            OPTIND=$((OPTIND + 1))
            ARG_COUNTER=$((ARG_COUNTER+1))
        done
        if [ $ARG_COUNTER -ne 1 ]; then
            printf "\nERROR: -S option has any argument\n"
            exit 1
        fi
        lat_max=$S_LAT_LT
        lon_min=$S_LON_LT
        lat_min=$S_LAT_RB
        lon_max=$S_LON_RB
        location_FLAG=3
        ;;
    A)
        if [ $location_FLAG -ne 0 ]; then
            printf "\nERROR: One location option at a time can be used\n"
            exit 1
        fi
        ARG_COUNTER=1
        until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
            OPTIND=$((OPTIND + 1))
            ARG_COUNTER=$((ARG_COUNTER+1))
        done
        if [ $ARG_COUNTER -ne 1 ]; then
            printf "\nERROR: -A option has any argument\n"
            exit 1
        fi
        lat_max=$A_LAT_LT
        lon_min=$A_LON_LT
        lat_min=$A_LAT_RB
        lon_max=$A_LON_RB
        location_FLAG=4
        ;;
    O)
        if [ $location_FLAG -ne 0 ]; then
            printf "\nERROR: One location option at a time can be used\n"
            exit 1
        fi
        ARG_COUNTER=1
        until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
            OPTIND=$((OPTIND + 1))
            ARG_COUNTER=$((ARG_COUNTER+1))
        done
        if [ $ARG_COUNTER -ne 1 ]; then
            printf "\nERROR: -O option has any argument\n"
            exit 1
        fi
        lat_max=$O_LAT_LT
        lon_min=$O_LON_LT
        lat_min=$O_LAT_RB
        lon_max=$O_LON_RB
        location_FLAG=5
        ;;
    Q)
        if [ $location_FLAG -ne 0 ]; then
            printf "\nERROR: One location option at a time can be used\n"
            exit 1
        fi
        ARG_COUNTER=1
        until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
            OPTIND=$((OPTIND + 1))
            ARG_COUNTER=$((ARG_COUNTER+1))
        done
        if [ $ARG_COUNTER -ne 1 ]; then
            printf "\nERROR: -Q option has any argument\n"
            exit 1
        fi
        lat_max=$Q_LAT_LT
        lon_min=$Q_LON_LT
        lat_min=$Q_LAT_RB
        lon_max=$Q_LON_RB
        location_FLAG=6
        ;;
    t)
        ARG_COUNTER=1
        until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
            OPTIND=$((OPTIND + 1))
            ARG_COUNTER=$((ARG_COUNTER+1))
        done
        if [ $ARG_COUNTER -ne 1 ]; then
            printf "\nERROR: -t option has any argument\n"
            exit 1  
        elif [[ $OPTARG -lt 1 || $OPTARG -gt 4 ]]; then
            printf "\nERROR: The argument of the -t option must be between 1 and 3\n"
            exit 1
        fi
        case $OPTARG in
            1)
                if [ $t1_FLAG == true ]; then
                    printf "\nERROR: The -t1 option can only be used once\n" >&2
                    exit 1
                fi
                t1_FLAG=true
                ;;
            2)
                if [ $t2_FLAG == true ]; then
                    printf "\nERROR: The -t2 option can only be used once\n" >&2
                    exit 1
                fi
                t2_FLAG=true
                ;;
            3)
                if [ $t3_FLAG == true ]; then
                    printf "\nERROR: The -t3 option can only be used once\n" >&2
                    exit 1
                fi
                t3_FLAG=true
                ;;
            4)
                if [ $t4_FLAG == true ]; then
                    printf "\nERROR: The -t4 option can only be used once\n" >&2
                    exit 1
                fi
                t4_FLAG=true
                ;;
        esac
        t_FLAG=true
        data_type_FLAG=true
        ;;
    p)
        ARG_COUNTER=1
        until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
            OPTIND=$((OPTIND + 1))
            ARG_COUNTER=$((ARG_COUNTER+1))
        done
        if [ $ARG_COUNTER -ne 1 ]; then
            printf "\nERROR: -p option has any argument\n"
            exit 1  
        elif [[ $OPTARG -lt 1 || $OPTARG -gt 4 ]]; then
            printf "\nERROR: The argument of the -p option must be between 1 and 3\n"
            exit 1
        fi
        case $OPTARG in
            1)
                if [ $p1_FLAG == true ]; then
                    printf "\nERROR: The -p1 option can only be used once\n" >&2
                    exit 1
                fi
                p1_FLAG=true
                ;;
            2)
                if [ $p2_FLAG == true ]; then
                    printf "\nERROR: The -p2 option can only be used once\n" >&2
                    exit 1
                fi
                p2_FLAG=true
                ;;
            3)
                if [ $p3_FLAG == true ]; then
                    printf "\nERROR: The -p3 option can only be used once\n" >&2
                    exit 1
                fi
                p3_FLAG=true
                ;;
            4)
                if [ $p4_FLAG == true ]; then
                    printf "\nERROR: The -p4 option can only be used once\n" >&2
                    exit 1
                fi
                p4_FLAG=true
                ;;
        esac
        p_FLAG=true
        data_type_FLAG=true
        ;;
    w)
        if [ $w_FLAG == true ]; then
            printf "\nERROR: The -w option can only be used once\n" >&2
            exit 1
        fi
        ARG_COUNTER=1
        until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
            OPTIND=$((OPTIND + 1))
            ARG_COUNTER=$((ARG_COUNTER+1))
        done
        if [ $ARG_COUNTER -ne 1 ]; then
            printf "\nERROR: -w option has any argument\n"
            exit 1
        fi         
        w_FLAG=true
        data_type_FLAG=true
        ;;
    h)
        if [ $h_FLAG == true ]; then
            printf "\nERROR: The -h option can only be used once\n" >&2
            exit 1
        fi
        ARG_COUNTER=1
        until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
            OPTIND=$((OPTIND + 1))
            ARG_COUNTER=$((ARG_COUNTER+1))
        done
        if [ $ARG_COUNTER -ne 1 ]; then
            printf "\nERROR: -h option has any argument\n"
            exit 1
        fi         
        h_FLAG=true
        data_type_FLAG=true
        ;;
    m)
        if [ $m_FLAG == true ]; then
            printf "\nERROR: The -m option can only be used once\n" >&2
            exit 1
        fi
        ARG_COUNTER=1
        until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
            OPTIND=$((OPTIND + 1))
            ARG_COUNTER=$((ARG_COUNTER+1))
        done
        if [ $ARG_COUNTER -ne 1 ]; then
            printf "\nERROR: -m option has any argument\n"
            exit 1
        fi
        m_FLAG=true
        data_type_FLAG=true
        ;;
    \?)
        # Invalid option
        printf "\nERROR: Invalid option: -$OPTARG\n"
        exit 1
        ;;
    :)
        # Option requires an argument
        printf "\nERROR: Option -$OPTARG requires an argument\n"
        exit 1
        ;;
    esac
done

# Checks that the -f option is active
if ! $f_FLAG; then
    printf "\nERROR: -f option must be added\n"
    exit 1
fi

# Checks that at least one data option is active
if [[ "$@" == *"--all"* ]]; then
    t1_FLAG=true
    t2_FLAG=true
    t3_FLAG=true
    t4_FLAG=true
    p1_FLAG=true
    p2_FLAG=true
    p3_FLAG=true
    p4_FLAG=true
    w_FLAG=true
    h_FLAG=true
    m_FLAG=true
elif ! $data_type_FLAG; then
    printf "\nERROR: One of these options must be used (-t, -p, -w, -h, -m)\n"
    exit 1
fi

# Checks the type of sort used
if [[ "$@" == *"--abr"* ]]; then
    sort_type="--abr"
    sort_FLAG=$((++sort_FLAG))
fi
if [[ "$@" == *"--tab"* ]]; then
    sort_type="--tab"
    sort_FLAG=$((++sort_FLAG))
fi
if [ $sort_FLAG -eq 0 ] || [[ "$@" == *"--avl"* ]]; then
    sort_type="--avl"
    sort_FLAG=$((++sort_FLAG))
fi
if [ $sort_FLAG -gt 1 ]; then
    printf "\nERROR: One type of sorting at a time (--avl, --abr, --tab)\n"
    exit 1
fi

printf "Done\n\n"
