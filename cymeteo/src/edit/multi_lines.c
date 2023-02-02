#include "../../includes/edit.h"
#define DAY_SEC 60*60*24 // Number of seconds in one day
#define DAY_DIFF_MAX 7 // Max diff in days (here 2 points can be connected if the diff between their dates is max 7 days

// Function to get the difference in seconds between two days
long long diffTime(char* day1, char* day2) {
    // Structure to store the date
    struct tm d1 = {0};
    struct tm d2 = {0};
    long long day_sec = DAY_SEC;

    // Convert the string date in a tm structure
    strptime(day1, "%Y-%m-%d", &d1);
    strptime(day2, "%Y-%m-%d", &d2);

    // Convert the tm structure in UNIX timestamp
    time_t t1 = mktime(&d1);
    time_t t2 = mktime(&d2);

    return t2 - t1;
}


// Function that converts a sorted CSV file into an organised DAT file for multi-lines graphs 
void multiLines(char* input, char*output) {

    // Open the CSV file
    FILE* input_file = fopen(input, "r");

    // Checks for errors
    if (input_file == NULL) {
        printf("Error opening file\n");
        exit(INPUT_ERROR);
    }

    // Declaration of variables
    char buffer[1024];
    char *element;
    int current_id;
    char day_string[11];
    char hour_string[3];
    double current_data;
    int counter = -1;

    // Skip the first header line
    fgets(buffer, sizeof(buffer), input_file);

    // Reading the CSV file line by line
    while (fgets(buffer, sizeof(buffer), input_file)) {
        // Get the current station ID
        element = strtok(buffer, ";");
        current_id = atoi(element);
        // Get the current day and time
        element = strtok(NULL, ";");
        struct tm tm = {0};
        strptime(element, "%Y-%m-%dT%H:%M:%S%z", &tm);
        strftime(day_string, sizeof(day_string), "%Y-%m-%d", &tm);
        strftime(hour_string, sizeof(hour_string), "%H", &tm);
        // Get the current data
        element = strtok(NULL, ";");
        current_data = atof(element);

        // Check if the id is already in the hash map
        if(multi_lines_tab[counter].id == current_id
        && strcmp(multi_lines_tab[counter].day_string, day_string) == 0
        && strcmp(multi_lines_tab[counter].hour_string, hour_string) == 0
        && current_data != 0) {
            // Update the values
            multi_lines_tab[counter].sum += current_data;
            multi_lines_tab[counter].count++;
        }
        else if (current_data != 0) {
            // Insert new values
            counter++;
            multi_lines_tab[counter].id = current_id;
            strcpy(multi_lines_tab[counter].day_string, day_string);
            strcpy(multi_lines_tab[counter].hour_string, hour_string);
            multi_lines_tab[counter].sum = current_data;
            multi_lines_tab[counter].count = 1;
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
    fprintf(output_file, "# ID_Station Day Hour Value\n");

    // Display one line per date/hour with "date" and "average"
    for(int i=0;i<counter+1;i++) {
        MultiLines time = multi_lines_tab[i];
        fprintf(output_file, "%d \"%s\" %s %f\n", time.id, time.day_string, time.hour_string, time.sum/time.count);

        // Put two blank lines if the time of the next line is different from the current one
        // Put two blank lines if the difference between the current and the next day is greater than DAY_DIFF_MAX days
        if (i < counter-1 && i > 0 && (strcmp(time.hour_string, multi_lines_tab[i+1].hour_string) != 0 || diffTime(time.day_string, multi_lines_tab[i+1].day_string) > DAY_DIFF_MAX*DAY_SEC)) {
            fprintf(output_file, "\n\n");
        }
    }

    // Close the DAT file
    fclose(output_file);
}