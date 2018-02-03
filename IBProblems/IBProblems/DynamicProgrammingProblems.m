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


//Find the contiguous subarray within an array (containing at least one number) which has the largest product.
//Return an integer corresponding to the maximum product possible.
+ (NSInteger) maxProduct:(NSArray *) A  {
    if ([A count] == 0) {
        return 0;
    }
    NSInteger currProduct = [[A objectAtIndex:0] intValue];
    NSInteger maxProduct = currProduct;
    NSInteger currVal = 0;
    for(NSInteger i=1;i<[A count];i++) {
        currVal = [[A objectAtIndex:i] intValue];
        currProduct = MAX(currVal, currProduct*currVal);
        maxProduct = MAX( maxProduct, currProduct);
    }
    return maxProduct;
}

+ (NSInteger) maxPathSum:(TreeNode *) A  {
    if (A == nil) {
        return 0;
    }
    return [self computeMaxPathSum:(TreeNode *) A  max:@(0)];
}

+ (NSInteger) computeMaxPathSum:(TreeNode *) A  max:(NSNumber*)max{
    if (A == nil) {
        return 0;
    }
    NSInteger left = [self computeMaxPathSum:A.left  max:max];
    NSInteger right = [self computeMaxPathSum:A.right  max:max];
    NSInteger oneChildMax = MAX(MAX(left, right) + A.val, A.val);
    NSInteger totalMax = MAX(oneChildMax, left+right+A.val);
    NSLog(@"left=%ld, right=%ld, oneChild=%ld, total=%ld, max=%d", left, right, oneChildMax, totalMax, [max intValue]);
    max = @(MAX(totalMax, [max intValue]));
    return oneChildMax;
}

+ (NSInteger) maxProfit:(NSArray *) A  {
    if ([A count] <2) {
        return 0;
    }
    NSInteger buyValue = [[A objectAtIndex:0] intValue];
    NSInteger maxProfit = 0;
    NSInteger currProfit = 0;
    for (NSInteger i=1;i<[A count];i++) {
        if(buyValue > [[A objectAtIndex:i] intValue]) {
            buyValue = [[A objectAtIndex:i] intValue];
        }
        currProfit = [[A objectAtIndex:i] intValue] - buyValue;
        if(currProfit > maxProfit) {
            maxProfit = currProfit;
        }
    }
    return maxProfit;
}

//Min Sum Path Triange: Given a triangle, find the minimum path sum from top to bottom. Each step you may move to adjacent numbers on the row below.
+ (NSInteger) minSumPathTriangle:(NSArray*)A {
    //Length of each row in A is one greater than the previous one
    //use the bottom up approach.
    NSArray *arr = nil;
    for (NSInteger i=[A count]-1;i>=0;i--) {
        arr = [self minSumPathForRow:[A objectAtIndex:i] minPathSum:arr];
    }
    return [[arr objectAtIndex:0] intValue];
    
}

+ (NSArray*) minSumPathForRow:(NSArray*)rowA minPathSum:(NSArray*)minPathSum{
    NSMutableArray *array = [NSMutableArray array];
    //process each element in row to find the min path sum of each element
    for (NSInteger i=0;i<[rowA count];i++) {
        if (minPathSum == nil || [minPathSum count] < [rowA count]) {
            [array addObject:[rowA objectAtIndex:i]];
        } else {
            NSInteger min = MIN([[minPathSum objectAtIndex:i] intValue], [[minPathSum objectAtIndex:i+1] intValue]);
            [array addObject:@(min+[[rowA objectAtIndex:i] intValue])];
        }
    }
    return array;
}

//Length of Longest Subsequence - Given an array of integers, find the length of longest subsequence which is first increasing then decreasing.
+ (NSInteger) longestSubsequenceLength:(NSArray *) A  {
    NSMutableArray *inc = [NSMutableArray arrayWithCapacity:[A count]];
    NSMutableArray *dec = [NSMutableArray arrayWithCapacity:[A count]];
    NSInteger targetVal = 0, currVal = 0;
    for(NSInteger i=0;i<[A count];i++) {
        [inc addObject:@(1)];
        [dec addObject:@(1)];
    }
    
    //increasing
    for(NSInteger i=1;i<[A count];i++) {
        targetVal = [[A objectAtIndex:i] intValue];
        for(NSInteger j=0;j<i;j++) {
            currVal = [[A objectAtIndex:j] intValue];
            if (currVal < targetVal && [[inc objectAtIndex:i]intValue] < [[inc objectAtIndex:j]intValue]+1) {
                [inc replaceObjectAtIndex:i withObject:@([[inc objectAtIndex:j]intValue]+1)];
            }
        }
    }
    //decreasing
    for(NSInteger i=[A count]-2;i>=0;i--) {
        targetVal = [[A objectAtIndex:i] intValue];
        for(NSInteger j=[A count]-1;j>i;j--) {
            currVal = [[A objectAtIndex:j] intValue];
            if (currVal < targetVal && [[dec objectAtIndex:i]intValue] < [[dec objectAtIndex:j]intValue]+1) {
                [dec replaceObjectAtIndex:i withObject:@([[dec objectAtIndex:j]intValue]+1)];
            }
        }
    }
    //NSLog(@"inc = %@", inc);
    //NSLog(@"dec = %@", dec);
    //max
    NSInteger max = 0, currMax = 0;
    for(NSInteger i=0;i<[A count];i++) {
        currMax = [[inc objectAtIndex:i]intValue] + [[dec objectAtIndex:i]intValue] -1;
        max = MAX(currMax, max);
    }
    
    return max;
    
}

/*
//2Xn matrix
+(NSInteger) maxSumWithoutAdjacentElements:(NSArray *)A {
    
}

+(NSInteger) findMax:(NSArray *)A row:(NSInteger)row col:(NSInteger)col max:(NSInteger)max{
    
}
*/

@end
