#include "../../includes/sort.h"
#include <getopt.h>

int main(int argc, char *argv[]) {

    // Get all the options 
    Options opts = getOptions(argc, argv);

    // Initializing the binary tree to NULL
    Node* tree = NULL;

    // Reads the data and stores it in a tree
    tree = readFile(opts.input_name, tree, opts.sort_type, opts.sort_col);

    // Print the sorted CSV file
    displayFile(opts.output_name, tree, opts.sort_order);

    return 0;
}