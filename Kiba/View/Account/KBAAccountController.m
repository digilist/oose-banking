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
    _receiver.placeholder = @"Empfänger hier eingeben";
    _receiver.floatingLabel.text = @"Empfänger";
    [_receiver setup];
    
    _accountNr.placeholder = @"Kontonummer";
    _accountNr.floatingLabel.text = @"Kontonummer";
    [_accountNr setup];
    
    _blz.placeholder = @"BLZ";
    _blz.floatingLabel.text = @"BLZ";
    [_blz setup];
    
    _amount.placeholder = @"Betrag";
    _amount.floatingLabel.text = @"Betrag";
    [_amount setup];
    
    _use.placeholder = @"Verwendungszweck";
    _use.floatingLabel.text = @"Verwendungszweck";
    [_use setup];
    
 //   _tan1.placeholder = @"TAN";
 //   _tan1.floatingLabel.text = @"TAN";
 //  [_tan1 setup];
    _tan1.hidden = YES;
    _tan1.placeholder = @"Bitte geben Sie die TAN an";
 

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sendTransaction:(KBAButton *)sender{
    self.tan1.hidden = NO;
    self.tanLabel.hidden = NO;
    
    
}

-(IBAction)coloringField:(JVFloatLabeledTextField *)sender{

    //regex
    NSPredicate* regexAccountNr = [NSPredicate predicateWithFormat: @"SELF MATCHES '\\\\d{10}'"];
    NSPredicate* regexBlz = [NSPredicate predicateWithFormat: @"SELF MATCHES '\\\\d{8}'"];
    
    
    self.regexMap = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory
                                          valueOptions:NSMapTableWeakMemory];
    [self.regexMap setObject:regexAccountNr forKey:self.accountNr];
    [self.regexMap setObject:regexBlz forKey:self.blz];
    

    if([self isValidInput:sender.text forTextfield: [self.regexMap objectForKey:sender]]){
        sender.floatingLabelTextColor  =
            [UIColor colorWithRed:0.316 green:0.560 blue:0.380 alpha:1.000];
    }
    
    else{
        sender.floatingLabelTextColor  =
            [UIColor colorWithRed:0.560 green:0.131 blue:0.173 alpha:1.000];
    }
}

-(Boolean)isValidInput:(NSString*)input forTextfield:(NSPredicate*)regex{
    
    
    // TODO: Eine Map mit Regex Ausdücken als Value, die Textfieldobjekte werden als Key reingeworfen.
    
    if([regex evaluateWithObject:input]){
        
    
    return TRUE;
    }
    else return FALSE;
   
}

@end
