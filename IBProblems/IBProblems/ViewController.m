//
//  ViewController.m
//  IBProblems
//
//  Created by Kavita Gaitonde on 11/18/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

#import "ViewController.h"
#import "IBProblems.h"
#import "ArraysProblems.h"
#import "StringsProblems.h"
#import "ListNode.h"
#import "LinkedListsProblems.h"
#import "HashingProblems.h"
#import "BinarySearchProblems.h"
#import "RecursionProblems.h"
#import "BitManipulationProblems.h"
#import "StackAndQueuesProblems.h"
#import "GraphProblems.h"
#import "TreesAndHeaps.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Invoke problems
    NSInteger input, input1, input2;
    NSArray *A, *B, *retArray;
    NSMutableArray *mA;
    NSMutableArray *result;
    NSInteger retval;
    ListNode *list1, *list2, *list3;
    BOOL retBool;
    NSString *retString;
    NSString *str1;
    
    /*
    // ************ CHECKPOINT 2 PROBLEMS **************
    
    input = 5;
    result = [IBProblems concentric2DPrint:input];
    NSLog(@"**** concentric2DPrint: For %ld : %@", input, result);

    // ************ CHECKPOINT 3 PROBLEMS **************
    input = 3;
    A = @[@(2), @(1), @(4), @(3), @(2)];
    retval = [IBProblems kthsmallest:A B:input];
    NSLog(@"**** kthsmallest: For %ld : %ld", input, retval);
    
    A = @[@(10), @(5), @(1), @(0), @(2)];
    input = 6;
    input2 = 8;
    retval = [IBProblems numRange:[NSMutableArray arrayWithArray:A] B:input C:input2];
    NSLog(@"**** numRange: For %ld,%ld : %ld", input, input2, retval);
    
    // ************ CHECKPOINT 4 PROBLEMS **************
    A = @[@(4), @(5), @(2), @(10)];
    result = [IBProblems nextGreater:[NSMutableArray arrayWithArray:A]];
    NSLog(@"**** nextGreater: %@", result);
    
    A = @[@(1), @(2), @(3), @(4), @(5)];
    ListNode *n = [ListNode initWithArray:A];
    ListNode *n1 = [IBProblems subtract:n];
    NSLog(@"**** subtract: %@", [n1 toString]);
    
    // ************ CHECKPOINT 5 PROBLEMS **************
    
    A = @[@(100), @(4), @(200), @(1), @(3), @(2)];
    retval = [IBProblems longestConsecutive:A];
    NSLog(@"**** longestConsecutive: Max sequence = %ld", retval);
    
    result = [NSMutableArray array];
    [IBProblems getUniquePermutations:[NSMutableArray arrayWithArray:A] result:result set:[NSMutableSet set] start:0 end:[A count]-1];
    NSLog(@"**** getUniquePermutations: %ld permutations", [result count]);
*/
    
