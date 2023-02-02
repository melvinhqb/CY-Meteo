#include "../../includes/sort.h"

// Function that returns the value to be sorted in the 'Data' structure
float getSortData(Data packet, enum sort_by sort_by) {
    switch (sort_by) {
        case ID:
            return packet.id_station;
        case DATE:
            return packet.date_float;
        case HOUR:
            return packet.hour;
        case HEIGHT:
            return packet.height;
        case MOISTURE:
            return packet.moisture;
        default:
            exit(1);
    }
}

// Function to display a line of a file
void displayLine(FILE* file, Node* node) {
    Data d = node->data;
    fprintf(file, "%d;", d.id_station);
    fprintf(file, "%s;", d.date);
    fprintf(file, "0;");
    fprintf(file, "%d;", d.wind_direction);
    fprintf(file, "%f;", d.wind_speed);
    fprintf(file, "%d;", d.moisture);
    fprintf(file, "%d;", d.pressure);
    fprintf(file, "0;0;");
    fprintf(file, "%f,", d.lat);
    fprintf(file, "%f;", d.lon);
    fprintf(file, "%f;", d.temp);
    fprintf(file, "0;0;");
    fprintf(file, "%d;", d.height);
    fprintf(file, "0\n");
}

// Function to perform an ascending order traversal of an AVL tree
void ascending_order(FILE* file, Node* root) {
    // If the root is NULL, return
    if (root == NULL) {
        return;
    }
    ascending_order(file, root->left); // Recursively traverse the left subtree
    displayLine(file, root); // Print the data of the root
    ascending_order(file, root->right); // Recursively traverse the right subtree
}

// Function to perform a descending order traversal of an AVL tree
void descending_order(FILE* file, Node* root) {
    // If the root is NULL, return
    if (root == NULL) {
        return;
    }
    descending_order(file, root->right); // Recursively traverse the right subtree
    displayLine(file, root); // Print the data of the root
    descending_order(file, root->left); // Recursively traverse the left subtree
}

// Function to write the sorted data to a new file
void displayFile(char* filename, Node* root, displayMode display) {
    FILE* file = fopen(filename, "w");
    if(file == NULL) {
        exit(OUTPUT_ERROR);
    }
    fprintf(file, "%s\n", HEAD_TITLES);
    display(file, root);
    fclose(file);
}

// Function that checks that the column read exists
const char* readColumn(char *line, CsvHandle handle) {
    const char *col;

    if ((col = CsvReadNextCol(line, handle)) == NULL) {
        exit(INPUT_ERROR);
    }
    return col;
}

// Function that reads each column of a row
Data readLine(char *line, CsvHandle handle) {
    Data packet;
    const char *col;

    col = readColumn(line, handle);
    packet.id_station = atoi(col);

    col = readColumn(line, handle);
    strcpy(packet.date, col);
    packet.date_float = convertDateToFloat(packet.date);
    packet.hour = getHour(packet.date);

    col = readColumn(line, handle);

    col = readColumn(line, handle);
    packet.wind_direction = atoi(col);

    col = readColumn(line, handle);
    packet.wind_speed = atof(col);

    col = readColumn(line, handle);
    packet.moisture = atoi(col);

    col = readColumn(line, handle);
    packet.pressure = atoi(col);

    col = readColumn(line, handle);
    col = readColumn(line, handle);

    col = readColumn(line, handle);
    sscanf(col, "%f,%f", &packet.lat, &packet.lon);

    col = readColumn(line, handle);
    packet.temp = atof(col);

    col = readColumn(line, handle);
    col = readColumn(line, handle);

    col = readColumn(line, handle);
    packet.height = atoi(col);

    return packet;
}

// Function for the data in the file to be sorted
Node* readFile(const char* filename, Node* root, insertMode add, enum sort_by sort_by) {
    char *row;
    float data;
    Data packet;

    // Use memory-mapped files to open the CSV file
    CsvHandle handle = CsvOpen(filename);

    row = CsvReadNextRow(handle);

    // Checks that the file header is present
    if (strcmp(row, HEAD_TITLES) != 0) {
        exit(INPUT_ERROR);
    }

    // Read each line of the CSV file
    while (row = CsvReadNextRow(handle)) {
        packet = readLine(row, handle); // Gets the useful data of the current line
        data = getSortData(packet, sort_by); // Gets the data to be used to sort the packet
        root = add(root, packet, data, sort_by); // Adds the packet to a binary tree or list
    }

    CsvClose(handle);

    return root;
}


/*-----------------------------------------
          Functions on tree nodes
-----------------------------------------*/

// Function to create a new node
Node* createNode(Data newData) {
    // Allocate memory for the new node
    Node *newNode = malloc(sizeof(Node));

    // Check if there is memory problem
    if(newNode == NULL)
    {
        exit(1);
    }
    
    // Set the data of the new node
    newNode->data = newData;
    
    // Set the height of the new node to 1
    newNode->height = 1;
    
    // Initialize the left and right pointers to NULL
    newNode->left = NULL;
    newNode->right = NULL;
    
    // Return a pointer to the new node
    return newNode;
}