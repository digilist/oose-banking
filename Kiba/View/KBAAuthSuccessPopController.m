//
//  KBAAuthSuccessPopController.m
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 14.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAAuthSuccessPopController.h"

@interface KBAAuthSuccessPopController ()

@end

@implementation KBAAuthSuccessPopController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"KBAAuthSuccessPopController" bundle:nibBundleOrNil];
    if (self) {
        
        self.preferredContentSize = CGSizeMake(293.0, 119.0);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
