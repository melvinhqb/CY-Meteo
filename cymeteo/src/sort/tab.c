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
    if (root == NULL || getSortData(root->data, sort_by) >= data) {
        new->left = root;
        root = new;
    }
    else {
        p1 = root;
        // Loop as long as the value of the link is smaller than the new nod
        while (p1->left != NULL && getSortData(p1->left->data, sort_by) < data) {
            p1 = p1->left;
        }
        new->left = p1->left;
        p1->left = new;
    }
    
    // Return the root of the tab
    return root;
}