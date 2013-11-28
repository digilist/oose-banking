//
//  KBAAccountController.m
//  Kiba
//
//  Created by 1fasselt on 26.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAAccountController.h"

@interface KBAAccountController ()

@end

@implementation KBAAccountController

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

-(IBAction)sendTransaction:(UIButton*)sender{
    self.tan1.hidden = NO;
    self.tanLabel.hidden = NO;
}

-(IBAction)coloringField:(id)sender{

    if([self isValidInput:self.accountNr.text]){
                self.accountNr.backgroundColor = [UIColor greenColor];
    }
    
    else self.accountNr.backgroundColor = [UIColor redColor];
              }

-(Boolean)isValidInput:(NSString*)input{
    NSPredicate* regex = [NSPredicate predicateWithFormat: @"SELF MATCHES '\\\\d{13}'"];
    
    
    
    if([regex evaluateWithObject:input]){
        
    
    return TRUE;
    }
    else return FALSE;
   
}

@end
