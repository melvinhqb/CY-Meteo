#include "../../includes/edit.h"

// Function that converts a sorted CSV file into an organised DAT file for vector graphs 
void vector(char* input, char*output) {

    // Open the CSV file
    FILE* file = fopen(input, "r");

    // Checks for errors
    if (file == NULL){
        printf("Error opening file\n");
        exit(INPUT_ERROR);
    }

    // Declaration of variables
    char buffer[1024];
    char *element;
    int current_id;
    double current_direction;
    double current_speed;
    float current_lat;
    float current_lon;
    int counter = -1;

    // Skip the first header line
    fgets(buffer, sizeof(buffer), file);

    // Reading the CSV file line by line
    while (fgets(buffer, sizeof(buffer), file)) {
        // Get the current station ID
        element = strtok(buffer, ";");
        current_id = atoi(element);
        // Get the current wind direction
        element = strtok(NULL, ";");
        current_direction = atof(element);
        // Get the current wind speed
        element = strtok(NULL, ";");
        current_speed = atof(element);
        // Get the current coordinates
        element = strtok(NULL, ";");
        sscanf(element, "%f,%f", &current_lat, &current_lon);

        // Check if the id is already in the hash map
        if(vector_tab[counter].id == current_id
        && current_direction != 0 && current_speed != 0) {
            // Update the values
            vector_tab[counter].sum_direction += current_direction;
            vector_tab[counter].sum_speed += current_speed;
            vector_tab[counter].count++;
        }
        else if (current_direction != 0 && current_speed != 0) {
            // Insert new values
            counter++;
            vector_tab[counter].id = current_id;
            vector_tab[counter].sum_direction = current_direction;
            vector_tab[counter].sum_speed = current_speed;
            vector_tab[counter].lat = current_lat;
            vector_tab[counter].lon = current_lon;
            vector_tab[counter].count = 1;
        }

    }

    // Close the CSV file
    fclose(file);

    // Open a DAT file
    FILE* output_file = fopen(output, "w");

    // Checks for errors
    if (output_file == NULL) {
        exit(OUTPUT_ERROR);
    }

    // Display the header line
    fprintf(output_file, "# X(lon) Y(lat) Moy_Direction Moy_Speed\n");

    // Display one line per station with "ID average", "min", and "max"
    for(int i=0;i<counter+1;i++) {
        Vector station = vector_tab[i];
        fprintf(output_file, "%f %f %f %f\n", station.lon, station.lat, station.sum_direction/station.count, station.sum_speed/station.count);
    }

    // Close the DAT file
    fclose(output_file);
}