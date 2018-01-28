//
//  DynamicProgrammingProblems.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 1/27/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import "DynamicProgrammingProblems.h"

@implementation DynamicProgrammingProblems

//Return the number of ways to climb A stairs if you can climb it 1 or 2 stairs at a time
+(NSInteger) climbStairs:(NSInteger) A  {
    if ( A <= 1) {
        return 1;
    }
    return [self climbStairs:A-1] + [self climbStairs:A-2];
}

+ (NSInteger) minPathSum:(NSMutableArray *) A  {
    
    NSMutableArray *memo = [NSMutableArray array];
    for (NSInteger i=0;i<[A count];i++) {
        NSMutableArray *memoRow = [NSMutableArray array];
        /*NSMutableArray *row = [A objectAtindex:i];
	        for (NSInteger j=0;j<[row count];j++) {
         [memoRow addObject:@(-1)];
	        }*/
        [memo addObject:memoRow];
    }
    return [self calculateMinPathSum:A row:0 col:0 memo:memo];
}

+ (NSInteger) calculateMinPathSum:(NSMutableArray *) A row:(NSInteger)row col:(NSInteger)col memo:(NSMutableArray*)memo {
    //NSLog(@"row = %ld, col = %ld", row, col);
    if (row >= [A count]) {
        return INT_MAX;
    }
    if (col >= [[A objectAtIndex:row] count]) {
        return INT_MAX;
    }
    //check if memo contains the value
    NSInteger memoVal;
    NSMutableArray *memoRow = [memo objectAtIndex:row];
    if ([memoRow count] > 0) {
        NSInteger memoVal = [[memoRow objectAtIndex:col] intValue];
        if (memoVal != -1) {
            //NSLog(@"Found memo = %ld", memoVal);
            return memoVal;
        }
    } else {
        //NSMutableArray *r = [A objectAtindex:row];
        for (NSInteger j=0;j<[[A objectAtIndex:row] count];j++) {
            [memoRow addObject:@(-1)];
        }
        [memo replaceObjectAtIndex:row withObject:memoRow];
    }
    
    NSInteger right = [self calculateMinPathSum:A row:row col:col+1 memo:memo];
    //NSLog(@"right = %ld", right);
    NSInteger bottom = [self calculateMinPathSum:A row:row+1 col:col memo:memo];
    //NSLog(@"bottom = %ld", bottom);
    NSInteger min = MIN(right, bottom);
    if (min == INT_MAX) {
        min = 0;
    }
    //compute
    memoVal =  min + [[[A objectAtIndex:row] objectAtIndex:col] intValue];
    //update memo
    [memoRow replaceObjectAtIndex:col withObject:@(memoVal)];
    return memoVal;
}

+ (NSInteger) uniquePathsWithObstacles:(NSMutableArray *) A  {
    NSMutableArray *memo = [NSMutableArray array];
    for (NSInteger i=0;i<[A count];i++) {
        NSMutableArray *memoRow = [NSMutableArray array];
        [memo addObject:memoRow];
    }
    return [self calculateUniquePaths:A row:0 col:0 memo:memo];
}

+ (NSInteger) calculateUniquePaths:(NSMutableArray *) A row:(NSInteger)row col:(NSInteger)col memo:(NSMutableArray*)memo{
    //NSLog(@"row = %ld, col = %ld", row, col);
    if (row >= [A count]) {
        return 0;
    }
    if (col >= [[A objectAtIndex:row] count]) {
        return 0;
    }
    NSInteger memoVal;
    NSMutableArray *memoRow = [memo objectAtIndex:row];
    //check if memo contains the value
    if ([memoRow count] > 0) {
        NSInteger memoVal = [[memoRow objectAtIndex:col] intValue];
        if (memoVal != -1) {
            //NSLog(@"Found memo = %ld", memoVal);
            return memoVal;
        }
    } else {
        //NSMutableArray *r = [A objectAtindex:row];
        for (NSInteger j=0;j<[[A objectAtIndex:row] count];j++) {
            [memoRow addObject:@(-1)];
        }
        [memo replaceObjectAtIndex:row withObject:memoRow];
    }
    
    if ([[[A objectAtIndex:row] objectAtIndex:col] intValue] == 1) {
        memoVal = 0;
    } else {
        //check if this is the end element
        if (row == [A count]-1 && col == [[A objectAtIndex:row] count]-1) {
            memoVal = 1;
        } else {
            NSInteger right = [self calculateUniquePaths:A row:row col:col+1 memo:memo];
            //NSLog(@"right = %ld", right);
            NSInteger bottom = [self calculateUniquePaths:A row:row+1 col:col memo:memo];
            //NSLog(@"bottom = %ld", bottom);
            //compute
            memoVal =  right + bottom;
        }
    }
    //update memo
    [memoRow replaceObjectAtIndex:col withObject:@(memoVal)];
    
    return memoVal;
}

+(NSInteger) longestIncreasingSubsequence:(NSArray *) A  {
    NSMutableArray *memo = [NSMutableArray array];
    for(NSInteger i=0;i<[A count];i++) {
        [memo addObject:@(-1)];
    }
    NSInteger m = 0;
    for(NSInteger i=0;i<[A count];i++) {
        m = MAX(m, [self longestSubsequence:A index:i memo:memo]);
        //NSLog(@"max for A[%ld]=%ld, is %ld", i, [[A objectAtIndex:i] intValue], m);
    }
    return m;//[m intValue];
}

+(NSInteger) longestSubsequence:(NSArray *)A index:(NSInteger)index memo:(NSMutableArray*)memo {
    if (index == [A count]) {
        return 0;
    }
    NSInteger memoVal = 0;
    /*if ([[memo objectAtIndex:index] intValue] != -1) {
     return [[memo objectAtIndex:index] intValue];
	    }*/
    //compute
    NSInteger i = 0, max = 0;
    for(i=0;i<index;i++) {
        if ([[A objectAtIndex:i] intValue] < [[A objectAtIndex:index] intValue]) {
            max = MAX(max, [[memo objectAtIndex:i] intValue]);
        }
    }
    if (i == index) {
        memoVal = max + 1;
    }
    [memo replaceObjectAtIndex:index withObject:@(memoVal)];
    return memoVal;
}

@end
