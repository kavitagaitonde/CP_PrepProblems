//
//  ArraysProblems.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 11/27/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import "ArraysProblems.h"

@implementation ArraysProblems


// Max non negative subarray
-(NSArray *) maxset:(NSMutableArray *) A  {
    NSInteger currNum = 0;
    NSInteger currSum = 0;
    NSInteger startIndex = 0;
    NSInteger maxSum = 0;
    NSInteger maxStartIndex = 0;
    NSInteger maxEndIndex = 0;
    for(NSInteger i=0;i<[A count];i++) {
        currNum = [[A objectAtIndex:i] intValue];
        if (currNum < 0 ) {
            startIndex = i+1;
            currSum = 0;
        } else {
            currSum = currSum + currNum;
            if (maxSum < currSum) {
                maxSum = currSum;
                maxStartIndex = startIndex;
                maxEndIndex = i+1;
            } else if (maxSum == currSum) {
                if (maxEndIndex-maxStartIndex < i+1 - startIndex) {
                    maxStartIndex = startIndex;
                    maxEndIndex = i+1;
                }
            }
        }
    }
    if (maxEndIndex == 0) {
        return nil;
    }
    NSRange range = NSMakeRange(maxStartIndex, maxEndIndex-maxStartIndex);
    return [A subarrayWithRange:range];
}

// Find first duplicate in array

-(NSInteger) repeatedNumber:(NSArray *) A  {
    NSInteger maxNum = 0;
    NSInteger maxCount = -1;
    NSInteger currCount = 0;
    NSInteger currNum = 0;
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    for (NSInteger i=0;i<[A count];i++) {
        currNum = [[A objectAtIndex:i] intValue];
        NSNumber *n = [map objectForKey:@(currNum)];
        if (n == nil) {
            //add n to map
            currCount = 1;
        } else {
            currCount = [n intValue] + 1;
        }
        [map setObject:@(currCount) forKey:@(currNum)];
        
        if (maxCount < currCount) {
            maxCount = currCount;
            maxNum = currNum;
        }
        if (maxCount > 1) {
            return maxNum;
        }
        
    }
    NSLog(@"Max number = %ld, max count = %ld", maxNum, maxCount);
    if (maxCount == 1) { //no duplicates
        return -1;
    } else {
        return maxNum;
    }
}

@end
