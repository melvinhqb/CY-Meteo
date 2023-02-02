#include "../../includes/sort.h"

// Function to convert a date in string format to a float
float convertDateToFloat(char *date_string) {
    // Structure pour stocker la date convertie
    struct tm tm = {0};

    // Convertir la chaîne de date en structure tm
    strptime(date_string, "%Y-%m-%dT%H:%M%z", &tm);

    // Convertir la structure tm en timestamp Unix
    time_t timestamp = mktime(&tm);
    
    return (float) timestamp;
}


// Function to get the hour of a date in string format
int getHour(char *date_string) {
    // Structure pour stocker la date convertie
    struct tm tm = {0};

    // Convertir la chaîne de date en structure tm
    strptime(date_string, "%Y-%m-%dT%H:%M%z", &tm);

    return tm.tm_hour;
}