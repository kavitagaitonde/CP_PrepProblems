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

@end
