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
    NSInteger input, input2;
    NSArray *A;
    NSMutableArray *result;
    NSInteger retval;
   
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
    
    // Arrays problems
    //A = @[@(1), @(2), @(3)];
    A = @[@(2), @(3), @(5), @(5), @(7), @(11), @(11), @(11), @(11), @(13)];
    retval = [ArraysProblems deleteDuplicatesFromSortedArray:[A mutableCopy]];
    NSLog(@"**** deleteDuplicatesFromSortedArray: unique numbers = %ld", retval);
}

@end
