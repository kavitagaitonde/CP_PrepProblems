//
//  LinkedListsProblems.h
//  IBProblems
//
//  Created by Kavita Gaitonde on 12/4/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListNode.h"

@interface LinkedListsProblems : NSObject

+ (ListNode *) addTwoNumbers:(ListNode *) a :(ListNode *) b;
+ (ListNode *) reverseBetween:(ListNode *) A :(NSInteger) B :(NSInteger) C;
+(ListNode *) reverseList:(ListNode *) A tillCount:(NSInteger) B;

@end
