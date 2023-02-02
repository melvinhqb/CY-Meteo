#include "../../includes/edit.h"

// Return the minimum between two float (does not include 0)
float min(float a, float b) {
    if (a == 0) {
        return b;
    }
    if (b == 0) {
        return a;
    }
    return a<b?a:b;
}

// Return the maximum between two float (does not include 0)
float max(float a, float b) {
    if (a == 0) {
        return b;
    }
    if (b == 0) {
        return a;
    }
    return a>b?a:b;
}

int main(int argc, char* argv[]) {

    // Get all the options
    Options opts = getOptions(argc, argv);

    // Edit the data according to the type of graph requested
    opts.graph(opts.input_name, opts.output_name);

    return 0;
}