//
//  LinkedListsProblems.h
//  IBProblems
//
//  Created by Kavita Gaitonde on 12/4/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListNode : NSObject
@property (nonatomic, assign) NSInteger val;
@property (nonatomic, strong) ListNode* next;
@end

@interface LinkedListsProblems : NSObject

+ (ListNode *) addTwoNumbers:(ListNode *) a :(ListNode *) b;

@end