/*
    // ARRAY problems
    //A = @[@(1), @(2), @(3)];
    A = @[@(2), @(3), @(5), @(5), @(7), @(11), @(11), @(11), @(11), @(13)];
    retval = [ArraysProblems deleteDuplicatesFromSortedArray:[A mutableCopy]];
    NSLog(@"**** deleteDuplicatesFromSortedArray: unique numbers = %ld", retval);
*/


    // STRING problems
    /*
    A = @[@"abc", @"ab", @"abd"];
    retString = [StringsProblems longestCommonPrefix:A];
    NSLog(@"**** longestCommonPrefix: prefix = %@", retString);
 
    retBool = [StringsProblems isSubsequence:@"euni" inString:@"sequence"];
    NSLog(@"**** isSubsequence: %@", retBool?@"YES":@"NO");
    */
    
    // LINKEDLIST problems
    /*
    A = @[@(2), @(3), @(5)];
    B = @[@(1), @(7), @(4)];
    list1 = [ListNode initWithArray:A];
    list2 = [ListNode initWithArray:B];
    list3 = [LinkedListsProblems  addTwoNumbers:list1 :list2];
    NSLog(@"**** addTwoNumbers: list1 =  %@", [list1 toString]);
    NSLog(@"**** addTwoNumbers: list2 =  %@", [list2 toString]);
    NSLog(@"**** addTwoNumbers: added =  %@", [list3 toString]);
    
    A = @[@(2), @(3), @(5), @(15), @(7), @(13), @(11), @(16), @(12), @(13)];
    list1 = [ListNode initWithArray:A];
    NSLog(@"**** reverseBetween: list = %@ from %ld to %ld", [list1 toString], input1, input2);
    input1 = 2;
    input2 = 5;
    list2 = [LinkedListsProblems  reverseBetween:list1 :input1 :input2];
    NSLog(@"**** reverseBetween: reversed = %@", [list2 toString]);
    
    A = @[@(2), @(3), @(5), @(7), @(13), @(16)];
    B = @[@(3), @(6), @(12), @(17), @(22), @(31)];
    list1 = [ListNode initWithArray:A];
    list2 = [ListNode initWithArray:B];
    list3 = [LinkedListsProblems  mergeTwoLists:list1 :list2];
    NSLog(@"**** mergeLists: list1 = %@", [list1 toString]);
    NSLog(@"**** mergeLists: list2 = %@", [list2 toString]);
    NSLog(@"**** mergeLists: merged = %@", [list3 toString]);
    
    A = @[@(2), @(3), @(5), @(7), @(13), @(16), @(11)];
    list1 = [ListNode initWithArray:A];
    NSLog(@"**** swapPairs: list input = %@", [list1 toString]);
    list2 = [LinkedListsProblems  swapPairs:list1];
    NSLog(@"**** swapPairs: list output = %@", [list2 toString]);
    
    ListNode *la = [[ListNode alloc] initWithData:1];
    ListNode *lb = [[ListNode alloc]  initWithData:2];
    la.next = lb;
    ListNode *lc = [[ListNode alloc]  initWithData:3];
    lb.next = lc;
    ListNode *ld = [[ListNode alloc]  initWithData:4];
    lc.next = ld;
    ListNode *le = [[ListNode alloc]  initWithData:5];
    ld.next = le;
    le.next = lc;
    list2 = [LinkedListsProblems  detectCycle:la];
    if (list2 != nil) {
        NSLog(@"**** detectCycle: %ld", list2.data);
    } else {
        NSLog(@"**** detectCycle: No cycle detected");
    }
    */
    
    // HASHING problems
    /*
    A = @[@(2), @(3), @(5), @(15), @(7), @(13), @(11), @(16), @(12), @(13)];
    result = [HashingProblems twoSum:A :20];
    NSLog(@"**** twoSum: %@", result);
    
    A = @[@(2), @(3), @(5), @(15), @(7), @(13), @(11), @(16), @(12), @(13)];
    retBool = [HashingProblems twoDiff:A :8];
    NSLog(@"**** twoDiff: %@", retBool?@"YES":@"NO");
   
    A = @[@"word",@"good",@"best",@"good"];//@[@"bar",@"foo",@"the"];  //@[@"foo", @"bar"];
    str1 = @"wordgoodgoodgoodbestword"; //@"barfoofoobarthefoobarman"; //@"barfoothefoobarman";
    NSLog(@"**** findSubstring in : %@ for array = %@", str1, A);
    retArray = [HashingProblems findSubstring:str1 :A];
    NSLog(@"**** findSubstring: %@", retArray);
    
    A = @[@"word",@"good",@"rowd"];
    NSLog(@"**** anagrams in : %@ ", A);
    retArray = [HashingProblems anagrams:A];
    NSLog(@"**** anagrams in : %@ ", retArray);
    */
    
    // BINARY SEARCH problems
    /*input = 11;
    retval = [BinarySearchProblems findSqrtOf:input];
    NSLog(@"**** findSqrtOf %ld : %ld ", input, retval);
    input = 100;
    retval = [BinarySearchProblems findSqrtOf:input];
    NSLog(@"**** findSqrtOf %ld : %ld ", input, retval);
    input = 56;
    retval = [BinarySearchProblems findSqrtOf:input];
    NSLog(@"**** findSqrtOf %ld : %ld ", input, retval);
    input = 144;
    retval = [BinarySearchProblems findSqrtOf:input];
    NSLog(@"**** findSqrtOf %ld : %ld ", input, retval);
    */
    
    // RECURSION problems
    /*A = @[@(1), @(2), @(3),];
    retArray = [RecursionProblems allPossibleSubsets:[A mutableCopy]];
    NSLog(@"**** allPossibleSubsets: %@", retArray);
    A = @[@(1), @(3), @(2)];
    retArray = [RecursionProblems allPossiblePermutations:[A mutableCopy]];
    NSLog(@"**** allPossiblePermutations: %@", retArray);
    A = @[@(1), @(3), @(2), @(4)];
    retArray = [RecursionProblems allPossibleCombinations:[A mutableCopy] forK:2];
    NSLog(@"**** allPossibleCombinations: %@", retArray);
    retArray = [RecursionProblems allPossibleCombinations:4 B:2];
    NSLog(@"**** allPossibleCombinations: %@", retArray);
    A = @[@(2), @(3), @(6), @(7)];
    retArray = [RecursionProblems allPossibleCombinationsSum:[A mutableCopy] forTotal:7];
    NSLog(@"**** allPossibleCombinationsSum: %@", retArray);
    retArray = [RecursionProblems palindromePartitioning:@"aab"];
    NSLog(@"**** palindromePartitioning: %@", retArray);
    /*retArray = [RecursionProblems generateAllParenthesis:3];
    NSLog(@"**** generateAllParenthesis: %@", retArray);
    A = @[@[@(1), @(2), @(3), @(4)],
          @[@(5), @(6), @(7), @(8)],
          @[@(9), @(10), @(11), @(12)],
          @[@(12), @(14), @(15), @(16)]];
    retArray = [RecursionProblems possiblePathsForMatrix:A toRow:3 toCol:3];
    NSLog(@"**** generateAllParenthesis: Total paths = %ld", [retArray count]);
    NSLog(@"**** generateAllParenthesis: %@", retArray);
    retval = [RecursionProblems computeGCD:6 num2:14];
    NSLog(@"**** computeGCD : %ld", retval);*/
    
    // BIT MANIPULATION problems
    /*retval = [BitManipulationProblems countOf1BitsIn:11];
    NSLog(@"**** countOf1BitsIn: %ld", retval);
    A = @[@(2), @(3), @(7), @(1), @(3), @(2), @(7)];
    retval = [BitManipulationProblems singleNumber:A];
    NSLog(@"**** countOf1BitsIn: %ld", retval);
    retval = [BitManipulationProblems reverseBits:2];
    NSLog(@"**** reverseBits: %ld", retval);*/

    // STACKS and QUEUES problems
    /*A = @[@"2", @"1", @"+", @"3", @"*"];
    retval = [StackAndQueuesProblems evalRPN:A];
    NSLog(@"**** evalRPN: %ld", retval);*/
    
    // GRAPH problems
    /*GraphNode *g1 = [[GraphNode alloc]initWithData:1];
    GraphNode *g2 = [[GraphNode alloc]initWithData:2];
    GraphNode *g3 = [[GraphNode alloc]initWithData:3];
    GraphNode *g4 = [[GraphNode alloc]initWithData:4];
    [g1 addNeighbor:g2];
    [g1 addNeighbor:g4];
    [g2 addNeighbor:g1];
    [g2 addNeighbor:g3];
    [g3 addNeighbor:g2];
    [g3 addNeighbor:g4];
    [g4 addNeighbor:g3];
    [g4 addNeighbor:g1];
    NSLog(@"**** cloneGraph: input");
    [GraphProblems bfsTraversal:g1];
    GraphNode *clonedGraph = [GraphProblems cloneGraph:g1];
    NSLog(@"**** cloneGraph: output");
    [GraphProblems bfsTraversal:clonedGraph];
    A = @[@(-1), @(0)]; //@[@(-1), @(0), @(0)]; @[@(-1), @(0), @(0), @(0), @(3)];
    retval = [GraphProblems largestDistance:[A mutableCopy]];
    NSLog(@"**** largestDistance: %ld", retval);
    A = @[@(1), @(2)];
    B = @[@(2), @(3)];
    retval = [GraphProblems canFinishCourseWithPrerequisites:3 :A :B];
    NSLog(@"**** largestDistance: %ld", retval);
    A = @[@[@(1), @(2)], @[@(0), @(2)], @[@(0), @(1)]];
    retval = [GraphProblems costForLibrary:A roads:3 cities:3 libCost:2 roadCost:1];
    NSLog(@"**** costForLibrary: %ld", retval);
    A = @[@[@(1), @(2)], @[@(0), @(2), @(3)], @[@(0), @(1), @(3)], @[@(1), @(2)], @[@(5)], @[@(4)]];
    retval = [GraphProblems costForLibrary:A roads:6 cities:6 libCost:2 roadCost:5];
    NSLog(@"**** costForLibrary: %ld", retval);
    A = @[@[@(0), @(1)], @[@(2), @(3)], @[@(0), @(4)]];
    retval = [GraphProblems journeyToTheMoon:A astronauts:5];
    NSLog(@"**** journeyToTheMoon:A: %ld", retval);*/
    mA = [NSMutableArray array];
    NSMutableArray *row = [NSMutableArray array];
    [row addObject:@"X"];
    [row addObject:@"X"];
    [row addObject:@"X"];
    [row addObject:@"X"];
    [mA addObject:row];
    row = [NSMutableArray array];
    [row addObject:@"X"];
    [row addObject:@"O"];
    [row addObject:@"O"];
    [row addObject:@"X"];
    [mA addObject:row];
    row = [NSMutableArray array];
    [row addObject:@"X"];
    [row addObject:@"X"];
    [row addObject:@"O"];
    [row addObject:@"X"];
    [mA addObject:row];
    row = [NSMutableArray array];
    [row addObject:@"X"];
    [row addObject:@"O"];
    [row addObject:@"X"];
    [row addObject:@"X"];
    [mA addObject:row];
    mA = [GraphProblems captureRegionsOnBoard:mA];
    NSLog(@"**** captureRegionsOnBoard: %@", mA);
    
    // TREES AND HEAPS problems
    /*TreeNode *g1 = [[TreeNode alloc]initWithData:1];
    TreeNode *g2 = [[TreeNode alloc]initWithData:2];
    TreeNode *g3 = [[TreeNode alloc]initWithData:3];
    TreeNode *g4 = [[TreeNode alloc]initWithData:4];
    TreeNode *g5 = [[TreeNode alloc]initWithData:5];
    [g1 setLeft:g2];
    [g1 setRight:g3];
    [g2 setLeft:g4];
    [g2 setRight:g5];
    retval = [TreesAndHeaps diameter:g1];
    NSLog(@"**** diameter of tree: %ld", retval);*/
}

@end
