//
//  KBAAuthController.h
//  Kiba
//
//  Created by 1fasselt on 26.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAViewController.h"

@interface KBAAuthController : KBAViewController

@property (nonatomic, weak) IBOutlet UITextField *authCodeField;
@property (nonatomic, weak) IBOutlet UILabel *authMessage;

@end
