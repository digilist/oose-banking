//
//  KBAFinanceController.h
//  Kiba
//
//  Created by 1jendryc on 07.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAViewController.h"

@interface KBAFinanceController : KBAViewController

- (IBAction)updateValue: (UISlider *) slider;

-(IBAction)mortgageOver: (UISlider *) slider;

-(IBAction)calculateRates;


@end
