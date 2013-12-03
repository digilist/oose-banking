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
    //regex

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

-(IBAction)coloringField:(UITextField*)sender{

    //regex
    NSPredicate* regexAccountNr = [NSPredicate predicateWithFormat: @"SELF MATCHES '\\\\d{10}'"];
    NSPredicate* regexBlz = [NSPredicate predicateWithFormat: @"SELF MATCHES '\\\\d{8}'"];
    
    
    self.regexMap = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory
                                          valueOptions:NSMapTableWeakMemory];
    [self.regexMap setObject:regexAccountNr forKey:self.accountNr];
    [self.regexMap setObject:regexBlz forKey:self.blz];
    

    if([self isValidInput:sender.text forTextfield: [self.regexMap objectForKey:sender]]){
                sender.backgroundColor = [UIColor greenColor];
    }
    
    else sender.backgroundColor = [UIColor redColor];
              }
-(Boolean)isValidInput:(NSString*)input forTextfield:(NSPredicate*)regex{
    
    
    // TODO: Eine Map mit Regex Ausdücken als Value, die Textfieldobjekte werden als Key reingeworfen.
    
    if([regex evaluateWithObject:input]){
        
    
    return TRUE;
    }
    else return FALSE;
   
}

@end
