//
//  RecursionProblems.h
//  IBProblems
//
//  Created by Kavita Gaitonde on 1/4/18.
//  Copyright © 2018 Kavita Gaitonde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecursionProblems : NSObject

+ (NSMutableArray *) allPossibleSubsets:(NSMutableArray*)array;
+ (void) subsetsBacktracking:(NSMutableArray*)input output:(NSMutableArray *)output current:(NSMutableArray*)current start:(NSInteger)start;
+ (NSMutableArray *) allPossiblePermutations:(NSMutableArray*)array;
+ (void) permutationsBacktracking:(NSMutableArray*)input output:(NSMutableArray *)output current:(NSMutableArray*)current;
+ (NSMutableArray *) allPossibleCombinations:(NSMutableArray*)array forK:(NSInteger)k ;
+ (void) combinationsBacktracking:(NSMutableArray*)input output:(NSMutableArray *)output current:(NSMutableArray*)current k:(NSInteger)k;
+ (NSMutableArray *) allPossibleCombinations:(NSInteger)A B:(NSInteger)B;
+ (void) combinationsBacktracking:(NSInteger)A output:(NSMutableArray *)output current:(NSMutableArray*)current B:(NSInteger)B;
+ (NSMutableArray *) allPossibleCombinationsSum:(NSMutableArray*)array forTotal:(NSInteger)total;
+ (void) combinationsSumBacktracking:(NSMutableArray*)input output:(NSMutableArray *)output current:(NSMutableArray*)current remainingTotal:(NSInteger)total start:(NSInteger)start;
+ (BOOL) isPalindrome:(NSString*)s start:(NSInteger)start end:(NSInteger)end;
+ (NSMutableArray *) palindromePartitioning:(NSString*)string;
+ (void) palindromePartitioningBacktracking:(NSString*)input output:(NSMutableArray *)output current:(NSMutableArray*)current start:(NSInteger)start;
+ (NSMutableArray *) generateAllParenthesis:(NSInteger)n;
+ (void) generateAllParenthesisBacktracking:(NSInteger)n output:(NSMutableArray *)output current:(NSMutableArray*)current start:(NSInteger)start end:(NSInteger)end;
+ (BOOL) areParenthesisValid:(NSArray*)s;
+ (NSArray*) possiblePathsForMatrix:(NSArray*)matrix toRow:(NSInteger)row toCol:(NSInteger)col;
+ (void) generateAllPossiblePathsForMatrix:(NSArray*)matrix output:(NSMutableArray*)output current:(NSMutableArray*)current row:(NSInteger) cRow col:(NSInteger)cCol m:(NSInteger)m n:(NSInteger)n;
+ (NSInteger) computeGCD:(NSInteger)num1 num2:(NSInteger)num2;

@end
