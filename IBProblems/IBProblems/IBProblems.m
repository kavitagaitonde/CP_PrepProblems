//
//  IBProblems.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 11/18/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import "IBProblems.h"

@implementation IBProblems

/************ CHECKPOINT 2 PROBLEMS **************/

/* Print concentric rectangular pattern in a 2d matrix. */
+ (NSMutableArray *) concentric2DPrint:(NSInteger) A  {
    
    NSInteger size = (2*A) - 1;
    NSMutableArray *array2D = [NSMutableArray arrayWithCapacity:size];
    int i = 0;
    while (i < size) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:size];
        for (int j = 0; j < size ; j++) {
            [arr addObject:@(0)];
        }
        [array2D addObject:arr];
        i++;
    }
    NSInteger currVal = A;
    NSInteger row = 0;
    NSInteger col = 0;
    while (currVal > 0) {
        //NSLog(@"currVal = %d, row = %d", currVal, row);
        NSMutableArray *arr = (NSMutableArray *)[array2D objectAtIndex:row];
        for (NSInteger j=col;j<size;j++) {
            [[array2D objectAtIndex:row] replaceObjectAtIndex:j withObject:@(currVal)];
        }
        //NSLog(@"currVal = %d, col = %d", currVal, col);
        for (NSInteger i=row;i<size;i++) {
            [[array2D objectAtIndex:i] replaceObjectAtIndex:size-1 withObject:@(currVal)];
        }
        arr = [array2D objectAtIndex:size-1];
        for (NSInteger j=size-1;j>=col;j--) {
            [arr replaceObjectAtIndex:j withObject:@(currVal)];
        }
        for (NSInteger i=size-1;i>=row;i--) {
            [[array2D objectAtIndex:i] replaceObjectAtIndex:col withObject:@(currVal)];
        }
        currVal--;
        row++;
        col++;
        size--;
    }
    return array2D;
}

/************ CHECKPOINT 3 PROBLEMS **************/

/* Find the kth smallest element in an unsorted array of non-negative integers. */
+ (NSInteger) kthsmallest:(NSArray *) A B:(NSInteger) B  {
    //NSLog(@"starting A: %@, size = %d", A, [A count]);
    
    if (A == nil || [A count] == 0 || B > [A count]) {
        return -1;
    }
    NSMutableArray * arr = [NSMutableArray arrayWithArray:A];
    NSInteger retVal = [self quickSelect:arr left:0 right:[arr count]-1 k: B-1];
    return retVal;
}

+ (NSInteger) quickSelect:(NSMutableArray *) arr left:(NSInteger) left  right:(NSInteger) right k:(NSInteger) k {
    if (left == right) {
        return [[arr objectAtIndex:left] intValue];
    }
    NSInteger pivotIndex = (left+right)/2; //median
    pivotIndex = [self partition:arr left:left right:right pivotIndex:pivotIndex];
    
    if (k == pivotIndex) {
        return [[arr objectAtIndex:k] intValue];
    } else if (k < pivotIndex) {
        //NSLog(@"LEFT: pivotIndex= %d, left = %d, right = %d", pivotIndex, left, pivotIndex-1);
        return [self quickSelect:arr left:left right:pivotIndex-1 k:k];
    } else {
        //NSLog(@"RIGHT: pivotIndex= %d, left = %d, right = %d", pivotIndex, pivotIndex+1, right);
        return [self quickSelect:arr left:pivotIndex+1 right:right k:k];
    }
}

+ (NSInteger) partition:(NSMutableArray *) arr left:(NSInteger) left  right:(NSInteger) right pivotIndex:(NSInteger) pivotIndex {
    
    NSInteger storeIndex = left;
    NSInteger pivot = [[arr objectAtIndex:pivotIndex] intValue];
    NSInteger temp = [[arr objectAtIndex:right] intValue];
    [arr replaceObjectAtIndex:right withObject:@(pivot)];
    [arr replaceObjectAtIndex:pivotIndex withObject:@(temp)];
    for (NSInteger i=left;i<right;i++) {
        if ([[arr objectAtIndex:i] intValue] < pivot) {
            temp = [[arr objectAtIndex:i] intValue];
            [arr replaceObjectAtIndex:i withObject:[arr objectAtIndex:storeIndex]];
            [arr replaceObjectAtIndex:storeIndex withObject:@(temp)];
            storeIndex++;
        }
    }
    temp = [[arr objectAtIndex:right] intValue];
    [arr replaceObjectAtIndex:right withObject:[arr objectAtIndex:storeIndex]];
    [arr replaceObjectAtIndex:storeIndex withObject:@(temp)];
    return storeIndex;
}

