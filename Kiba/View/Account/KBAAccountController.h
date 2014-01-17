//
//  KBAAccountController.h
//  Kiba
//
//  Created by 1fasselt on 26.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAViewController.h"
#import "JVFloatLabeledTextField.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "KBAAlertView.h"

@interface KBAAccountController : KBAViewController <KBAAlertViewDelegate>

@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *receiver;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *accountNr;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *blz;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *amount;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *use;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *tan1;
@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic,weak) IBOutlet UILabel* tanLabel;
@property (nonatomic,weak) IBOutlet UIButton* executeButton;

@property NSMapTable* regexMap;


-(IBAction)progressTransaction:(KBAButton *)sender;

-(IBAction)coloringField:(id)sender;

@end
