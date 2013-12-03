//
//  KBASelfServiceController.h
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAViewController.h"

@interface KBASelfServiceController : KBAViewController

@property (nonatomic, weak) IBOutlet UIButton *connectButton;
@property (nonatomic, weak) IBOutlet UIButton *transferButton;
@property (nonatomic, weak) IBOutlet UIButton *transactionOverviewButton;
@property (nonatomic, weak) IBOutlet UIButton *documentsButton;
@property (nonatomic, weak) IBOutlet UIView *transferView;

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *circle;


@end
