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

//Clone an undirected graph. Each node in the graph contains a label and a list of its neighbors.
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

// BFS traversal
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

// Largest Distance between nodes of a Tree
//The goal of the problem is to find largest distance between two nodes in a tree. Distance between two nodes is a number of edges on a path between the nodes (there will be a unique path between any pair of nodes since it is a tree)
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

// Given the total number of courses and a list of prerequisite pairs, is it possible for you to finish all courses. return 1/0 if it is possible/not possible.
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

//2 dimensional array. Index of main array will be a city. Value of each index will be an
//array of nodes that it is connected to.
//[ [1,2], //0
//    [0,2], //1
//    [0,1]  //2
//  ]
// cost of graph = (cost of Vi + cost of Ei-Ei+1)
+ (NSInteger) costForLibrary:(NSArray*)cityArray roads:(NSInteger)roads cities:(NSInteger)cities libCost:(NSInteger)libCost roadCost:(NSInteger)roadCost {
    if (roadCost >= libCost) {
        NSLog(@"Library per city...");
        return libCost*cities;
    }
    
    //means we build 1 library in each connected set of cities. The total cost will be sum of (1 library + n roads) in each component)
    NSInteger sum = 0;
    NSMutableArray *visited = [NSMutableArray array];
    NSInteger i;
    for (i=0;i<[cityArray count];i++) {
        [visited addObject:@(0)];
    }
    
    for (i=0;i<[cityArray count];i++) {
        if ([[visited objectAtIndex:i] intValue] == 1) {
            //already visited, skip it
            continue;
        }
        [visited replaceObjectAtIndex:i withObject:@(1)];
        sum = sum + libCost + [self dfs:cityArray city:i roadCost:roadCost visited:visited];
        
    }
    return sum;
}

+(NSInteger) dfs:(NSArray*)cityArray city:(NSInteger)city roadCost:(NSInteger)roadCost visited:(NSMutableArray*)visited{
    NSArray *cityNeighbors = [cityArray objectAtIndex:city];
    NSInteger sum = 0, i, neighbor;
    for (i=0;i<[cityNeighbors count];i++) {
        neighbor = [[cityNeighbors objectAtIndex:i]intValue];
        if ([[visited objectAtIndex:neighbor] intValue] == 1) {
            //already visited, skip it
            continue;
        }
        [visited replaceObjectAtIndex:neighbor withObject:@(1)];
        sum = sum + roadCost + [self dfs:cityArray city:neighbor roadCost:roadCost visited:visited];
    }
    return sum;
}

+(NSInteger) journeyToTheMoon:(NSArray*)array astronauts:(NSInteger)n {
    NSInteger i, j;
    NSMutableArray *neighborSets = [NSMutableArray array];
    //setup neighbors
    for (i=0;i<[array count];i++) {
        NSArray *a = [array objectAtIndex:i];
        for (j=0;j<[neighborSets count];j++) {
            NSMutableSet *set = [neighborSets objectAtIndex:j];
            if ([set containsObject:[a objectAtIndex:0]]) {
                [set addObject:[a objectAtIndex:1]];
                break;
            } else if ([set containsObject:[a objectAtIndex:1]]) {
                [set addObject:[a objectAtIndex:1]];
                break;
            }
        }
        if (j == [neighborSets count]) {
            //create new set and add
            NSMutableSet *set = [NSMutableSet set];
            [set addObjectsFromArray:a];
            [neighborSets addObject:set];
        }
    }
    NSInteger result = 0, sum = 0;
    for (i=0;i<[neighborSets count];i++) {
        NSMutableSet *set = [neighborSets objectAtIndex:i];
        result += sum*[set count];
        sum += [set count];
    }
    return result;
}

+ (NSMutableArray*) captureRegionsOnBoard:(NSMutableArray *) array {
    NSInteger i, j;
    
    //replace all O's to -
    for (i=0;i<[array count];i++) {
        NSMutableArray *row = [array objectAtIndex:i];
        for (j=0;j<[array count];j++) {
            if ([[row objectAtIndex:j] isEqualToString:@"O"]) {
                [row replaceObjectAtIndex:j withObject:@"-"];
            }
        }
    }
    
    //replace all -'s on the edges to O
    for(i=0;i<[array count];i++) {
        [self dfsRegionReplace:0 col:i array:array prevStr:@"-" newStr:@"O"];
    }
    for(i=0;i<[array count];i++) {
        [self dfsRegionReplace:[array count]-1 col:i array:array prevStr:@"-" newStr:@"O"];
    }
    for(i=0;i<[array count];i++) {
        [self dfsRegionReplace:i col:0 array:array prevStr:@"-" newStr:@"O"];
    }
    for(i=0;i<[array count];i++) {
        [self dfsRegionReplace:i col:[array count]-1 array:array prevStr:@"-" newStr:@"O"];
    }
    
    //replace all remaining -'s to X
    for (i=0;i<[array count];i++) {
        NSMutableArray *row = [array objectAtIndex:i];
        for (NSInteger j=0;j<[array count];j++) {
            if ([[row objectAtIndex:j] isEqualToString:@"-"]) {
                [row replaceObjectAtIndex:j withObject:@"X"];
            }
        }
    }
    
    return array;
}

