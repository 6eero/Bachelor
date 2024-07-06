#include <stdio.h>
#include <stdlib.h>

struct node {
	int data;
	struct node *left;
	struct node *right;
};

/* newNode() allocates a new node with the given data and NULL left and right pointers. */
struct node *newNode(int data) {
	struct node *node = malloc(sizeof(struct node));  // Allocate memory for new node
	node->data = data;  // Assign data to this node
	node->left = NULL;  // Initialize left and...
	node->right = NULL; // ...right children as NULL
	return (node);
}

int main() {
	/*create root*/
	struct node* root = newNode(1);
/*
		 1
		/ \
	   N   N
*/

	root->left = newNode(2);
	root->right = newNode(3);
/* 2 and 3 become left and right children of 1
			1
		   / \
		  2	  3
	    /  \ /  \
       N   N N   N
*/

	root->left->left = newNode(4);
/* 4 becomes left child of 2
			1
		   / \
		  2	  3
	    /  \ /  \
       4   N N   N
	  / \
     N   N
*/

	getchar();
	return 0;
}
