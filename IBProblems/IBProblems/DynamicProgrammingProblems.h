//
//  DynamicProgrammingProblems.h
//  IBProblems
//
//  Created by Kavita Gaitonde on 1/27/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreesAndHeaps.h"

@interface DynamicProgrammingProblems : NSObject

+ (NSInteger) climbStairs:(NSInteger) A;
+ (NSInteger) minPathSum:(NSMutableArray *) A;
+ (NSInteger) uniquePathsWithObstacles:(NSMutableArray *) A;
+ (NSInteger) longestIncreasingSubsequence:(NSArray *) A;
+ (NSInteger) maxProduct:(NSArray *) A;
+ (NSInteger) maxPathSum:(TreeNode *) A;
+ (NSInteger) maxProfit:(NSArray *) A;
+ (NSInteger) minSumPathTriangle:(NSArray*)A;
+ (NSInteger) longestSubsequenceLength:(NSArray *) A;

@end
