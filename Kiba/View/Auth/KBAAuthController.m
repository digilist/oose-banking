//
//  KBAAuthController.m
//  Kiba
//
//  Created by 1fasselt on 26.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAAuthController.h"

@interface KBAAuthController ()

@end

@implementation KBAAuthController

/**
 *  Validates the auth code.
 *
 *  @param sender
 */
- (IBAction)validate:(id)sender {
    [self.authMessage setHidden:NO];
    
    if([self.authCodeField.text isEqualToString:@"123"]){
        self.authMessage.text = @"Validierung erfolgreich!";
    } else {
        self.authMessage.text = @"falsche Eingabe";
    }
    //TODO : user auf authed = true setzen
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
