//
//  BitManipulationProblems.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 1/9/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import "BitManipulationProblems.h"

@implementation BitManipulationProblems

+ (NSInteger) countOf1BitsIn:(NSUInteger)a {
    NSInteger size = sizeof(a);
    NSInteger count = 0;
    for(NSInteger i=0;i<size;i++) {
        if ((a & 1) > 0) {
            count++;
        }
        a = a >> 1;
    }
    return count;
}

+ (NSInteger) singleNumber:(NSArray *) A  {
    if (A == nil || [A count] == 0) {
        return 0;
    }
    NSInteger num = 0;
    for (NSInteger i=0;i<[A count];i++) {
        num = num ^ [[A objectAtIndex:i] intValue];
    }
    return num;
}

+ (NSInteger) reverseBits:(NSUInteger) a  {
    NSInteger size = sizeof(a)*4;
    NSInteger output = 0;
    NSInteger x;
    NSLog(@"size = %ld", size);
    for(NSInteger i=0;i<size;i++) {
        NSLog(@"i = %ld", i);
        x = (a & (1 << i ));
        if (x > 0) {
            output = output | (1 << ((size-1)-i));
        }
    }
    return output;
}

@end
