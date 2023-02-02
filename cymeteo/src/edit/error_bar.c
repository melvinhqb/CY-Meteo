#include "../../includes/edit.h"

// Function that converts a sorted CSV file into an organised DAT file for error bar graphs
void errorBar(char* input, char* output) {

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
    int current_id;
    double current_data;
    int counter = -1;

    // Skip the first header line
    fgets(buffer, sizeof(buffer), input_file);

    // Reading the CSV file line by line
    while (fgets(buffer, sizeof(buffer), input_file)) {
        // Get the current station ID
        element = strtok(buffer, ";");
        current_id = atoi(element);
        // Get the current data
        element = strtok(NULL, ";");
        current_data = atof(element);

        // Check if the id is already in the hash map
        if(error_bar_tab[counter].id == current_id && current_data != 0) {
            // Update the values
            error_bar_tab[counter].sum += current_data;
            error_bar_tab[counter].count++;
            error_bar_tab[counter].min = min(error_bar_tab[counter].min, current_data);
            error_bar_tab[counter].max = max(error_bar_tab[counter].max, current_data);
        }
        else if (current_data != 0) {
            // Insert new values
            counter++;
            error_bar_tab[counter].id = current_id;
            error_bar_tab[counter].sum = current_data;
            error_bar_tab[counter].count = 1;
            error_bar_tab[counter].min = current_data;
            error_bar_tab[counter].max = current_data;
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
    fprintf(output_file, "# ID_Station Moyenne Min Max\n");

    // Display one line per station with "ID average", "min", and "max"
    for(int i=0;i<counter+1;i++) {
        ErrorBar station = error_bar_tab[i];
        fprintf(output_file, "%d %f %f %f\n", station.id, station.sum/station.count, station.min, station.max);
    }

    // Close the DAT file
    fclose(output_file);
}