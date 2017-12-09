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
    A = @[@"abc", @"ab", @"abd"];
    retString = [StringsProblems longestCommonPrefix:A];
    NSLog(@"**** longestCommonPrefix: prefix = %@", retString);
 
    retBool = [StringsProblems isSubsequence:@"euni" inString:@"sequence"];
    NSLog(@"**** isSubsequence: %@", retBool?@"YES":@"NO");
   
    // LINKEDLIST problems
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
    
    // HASHING problems
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

}

@end