/* Given an array of non negative integers A, and a range (B, C),
 find the number of continuous subsequences in the array which have sum S in the range [B, C] or B <= S <= C*/
+ (NSInteger) numRange:(NSMutableArray *) A B:(NSInteger) B C:(NSInteger) C  {
    NSInteger startIndex = 0;
    NSInteger currIndex = 0;
    NSInteger currSum = 0;
    NSInteger total = 0;
    NSInteger prevTotal = 0;
    for (int i=0;i<[A count];i++) {
        NSInteger currVal = [[A objectAtIndex:i] intValue];
        if (currVal > C) {
            //move ahead
        } else {
            startIndex = i;
            currIndex = i;
            currSum = 0;
            total = 0;
            while (currIndex < [A count]) {
                currVal = [[A objectAtIndex:currIndex] intValue];
                currSum += currVal;
                /*if (currVal >= B && currVal <= C) {
                 total++;
	                }*/
                if (currSum >= B && currSum <= C) {
                    total++;
                } else if (currSum > C){
                    //if (prevTotal < total) {
                    //prevTotal += total;
                    //}
                    break;
                }
                currIndex++;
	           }
	           prevTotal += total;
	           //NSLog(@" sequence = %d , %d", i, currIndex);
        }
    }
    return prevTotal;
}

/************ CHECKPOINT 4 PROBLEMS **************/

/* Given an array, find the next greater element G[i] for every element A[i] in the array. The Next greater Element for an element A[i] is the first greater element on the right side of A[i] in array. */
+ (NSMutableArray *) nextGreater:(NSMutableArray *) A  {
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:[A count]];
    NSInteger iVal, jVal;
    for(int i=0;i<[A count];i++) {
        iVal = [[A objectAtIndex:i] intValue];
        //NSLog(@"i = %d, iVal = %d", i, iVal);
        NSInteger j = i+1;
        jVal = 0;
        while (j < [A count]) {
            jVal = [[A objectAtIndex:j] intValue];
            //NSLog(@"j = %d, jVal = %d", j, jVal);
            if (iVal < jVal) {
                break;
            }
            j++;
        }
        if (j == [A count]) { //reached end
            [arr addObject:@(-1)];
        } else {
            [arr addObject:@(jVal)];
        }
    }
    return arr;
}

/* Given a singly linked list, modify the value of first half nodes such that :
 1st node’s new value = the last node’s value - first node’s current value
 2nd node’s new value = the second last node’s value - 2nd node’s current value.
*/
+ (ListNode *) subtract:(ListNode *) A  {
    if ( A == nil) {
        return nil;
    }
    ListNode* start = A;
    ListNode* curr = start;
    //figure out the list midpoint using slow and fast pointer
    ListNode* slow = start;
    ListNode* fast = start.next;
    while (fast != nil) {
        fast = fast.next;
        if (fast != nil){
            slow = slow.next;
            fast = fast.next;
        }
    }
    ListNode* secondList = slow.next;
    slow.next = nil;
    //NSLog(@"Second list : %d", secondList.val);
    
    //reverse 2nd list
    secondList = [self reverse:secondList];
    
    //traverse both lists
    ListNode *prevStart = nil;
    ListNode *firstList = start;
    curr = secondList;
    while (start != nil && curr != nil) {
        //NSLog(@"Substract list : %d - %d", curr.val, start.val);
        start.data = curr.data - start.data;
        prevStart = start;
        start = start.next;
        curr = curr.next;
    }
    if(start != nil) {//takes care of odd numbered list
        prevStart = start;
    }
    //reverse 2nd list again
    secondList = [self reverse:secondList];
    prevStart.next = secondList;
    
    /*NSMutableString *str = [[NSMutableString alloc] init];
	    while (firstList != nil) {
     [str appendString:[NSString stringWithFormat:@"%d",firstList.val]];
     if (firstList.next !=nil) {
     [str appendString:@" -> "];
     }
	    }*/
    //NSLog(@"%@", str);
    return firstList;
}

+ (ListNode *) reverse:(ListNode *) list  {
    ListNode *curr = list;
    ListNode *next = nil;
    ListNode *prev = nil;
    while (curr != nil) {
        next = curr.next;
        curr.next = prev;
        prev = curr;
        curr = next;
    }
    return prev;
}

/************ CHECKPOINT 5 PROBLEMS **************/

