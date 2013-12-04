//
//  KBASelfServiceController.m
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBASelfServiceController.h"
#import "KBATransferController.h"
#import "KBAStatementController.h"
#import "KBADocumentController.h"

@interface KBASelfServiceController ()

@end

@implementation KBASelfServiceController

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
    
    //additional setup after loading the view from its nib.
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
    [self.subMoneyTransferContr.tableView reloadData];
    
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [UIView animateWithDuration:0.5
                         animations:^{
                             [self.imageView setHidden:NO];
                             //set height between elements
                             self.firstToSecondElement.constant = 110;
                             self.secondToThirdElement.constant = 110;
                             //height of top element to top of view
                             self.topConstraintElements.constant = 290;
                             //width to left of elements
                             self.leftConstraintElements.constant = 70;
                             //table-view sizes
                             self.subDocTableHeight.constant = 150;
                             self.subMoneyTableHeight.constant = 150;
//                             self.topConstraintTitle.constant = 90;
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
                             //height of top element to top  of view
                             self.topConstraintElements.constant = 200;
                             //width to left of elements
                             self.leftConstraintElements.constant = 54;
                             //table-view sizes
                             self.subDocTableHeight.constant = 120;
                             self.subMoneyTableHeight.constant = 120;
//                              self.topConstraintTitle.constant = 90;
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
    self.circle.hidden = NO;
    [self.circle startAnimating];


    dispatch_queue_t work = dispatch_queue_create("work", NULL);
    dispatch_async(work, ^{
        [NSThread sleepForTimeInterval:2];
        //connect here

        dispatch_async(dispatch_get_main_queue(), ^{
    
            [self.circle stopAnimating];
            self.circle.hidden = YES;
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
    [self.navigationController pushViewController:[KBATransferController new] animated:YES];
}

/**
 *  Changes view to statement view.
 *
 *  @param sender
 */
- (IBAction)changeToStatementView:(id)sender
{
    [self.navigationController pushViewController:[KBAStatementController new] animated:YES];
}

/**
 *  Changes view to statement view.
 *
 *  @param sender
 */
- (IBAction)changeToDocumentView:(id)sender
{
    [self.navigationController pushViewController:[KBADocumentController new] animated:YES];
}

@end
