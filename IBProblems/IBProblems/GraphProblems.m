//
//  GraphProblems.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 1/20/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import "GraphProblems.h"

@implementation GraphNode

- (id) initWithData:(NSUInteger)val{
    self = [super init];
    if (self)
    {
        self.val = val;
        self.neighbors = [NSMutableArray array];
        self.visited = NO;
    }
    return self;
}

- (void) addNeighbor:(GraphNode*)node {
    [self.neighbors addObject:node];
}

- (id) copyWithZone:(NSZone *)zone {
    GraphNode *node = [[[self class] allocWithZone:zone] init];
    node.val = self.val;
    node.neighbors = self.neighbors;
    return node;
}

- (BOOL) isEqual:(id)object {
    if ([object isMemberOfClass:[GraphNode class]]) {
        if (self.val == ((GraphNode*)object).val) {
            return YES;
        }
    }
    return NO;
}

@end

@implementation GraphProblems

+ (GraphNode*) cloneGraph:(GraphNode*)node {
    return [self cloneGraphBFS:node vertices:[NSMutableDictionary dictionary]];
    
}

+ (GraphNode*) cloneGraphBFS:(GraphNode*)node vertices:(NSMutableDictionary*)vertices {
    if (node == nil) {
        return nil;
    }
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:node];
    GraphNode *startNode ;//= [[GraphNode alloc]initWithData:[node val]];
    //[vertices setObject:startNode forKey:node];
    
    while([queue count] > 0) {
        GraphNode *g = [queue objectAtIndex:0];
        NSLog(@"cloneGraphBFS:processing %ld", [g val]);
        [queue removeObjectAtIndex:0];
        
        //check if node is already cloned
        GraphNode *currNode = [vertices objectForKey:@([g val])];
        if(currNode == nil) {
            //doesn't exist
            currNode = [[GraphNode alloc]initWithData:[g val]];
            [vertices setObject:currNode forKey:@([g val])];
            NSLog(@"cloneGraphBFS:created %ld", [currNode val]);
            if (startNode == nil) {
                startNode = currNode;
            }
        }
        
        NSInteger index = 0;
        while (index < [[g neighbors] count]) {
            GraphNode *n = [[g neighbors] objectAtIndex:index];
            
            //check if node is already cloned
            GraphNode *c = [vertices objectForKey:@([n val])];
            if(c == nil) {
                //doesn't exist
                c = [[GraphNode alloc]initWithData:[n val]];
                [vertices setObject:c forKey:@([n val])];
                [queue addObject:n];
                NSLog(@"cloneGraphBFS:created neighbor %ld", [c val]);
            }
            [currNode addNeighbor:c];
            index++;
        }
    }    
    return startNode;
}

+ (void) bfsTraversal:(GraphNode*)node {
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:node];
    node.visited = YES;
    //NSLog(@"%ld", [node val]);
    while([queue count] > 0) {
        GraphNode *g = [queue objectAtIndex:0];
        NSLog(@"\t%ld", [g val]);
        [queue removeObjectAtIndex:0];
        NSInteger index = 0;
        while (index < [[g neighbors] count]) {
            GraphNode *n = [[g neighbors] objectAtIndex:index];
            if (!n.visited) {
                [queue addObject:n];
                n.visited = YES;
            }
            index++;
        }
    }
}

+ (NSInteger) diameter:(GraphNode*)node {
    if (node == nil) {
        return 0;
    }
    
    NSInteger index = 0;
    NSInteger maxD1 = 0, maxD2 = 0;
    while (index < [[node neighbors] count]) {
        GraphNode *n = [[node neighbors] objectAtIndex:index];
        NSInteger depth = [self depth:n];
        if (depth > maxD1) {
            maxD2 = maxD1;
            maxD1 = depth;
        } else if (depth > maxD2) {
            maxD2 = depth;
        }
        index++;
    }
    
    NSInteger maxDCurr = maxD1 + maxD2 + 1;
    
    index = 0;
    NSInteger maxD = 0;
    while (index < [[node neighbors] count]) {
        GraphNode *n = [[node neighbors] objectAtIndex:index];
        NSInteger d = [self diameter:n];
        maxD = MAX (maxD, d);
    }
    
    return MAX(maxDCurr, maxD);
    
}

+ (NSInteger) depth:(GraphNode*)node {
    if (node == nil) {
        return 0;
    }
    
    NSInteger maxD = 0;
    NSInteger index = 0;
    while (index < [[node neighbors] count]) {
        GraphNode *n = [[node neighbors] objectAtIndex:index];
        NSInteger d = [self depth:n];
        maxD = MAX (maxD, d);
    }
    return maxD + 1;
}

