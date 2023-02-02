#include "../../includes/edit.h"

// Function that returns the options to be used by the program
Options getOptions(int argc, char *argv[]) {
    int opt;
    int option_index = 0;
    int f_flag = 0;
    int o_flag = 0;
    int mode_flag = 0;
    Options opts = {0};

    struct option long_options[] = {
        {"file", required_argument, 0, 'f'},
        {"output", required_argument, 0, 'o'},
        {"temperature", required_argument, 0, 't'},
        {"pressure", required_argument, 0, 'p'},
        {"wind", no_argument, 0, 'w'},
        {"height", no_argument, 0, 'h'},
        {"moisture", no_argument, 0, 'm'},
        {0, 0, 0, 0}
    };

    struct stat buffer;

    while ((opt = getopt_long(argc, argv, "f:o:t:p:whm", long_options, NULL)) != -1) {
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
            case 't':
            case 'p':
                if (mode_flag || atoi(optarg) == 0) {
                    exit(OPT_ERROR);
                }
                switch(atoi(optarg)) {
                    case 1:
                    case 4:
                        opts.graph = errorBar;
                        break;
                    case 2:
                        opts.graph = singleLine;
                        break;
                    case 3:
                        opts.graph = multiLines;
                        break;
                    default:
                        exit(OPT_ERROR);
                }
                mode_flag = 1;
                break;
            case 'w':
                if (mode_flag) {
                    exit(OPT_ERROR);
                }
                opts.graph = vector;
                mode_flag = 1;
                break;
            case 'h':
            case 'm':
                if (mode_flag) {
                    exit(OPT_ERROR);
                }
                opts.graph = interpolatedMap;
                mode_flag = 1;
                break;
            case '?':
                exit(OPT_ERROR);
        }
    }

    if (!f_flag) {
        exit(INPUT_ERROR);
    }
    if (!o_flag) {
        exit(OUTPUT_ERROR);
    }
    if (strcmp(opts.input_name, opts.output_name) == 0) {
        exit(OUTPUT_ERROR);
    }
    if (!mode_flag) {
        exit(OPT_ERROR);
    }

    return opts;
}