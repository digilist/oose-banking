//
//  KBASelfServiceController.h
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAViewController.h"
#import "KBASubTransferController.h"
#import "KBASubDocumentController.h"


@interface KBASelfServiceController : KBAViewController

@property (nonatomic, strong) IBOutlet KBASubTransferController *subMoneyTransferContr;
@property (nonatomic, strong) IBOutlet KBASubDocumentController *subDocContr;
@property (nonatomic, weak) IBOutlet UIButton *connectButton;
@property (nonatomic, weak) IBOutlet UIButton *transferButton;
@property (nonatomic, weak) IBOutlet UIButton *transactionOverviewButton;
@property (nonatomic, weak) IBOutlet UIButton *documentsButton;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *firstToSecondElement;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *subDocTableHeight;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *subMoneyTableHeight;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *secondToThirdElement;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topConstraintElements;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topConstraintTitle;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *leftConstraintElements;
@property (nonatomic, weak) IBOutlet UIView *transferView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *circle;


@end
