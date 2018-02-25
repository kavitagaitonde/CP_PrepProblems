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

- (id) initWithData:(NSInteger)val{
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


@implementation LRUNode

- (id)initWithData:(NSInteger)key :(NSInteger)val{
    self = [super init];
    if (self)
    {
        self.key = key;
        self.val = val;
        self.prev = nil;
        self.next = nil;
    }
    return self;
}

@end

//LRU cache. Design and implement a data structure for Least Recently Used (LRU) cache. It should support the following operations: get and set.
//get(key) - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return -1.
//set(key, value) - Set or insert the value if the key is not already present. When the cache reaches its capacity, it should invalidate the least recently used item before inserting the new item.
//The LRUCache will be initialized with an integer corresponding to its capacity. Capacity indicates the maximum number of unique keys it can hold at a time.
@interface LRUCache ()

@property (assign, nonatomic) NSUInteger capacity;
//cache of LRUNodes
@property (strong, nonatomic) NSMutableDictionary *cache;
@property (strong, nonatomic) LRUNode *queue;
@property (strong, nonatomic) LRUNode *queueEnd;
@end


@implementation LRUCache

- (id)init:(NSInteger)capacity  {
    self = [super init];
    if (self)
    {
        _capacity = capacity;
        _cache = [NSMutableDictionary dictionaryWithCapacity:capacity];
        _queue = nil;
        _queueEnd = nil;
        NSLog(@"LRUCache capacity: %ld", _capacity);
    }
    return self;
}

- (NSInteger)get:(NSInteger)key {
    LRUNode *node = [_cache objectForKey:@(key)];
    if (node) {
        if (node != _queue) {
            //remove node from doubly linked list
            LRUNode *prevNode = node.prev;
            node.prev = nil;
            prevNode.next = node.next;
            if (node.next == nil) { //last node
                _queueEnd = prevNode;
            } else {
                node.next.prev = prevNode;
                node.next = nil;
            }
            //put this node to the start of doubly linked list
            node.next = _queue;
            _queue.prev = node;
            _queue = node;
        }
        NSLog(@"LRUCache get cache for key: %ld, value: %ld", key, node.val);
        return (node.val);
    } else {
        NSLog(@"LRUCache get cache for key: %ld, value: -1", key);
        return -1;
    }
}

- (void)set:(NSInteger) key :(NSInteger) value {
    if (!_queue) {
        NSLog(@"LRUCache initializing cache with key: %ld, value: %ld", key, value);
        _queue = [[LRUNode alloc] initWithData:key :value];
        _queueEnd = _queue;
        [_cache setObject:_queue forKey:@(key)];
    } else {
        if ([_cache count] == _capacity) {
            NSLog(@"LRUCache max cache ...");
            //remove last node from doublylinked list
            LRUNode *last = _queueEnd;
            _queueEnd = _queueEnd.prev;
            _queueEnd.next = nil;
            //remove from dictionary
            NSLog(@"LRUCache removing cache key: %ld, value: %ld", last.key, last.val);
            [_cache removeObjectForKey:@(last.key)];
        }
        NSLog(@"LRUCache add to cache with key: %ld, value: %ld", key, value);
        //add new value
        LRUNode *node = [[LRUNode alloc] initWithData:key :value];
        node.next = _queue;
        _queue.prev = node;
        _queue = node;
        [_cache setObject:_queue forKey:@(key)];
    }
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

// Distinct numbers in a window. You are given an array of N integers, A1, A2 ,…, AN and an integer K. Return the count of distinct numbers in all windows of size K.
+ (NSMutableArray *) dNums:(NSMutableArray *) A :(NSInteger) B  {
    if (A == nil || [A count] == 0 || [A count] < B) {
        return [NSMutableArray array];
    }
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *arr = [NSMutableArray array];
    NSInteger numsCount = 0;
    //prepare hashmap with first B elements
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

//Merge K Sorted Lists. Merge k sorted linked lists or arrays in this case and return it as one sorted list.
+ (NSArray*) mergeKSortedLists:(NSMutableArray *) A {
    NSMutableArray *output = [NSMutableArray array];
    NSMutableArray *minHeap = [NSMutableArray array];
    NSInteger minIndex = 0;
    BOOL done = NO;
    while (!done) {
        NSInteger i = 0;
        while (i < [A count]) {
            NSMutableArray *a = [A objectAtIndex:i];
            if ([a count] > 0) {
                NSInteger val = [[a objectAtIndex:0] intValue];
                [self addToMinHeap:minHeap val:val];
                [a removeObjectAtIndex:0];
                if ([[minHeap objectAtIndex:0] intValue] == val) {
                    minIndex = i;
                }
                i++;
            } else {
                //remove empty list
                [A removeObjectAtIndex:i];
            }
        }
        if (i == 0) {
            done = YES;
        }
        //remove the min element from heap and put in the output array
        if (done) {
            while ([minHeap count] > 0) {
                [output addObject:[minHeap objectAtIndex:0]];
                [self removeFromMinHeap:minHeap];
            }
            break;
        } else {
            [output addObject:[minHeap objectAtIndex:0]];
            [self removeFromMinHeap:minHeap];
        }
    }
    return output;
}

+ (void) addToMinHeap:(NSMutableArray *)minHeap val:(NSInteger)val {
    [minHeap addObject:@(val)];
    //heapify : child = 2n, 2n+1 and parent = n/2
    NSInteger index = [minHeap count];
    while (index > 1) {
        NSInteger parentIndex = index/2;
        NSInteger parent = [[minHeap objectAtIndex:parentIndex-1] intValue];
        if (parent > val) {
            //swap
            [minHeap replaceObjectAtIndex:index-1 withObject:@(parent)];
            [minHeap replaceObjectAtIndex:parentIndex-1 withObject:@(val)];
            val = [[minHeap objectAtIndex:parentIndex-1] intValue];
            index = parentIndex;
        } else {
            break;
        }
    }
}

+ (void) removeFromMinHeap:(NSMutableArray *)minHeap {
    NSInteger lastVal = [[minHeap objectAtIndex:[minHeap count]-1] intValue];
    [minHeap removeLastObject];
    [minHeap replaceObjectAtIndex:0 withObject:@(lastVal)];
    NSInteger index = 0;
    while (index < [minHeap count]) {
        NSInteger leftChildIndex = 2*(index+1);
        NSInteger rightChildIndex = 2*(index+2);
        NSInteger currVal = [[minHeap objectAtIndex:index] intValue];
        if (leftChildIndex < [minHeap count] && currVal > [[minHeap objectAtIndex:leftChildIndex-1] intValue]) {
            //swap with left child
            [minHeap replaceObjectAtIndex:index-1 withObject:[minHeap objectAtIndex:leftChildIndex-1]];
            [minHeap replaceObjectAtIndex:leftChildIndex-1 withObject:@(currVal)];
        } else if (rightChildIndex < [minHeap count] && currVal > [[minHeap objectAtIndex:rightChildIndex-1] intValue]) {
            //swap with right child
            [minHeap replaceObjectAtIndex:index-1 withObject:[minHeap objectAtIndex:rightChildIndex-1]];
            [minHeap replaceObjectAtIndex:rightChildIndex-1 withObject:@(currVal)];
        } else {
            return;
        }
    }
}


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
