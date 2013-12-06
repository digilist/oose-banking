//
//  KBASelfServiceController.m
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBASelfServContr.h"
#import "KBATransContr.h"
#import "KBAStatemContr.h"
#import "KBADocContr.h"

@interface KBASelfServContr ()

@property (nonatomic, strong) IBOutlet KBATransTableContr *subMoneyTransferContr;
@property (nonatomic, strong) IBOutlet KBADocTableContr *subDocContr;

@property (nonatomic, weak) IBOutlet UIButton *connectButton;
@property (nonatomic, weak) IBOutlet UIButton *transferButton;
@property (nonatomic, weak) IBOutlet UIButton *transactionOverviewButton;
@property (nonatomic, weak) IBOutlet UIButton *documentsButton;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *firstToSecondElement;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *secondToThirdElement;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *middleWidthElements;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *subDocTableHeight;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *subMoneyTableHeight;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topConstraintElements;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topConstraintTitle;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *leftConstraintElements;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *indicator;
@end

@implementation KBASelfServContr

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self respondToOrientation: UIApplication.sharedApplication.statusBarOrientation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  Set constraints and show/hide kiba icon
 *  based on iPad-orientation
 *
 *  @param orientation orientation to respond to
 */
-(void)respondToOrientation:(UIInterfaceOrientation)orientation
{
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [UIView animateWithDuration:0.5
                         animations:^{
                             [self.imageView setHidden:NO];
                             //set height between elements
                             self.firstToSecondElement.constant = 110;
                             self.secondToThirdElement.constant = 110;
                             self.middleWidthElements.constant = 80;
                             //height of top element to top of view
                             self.topConstraintElements.constant = 230;
                             //width to left of elements
                             self.leftConstraintElements.constant = 80;
                             //table-view sizes
                             self.subMoneyTableHeight.constant = 150;
                             self.subDocTableHeight.constant = 150;
                             [self.view layoutIfNeeded];
                         }];

    }
    else{
        [UIView animateWithDuration:0.5
                         animations:^{
                             [self.imageView setHidden:YES];
                             //set height between elements
                             self.firstToSecondElement.constant = 98;
                             self.secondToThirdElement.constant = 98;
                             self.middleWidthElements.constant = 60;
                             //height of top element to top  of view
                             self.topConstraintElements.constant = 200;
                             //width to left of elements
                             self.leftConstraintElements.constant = 54;
                             //table-view sizes
                             self.subMoneyTableHeight.constant = 120;
                             self.subDocTableHeight.constant = 120;
                             [self.view layoutIfNeeded];
                         }];

    }
}


-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                               duration:(NSTimeInterval)duration
{
    [self respondToOrientation:toInterfaceOrientation];
}

/**
 *  Action to connect to KiBa-station.
 *
 *  @param sender
 */
- (IBAction)connect:(id)sender
{
    self.indicator.hidden = NO;
    [self.indicator startAnimating];

    dispatch_queue_t work = dispatch_queue_create("work", NULL);
    dispatch_async(work, ^{
        [NSThread sleepForTimeInterval:2];
        //connect here

        dispatch_async(dispatch_get_main_queue(), ^{
    
            [self.indicator stopAnimating];
            self.indicator.hidden = YES;
            self.connectButton.enabled = NO;
            [self.connectButton setTitle:@"mit KiBa-Station verbunden" forState: UIControlStateNormal];
            [self.connectButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        });
    
    });
    
}

/**
 *  Changes view to transfer view.
 *
 *  @param sender
 */
- (IBAction)changeToTransferView:(id)sender
{
    [self.navigationController pushViewController:[KBATransContr new] animated:YES];
}

/**
 *  Changes view to statement view.
 *
 *  @param sender
 */
- (IBAction)changeToStatementView:(id)sender
{
    [self.navigationController pushViewController:[KBAStatemContr new] animated:YES];
}

/**
 *  Changes view to statement view.
 *
 *  @param sender
 */
- (IBAction)changeToDocumentView:(id)sender
{
    [self.navigationController pushViewController:[KBADocContr new] animated:YES];
}

@end
