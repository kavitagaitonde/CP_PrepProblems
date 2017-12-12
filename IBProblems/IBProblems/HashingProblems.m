//
//  HashingProblems.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 12/3/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import "HashingProblems.h"

@implementation HashingProblems

// 2sum -- Given an array of integers, find two numbers such that they add up to a specific target number.
+ (NSMutableArray *) twoSum:(NSArray *) A :(NSInteger) B  {
    NSMutableArray *newA = [NSMutableArray array];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSInteger num = 0;
    NSInteger num1 = 0;
    if (A == nil || [A count] == 0) {
        return newA;
    }
    NSInteger index1 = [A count];
    NSInteger index2 = [A count];
    
    for(NSInteger i=0;i<[A count];i++) {
        //NSLog(@"Adding num = %ld at index = %ld", [[A objectAtIndex:i] intValue], i);
        NSMutableArray *arr = [dict objectForKey:[A objectAtIndex:i]];
        if (arr == nil) {
            arr = [NSMutableArray array];
        }
        [arr addObject:@(i)];
        [dict setObject:arr forKey:[A objectAtIndex:i]];
    }
    for(NSInteger i=0;i<[A count];i++) {
        num = [[A objectAtIndex:i] intValue];
        num1 = B - num;
        //NSLog(@"num = %ld, num1 = %ld", num, num1);
        NSMutableArray *arr = [dict objectForKey:@(num1)];
        if (arr != nil) {
            NSInteger j=0;
            NSInteger index=0;
            while (j<[arr count]) {
                //NSLog(@"j = %ld, arrcount = %ld", j, [arr count]);
                index = [[arr objectAtIndex:j] intValue];
                //NSLog(@"j = %ld, index = %ld", j, index);
                if (index > i) {
                    NSInteger ind = index;
                    //NSLog(@"index1=%ld, index2=%ld, i = %ld, ind = %ld", index1, index2, i, ind);
                    if (index2>ind || (index2 == ind && index1 > i)) {
                        index1 = i;
                        index2 = ind;
                    }
                }
                j++;
            }
        }
    }
    if (index1 < [A count] && index2 < [A count]) {
        [newA addObject:@(index1+1)];
        [newA addObject:@(index2+1)];
    }
    return newA;
}

// Diff K  -- Given an array of integers, find two numbers such that the difference is a specific target number K and i > j
+ (BOOL) twoDiff:(NSArray *) A :(NSInteger) B  {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSInteger num = 0;
    NSInteger num1 = 0;
    if (A == nil || [A count] == 0) {
        return NO;
    }
    
    for(NSInteger i=0;i<[A count];i++) {
        //NSLog(@"Adding num = %ld at index = %ld", [[A objectAtIndex:i] intValue], i);
        NSMutableArray *arr = [dict objectForKey:[A objectAtIndex:i]];
        if (arr == nil) {
            arr = [NSMutableArray array];
        }
        [arr addObject:@(i)];
        [dict setObject:arr forKey:[A objectAtIndex:i]];
    }
    
    for(NSInteger i=0;i<[A count];i++) {
        num = [[A objectAtIndex:i] intValue];
        num1 = num - B;
        //NSLog(@"num = %ld, num1 = %ld", num, num1);
        NSMutableArray *arr = [dict objectForKey:@(num1)];
        if (arr != nil) {
            NSInteger j=0;
            NSInteger index=0;
            while (j<[arr count]) {
                //NSLog(@"j = %ld, arrcount = %ld", j, [arr count]);
                index = [[arr objectAtIndex:j] intValue];
                //NSLog(@"j = %ld, index = %ld", j, index);
                if (index != i) {
                    //NSLog(@"i = %ld, index = %ld", i, index);
                    return YES;
                }
                j++;
            }
        }
    }
    return NO;
}


