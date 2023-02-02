#include "../../includes/edit.h"

// Function that converts a sorted CSV file into an organised DAT file for single line graphs
void singleLine(char* input, char* output) {

    // Open the CSV file
    FILE* input_file = fopen(input, "r");
    
    // Checks for errors
    if (input_file == NULL) {
        perror("Error opening file");
        exit(INPUT_ERROR);
    }

    // Declaration of variables
    char buffer[1024];
    char *element;
    char date_string[14];
    double current_data;
    int counter = -1;

    // Skip the first header line
    fgets(buffer, sizeof(buffer), input_file);

    // Reading the CSV file line by line
    while (fgets(buffer, sizeof(buffer), input_file)) {
        // Get the current date
        element = strtok(buffer, ";");
        struct tm tm = {0};
        strptime(element, "%Y-%m-%dT%H:%M:%S%z", &tm);
        strftime(date_string, sizeof(date_string), "%Y-%m-%dT%H", &tm);
        // Get the current data
        element = strtok(NULL, ";");
        current_data = atof(element);

        // Check if the id is already in the hash map
        if(strcmp(single_line_tab[counter].date_string, date_string) == 0
        && current_data != 0) {
            // Update the values
            single_line_tab[counter].sum += current_data;
            single_line_tab[counter].count++;
        }
        else if (current_data != 0) {
            // Insert new values
            counter++;
            strcpy(single_line_tab[counter].date_string, date_string);
            single_line_tab[counter].sum = current_data;
            single_line_tab[counter].count = 1;
        }

    }

    // Close the CSV file
    fclose(input_file);

    // Open a DAT file
    FILE* output_file = fopen(output, "w");

    // Checks for errors
    if (output_file == NULL) {
        exit(OUTPUT_ERROR);
    }

    // Display the header line
    fprintf(output_file, "# Date Moy\n");

    // Display one line per date/hour with "date" and "average"
    for(int i=0;i<counter+1;i++) {
        SingleLine time = single_line_tab[i];
        fprintf(output_file, "\"%s\" %f\n", time.date_string, time.sum/time.count);
    }

    // Close the DAT file
    fclose(output_file);
}