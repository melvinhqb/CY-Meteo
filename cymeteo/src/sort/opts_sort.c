#include "../../includes/sort.h"
#include <getopt.h>

// Function that defines on which column the sorting is applied
sort_by defineSortColumn(char *arg) {
    if (strcmp(arg, "ID") == 0) {
        return ID;
    }
    else if (strcmp(arg, "DATE") == 0) {
        return DATE;
    }
    else if (strcmp(arg, "HOUR") == 0) {
        return HOUR;
    }
    else if (strcmp(arg, "MOISTURE") == 0) {
        return MOISTURE;
    }
    else if (strcmp(arg, "HEIGHT") == 0) {
        return HEIGHT;
    }
    else {
        printf("Error sort column\n");
        exit(OPT_ERROR);
    }
}

// Function that returns the options to be used by the program
Options getOptions(int argc, char *argv[]) {

    // Declaration of variables
    int opt;
    int option_index = 0;
    int abr_flag = 0;
    int avl_flag = 0;
    int tab_flag = 0;
    int f_flag = 0;
    int o_flag = 0;
    int r_flag = 0;
    int c_flag = 0;
    Options opts = {0};

    // Declares an array of options
    struct option long_options[] = {
        {"tab", no_argument, &tab_flag, 1},
        {"abr", no_argument, &abr_flag, 1},
        {"avl", no_argument, &avl_flag, 1},
        {"file", required_argument, 0, 'f'},
        {"output", required_argument, 0, 'o'},
        {"reverse", no_argument, 0, 'r'},
        {"column", required_argument, 0, 'c'},
        {0, 0, 0, 0}
    };

    struct stat buffer;

    // Compare each argument with the options defined
    while ((opt = getopt_long(argc, argv, "f:o:rc:", long_options, NULL)) != -1) {
        switch (opt) {
            case 'f':
                if (f_flag || stat(optarg, &buffer) != 0) {
                    exit(INPUT_ERROR);
                }
                opts.input_name = optarg;
                f_flag = 1;
                break;
            case 'o':
                if (o_flag) {
                    exit(OUTPUT_ERROR);
                }
                opts.output_name = optarg;
                o_flag = 1;
                break;
            case 'r':
                if (r_flag) {
                    exit(OPT_ERROR);
                }
                opts.sort_order = descending_order;
                r_flag = 1;
                break;
            case 'c':
                if (c_flag) {
                    exit(OPT_ERROR);
                }
                opts.sort_col = defineSortColumn(optarg);
                c_flag = 1;
                break;
            case '?':
                exit(OPT_ERROR);
        }
    }

    // Checks if there are several sorting methods requested
    if((abr_flag + avl_flag + tab_flag) > 1) {
        exit(OPT_ERROR);
    }

    // Assigns a sorting function based on the
    else if (abr_flag) {
        opts.sort_type = insertNodeABR;
    }
    else if (tab_flag) {
        opts.sort_type = insertNodeTAB;
    }
    else {
        opts.sort_type = insertNodeAVL;
    }

    // Checks that the required options are active
    if (!f_flag) {
        exit(INPUT_ERROR);
    }
    if (!o_flag) {
        exit(OUTPUT_ERROR);
    }
    if (!c_flag) {
        exit(OPT_ERROR);
    }

    // Checks that the input and output files are different
    if (strcmp(opts.input_name, opts.output_name) == 0) {
        exit(OUTPUT_ERROR);
    }

    // If the reverse option is not active, define the ascending order mode
    if (!r_flag) {
        opts.sort_order = ascending_order;
    }

    return opts;
}