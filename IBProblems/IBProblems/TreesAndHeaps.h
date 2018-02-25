//
//  TreesAndHeaps.h
//  IBProblems
//
//  Created by Kavita Gaitonde on 12/12/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListNode.h"

@interface TreeNode : NSObject

@property (assign, nonatomic) NSInteger val;
@property (strong) TreeNode *left;
@property (strong) TreeNode *right;

- (id)initWithData:(NSInteger)data;
@end

@interface LRUNode : NSObject

@property (assign, nonatomic) NSInteger key;
@property (assign, nonatomic) NSInteger val;
@property (strong) LRUNode *prev;
@property (strong) LRUNode *next;

- (id)initWithData:(NSInteger)key :(NSInteger)val;

@end

@interface LRUCache : NSObject

- (id)init:(NSInteger)capacity;
- (NSInteger)get:(NSInteger)key;
- (void)set:(NSInteger)key :(NSInteger)value;

@end

@interface TreesAndHeaps : NSObject

+ (NSMutableArray *)inorderTraversalIterative:(TreeNode *) A;
+ (NSMutableArray *)preorderTraversalIterative:(TreeNode *) A;
+ (NSMutableArray *)dNums:(NSMutableArray *) A :(NSInteger) B;
+ (NSMutableArray *)levelOrder:(TreeNode *) A;
+ (NSInteger)diameter:(TreeNode*)node;
+ (NSInteger)height:(TreeNode*)node;
+ (TreeNode*)convertSortedListToBST:(ListNode*)list;

@end
