//
//  TreesAndHeaps.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 12/12/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import "TreesAndHeaps.h"
#import "ListNode.h"

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
        return [NSMutableArray array];
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

+ (NSMutableArray *) levelOrder:(TreeNode *) A  {
    NSMutableArray *output = [NSMutableArray array];
    //[self levelOrderTraversalDFS:A level:1 output:output];
    NSMutableArray *queue = [NSMutableArray array];
    if (A != nil) {
        [queue addObject:A];
    }
    [self levelOrderTraversalBFS:queue level:1 output:output];
    return output;
}

+ (void) levelOrderTraversalDFS:(TreeNode *) A  level:(NSInteger)level output:(NSMutableArray*)output {
    if (A == nil) {
        return;
    }
    
    if([output count] < level) {
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:A];
        [output addObject:arr];
    }else {
        NSMutableArray *arr = [output objectAtIndex:level-1];
        [arr addObject:A];
        [output replaceObjectAtIndex:level-1 withObject:arr];
    }
    
    if (A.left != nil) {
        [self levelOrderTraversalDFS:A.left level:level+1 output:output];
    }
    if (A.right != nil) {
        [self levelOrderTraversalDFS:A.right level:level+1 output:output];
    }
}

+(void) levelOrderTraversalBFS:(NSMutableArray*)queue  level:(NSInteger)level output:(NSMutableArray*)output {
    NSMutableArray *newQueue = [NSMutableArray array];
    NSMutableArray *levelNodes = [NSMutableArray array];
    while ([queue count] > 0) {
        TreeNode *node = [queue objectAtIndex:0];
        [queue removeObjectAtIndex:0];
        [levelNodes addObject:node];
        if (node.left != nil) {
            [newQueue addObject:node.left];
        }
        if (node.right != nil) {
            [newQueue addObject:node.right];
        }
    }
    if ([levelNodes count] > 0) {
        [output addObject:levelNodes];
    }
    if ([newQueue count] > 0) {
        queue = newQueue;
        [self levelOrderTraversalBFS:queue level:level+1 output:output];
    }
}

+ (NSInteger) diameter:(TreeNode*)node {
    if (node == nil) {
        return 0;
    }
    
    NSInteger leftHeight = [self height:node.left];
    NSInteger rightHeight = [self height:node.right];
    NSInteger currD = leftHeight + rightHeight + 1;
    
    NSInteger leftD = [self diameter:node.left];
    NSInteger rightD = [self diameter:node.right];
    NSInteger maxDChild = MAX(leftD, rightD);
    
    return MAX(currD, maxDChild);

}

+ (NSInteger) height:(TreeNode*)node {
    if (node == nil) {
        return 0;
    }
    
    NSInteger leftHeight = [self height:node.left];
    NSInteger rightHeight = [self height:node.right];
   
    return MAX(leftHeight, rightHeight) + 1;
    
}

+ (TreeNode*) convertSortedListToBST:(ListNode*)list {
    if (list == nil) {
        return nil;
    }
    NSInteger count = 0;
    ListNode* start = list;
    while (list != nil) {
        list = list.next;
        count++;
    }
    list = start;
    ListNode* prev = list;
    NSInteger i = 0;
    while (i < (count/2)) {
        prev = list;
        list = list.next;
        i++;
    }
    prev.next = nil;
    TreeNode *root = [[TreeNode alloc] initWithData:list.data];
    if (count == 1) {
        return root;
    }
    ListNode* left = start;
    ListNode* right = list.next;
    root.left = [self convertSortedListToBST:left];
    root.right = [self convertSortedListToBST:right];
    return root;
}

@end
