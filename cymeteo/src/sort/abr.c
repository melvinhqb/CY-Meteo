#include "../../includes/sort.h"

/*-----------------------------------------
               ABR functions
-----------------------------------------*/

// Function to insert a new node into an ABR tree
Node *insertNodeABR(Node *root, Data packet, float data, sort_by sort_by) {
    // If the tree is empty, create a new node and return it
    if (root == NULL) {
        return createNode(packet);
    }

    // Gets the data that will be used by the binary tree to compare
    float rootData = getSortData(root->data, sort_by);

    // If the data is less than the data of the root, insert it into the left subtree
    if(data < rootData) {
        root->left = insertNodeABR(root->left, packet, data, sort_by);
    }
    // If the data is greater than or equal to the data of the root, insert it into the right subtree
    else {
        root->right = insertNodeABR(root->right, packet, data, sort_by);
    }

    // Return the root of the tree
    return root;
}