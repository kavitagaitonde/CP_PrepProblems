//
//  TreesAndHeaps.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 12/12/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import "TreesAndHeaps.h"

@implementation TreeNode

- (id) initWithData:(NSUInteger)val{
    self = [super init];
    if (self)
    {
        self.val = val;
        self.left = nil;
        self.right = nil;
    }
    return self;
}
@end


@implementation TreesAndHeaps

+ (NSMutableArray *) inorderTraversalIterative:(TreeNode *) A  {
    NSMutableArray * arr = [NSMutableArray array];
    NSMutableArray * stack = [NSMutableArray array];
    TreeNode *node = A;
    BOOL shouldContinue = YES;
    while (shouldContinue) {
        if (node != nil) {
            //push
            [stack addObject:node];
            node = node.left;
        } else {
            //pop
            if ([stack count] > 0) {
                node = [stack lastObject];
                [stack removeLastObject];
                NSLog(@"Added - %ld", node.val);
                [arr addObject:@(node.val)];
                node = node.right;
            } else {
                shouldContinue = NO;
            }
        }
    }
    return arr;
}

+ (NSMutableArray *) preorderTraversalIterative:(TreeNode *) A  {
    NSMutableArray * arr = [NSMutableArray array];
    NSMutableArray * stack = [NSMutableArray array];
    TreeNode *node = A;
    BOOL shouldContinue = YES;
    while (shouldContinue) {
        if (node != nil) {
            //push
            [arr addObject:@(node.val)];
            [stack addObject:node];
            node = node.left;
        } else {
            //pop
            if ([stack count] > 0) {
                node = [stack lastObject];
                [stack removeLastObject];
                node = node.right;
            } else {
                shouldContinue = NO;
            }
        }
    }
    return arr;
}


+ (NSMutableArray *) dNums:(NSMutableArray *) A :(NSInteger) B  {
    if (A == nil || [A count] == 0 || [A count] < B) {
        return @[];
    }
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *arr = [NSMutableArray array];
    NSInteger numsCount = 0;
    //prepare hasmap with first B elements
    for (NSInteger i=0;i<B;i++){
        NSNumber *val = [dict objectForKey:[A objectAtIndex:i]];
        if (val != nil) {
            [dict setObject:@([val intValue]+1) forKey:[A objectAtIndex:i]];
        } else {
            [dict setObject:@(1) forKey:[A objectAtIndex:i]];
            numsCount++;
        }
    }
    [arr addObject:@(numsCount)];
    if ([A count] == B) {
        return arr;
    }
    
    //sliding window for total elements - first B
    for (NSInteger i=B;i<[A count];i++){
        NSNumber *curr = [A objectAtIndex:i];
        NSNumber *first = [A objectAtIndex:i-B];
        NSInteger firstCount = [[dict objectForKey:first] intValue];
        //remove first element in the previous window
        if (firstCount > 1) {
            [dict setObject:@(firstCount-1) forKey:first];
        } else {
            [dict removeObjectForKey:first];
            numsCount--;
        }
        
        //add last element of current window
        NSNumber *val = [dict objectForKey:curr];
        if (val != nil) {
            [dict setObject:@([val intValue]+1) forKey:curr];
        } else {
            [dict setObject:@(1) forKey:curr];
            numsCount++;
        }
        
        [arr addObject:@(numsCount)];
    }
    
    return arr;
}

/*+ (ListNode*) mergeKSortedLists:(NSMutableArray *) A {
    NSMutableArray *minHeap = [NSMutableArray array];
    while () {
        NSInteger i = 0;
        while (i < [A count]) {
            ListNode *node = [A objectAtIndex:i];
            [self addToMinHeap:minHeap node:node];
            if (node.next != nil) {
                [A replaceObjectAtIndex:i withObject:node.next];
                i++;
            } else {
                [A removeObjectAtIndex:i];
            }
        }
    }
}

+ (void) addToMinHeap:(NSMutableArray *)minHeap node:(ListNode*)node {
    [minHeap addObject:node];
    //heapify : child = 2n, 2n+1 and parent = n/2
    NSInteger index = [minHeap count];
    while (index > 1) {
        NSInteger parentIndex = index/2;
        ListNode *parent = [minHeap objectAtIndex:parentIndex-1];
        if (parent.data > node.data) {
            //swap
            [minHeap replaceObjectAtIndex:index-1 withObject:parent];
            [minHeap replaceObjectAtIndex:parentIndex-1 withObject:node];
            node = [minHeap objectAtIndex:parentIndex-1];
            index = parentIndex;
        } else {
            break;
        }
    }
}*/

+ (TreeNode*) getNextSuccessor:(TreeNode*)node successorOf:(NSInteger)successorOf {
    if (node == nil) {
        return nil;
    }
    
    TreeNode *sNode = nil;
    while (node != nil) {
        if (node.val > successorOf) {
            sNode = node;
            node = node.left;
        } else {
            node = node.right;
        }
    }
    
    return sNode;
}

//Given a binary tree, determine if it is height-balanced.
-(NSInteger) isBalanced:(TreeNode *) A  {
    
    if ( A == nil) {
        return 0;
    }
    
    NSInteger height = [self depth:A];
    if (height > 0) {
        return 1;
    } else {
        return 0;
    }
}

-(NSInteger) depth:(TreeNode *) A  {
    
    if ( A == nil) {
        return 0;
    }
    
    NSInteger leftHeight = 0;
    NSInteger rightHeight = 0;
    if (A.left != nil) {
        leftHeight = [self depth:A.left];
        if (leftHeight == 0) {
            return 0;
        }
    }
    if (A.right != nil) {
        rightHeight = [self depth:A.right];
        if (rightHeight == 0) {
            return 0;
        }
    }
    
    
    if (ABS(leftHeight - rightHeight) > 1) {
        return 0;
    } else {
        if (leftHeight > rightHeight) {
            return leftHeight+1;
        } else {
            return rightHeight+1;
        }
    }
}

//Given two binary trees, write a function to check if they are equal or not.
-(BOOL) isSameTree:(TreeNode *) A B:(TreeNode *) B  {
    if (A == nil && B == nil) {
        return YES;
    } else if ((A == nil && B != nil) || (A != nil && B == nil)) {
        return NO;
    }
    
    if (A.val == B.val) {
        return [self isSameTree:A.left B:B.left] && [self isSameTree:A.right B:B.right];
    } else {
        return NO;
    }
    
}

@end