/* Given an unsorted array of integers, find the length of the longest consecutive elements sequence. */
+ (NSInteger) longestConsecutive:(NSArray *) A  {
    //return [self longestSequenceUsingSort:A];
    return [self longestSequenceUsingMap:A];
    //return [self longestSequenceUsingSet:A];
}

+ (NSInteger) longestSequenceUsingSort:(NSArray *) A  {
    NSArray *arr = [A sortedArrayUsingSelector:@selector(compare:)];
    //NSLog(@"sorted array = %@", arr);
    NSInteger maxSequence = 0;
    NSInteger iVal, prevVal;
    NSInteger i = 1;
    NSInteger currSequence = 1;
    while(i < [arr count]) {
        prevVal = [[arr objectAtIndex:i-1] intValue];
        iVal = [[arr objectAtIndex:i] intValue];
        if ((iVal - prevVal) == 1) {
            currSequence++;
            //NSLog(@"currSequence = %d", currSequence);
        } else if ((iVal - prevVal) == 0) {
            //ignore
        } else {
            currSequence = 1;
        }
        i++;
        maxSequence = MAX(maxSequence, currSequence);
    }
    //NSLog(@"max = %d", maxSequence);
    return maxSequence;
}

+ (NSInteger) longestSequenceUsingMap:(NSArray *) A  {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSInteger maxSequence = 1;
    NSInteger iVal, x, y, diff;
    for(int i=0;i<[A count];i++) {
        iVal = [[A objectAtIndex:i] intValue];
        if ([dict objectForKey:@(iVal)] != nil) { //exists
            continue;
        }
        [dict setObject:@(1) forKey:@(iVal)];
        
        x = iVal;
        y = iVal;
        //check if previous exists
        if ([dict objectForKey:@(iVal-1)] != nil) {
            x = iVal - [[dict objectForKey:@(iVal-1)] intValue];
        }
        //check if next exists
        if ([dict objectForKey:@(iVal+1)] != nil) {
            y = iVal + [[dict objectForKey:@(iVal+1)] intValue];
        }
        diff = y - x + 1;
        maxSequence = MAX(maxSequence, diff);
        [dict setObject:@(diff) forKey:@(x)];
        [dict setObject:@(diff) forKey:@(y)];
    }
    //NSLog(@"***** maxsequence = %ld", maxSequence);
    return maxSequence;
}

+ (NSInteger) longestSequenceUsingSet:(NSArray *) A  {
    NSMutableSet *set = [NSMutableSet set];
    [set addObjectsFromArray:A];
    /*for(int i=0;i<[A count];i++) {
     [set addObject:[A objectAtIndex:i]];
     }*/
    NSInteger maxSequence = 1;
    NSInteger iVal, currSequence, left, right;
    for(int i=0;i<[A count];i++) {
        iVal = [[A objectAtIndex:i] intValue];
        currSequence = 1;
        left = iVal-1;
        right = iVal+1;
        //NSLog(@"iVal = %@", arr);
        while ([set containsObject:@(left)]) {
            [set removeObject:@(left)];
            left--;
            currSequence++;
        }
        while ([set containsObject:@(right)]) {
            [set removeObject:@(right)];
            right++;
            currSequence++;
        }
        maxSequence = MAX(maxSequence, currSequence);
    }
    return maxSequence;
}

/* Given a collection of numbers that might contain duplicates, return all possible unique permutations. */
+ (void) getUniquePermutations:(NSMutableArray *) A result:(NSMutableArray *) result set: (NSMutableSet *)set start:(NSInteger) start end:(NSInteger) end {
    //NSLog(@"getUniquePermutation: %@, start=%d, end=%d", A, start, end);
    if(start == end) {
        NSString *str = [A componentsJoinedByString:@","];
        //NSLog(@"str = %@", str);
        if(![set containsObject:str]) { //add unique only
            //NSLog(@"Adding str");
            [set addObject:str];
            [result insertObject:[str componentsSeparatedByString:@","] atIndex:0];
        }
        return;
    }
    for(NSInteger i=start;i<=end;i++) {
        [self swap:A index:start withIndex:i];//swap
        [self getUniquePermutations:A result:result set:set start:start+1 end:end];
        [self swap:A index:start withIndex:i];//reset swap
    }
    
}
+ (void) swap:(NSMutableArray *) A index:(NSInteger)i withIndex:(NSInteger)j {
    NSInteger temp = [[A objectAtIndex:i] intValue];
    [A replaceObjectAtIndex:i withObject:[A objectAtIndex:j]];
    [A replaceObjectAtIndex:j withObject:@(temp)];
}

@end
