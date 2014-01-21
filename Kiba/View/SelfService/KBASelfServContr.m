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
#import "KBAStatemTableContr.h"
#import "SVProgressHUDViewController.h"
#import "SVProgressHUD.h"
#import "KBAInfoController.h"

@interface KBASelfServContr ()

@property (nonatomic, strong) IBOutlet KBATransTableContr *subMoneyTransferContr;
@property (nonatomic, strong) IBOutlet KBADocTableContr *subDocContr;
@property (nonatomic, strong) IBOutlet KBAStatemTableContr *subStatemContr;

@property (nonatomic, weak) IBOutlet KBAButton *connectButton;
@property (nonatomic, weak) IBOutlet KBAButton *transferButton;
@property (nonatomic, weak) IBOutlet KBAButton *transactionOverviewButton;
@property (nonatomic, weak) IBOutlet KBAButton *documentsButton;
@property (nonatomic, weak) IBOutlet KBAButton *infoButton;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topConstraintTitle;
@property NSTimer *timer;

//popover
@property (strong) UIPopoverController *popController;
@property (nonatomic, strong) KBAInfoController *serviceInfoController;


@end

@implementation KBASelfServContr

- (id)init
{
    self = [super init];
    if (self) {
        self.needsAuthentification = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.serviceInfoController = [KBAInfoController new];
    
    [self respondToOrientation: UIApplication.sharedApplication.statusBarOrientation
        inAnimatedDurationTime: 0.5];
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
                             
                         }
                         //animations if switch to landscape-mode
                         else{
                             
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
 *  Action to connect to KiBa-station.
 *
 *  @param sender
 */
- (IBAction)connect:(id)sender
{
    NSRunLoop *r = [NSRunLoop mainRunLoop];
    self.timer = [NSTimer timerWithTimeInterval:0.01
                                         target:self
                                       selector:@selector(respondToTimer)
                                       userInfo:nil
                                        repeats:YES];
    [r addTimer: self.timer forMode:NSDefaultRunLoopMode];
}

/**
 *  Will be executed when the timer fires an event.
 */
-(void)respondToTimer
{
    static float time = 0.00;
    if (time <= 1.5) {
        [SVProgressHUD showProgress:time
                             status:@"Verbinden..."
                           maskType:SVProgressHUDMaskTypeGradient];
        time += 0.01;
    }
    else{
        [SVProgressHUD dismiss];
        time = 0;
        [self.timer invalidate];
        
        if (true){
            [SVProgressHUD showSuccessWithStatus:@"Erfolgreich" ];
            self.connectButton.enabled = NO;
            [self.connectButton setTitle:@"mit KiBa-Station verbunden" forState:UIControlStateDisabled];
            [self.connectButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"Fehlgeschlagen!"];
        }
        
    }
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

-(IBAction)requestInformation: (UIButton *) sender {
    [self showPopover:sender withPopoverController: self.serviceInfoController
         andDirection:UIPopoverArrowDirectionAny
            andOffset:CGPointMake(0, 15)];
}

/**
 *  Show a Popover
 */
- (void)showPopover: (UIButton *)sender withPopoverController:(UIViewController *)popoverController
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

@end
