//
//  KBAViewController.m
//  Kiba
//
//  Created by 1fasselt on 26.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAViewController.h"

@interface KBAViewController ()

@end

@implementation KBAViewController

- (id) init {
    NSString *className = NSStringFromClass([self class]);
    self = [self initWithNibName:className bundle:Nil];
    
    if (self) {
        
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [self init];
    if (self) {
        
    }
    return self;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