//Substring concatenation
+ (NSArray *) findSubstring:(NSString *) A :(NSArray *) B  {
    if (A == nil || [A length] == 0 || B == nil || [B count] == 0) {
        return @[];
    }
    NSMutableArray *arr = [NSMutableArray array];
    NSString *first = [B objectAtIndex:0];
    //NSLog(@"first = %@",first);
    NSInteger wordLen = [first length];
    //NSLog(@"wordLen = %ld",wordLen);
    NSInteger totalWordsLen = [B count] * wordLen;
    //NSLog(@"totalWordsLen = %ld",totalWordsLen);
    NSInteger i = 0;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSInteger j=0;
    for (j=0;j<[B count];j++) {
        NSNumber *val = [dict objectForKey:[B objectAtIndex:j]];
        if (val == nil) {
            [dict setObject:@(1) forKey:[B objectAtIndex:j]];
        } else {
            [dict setObject:@([val intValue]+1) forKey:[B objectAtIndex:j]];
        }
    }
    NSInteger cnt=0;
    NSInteger index=0;
    while (i+totalWordsLen <= [A length]) {
        //NSLog(@"i = %ld",i);
        index=i;
        j=i;
        NSInteger max = i+totalWordsLen;
        while (j < max) {
            //NSLog(@"j = %ld",j);
            NSRange range = NSMakeRange(j, wordLen);
            if (range.location != NSNotFound) {
                NSString *s = [A substringWithRange:range];
                NSNumber* n = [dict objectForKey:s];
                if (n != nil && [n intValue] > 0) {
                    //NSLog(@"found s = %@, n = %d",s, [n intValue]);
                    if (cnt == 0) {
                        index = i;
                    }
                    cnt++;
                    j += wordLen;
                    [dict setObject:@([n intValue]-1) forKey:s];
                }else{
                    //NSLog(@"skip found s = %@, but it already is counted or does not exist",s);
                    break;
                }
            } else {
                //NSLog(@"not found s");
                break;
            }
        }
        //reset count
        dict = [NSMutableDictionary dictionary];
        for (NSInteger k=0;k<[B count];k++) {
            NSNumber *val = [dict objectForKey:[B objectAtIndex:k]];
            if (val == nil) {
                [dict setObject:@(1) forKey:[B objectAtIndex:k]];
            } else {
                [dict setObject:@([val intValue]+1) forKey:[B objectAtIndex:k]];
            }
        }
        
        if (j-index == totalWordsLen) {
            //NSLog(@"Found match from i = %ld", index);
            [arr addObject:@(index)];
            cnt = 0;
            i = index+1;//wordLen;
        }else{
            //NSLog(@"NOT Found match from i = %ld", index);
            if (i == j){
                i += 1;
            } else {
                i=index+1;//wordLen;
            }
            
        }
    }
    return arr;
}

//Check if strings from given array are anagrams of each other
+ (NSArray *) anagrams:(NSArray *) A  {
    if (A == nil || [A count] == 0) {
        return @[];
    }
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i=0;i<[A count]; i++) {
        NSString *s1 = [A objectAtIndex:i];
        NSMutableDictionary *dict1 = [self characterDictionaryOfString:s1];
        for (NSInteger j=i+1;j<[A count]; j++) {
            NSString *s2 = [A objectAtIndex:j];
            if ([s1 length] == [s2 length]) {
                BOOL ret = [self isAnagram:s2 withDict:dict1];
                if (ret) {
                    NSMutableArray *a1 = [NSMutableArray array];
                    [a1 addObject:@(i+1)];
                    [a1 addObject:@(j+1)];
                    [arr addObject:a1];
                }
            }
        }
    }
    return arr ;
}

+(NSMutableDictionary*) characterDictionaryOfString:(NSString *)s {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSRange r;
    for (NSInteger i=0;i<[s length]; i++) {
        r = NSMakeRange(i,1);
        NSString *s1 = [s substringWithRange:r];
        NSNumber *num = [dict objectForKey:s1];
        if (num != nil) {
            [dict setObject:@([num intValue]+1) forKey:s1];
        } else {
            [dict setObject:@(1) forKey:s1];
        }
    }
    return dict;
}

+(BOOL) isAnagram:(NSString *)s  withDict:(NSMutableDictionary*)dict {
    BOOL ret = true;
    for (NSInteger i=0;i<[s length]; i++) {
        NSRange r = NSMakeRange(i,1);
        NSString *s1 = [s substringWithRange:r];
        NSNumber *num = [dict objectForKey:s1];
        if (num != nil && [num intValue] > 0) {
            [dict setObject:@([num intValue]-1) forKey:s1];
        } else {
            ret = false;
            break;
        }
    }
    return ret;
}

@end
