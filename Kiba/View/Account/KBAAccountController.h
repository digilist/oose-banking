//
//  KBAAccountController.h
//  Kiba
//
//  Created by 1fasselt on 26.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAViewController.h"
#import "JVFloatLabeledTextField.h"

@interface KBAAccountController : KBAViewController
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *receiver;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *accountNr;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *blz;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *amount;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *use;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *tan1;
@property (nonatomic,weak) IBOutlet UILabel* tanLabel;

@property NSMapTable* regexMap;


-(IBAction)sendTransaction:(KBAButton *)sender;

-(IBAction)coloringField:(id)sender;

@end
