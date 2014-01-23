//
//  KBAInfoController.m
//  Kiba
//
//  Created by 1jendryc on 21.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAInfoController.h"

@interface KBAInfoController ()

@end

@implementation KBAInfoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.preferredContentSize = self.view.frame.size;
        
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
