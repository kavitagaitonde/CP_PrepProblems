//
//  RecursionProblems.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 1/4/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import "RecursionProblems.h"

@implementation RecursionProblems

+ (NSMutableArray *) allPossibleSubsets:(NSMutableArray*)array {
    if (array == nil || [array count] == 0) {
        return [NSMutableArray new];
    }
    array = [[array sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
    NSLog(@"input : %@", array);
    NSMutableArray *output = [NSMutableArray array];
    [self subsetsBacktracking:array output:output current:[NSMutableArray array] start:0];
    return output;
}

+ (void) subsetsBacktracking:(NSMutableArray*)input output:(NSMutableArray *)output current:(NSMutableArray*)current start:(NSInteger)start {
    [output addObject:[NSArray arrayWithArray:current]];
    //NSLog(@"output : %@", output);
    for(NSInteger i=start;i<[input count];i++) {
        if (i > start && [[input objectAtIndex:i] intValue] == [[input objectAtIndex:i-1] intValue]) {
            //duplicate
            //NSLog(@"duplicate (start=%ld): %d", (long)start, [[input objectAtIndex:i] intValue]);
            continue;
        }
        [current addObject:[input objectAtIndex:i]];
        [self subsetsBacktracking:input output:output current:current start:i+1];
        [current removeLastObject];
    }
}

+ (NSMutableArray *) allPossiblePermutations:(NSMutableArray*)array {
    if (array == nil || [array count] == 0) {
        return [NSMutableArray new];
    }
    NSLog(@"input : %@", array);
    NSMutableArray *output = [NSMutableArray array];
    [self permutationsBacktracking:array output:output current:[NSMutableArray array]];
    return output;
}

+ (void) permutationsBacktracking:(NSMutableArray*)input output:(NSMutableArray *)output current:(NSMutableArray*)current {
    if ([current count] == [input count]) {
        [output addObject:[NSArray arrayWithArray:current]];
    }
    //NSLog(@"output : %@", output);
    for(NSInteger i=0;i<[input count];i++) {
        if ([current containsObject:[input objectAtIndex:i]]) {
            //permutations used
            continue;
        }
        [current addObject:[input objectAtIndex:i]];
        [self permutationsBacktracking:input output:output current:current];
        [current removeLastObject];
    }
}

+ (NSMutableArray *) allPossibleCombinations:(NSMutableArray*)array forK:(NSInteger)k {
    if (array == nil || [array count] == 0) {
        return [NSMutableArray new];
    }
    NSLog(@"input : %@", array);
    NSMutableArray *output = [NSMutableArray array];
    [self combinationsBacktracking:array output:output current:[NSMutableArray array] k:k];
    return output;
}

+ (void) combinationsBacktracking:(NSMutableArray*)input output:(NSMutableArray *)output current:(NSMutableArray*)current k:(NSInteger)k {
    if ([current count] == k) {
        [output addObject:[NSArray arrayWithArray:current]];
    }
    //NSLog(@"output : %@", output);
    for(NSInteger i=0;i<[input count];i++) {
        if ([current containsObject:[input objectAtIndex:i]] || [[current lastObject] intValue] > [[input objectAtIndex:i] intValue]) {
            //combination exists
            continue;
        }
        [current addObject:[input objectAtIndex:i]];
        [self combinationsBacktracking:input output:output current:current k:k];
        [current removeLastObject];
    }
}

+ (NSMutableArray *) allPossibleCombinations:(NSInteger)A B:(NSInteger)B {
    if (A < B) {
        return [NSMutableArray new];
    }
    NSMutableArray *output = [NSMutableArray array];
    [self combinationsBacktracking:A output:output current:[NSMutableArray array] B:B];
    return output;
}

+ (void) combinationsBacktracking:(NSInteger)A output:(NSMutableArray *)output current:(NSMutableArray*)current B:(NSInteger)B {
    if ([current count] == B) {
        [output addObject:[NSArray arrayWithArray:current]];
    }
    //NSLog(@"output : %@", output);
    for(NSInteger i=1;i<=A;i++) {
        if ([current containsObject:@(i)] || [[current lastObject] intValue] > i) {
            //combination exists
            continue;
        }
        [current addObject:@(i)];
        [self combinationsBacktracking:A output:output current:current B:B];
        [current removeLastObject];
    }
}

+ (NSMutableArray *) allPossibleCombinationsSum:(NSMutableArray*)array forTotal:(NSInteger)total {
    if (array == nil || [array count] == 0) {
        return [NSMutableArray new];
    }
    NSLog(@"input : %@", array);
    NSMutableArray *output = [NSMutableArray array];
    [self combinationsSumBacktracking:array output:output current:[NSMutableArray array] remainingTotal:total start:0];
    NSLog(@" unsorted output : %@", output);
    [output sortUsingComparator:^(id obj1, id obj2) {
        if ([obj1 objectAtIndex:0] > [obj2 objectAtIndex:0]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 objectAtIndex:0] < [obj2 objectAtIndex:0]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    return output;
}

+ (void) combinationsSumBacktracking:(NSMutableArray*)input output:(NSMutableArray *)output current:(NSMutableArray*)current remainingTotal:(NSInteger)total start:(NSInteger)start {
    if(total < 0) {
        return;
    }
    if (total == 0) {
        [output addObject:[NSArray arrayWithArray:current]];
        return;
    }
    //NSLog(@"output : %@", output);
    for(NSInteger i=0;i<[input count];i++) {
        if ([[current lastObject] intValue] > [[input objectAtIndex:i] intValue]) {
            //combination exists
            continue;
        }
        [current addObject:[input objectAtIndex:i]];
        [self combinationsSumBacktracking:input output:output current:current remainingTotal:total-[[input objectAtIndex:i] intValue] start:i];
        [current removeLastObject];
    }
}

+ (NSMutableArray *) palindromePartitioning:(NSString*)string {
    if (string == nil || [string length] == 0) {
        return [NSMutableArray new];
    }
    NSLog(@"input : %@", string);
    NSMutableArray *output = [NSMutableArray array];
    [self palindromePartitioningBacktracking:string output:output current:[NSMutableArray array] start:0];
    return output;
}

+ (void) palindromePartitioningBacktracking:(NSString*)input output:(NSMutableArray *)output current:(NSMutableArray*)current start:(NSInteger)start {
    if (start == [input length]) {
        [output addObject:[NSArray arrayWithArray:current]];
        return;
    }
    //NSLog(@"output : %@", output);
    for(NSInteger i=start;i<[input length];i++) {
         NSLog(@"start : %ld, end : %ld", start, i);
        if ([self isPalindrome:input start:start end:i]) {
            //palindrome exists
            [current addObject:[input substringWithRange:NSMakeRange(start, i+1-start)]];
            //NSLog(@"palindrome : %@", current);
            [self palindromePartitioningBacktracking:input output:output current:current start:i+1];
            [current removeLastObject];
        }
    }
}

+ (BOOL) isPalindrome:(NSString*)s start:(NSInteger)start end:(NSInteger)end {
    BOOL ret = true;
    if (s == nil) {
        return ret;
    }
    while (start < end && end > 0) {
        if ([s characterAtIndex:start] != [s characterAtIndex:end]) {
            ret = false;
            break;
        }
        start++;
        end--;
    }
    return ret;
}

+ (NSMutableArray *) generateAllParenthesis:(NSInteger)n {
    if (n == 0) {
        return [NSMutableArray new];
    }
    if (n == 1) {
        return [NSMutableArray arrayWithObject:@"()"];
    }
    NSLog(@"n : %ld", n);
    NSMutableArray *output = [NSMutableArray array];
    [self generateAllParenthesisBacktracking:n output:output current:[NSMutableArray array] start:0 end:0];
    return output;
}

+ (void) generateAllParenthesisBacktracking:(NSInteger)n output:(NSMutableArray *)output current:(NSMutableArray*)current start:(NSInteger)start end:(NSInteger)end {
    if ([current count] == n*2 && [self areParenthesisValid:current]) {
        [output addObject:[current componentsJoinedByString:@""]];
        return;
    }
    //NSLog(@"output : %@", output);
    
    if (start < n) {
        [current addObject:@"("];
        [self generateAllParenthesisBacktracking:n output:output current:current start:start+1 end: end];
        [current removeLastObject];
    }
    if (end < n) {
        [current addObject:@")"];
        [self generateAllParenthesisBacktracking:n output:output current:current start:start end: end+1];
        [current removeLastObject];
    }
}

+ (BOOL) areParenthesisValid:(NSArray*)s {
    if (s == nil) {
        return true;
    }
    NSInteger count = 0;
    NSInteger i = 0;
    while (count >= 0 && i < [s count]) {
        if ([[s objectAtIndex:i] isEqualToString: @"("]) {
            count++;
        } else {
            count--;
        }
        i++;
    }
    if (count == 0) {
        return true;
    }
    return false;
}

@end
