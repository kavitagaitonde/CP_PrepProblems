//
//  StackAndQueuesProblems.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 1/10/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import "StackAndQueuesProblems.h"

@implementation StackAndQueuesProblems

//Evaluate the value of an arithmetic expression in Reverse Polish Notation.
//Valid operators are +, -, *, /. Each operand may be an integer or another expression.
//["2", "1", "+", "3", "*"] -> ((2 + 1) * 3) -> 9
//["4", "13", "5", "/", "+"] -> (4 + (13 / 5)) -> 6
+(NSInteger) evalRPN:(NSArray *) A  {
    
    if (A == nil || [A count] == 0) {
        return 0;
    }
    NSMutableArray *stack = [NSMutableArray array];
    NSString *val;
    NSInteger lhs, rhs, i = 0;
    NSInteger sum = 0;
    while (i < [A count]) {
        val = [A objectAtIndex:i];
        if ([val isEqualToString:@"+"]) {
            rhs = [[stack lastObject] intValue];
            [stack removeLastObject];
            lhs = [[stack lastObject] intValue];
            [stack removeLastObject];
            sum = lhs + rhs;
            [stack addObject:@(sum)];
        } else if ([val isEqualToString:@"-"]) {
            rhs = [[stack lastObject] intValue];
            [stack removeLastObject];
            lhs = [[stack lastObject] intValue];
            [stack removeLastObject];
            sum = lhs - rhs;
            [stack addObject:@(sum)];
        } else if ([val isEqualToString:@"/"]) {
            rhs = [[stack lastObject] intValue];
            [stack removeLastObject];
            lhs = [[stack lastObject] intValue];
            [stack removeLastObject];
            sum = lhs / rhs;
            [stack addObject:@(sum)];
        } else if ([val isEqualToString:@"*"]) {
            rhs = [[stack lastObject] intValue];
            [stack removeLastObject];
            lhs = [[stack lastObject] intValue];
            [stack removeLastObject];
            sum = lhs * rhs;
            [stack addObject:@(sum)];
        } else {
            [stack addObject:val];
        }
        i++;
    }
    return [[stack lastObject] intValue];
}

@end
