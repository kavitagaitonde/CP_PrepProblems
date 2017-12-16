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

@property (assign, nonatomic) NSUInteger val;
@property (strong) TreeNode *left;
@property (strong) TreeNode *right;

- (id) initWithData:(NSUInteger)data;
@end

@interface TreesAndHeaps : NSObject

+ (NSMutableArray *) inorderTraversalIterative:(TreeNode *) A;
+ (NSMutableArray *) preorderTraversalIterative:(TreeNode *) A;
+ (NSMutableArray *) dNums:(NSMutableArray *) A :(NSInteger) B;

@end
