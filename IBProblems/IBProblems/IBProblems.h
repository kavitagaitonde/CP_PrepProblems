//
//  IBProblems.h
//  IBProblems
//
//  Created by Kavita Gaitonde on 11/18/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListNode.h"

@interface IBProblems : NSObject

+ (NSMutableArray *) concentric2DPrint:(NSInteger) A;
+ (NSInteger) kthsmallest:(NSArray *) A B:(NSInteger) B;
+ (NSInteger) numRange:(NSMutableArray *) A B:(NSInteger) B C:(NSInteger) C;
+ (NSMutableArray *) nextGreater:(NSMutableArray *) A;
+ (ListNode *) subtract:(ListNode *) A;
+ (NSInteger) longestConsecutive:(NSArray *)A;
+ (void) getUniquePermutations:(NSMutableArray *)A result:(NSMutableArray *)result set:(NSMutableSet *)set start:(NSInteger)start end:(NSInteger)end;

@end
