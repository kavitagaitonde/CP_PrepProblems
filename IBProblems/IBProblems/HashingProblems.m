//
//  HashingProblems.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 12/3/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import "HashingProblems.h"

@implementation HashingProblems

// 2sum -- Given an array of integers, find two numbers such that they add up to a specific target number.
+ (NSMutableArray *) twoSum:(NSArray *) A :(NSInteger) B  {
    NSMutableArray *newA = [NSMutableArray array];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSInteger num = 0;
    NSInteger num1 = 0;
    if (A == nil || [A count] == 0) {
        return newA;
    }
    NSInteger index1 = [A count];
    NSInteger index2 = [A count];
    
    for(NSInteger i=0;i<[A count];i++) {
        //NSLog(@"Adding num = %ld at index = %ld", [[A objectAtIndex:i] intValue], i);
        NSMutableArray *arr = [dict objectForKey:[A objectAtIndex:i]];
        if (arr == nil) {
            arr = [NSMutableArray array];
        }
        [arr addObject:@(i)];
        [dict setObject:arr forKey:[A objectAtIndex:i]];
    }
    for(NSInteger i=0;i<[A count];i++) {
        num = [[A objectAtIndex:i] intValue];
        num1 = B - num;
        //NSLog(@"num = %ld, num1 = %ld", num, num1);
        NSMutableArray *arr = [dict objectForKey:@(num1)];
        if (arr != nil) {
            NSInteger j=0;
            NSInteger index=0;
            while (j<[arr count]) {
                //NSLog(@"j = %ld, arrcount = %ld", j, [arr count]);
                index = [[arr objectAtIndex:j] intValue];
                //NSLog(@"j = %ld, index = %ld", j, index);
                if (index > i) {
                    NSInteger ind = index;
                    //NSLog(@"index1=%ld, index2=%ld, i = %ld, ind = %ld", index1, index2, i, ind);
                    if (index2>ind || (index2 == ind && index1 > i)) {
                        index1 = i;
                        index2 = ind;
                    }
                }
                j++;
            }
        }
    }
    if (index1 < [A count] && index2 < [A count]) {
        [newA addObject:@(index1+1)];
        [newA addObject:@(index2+1)];
    }
    return newA;
}

// Diff K  -- Given an array of integers, find two numbers such that the difference is a specific target number K and i > j
+ (BOOL) twoDiff:(NSArray *) A :(NSInteger) B  {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSInteger num = 0;
    NSInteger num1 = 0;
    if (A == nil || [A count] == 0) {
        return NO;
    }
    
    for(NSInteger i=0;i<[A count];i++) {
        //NSLog(@"Adding num = %ld at index = %ld", [[A objectAtIndex:i] intValue], i);
        NSMutableArray *arr = [dict objectForKey:[A objectAtIndex:i]];
        if (arr == nil) {
            arr = [NSMutableArray array];
        }
        [arr addObject:@(i)];
        [dict setObject:arr forKey:[A objectAtIndex:i]];
    }
    
    for(NSInteger i=0;i<[A count];i++) {
        num = [[A objectAtIndex:i] intValue];
        num1 = num - B;
        NSLog(@"num = %ld, num1 = %ld", num, num1);
        NSMutableArray *arr = [dict objectForKey:@(num1)];
        if (arr != nil) {
            NSInteger j=0;
            NSInteger index=0;
            while (j<[arr count]) {
                //NSLog(@"j = %ld, arrcount = %ld", j, [arr count]);
                index = [[arr objectAtIndex:j] intValue];
                //NSLog(@"j = %ld, index = %ld", j, index);
                if (index != i) {
                    NSLog(@"i = %ld, index = %ld", i, index);
                    return YES;
                }
                j++;
            }
        }
    }
    return NO;
}


@end
