//
//  BinarySearchProblems.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 12/11/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import "BinarySearchProblems.h"

@implementation BinarySearchProblems

+ (NSInteger) findSqrtOf:(NSInteger) B {
    if (B == 0 || B ==1) {
        return B;
    }
    
    NSInteger s = 1;
    NSInteger e = B;
    NSInteger ret = 0;
    while (s <= e) {
        NSInteger m = (s + e) / 2;
        
        if (m*m > B) {
            e = m - 1;
        } else if (m*m < B) {
            s = m + 1;
            ret = m;
        } else {
            ret = m;
            break;
        }
        
    }
    return ret;
}

@end
