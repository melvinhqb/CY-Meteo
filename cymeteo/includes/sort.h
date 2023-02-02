#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>
#include <string.h>
#define __USE_XOPEN
#define _GNU_SOURCE
#include <time.h>
#include <unistd.h>
#include<sys/stat.h>

#define LINE_SIZE 1024

#define OPT_ERROR 1
#define INPUT_ERROR 2
#define OUTPUT_ERROR 3
#define ERROR 4

#define HEAD_TITLES "ID OMM station;Date;Pression au niveau mer;Direction du vent moyen 10 mn;Vitesse du vent moyen 10 mn;Humidité;Pression station;Variation de pression en 24 heures;Précipitations dans les 24 dernières heures;Coordonnees;Température (°C);Température minimale sur 24 heures (°C);Température maximale sur 24 heures (°C);Altitude;communes (code)"

typedef struct data {
    int id_station;
    char date[30];
    float date_float;
    int hour;
    int wind_direction;
    float wind_speed;
    int moisture;
    int pressure;
    float lat;
    float lon;
    float temp;
    int height;
} Data;

// Define a structure for an AVL tree node
typedef struct node {
    Data data; // The data stored in the node
    int height; // The height of the node in the tree
    struct node *left; // Pointer to the left child of the node
    struct node *right; // Pointer to the right child of the node
}Node;

typedef enum sort_by { ID = 1, DATE, HEIGHT, MOISTURE, HOUR} sort_by;
typedef enum sort_type { AVL = 1, ABR, TAB} sort_type;
typedef enum sort_order { ASCENDING = 0, DESCENDING = 1} sort_order;

typedef Node* (*insertMode)(Node*, Data, float, enum sort_by);
typedef void (*displayMode)(FILE*, Node*);

typedef struct CsvHandle_ *CsvHandle;

typedef struct options{
    char *input_name;
    char *output_name;
    displayMode sort_order;
    insertMode sort_type;
    sort_by sort_col;
}Options;

/* Prototypes of tree.c functions */
float getSortData(Data packet, enum sort_by sort_by);
void displayLine(FILE* file, Node* node);
void ascending_order(FILE* file, Node* root);
void descending_order(FILE* file, Node* root);
void displayFile(char* filename, Node* root, displayMode display);
Node* readFile(const char* filename, Node* root, insertMode add, enum sort_by sort_by);
Node* createNode(Data newData);

/* Prototypes of avl.c functions */
int getHeight(Node* node);
int getBalanceFactor(Node* node);
Node* rotateRight(Node* node);
Node* rotateLeft(Node* node);
Node* insertNodeAVL(Node* root, Data packet, float data, sort_by sort_by);

/* Prototypes of abr.c functions */
Node *insertNodeABR(Node *root, Data packet, float data, sort_by sort_by);

/* Prototypes of tab.c functions */
Node* insertNodeTAB(Node* root, Data packet, float data, sort_by sort_by);

/* Prototype of date.c functions */
float convertDateToFloat(char *date_string);
int getHour(char *date_string);

/* Prototypes of options.c functions */
sort_by defineSortColumn(char *arg);
displayMode defineDisplayMode(char *arg);
Options getOptions(int argc, char *argv[]);

/* Prototype of csv.c functions */
CsvHandle CsvOpen(const char* filename);
CsvHandle CsvOpen2(const char* filename, char delim, char quote, char escape);
void CsvClose(CsvHandle handle);
char* CsvReadNextRow(CsvHandle handle);
const char* CsvReadNextCol(char* row, CsvHandle handle);
