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
+ (NSArray *) maxset:(NSMutableArray *) A  {
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

+ (NSInteger) repeatedNumber:(NSArray *) A  {
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

// Deleting duplicates from a array

+ (NSInteger) deleteDuplicatesFromSortedArray:(NSMutableArray *) A  {
    if (A == nil || [A count] == 0) {
        return 0;
    }
    NSInteger i = 1;
    NSInteger count = 1;
    NSInteger num = 0;
    NSInteger swapIndex = 1;
    NSInteger prevNum = [[A objectAtIndex:0] intValue];
    while (i < [A count]) {
        num = [[A objectAtIndex:i] intValue];
        if (num != prevNum) {
            count++;
            [A replaceObjectAtIndex:swapIndex++ withObject:@(num)];
            prevNum = num;
        }
        i++;
    }
    return count;
}

// Enumerate all primes numbers till the given number

/*+ (NSArray*) enumeratePrimes:(NSInteger) n  {
    
    if (n < 2) {
        return @[];
    }
    
    
    NSMutableArray *primes = [NSMutableArray array];
    for(NSInteger i=0;i<n;i++) {
        [primes insertObject:@(NO) atIndex:i];
    }
    NSInteger x=3;
    for(NSInteger i=2;i<=n;i++) {
        
        for(NSInteger j=x*i;j<=n;j++) {
            if([[primes objectAtIndex:j] boolValue] == YES) {
                
            }
        }
    }
    
    while (i < [A count]) {
        num = [[A objectAtIndex:i] intValue];
        if (num != prevNum) {
            count++;
            [A replaceObjectAtIndex:swapIndex++ withObject:@(num)];
            prevNum = num;
        }
        i++;
    }
    return count;
}*/

// Max contiguous subarray
+ (NSInteger) maxSubArray:(NSArray *) A  {
    
    if (A == nil || [A count] == 0) {
        return 0;
    }
    
    NSInteger i = 1;
    NSInteger num = [[A objectAtIndex:0] intValue];
    NSInteger maxSum = num;
    NSInteger sum = num;
    while (i<[A count]) {
        num = [[A objectAtIndex:i] intValue];
        sum = MAX(sum+num, num);
        maxSum = MAX(maxSum, sum);
        i++;
    }
    return maxSum;
}


@end
