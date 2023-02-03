#include "../../includes/sort.h"

/*-----------------------------------------
               TAB functions
-----------------------------------------*/

// Function to insert a new node into a TAB
Node* insertNodeTAB(Node* root, Data packet, float data, sort_by sort_by) {
    // Create a new node and a temporary node
    Node* new = createNode(packet);
    Node* p1 = NULL;

    // If root is NULL or the value of the new node is less than the value of the first chainon
    if (root == NULL || getSortData(root->data, sort_by) > data) {
        new->right = root;
        root = new;
    }
    else {
        p1 = root;
        // Loop as long as the value of the current node is smaller equal the new node
        while (p1->right != NULL && getSortData(p1->right->data, sort_by) <= data) {
            p1 = p1->right;
        }
        new->right = p1->right;
        p1->right = new;
    }
    
    // Return the root of the tab
    return root;
}