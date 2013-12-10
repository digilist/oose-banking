//
//  KBATransferController.h
//  Kiba
//
//  Created by Schaarschmidt, Michael on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAViewController.h"

@interface KBATransContr : KBAViewController

@property (nonatomic, weak) IBOutlet UILabel* amountLabel;
@property (nonatomic, weak) IBOutlet UILabel* sourceAccountLabel;
@property (nonatomic, weak) IBOutlet UILabel* destinationAccountLabel;
@property (nonatomic, weak) IBOutlet UILabel* nameLabel;
@property (nonatomic, weak) IBOutlet UILabel* dateLabel;
@property (nonatomic, weak) IBOutlet UITextField* amountField;


@end

