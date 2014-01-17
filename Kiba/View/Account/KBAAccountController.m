//
//  KBAAccountController.m
//  Kiba
//
//  Created by 1fasselt on 26.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAAccountController.h"

@interface KBAAccountController ()
@property NSPredicate* regexAccountNr;
@property  NSPredicate* regexBlz;

@end

@implementation KBAAccountController

- (id)init
{
    self = [super init];
    if (self) {
        self.needsAuthentification = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //init scrollview
    [self.scrollView contentSizeToFit];
    //set initial scroll position
    CGPoint bottomOffset = CGPointMake(0, [self.scrollView contentSize].height);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
    
    //init textfields
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
    
    _tan1.hidden = YES;
    [_tan1 setTintColor:KBATintColor];
    _tan1.placeholder = @"Bitte geben Sie die TAN an";
 
    //to dismiss keyboard if user taps outside of textfields
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    //regexes to check if input for textfield is valid
    _regexAccountNr = [NSPredicate predicateWithFormat: @"SELF MATCHES '\\\\d{10}'"];
    _regexBlz = [NSPredicate predicateWithFormat: @"SELF MATCHES '\\\\d{8}'"];

}

/**
 *  Dismiss Keyboard if user taps outside of textfields.
 */
-(void)dismissKeyboard
{
    //dismiss active textfield
    for (UITextField * activeTextField in self.scrollView.subviews) {
        if ([activeTextField isKindOfClass:[UITextField class]]) {
            if ([activeTextField isEditing]){
                [activeTextField resignFirstResponder];
            }
        }
    }
}

/**
 *  Progress transaction on clicked button.
 *
 *  @param sender clicked button
 */
-(IBAction)progressTransaction:(KBAButton *)sender
{
    //if "Weiter" was pressed progress/set focus to tan textfield
    if ([sender.titleLabel.text isEqualToString:@"Weiter"]) {
        self.tan1.hidden = NO;
        self.tanLabel.hidden = NO;
        [sender setTitle:@"Bestätigen" forState:UIControlStateNormal];
        [self.tan1 becomeFirstResponder];
        return;
    }
    
    //if "Bestätigen" was pressed check textfields and tan
    else if ([sender.titleLabel.text isEqualToString:@"Bestätigen"]) {
        
        //if not all fields valid
        if (!([self isValidInput:self.accountNr.text forTextfield:self.regexAccountNr]
             || [self isValidInput:self.blz.text forTextfield:self.regexBlz])) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Eingaben prüfen"
                                  message:@"Nicht alle Felder wurden korrekt ausgefüllt. Bitte prüfen sie ihre Eingaben."
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            [self.receiver becomeFirstResponder];
            return;
        }
        
        //if tan not correct
        else if ([self.tan1.text isEqualToString:@""]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"TAN"
                                      message:@"Die von ihnen eingegebene TAN war nicht korrekt."
                                      delegate:nil
                                      cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
            [alert show];
            [self.tan1 becomeFirstResponder];
            return;
        }
        
        //if tan correct & input valid, execute transaction
        else{
            [self.tan1 resignFirstResponder];
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Überweisung"
                                  message:@"Bitte bestätigen sie ihre Überweisung!"
                                  delegate:self
                                  cancelButtonTitle:@"Abbrechen"
                                  otherButtonTitles:@"Bestätigen", nil];
            [alert show];
            return;
        }
    }
}

/**
 *  Respond to succeeded transaction, after user clicked "ok" in alertview
 *
 *  @param alertView  the alert view
 *  @param buttonIndex clicked button
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        self.tan1.hidden = YES;
        self.tanLabel.hidden = YES;
        for (JVFloatLabeledTextField *textfield in self.scrollView.subviews ) {
            if ([textfield isKindOfClass:[UITextField class]]) {
                textfield.text = @"";
            }
        }
        [self.executeButton setTitle:@"Weiter" forState:UIControlStateNormal];
    }
}

/**
 *  Color textfields based on regex validation.
 *
 *  @param sender edited textfield
 */
-(IBAction)coloringField:(JVFloatLabeledTextField *)sender{
    
    self.regexMap = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory
                                          valueOptions:NSMapTableWeakMemory];
    [self.regexMap setObject:_regexAccountNr forKey:self.accountNr];
    [self.regexMap setObject:_regexBlz forKey:self.blz];
    

    if([self isValidInput:sender.text forTextfield: [self.regexMap objectForKey:sender]]){
        sender.floatingLabelTextColor  =
            [UIColor colorWithRed:0.316 green:0.560 blue:0.380 alpha:1.000];
    }
    
    else{
        sender.floatingLabelTextColor  =
            [UIColor colorWithRed:0.560 green:0.131 blue:0.173 alpha:1.000];
    }
}

/**
 *  Check if input is valid for given textfield.
 *
 *  @param input string to check
 *  @param regex regex to check with
 *
 *  @return bool: input was valid or not
 */
-(Boolean)isValidInput:(NSString*)input forTextfield:(NSPredicate*)regex{
    
    // TODO: Eine Map mit Regex Ausdücken als Value, die Textfieldobjekte werden als Key reingeworfen.
    if([regex evaluateWithObject:input]){
        return TRUE;
    }
    else {
        return FALSE;
    }
}

@end
