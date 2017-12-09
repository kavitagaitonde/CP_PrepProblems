//
//  LinkedListsProblems.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 12/4/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import "LinkedListsProblems.h"

/*@implementation ListNode

- (id) initWithValue:(NSInteger)value{
    return [self initWithValue:value next:nil];
}

- (id) initWithValue:(NSInteger)value next:(ListNode*)next {
    ListNode *n = [super init];
    if(n) {
        n.val = value;
        n.next = next;
    }
    return n;
}

+ (ListNode*) createLinkedListFrom:(NSArray*)A {
    ListNode *head = nil;
    ListNode *prev = nil;
    if (A == nil) {
        return head;
    }
    NSInteger i = 0;
    while (i < [A count]) {
        NSInteger num = [[A objectAtIndex:i] intValue];
        ListNode *node = [[ListNode alloc] initWithValue:num];
        if(head == nil) {
            head = node;
            prev = node;
        } else {
            prev.next = node;
            prev = node;
        }
    }
    return head;
}
@end*/

@implementation LinkedListsProblems

// Add Two Numbers as Lists
+ (ListNode *) addTwoNumbers:(ListNode *) a :(ListNode *) b  {
    ListNode *list = nil;
    ListNode *head = nil;
    ListNode *node = nil;
    NSInteger temp = 0;
    while (a != nil  || b != nil) {
        temp = temp + (a!=nil?a.data:0) + (b!=nil?b.data:0);
        node = [ListNode new];
        node.data = temp % 10;
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
        list.next.data = temp;
        list = list.next;
    }
    return head;
}

// Reverse linked list between 2 nodes
+ (ListNode *) reverseBetween:(ListNode *) A :(NSInteger) B :(NSInteger) C  {
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

+(ListNode *) reverseList:(ListNode *) A tillCount:(NSInteger) B {
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

// Merge 2 sorted linked lists
+(ListNode *) mergeTwoLists:(ListNode *) A :(ListNode *) B  {
    if ( A == nil) {
        return B;
    }
    if ( B == nil) {
        return A;
    }
    ListNode *n1 = A;
    ListNode *n2 = B;
    ListNode *start = nil, *node = nil;
    while (n1 != nil && n2 != nil) {
        if (n1.data < n2.data) {
            if (node == nil) {
                node = n1;
                start = node;
            } else {
                node.next = n1;
                node = n1;
            }
            n1 = n1.next;
            node.next = nil;
        } else {
            if (node == nil) {
                node = n2;
                start = node;
            } else {
                node.next = n2;
                node = n2;
            }
            n2 = n2.next;
            node.next = nil;
        }
    }
    if (n1 == nil  && n2 != nil) {
        node.next = n2;
    } else if (n2 == nil  && n1 != nil) {
        node.next = n1;
    }
    return start;
}

//Swap adjacent pairs
+ (ListNode *) swapPairs:(ListNode *) A  {
    if (A == nil || A.next == nil) {
        return A;
    }
    ListNode *first = A;
    ListNode *second = A.next;
    NSInteger temp;
    while (first != nil && second != nil) {
        temp = first.data;
        first.data = second.data;
        second.data = temp;
        first = second.next;
        if (first.next != nil) {
            second = first.next;
        } else {
            second = nil;
        }
    }
    return A;
}

//Detect cycle and return node at which cycle begins if cycle exists, else return nil
+ (ListNode *) detectCycle:(ListNode *) A  {
    if (A == nil || A.next == nil || A.next.next == nil) {
        return nil;
    }
    ListNode *slow = A;
    ListNode *fast = A;
    while (slow != nil && fast != nil) {
        slow = slow.next;
        fast = fast.next;
        if (fast != nil) {
            fast = fast.next;
        } else {
            //no cycle
            break;
        }
        if (slow == fast) {
            //cycle
            while (A != slow) {
                A = A.next;
                slow = slow.next;
            }
            return A;
        }
    }
    return nil;
}

@end

