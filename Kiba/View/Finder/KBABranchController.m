//
//  KBABranchController.m
//  Kiba
//
//  Created by 1fasselt on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAExchangeRateDao.h"
#import "KBADependencyInjector.h"

#import "KBABranchController.h"
#import "KBACurrencyContr.h"
#import "KBAAppointmentContr.h"

#import "Branch.h"
#import "Currency.h"

@interface KBABranchController ()

@property Branch *branch;
@property Currency *selectedCurrency;

// popovercontroller
@property (strong) UIPopoverController *popController;
@property (strong) UIViewController *popoverViewController;

@property (nonatomic, strong) KBACurrencyContr *currencyContr;
@property (nonatomic, strong) KBAAppointmentContr *appointmentContr;

@end

@implementation KBABranchController

- (id)initWithBranch: (Branch *) branch {
    self = [self init];
    
    if (self)
    {
        self.branch = branch;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.currencyContr = [KBACurrencyContr new];
    self.appointmentContr = [KBAAppointmentContr new];
    
    NSMutableString *openingHours = [NSMutableString new];
    for (int i = 0; i < self.branch.openHours.count; i++)
    {
        [openingHours appendFormat:@"%@\n", [self.branch.openHours[i] formatted]];
    }
    
    // Fill labels
    self.openingHoursLabel.text = openingHours;
    [self.openingHoursLabel sizeToFit];
    
    self.branchLabel.text = self.branch.name;
    [self.branchLabel sizeToFit];
    
    self.contactImage.image = self.branch.consultant.image;
    self.contactPersonLabel.text = self.branch.consultant.fullName;
    
    [self respondToOrientation: UIApplication.sharedApplication.statusBarOrientation
        inAnimatedDurationTime: 0.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  Set constraints based on iPad-orientation
 *
 *  @param orientation orientation to respond to
 */
-(void)respondToOrientation:(UIInterfaceOrientation)orientation
     inAnimatedDurationTime:(double)duration
{
    [UIView animateWithDuration:duration
                     animations:^{
                         //animations if switch to portrait-mode
                         if (orientation == UIInterfaceOrientationPortrait ||
                             orientation == UIInterfaceOrientationPortraitUpsideDown) {
                             
                             self.bottomConstraint.constant = 200;
                         }
                         else{
                             self.bottomConstraint.constant = 20;
                         }
                         [self.view setNeedsLayout];
                     }];
}


-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                               duration:(NSTimeInterval)duration
{
    [self respondToOrientation:toInterfaceOrientation
        inAnimatedDurationTime:0.2];
}


/**
 *  Show the currency exhange view.
 */
- (IBAction)showCurrencyPopover:(KBAButton *)sender {
    [self showPopover:sender withPopoverController:self.currencyContr
         andDirection:UIPopoverArrowDirectionAny
            andOffset:CGPointMake(0, 15)];
}

/**
 *  Show the appointment request view.
 */
- (IBAction)showAppointmentPopover:(KBAButton *)sender {
    [self showPopover:sender withPopoverController:self.appointmentContr
         andDirection:UIPopoverArrowDirectionUp
            andOffset:CGPointMake(60, 23)];
}


/**
 *  Show a Popover
 */
- (void)showPopover:(KBAButton *)sender withPopoverController:(UIViewController *)popoverController
       andDirection: (UIPopoverArrowDirection) popoverDirection
          andOffset: (CGPoint) offset{
    self.popController = [[UIPopoverController alloc]
                          initWithContentViewController:popoverController];
    
    CGPoint buttonPosition = sender.frame.origin;
    buttonPosition.x += sender.superview.frame.origin.x;
    buttonPosition.y += sender.superview.frame.origin.y;
    
    buttonPosition.x += offset.x;
    buttonPosition.y += offset.y;
    
    //given size as arg. is irrelevant
    //size is defined through size of view in popover
    [self.popController presentPopoverFromRect:CGRectMake(buttonPosition.x, buttonPosition.y, 1, 1)
                                        inView:self.view
                      permittedArrowDirections:popoverDirection
                                      animated:YES];
}
/**
 *  Start a phone call
 *
 */
-(IBAction)makeCall:(KBAButton *)sender{
        NSLog(@"Call %@", self.branch.phoneNumber);
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.branch.phoneNumber]];
    }


@end
