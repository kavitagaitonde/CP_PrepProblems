//
//  ListNode.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 11/18/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import "ListNode.h"

@implementation ListNode

- (id) initWithData:(NSUInteger)data{
    self = [super init];
    if (self)
    {
        self.data = data;
        self.next = nil;
    }
    return self;
}

+ (id) initWithArray:(NSArray*)array {
    if(array == nil || [array count] == 0) {
        return nil;
    }
    ListNode *start = nil;
    ListNode *prev = nil;
    for (NSInteger i=0;i<[array count];i++) {
        ListNode *n = [[ListNode alloc] initWithData:[[array objectAtIndex:i] intValue]];
        if (i == 0) {
            start = n;
        }
        if (prev == nil) {
            prev = n;
        } else {
            prev.next = n;
            prev = n;
        }
    }
    return start;
}

- (NSString *)toString {
    NSMutableString *str = [[NSMutableString alloc] init];
    ListNode *node = self;
    while (node != nil) {
        [str appendString:[NSString stringWithFormat:@"%ld",node.data]];
        if (node.next !=nil) {
            [str appendString:@" -> "];
        }
        node = node.next;
    }
    return str;
}
@end
