//
//  GraphProblems.h
//  IBProblems
//
//  Created by Kavita Gaitonde on 1/20/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GraphNode : NSObject <NSCopying>

@property (assign, nonatomic) NSUInteger val;
@property (assign, nonatomic) BOOL visited;
@property (strong) NSMutableArray *neighbors;

- (id) initWithData:(NSUInteger)data;
- (void) addNeighbor:(GraphNode*)node;

@end

@interface GraphProblems : NSObject

+ (GraphNode*) cloneGraph:(GraphNode*)node;
+ (void) bfsTraversal:(GraphNode*)node;
+ (NSInteger) diameter:(GraphNode*)node;
+ (NSInteger) depth:(GraphNode*)node;
+ (NSInteger) largestDistance:(NSMutableArray *) A;
+ (NSInteger) canFinishCourseWithPrerequisites:(NSInteger) A :(NSArray *) B :(NSArray *) C;
+ (NSInteger) costForLibrary:(NSArray*)cityArray roads:(NSInteger)roads cities:(NSInteger)cities libCost:(NSInteger)libCost roadCost:(NSInteger)roadCost;
+ (NSInteger) journeyToTheMoon:(NSArray*)array astronauts:(NSInteger)n;
+ (NSMutableArray*) captureRegionsOnBoard:(NSMutableArray *) array;
+ (BOOL) doesWordExist:(NSMutableArray*)array word:(NSString*)word;
+(NSInteger) countBlackShapes:(NSMutableArray *) array;

@end