+ (NSInteger) largestDistance:(NSMutableArray *) A  {
    
    NSMutableArray *graphArray = [NSMutableArray array];
    for (NSInteger i=0;i<[A count] ; i++) {
        [graphArray addObject:[NSMutableArray array]];
    }
    //build child nodes
    for (NSInteger i=0;i<[A count] ; i++) {
        NSInteger n = [[A objectAtIndex:i] intValue];
        if (n == -1) {
            //skip its root
        } else {
            NSMutableArray *arr = [graphArray objectAtIndex:n];
            [arr addObject:@(i)];
            [graphArray replaceObjectAtIndex:n withObject:arr];
        }
    }
    NSLog(@"graphArray = %@", graphArray);
    return [self largestDistance:0 fromArray:graphArray];
}

+ (NSInteger) largestDistance:(NSInteger)node fromArray:(NSMutableArray*)arr {
    NSMutableArray *currNode = [arr objectAtIndex:node];
    if (currNode == nil || [currNode count] == 0) {
        return 0;
    }
    NSLog(@"largestDistance for node (%ld)", node);
    NSInteger index = 0;
    NSInteger maxD1 = 0, maxD2 = 0;
    while (index < [currNode count]) {
        NSInteger n = [[currNode objectAtIndex:index]intValue];
        NSInteger depth = [self depth:n fromArray:arr];
        if (depth > maxD1) {
            maxD2 = maxD1;
            maxD1 = depth;
        } else if (depth > maxD2) {
            maxD2 = depth;
        }
        index++;
    }
    NSLog(@"maxD1 = %ld, maxD2 = %ld", maxD1, maxD2);
    NSInteger maxDCurr = maxD1 + maxD2;
    NSLog(@"max diameter for current node (%ld) = %ld", node, maxDCurr);
    index = 0;
    NSInteger maxD = 0;
    while (index < [currNode count]) {
        NSInteger n = [[currNode objectAtIndex:index] intValue];
        NSInteger d = [self largestDistance:n fromArray:arr];
        maxD = MAX (maxD, d);
        index++;
    }
    NSLog(@"maxDiameter for node(%ld) = %ld", node, MAX(maxDCurr, maxD));
    return MAX(maxDCurr, maxD);
    
}

+ (NSInteger) depth:(NSInteger)node fromArray:(NSMutableArray*)arr {
    NSMutableArray *currNode = [arr objectAtIndex:node];
    if (currNode == nil) {
        return 0;
    }
    /*if ([currNode count] == 0) {
        NSLog(@"maxDepth for node(%ld) = 0", node);
        return 0;
    }*/
    
    NSInteger maxD = 0;
    NSInteger index = 0;
    while (index < [currNode count]) {
        NSInteger n = [[currNode objectAtIndex:index] intValue];
        NSInteger d = [self depth:n fromArray:arr];
        maxD = MAX (maxD, d);
        index++;
    }
    NSLog(@"maxDepth for node(%ld) = %ld", node, maxD+1);
    return maxD + 1;
    
}

+ (NSInteger) canFinishCourseWithPrerequisites:(NSInteger) A :(NSArray *) B :(NSArray *) C  {
    NSMutableArray *courses = [NSMutableArray array];
    NSMutableArray *dependents = [NSMutableArray array];
    //initialize
    for (NSInteger i=0;i<A+1;i++) {
        [courses addObject:@(0)];
        [dependents addObject:[NSMutableArray array]];
    }
    
    //keep track of the dependencies for each course.
    for (NSInteger i=0;i<[B count];i++) {
        NSInteger cindex = [[C objectAtIndex:i] intValue];
        NSInteger cvalue = [[courses objectAtIndex:cindex] intValue];
        [courses replaceObjectAtIndex:cindex withObject:@(cvalue+1)];
        
        NSInteger bindex = [[B objectAtIndex:i] intValue];
        NSMutableArray *arr = [dependents objectAtIndex:bindex];
        [arr addObject:[C objectAtIndex:i]];
        [dependents replaceObjectAtIndex:bindex withObject:arr];
    }
    
    //go thru each vertex and reduce the depenencies by 1
    for (NSInteger i=1;i<[courses count];i++) {
        NSInteger j;
        for (j=1;j<[courses count];j++) {
            NSInteger numOfCourses = [[courses objectAtIndex:j]intValue];
            if (numOfCourses == 0) {
                //found one with no dep
                break;
            }
        }
        if (j == [courses count]) {
            //there is a loop
            return 0;
        }
        [courses replaceObjectAtIndex:j withObject:@(-1)];
        //reduce the dependency
        NSMutableArray *deps = [dependents objectAtIndex:j] ;
        NSLog(@"course %ld has dependents = %@", j, deps);
        
        for (j=0;j<[deps count];j++) {
            NSInteger cindex = [[deps objectAtIndex:j] intValue] ;
            NSInteger cvalue = [[courses objectAtIndex:cindex] intValue];
            [courses replaceObjectAtIndex:cindex withObject:@(cvalue-1)];
        }
    }
    return 1;
}

@end
