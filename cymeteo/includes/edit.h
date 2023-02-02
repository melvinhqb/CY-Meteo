#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <string.h>
#define __USE_XOPEN
#define _GNU_SOURCE
#include <time.h>
#include<sys/stat.h>
#include <stdbool.h>

#define OPT_ERROR 1
#define INPUT_ERROR 2
#define OUTPUT_ERROR 3
#define ERROR 4

#define NB_STATIONS_MAX 100
#define NB_DATES_HOURS_MAX 40000

typedef struct errorBar {
    int id;
    double sum;
    int count;
    double min;
    double max;
} ErrorBar;

typedef struct singleLine {
    char date_string[14];
    double sum;
    int count;
} SingleLine;

typedef struct multiLines {
    int id;
    char day_string[11];
    char hour_string[3];
    float sum;
    int count;
} MultiLines;

typedef struct vector {
    int id;
    double sum_direction;
    double sum_speed;
    float lat;
    float lon;
    int count;
} Vector;

typedef struct interpolatedMap {
    int id;
    float lat;
    float lon;
    int max;
} InterpolatedMap;

ErrorBar error_bar_tab[NB_STATIONS_MAX];
SingleLine single_line_tab[NB_DATES_HOURS_MAX];
MultiLines multi_lines_tab[NB_STATIONS_MAX*NB_DATES_HOURS_MAX];
Vector vector_tab[NB_STATIONS_MAX];
InterpolatedMap interpolated_map_tab[NB_STATIONS_MAX];

typedef void (*typeGraph)(char* input_name, char* output_name);

typedef struct options{
    char *input_name;
    char *output_name;
    typeGraph graph;
}Options;

float min(float a, float b);
float max(float a, float b);

Options getOptions(int argc, char *argv[]);

void errorBar(char* input, char* output);
void singleLine(char* input, char* output);
void multiLines(char* input, char*output);
void vector(char* input, char*output);
void interpolatedMap(char* input, char* output);
