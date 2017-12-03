//
//  StringsProblems.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 11/27/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import "StringsProblems.h"

@implementation StringsProblems

// Return longest common prefix
+ (NSString *) longestCommonPrefix:(NSArray *) A  {
    
    if(A == nil || [A count] == 0) {
        return nil;
    }
    NSString *searchString = [A objectAtIndex:0];
    for (NSInteger i=0;i<[searchString length];i++) {
        char c = [searchString characterAtIndex:i];
        NSInteger j;
        for (j=1;j<[A count];j++) {
            NSString *s = [A objectAtIndex:j];
            if (i >= [s length]) {
                return s;
            }else if ( c != [s characterAtIndex:i]) {
                return [searchString substringToIndex:i];
            }
        }
    }
    return searchString;
}

//Longest palindrome
+ (NSString *) longestPalindrome:(NSString *) A {
    NSInteger sIndex = 0;
    NSInteger eIndex = 0;
    NSInteger lIndex = 0;
    NSInteger rIndex = 0;
    NSInteger len1 = 0;
    NSInteger len2 = 0;
    NSInteger len = 0;
    NSInteger currLen = 0;
    for (NSInteger i=0;i<[A length];i++) {
        //odd number case
        lIndex = i;
        rIndex = i;
        while (lIndex>=0 && rIndex <[A length] && [A characterAtIndex:lIndex] == [A characterAtIndex:rIndex]) {
            lIndex--;
            rIndex++;
        }
        len1 = rIndex - lIndex - 1;
        
        //even number case
        lIndex = i;
        rIndex = i+1;
        while (lIndex>=0 && rIndex <[A length] && [A characterAtIndex:lIndex] == [A characterAtIndex:rIndex]) {
            lIndex--;
            rIndex++;
        }
        len2 = rIndex - lIndex - 1;
        
        len = MAX(len1, len2);
        currLen = eIndex - sIndex + 1;
        //NSLog(@"len1:%ld, len2:%ld, currLen:%ld", len1, len2, currLen);
        if (len > currLen) {
            //NSLog(@"len:%ld, currLen:%ld", len, currLen);
            //NSLog(@"len1:%ld, len2:%ld, currLen:%ld", len1, len2, currLen);
            
            sIndex = i - (len -1)/2;
            eIndex = i+ len/2;
            //NSLog(@"start:%ld, end:%ld", sIndex, eIndex);
        }
    }
    NSLog(@"start:%ld, end:%ld", sIndex, eIndex);
    NSRange range = NSMakeRange (sIndex, eIndex-sIndex+1);
    return [A substringWithRange:range];
}



-(NSString *) getLongestPalindromeSlow:(NSString *) a {
    NSInteger len = [a length];
    NSInteger i = 0;
    NSInteger index = 0;
    while (len > 0) {
        index = 0;
        while (index <= i) {
            NSRange range = NSMakeRange(index, len);
            NSString *str = [[a substringWithRange:range] lowercaseString];
            //NSLog(@"Checking palindrome for string: %@", str);
            BOOL ret = [StringsProblems isPalindrome:str];
            if (ret) {
                //NSLog(@"Found palindrome string: %@", str);
                return str;
            }
            index++;
        }
        len--;
        i++;
    }
    return nil;
}

+ (BOOL) isPalindrome:(NSString *) A{
    NSInteger start = 0;
    NSInteger end = [A length]-1;
    BOOL ret = YES;
    while (start <= end) {
        if ([A characterAtIndex:start] != [A characterAtIndex:end]) {
            ret = NO;
            break;
        }
        start++;
        end--;
    }
    return ret;
}

// String within a string
+ (NSInteger) strStr:(NSString *) A :(NSString *) B  {
    NSLog(@"1");
    if (A == nil || [A length] == 0 || B == nil || [B length] == 0 || [A length] < [B length]) {
        return -1;
    }
    NSLog(@"2");
    NSString *needle = [B lowercaseString];
    NSString *haystack = [A lowercaseString];
    NSInteger needleLength = [needle length];
    NSLog(@"needle = %@, haystack = %@", needle, haystack);
    NSLog(@"needlelenght = %ld, haystacklength = %ld", needleLength, [haystack length]);
    for (NSInteger i=0;i<[haystack length];i++) {
        if ([needle characterAtIndex:0] == [haystack characterAtIndex:i]) {
            //check if needle exists with starting point i;
            if ( i + needleLength > [haystack length])  {
                return -1;
            }
            NSRange r = NSMakeRange(i, needleLength);
            NSString *s = [haystack substringWithRange:r];
            if ([s isEqualToString:needle]) {
                //found
                return i;
            }
        }
    }
    return -1;
}
@end
