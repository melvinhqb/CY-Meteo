#include "../../includes/edit.h"

// Function that returns the index of a station if in the array, otherwise returns -1
int isInList(int* list, int val, int count) {
    for (int i=0;i<count+1;i++) {
        if (val == list[i]) {
            return i;
        }
    }
    return -1;
}

// Function that converts a sorted CSV file into an organised DAT file for heat map graphs 
void interpolatedMap(char* input, char* output) {

    // Open the CSV file
    FILE* input_file = fopen(input, "r");

    // Checks for errors
    if (input_file == NULL){
        printf("Error opening file\n");
        exit(INPUT_ERROR);
    }

    // Declaration of variables
    char buffer[1024];
    char *element;
    int current_id;
    int current_data;
    float current_lat;
    float current_lon;
    int list_id[NB_STATIONS_MAX];
    int verif;
    int counter = -1;

    // Skip the first header line
    fgets(buffer, sizeof(buffer), input_file);

    // reading the CSV file line by line
    while (fgets(buffer, sizeof(buffer), input_file)) {
        // Get the current station ID
        element = strtok(buffer, ";");
        current_id = atoi(element);
        // Get the current coordonates
        element = strtok(NULL, ";");
        sscanf(element, "%f,%f", &current_lat, &current_lon);
        // Get the current data
        element = strtok(NULL, ";");
        current_data = atoi(element);

        // Check if the current id is already in the 'list_id' list
        if (isInList(list_id, current_id, counter) != -1) {
            // Update the values
            interpolated_map_tab[verif].max = max(interpolated_map_tab[verif].max, current_data);
        }
        else if (current_data != 0) {
            // Insert new values
            counter++;
            list_id[counter] = current_id;
            interpolated_map_tab[counter].id = current_id;
            interpolated_map_tab[counter].max = current_data;
            interpolated_map_tab[counter].lat = current_lat;
            interpolated_map_tab[counter].lon = current_lon;
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
    fprintf(output_file, "# X(lon) Y(lat) Val\n");

    // Display one line per station with 'longitude', 'latitude' and 'max value'
    for (int i=0; i<counter+1; i++) {
        InterpolatedMap station = interpolated_map_tab[i];
        fprintf(output_file, "%f %f %d\n", station.lon, station.lat, station.max);
    }

    // Close the DAT file
    fclose(output_file);
}