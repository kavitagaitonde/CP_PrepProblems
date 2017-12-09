//
//  ListNode.h
//  IBProblems
//
//  Created by Kavita Gaitonde on 11/18/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListNode : NSObject

@property (assign, nonatomic) NSUInteger data;
@property (strong) ListNode *next;

- (id) initWithData:(NSUInteger)data;
+ (id) initWithArray:(NSArray*)array;
- (NSString *)toString;

@end
