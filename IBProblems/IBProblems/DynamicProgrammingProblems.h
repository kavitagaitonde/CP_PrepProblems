//
//  DynamicProgrammingProblems.h
//  IBProblems
//
//  Created by Kavita Gaitonde on 1/27/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DynamicProgrammingProblems : NSObject

+ (NSInteger) climbStairs:(NSInteger) A;
+ (NSInteger) minPathSum:(NSMutableArray *) A;
+ (NSInteger) uniquePathsWithObstacles:(NSMutableArray *) A;
+ (NSInteger) longestIncreasingSubsequence:(NSArray *) A;

@end