+ (void) dfsRegionReplace:(NSInteger)row col:(NSInteger)col array:(NSMutableArray*)array prevStr:(NSString*)prevStr newStr:(NSString*)newStr{
    if (row < 0 || row >= [array count] || col <0 || col >= [array count]) {
        return;
    }
    
    NSMutableArray *rowArray = [array objectAtIndex:row];
    if (![[rowArray objectAtIndex:col] isEqualToString:prevStr]) {
        return;
    }
    
    [rowArray replaceObjectAtIndex:col withObject:newStr];
    
    [self dfsRegionReplace:row-1 col:col array:array prevStr:prevStr newStr:newStr];
    [self dfsRegionReplace:row+1 col:col array:array prevStr:prevStr newStr:newStr];
    [self dfsRegionReplace:row col:col-1 array:array prevStr:prevStr newStr:newStr];
    [self dfsRegionReplace:row col:col+1 array:array prevStr:prevStr newStr:newStr];
    
}

+ (BOOL) doesWordExist:(NSMutableArray*)array word:(NSString*)word {
    for (NSInteger i=0;i<[array count];i++) {
        NSString *rowStr = [array objectAtIndex:i];
        for (NSInteger j=0;j<[rowStr length];j++) {
            if ([self wordSearch:i col:j array:array word:word wordIndex:0]) {
                return YES;
            }
        }
    }
    return NO;
}

+ (BOOL) wordSearch:(NSInteger)row col:(NSInteger)col array:(NSMutableArray*)array word:(NSString*)word wordIndex:(NSInteger)wordIndex{
    if (wordIndex == [word length]) {
        return YES;
    }
    if (row < 0 || row >= [array count] || col <0 ) {
        return NO;
    }
    NSString *rowStr = [array objectAtIndex:row];
    if (col >= [rowStr length]) {
        return NO;
    }
    
    if ([rowStr characterAtIndex:col] != [word characterAtIndex:wordIndex]) {
        return NO;
    }
    //found match, look for next match
    return ([self wordSearch:row-1 col:col array:array word:word wordIndex:wordIndex+1] ||
            [self wordSearch:row+1 col:col array:array word:word wordIndex:wordIndex+1] ||
            [self wordSearch:row col:col-1 array:array word:word wordIndex:wordIndex+1] ||
            [self wordSearch:row col:col+1 array:array word:word wordIndex:wordIndex+1]);
    
}

+(NSInteger) countBlackShapes:(NSMutableArray *) array  {
    NSInteger count = 0;
    for (NSInteger i=0;i<[array count];i++) {
        NSMutableArray *rowArray = [array objectAtIndex:i];
        for (NSInteger j=0;j<[rowArray count];j++) {
            count+=[self adjacentBlackShapes:i col:j array:array];
        }
    }
    return count;
}

+ (NSInteger) adjacentBlackShapes:(NSInteger)row col:(NSInteger)col array:(NSMutableArray*)array {
    if (row < 0 || row >= [array count] || col <0 ) {
        return 0;
    }
    NSMutableArray *rowArray = [array objectAtIndex:row];
    if (col >= [rowArray count]) {
        return 0;
    }
    if (![[rowArray objectAtIndex:col] isEqualToString:@"X"]) {
        return 0;
    }
    
    //found match, look for adjacent match
    [rowArray replaceObjectAtIndex:col withObject:@"-"];
    [self adjacentBlackShapes:row-1 col:col array:array];
    [self adjacentBlackShapes:row+1 col:col array:array];
    [self adjacentBlackShapes:row col:col-1 array:array];
    [self adjacentBlackShapes:row col:col+1 array:array];
    return 1;
    
}

//HR problem: Get the groups
+ (NSArray *) getTheGroups:(NSNumber *)n queryType:(NSArray *)queryType students1:(NSArray *)students1 students2:(NSArray *)students2 {
    NSMutableArray *retArray = [NSMutableArray array];
    NSMutableDictionary *groups = [NSMutableDictionary dictionary];
    //first handle all FRIEND queries
    for(NSInteger i=0;i<[queryType count];i++) {
        if ([[queryType objectAtIndex:i] isEqualToString:@"Friend"]) {
            NSNumber *s1 = [students1 objectAtIndex:i] ;
            NSNumber *s2 = [students2 objectAtIndex:i] ;
            //make friends.
            NSMutableSet *set1 = [groups objectForKey:s1];
            if (set1 == nil) {
                set1 = [NSMutableSet set];
            }
            [set1 addObject:s2];
            
            NSMutableSet *set2 = [groups objectForKey:s2];
            if (set2 == nil) {
                set2 = [NSMutableSet set];
            }
            [set2 addObject:s1];
            [set1 unionSet:set2];
            [set2 unionSet:set1];
            [groups setObject:set1 forKey:s1];
            [groups setObject:set2 forKey:s2];
        }
    }
    NSLog(@"groups = %@", groups);
    
    //compute TOTAL queries
    for(NSInteger i=0;i<[queryType count];i++) {
        if ([[queryType objectAtIndex:i] isEqualToString:@"Total"]) {
            NSNumber *s1 = [students1 objectAtIndex:i] ;
            NSNumber *s2 = [students2 objectAtIndex:i] ;
            //make friends.
            NSInteger count = 0;
            BOOL sameSet = NO;
            NSMutableSet *set1 = [groups objectForKey:s1];
            if (set1 == nil) {
                count = 1;
            } else {
                if ([set1 containsObject:s2]) {
                    sameSet = YES;
                }
                count = [set1 count];
            }
            
            if (sameSet) {
                [retArray addObject:@(count)];
                continue;
            }
            //diff sets
            NSMutableSet *set2 = [groups objectForKey:s2];
            if (set2 == nil) {
                count += 1;
            } else {
                count += [set2 count];
            }
            [retArray addObject:@(count)];
        }
    }
    return retArray;
}

@end
