//
//  KBAAccountController.h
//  Kiba
//
//  Created by 1fasselt on 26.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAViewController.h"

@interface KBAAccountController : KBAViewController
@property IBOutlet UITextField* reciever;
@property IBOutlet UITextField* accountNr;
@property IBOutlet UITextField* blz;

@property (nonatomic, weak) IBOutlet UITextField* tan1;
@property (nonatomic,weak) IBOutlet UILabel* tanLabel;


-(IBAction)sendTransaction:(UIButton*)sender;

-(IBAction)coloringField:(id)sender;

@end
