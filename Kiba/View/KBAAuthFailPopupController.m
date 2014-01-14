//
//  KBAAuthPopupController.m
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 14.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAAuthFailPopupController.h"

@interface KBAAuthFailPopupController ()

@end

@implementation KBAAuthFailPopupController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"KBAAuthFailPopupController" bundle:nibBundleOrNil];
    if (self) {
        
       self.preferredContentSize = CGSizeMake(400.0, 210.0);
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
