#include "../../includes/sort.h"

/*-----------------------------------------
               AVL functions
-----------------------------------------*/

// Function to find the height of an AVL tree node
int getHeight(Node* node) {
    // If the node is NULL, return 0
    if (node == NULL) {
        return 0;
    }
    else {
        // Return the height of the node
        return node->height;
    }
}

// Function to find the balance factor of an AVL tree node
int getBalanceFactor(Node* node) {
    // If the node is NULL, return 0
    if (node == NULL) {
        return 0;
    }
    else {
        // Return the balance factor of the node
        return getHeight(node->left) - getHeight(node->right);
    }
}

// Function to perform a right rotation on an AVL tree
Node* rotateRight(Node* node) {
    // Perform the rotation
    Node* temp = node->left;
    node->left = temp->right;
    temp->right = node;
    
    // Update the heights of the nodes
    node->height = 1 + fmaxf(getHeight(node->left), getHeight(node->right));
    temp->height = 1 + fmaxf(getHeight(temp->left), getHeight(temp->right));
    
    // Return the new root of the subtree
    return temp;
}

// Function to perform a left rotation on an AVL tree
Node* rotateLeft(Node* node) {
    // Perform the rotation
    Node* temp = node->right;
    node->right = temp->left;
    temp->left = node;
    
    // Update the heights of the nodes
    node->height = 1 + fmaxf(getHeight(node->left), getHeight(node->right));
    temp->height = 1 + fmaxf(getHeight(temp->left), getHeight(temp->right));
    
    // Return the new root of the subtree
    return temp;
}

// Function to insert a new node into an AVL tree
Node* insertNodeAVL(Node* root, Data packet, float data, sort_by sort_by) {
    // If the tree is empty, create a new node and return it
    if (root == NULL) {
        return createNode(packet);
    }

    // Gets the data that will be used by the binary tree to compare
    float rootData = getSortData(root->data, sort_by);

    // If the data is less than the data of the root, insert it into the left subtree
    if (data < rootData) {
        root->left = insertNodeAVL(root->left, packet, data, sort_by);
    }
    // If the data is greater than or equal to the data of the root, insert it into the right subtree
    else {
        root->right = insertNodeAVL(root->right, packet, data, sort_by);
    }
    
    // Update the height of the root
    root->height = 1 + fmaxf(getHeight(root->left), getHeight(root->right));
    
    // Find the balance factor of the root
    int balanceFactor = getBalanceFactor(root);
    
    // If the balance factor is greater than 1, the tree is left-heavy
    if (balanceFactor > 1) {
        // If the left child is left-heavy, perform a right rotation
        if (getBalanceFactor(root->left) > 0) {
            return rotateRight(root);
        }
        // If the left child is right-heavy, perform a left-right rotation
        else {
            root->left = rotateLeft(root->left);
            return rotateRight(root);
        }
    }
    // If the balance factor is less than -1, the tree is right-heavy
    else if (balanceFactor < -1) {
        // If the right child is right-heavy, perform a left rotation
        if (getBalanceFactor(root->right) < 0) {
            return rotateLeft(root);
        }
        // If the right child is left-heavy, perform a right-left rotation
        else {
            root->right = rotateRight(root->right);
            return rotateLeft(root);
        }
    }
    // Return the root of the tree
    return root;
}