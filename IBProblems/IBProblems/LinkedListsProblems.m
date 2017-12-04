//
//  LinkedListsProblems.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 12/4/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import "LinkedListsProblems.h"

@implementation ListNode

/*- (id) initWithValue:(NSInteger)value next:(Node*)next {
    Node *n = [super init];
    if(n) {
        n.value = value;
        n.next = next;
    }
    return n;
}*/
@end

@implementation LinkedListsProblems

// Add Two Numbers as Lists
+ (ListNode *) addTwoNumbers:(ListNode *) a :(ListNode *) b  {
    ListNode *list = nil;
    ListNode *head = nil;
    ListNode *node = nil;
    NSInteger temp = 0;
    while (a != nil  || b != nil) {
        temp = temp + (a!=nil?a.val:0) + (b!=nil?b.val:0);
        node = [ListNode new];
        node.val = temp % 10;
        if(list == nil) {
            list = node;
            head = list;
        } else {
            list.next = node;
            list = list.next;
        }
        
        if (a != nil) {
            a = a.next;
        }
        if (b != nil) {
            b = b.next;
        }
        temp = temp/10;
    }
    if (temp != 0) {
        list.next = [ListNode new];
        list.next.val = temp;
        list = list.next;
    }
    return head;
}

// Reverse linked list between 2 nodes
-(ListNode *) reverseBetween:(ListNode *) A :(NSInteger) B :(NSInteger) C  {
    ListNode *prev = nil;
    if (A == nil) {
        return nil;
    }
    ListNode *node = A;
    NSInteger count = 1;
    while (node != nil) {
        if (count == B) {
            ListNode *n = [self reverseList:node tillCount:C-B];
            prev.next = n;
            break;
        }
        prev = node;
        node = node.next;
        count++;
    }
    
    return A;
}

-(ListNode *) reverseList:(ListNode *) A tillCount:(NSInteger) B {
    NSInteger count = 0;
    ListNode *n = A;
    ListNode *start = nil;
    ListNode *last = nil;
    while (n != nil && count <=B) {
        ListNode *node = n;
        n = n.next;
        node.next = start;
        start = node;
        if (last == nil) {
            last = start;
        }
        count++;
    }
    if (n != nil) {
        last.next = n;
    }
    return start;
}

@end

