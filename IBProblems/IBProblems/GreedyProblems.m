//
//  GreedyProblems.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 2/28/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import "GreedyProblems.h"

@implementation GreedyProblems

//Highest Product - Given an array of integers, return the highest product possible by multiplying 3 numbers from the array
+ (NSInteger)maxp3:(NSArray *) A  {
    if (A == nil || [A count] < 3) {
        return -1;
    }
    NSMutableArray *heapArray;
    if ( [A count] > 3 ) {
        heapArray = [self buildHeapFor:A];
        
    } else {
        heapArray = A;
    }
    NSLog(@"heapArray = %@", heapArray);
    NSInteger multiple = 1;
    for (NSInteger i=0;i<3;i++) {
        multiple*=[self removeMaxFromHeap:heapArray];
    }
    return multiple;
}

+ (NSMutableArray*)buildHeapFor:(NSArray *)A {
    NSMutableArray *heapArray = [NSMutableArray arrayWithCapacity:[A count]];
    for (NSInteger i=0;i<[A count];i++) {
        [heapArray addObject:[A objectAtIndex:i]];
        [self heapify:heapArray];
        NSLog(@"heapified heapArray = %@", heapArray);
    }
    return heapArray;
}

+ (void)heapify:(NSMutableArray *)heap {
    NSInteger index = [heap count];
    NSInteger parentIndex = index / 2;
    while (index > 1) {
        NSInteger childVal = [[heap objectAtIndex:index-1] intValue];
        NSInteger parentVal = [[heap objectAtIndex:parentIndex-1] intValue];
        NSLog(@"heapified childVal = %ld, parentVal = %ld", childVal, parentVal);
        if (childVal > parentVal) { //swap
            [heap replaceObjectAtIndex:index-1 withObject:@(parentVal)];
            [heap replaceObjectAtIndex:parentIndex-1 withObject:@(childVal)];
            index = parentIndex;
            parentIndex = index / 2;
        } else {
            return;
        }
    }
}

+ (NSInteger) removeMaxFromHeap:(NSMutableArray *)heap {
    NSInteger max = [[heap objectAtIndex:0] intValue];
    [heap replaceObjectAtIndex:0 withObject:[heap objectAtIndex:[heap count]-1]];
    [heap removeLastObject];
    //heapify
    NSInteger index = 1;
    NSInteger leftIndex = index*2;
    NSInteger rightIndex = index*2+1;
    while (index < [heap count]) {
        if (leftIndex > [heap count]) {
            break;
        }
        if (rightIndex > [heap count]) {
            rightIndex = leftIndex;
        }
        NSInteger currVal = [[heap objectAtIndex:index-1] intValue];
        NSInteger leftVal = [[heap objectAtIndex:leftIndex-1] intValue];
        NSInteger rightVal = [[heap objectAtIndex:rightIndex-1] intValue];
        
        
        if (currVal > leftVal && currVal > rightVal) {
            break;
        }
        NSInteger swapIndex = leftIndex;
        if (leftVal < rightVal) {
            swapIndex = rightIndex;
        }
        //swap
        NSInteger swapVal = [[heap objectAtIndex:swapIndex-1] intValue];
        [heap replaceObjectAtIndex:index-1 withObject:@(swapVal)];
        [heap replaceObjectAtIndex:swapIndex-1 withObject:@(currVal)];
        index = swapIndex;
        leftIndex = index*2;
        
        rightIndex = index*2+1;
        
    }
    return max;
}

//Majority Element - Given an array of size n, find the majority element. The majority element is the element that appears more than floor(n/2) times.
+ (NSInteger)majorityElement:(NSArray *) A  {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSInteger  div = [A count]/2 ;
    /*if(([A count]%2) != 0) { //odd
     div++;
	    } */
    NSInteger maxCount = 0;
    NSInteger maxNum = 0;
    for (NSInteger i=0;i<[A count];i++) {
        NSNumber *num = [A objectAtIndex:i];
        NSNumber *value = [dict objectForKey:num];
        if (value) {
            value = @([value intValue]+1);
            [dict setObject:value forKey:num];
        }else{
            value = @(1);
            [dict setObject:value forKey:num];
        }
        if ([value intValue] > div && maxCount < [value intValue]) {
            maxCount = [value intValue];
            maxNum = [num intValue];
        }
    }
    return maxNum;
}

@end
