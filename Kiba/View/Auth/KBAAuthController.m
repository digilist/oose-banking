//
//  KBAAuthController.m
//  Kiba
//
//  Created by 1fasselt on 26.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAAuthController.h"
#import "SVProgressHUDViewController.h"
#import "SVProgressHUD.h"
#import "JVFloatLabeledTextField.h"
#import "KBAAuthAdvantagesController.h"
#import "KBADependencyInjector.h"
#import "Customer.h"
#import "KBAAuth.h"

//const static CGFloat kJVFieldHeight = 44.0f;
//const static CGFloat kJVFieldHMargin = 10.0f;
//const static CGFloat kJVFieldFontSize = 16.0f;
//const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

@interface KBAAuthController ()

@property (strong) UIPopoverController *popController;
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *authCodeField;
@property (nonatomic, weak) IBOutlet UIView *comicView;
@property (nonatomic, strong) KBAAuthAdvantagesController *advantagesController;
@property (atomic, strong) NSTimer *timer;
//@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

- (IBAction)showAuthPopOver:(UIButton*)sender;
@end

@implementation KBAAuthController



/**
 *  Validates the auth code.
 *
 *  @param sender
 */
- (IBAction)validate:(id)sender {
    
    NSRunLoop *r = [NSRunLoop mainRunLoop];
    self.timer = [NSTimer timerWithTimeInterval:0.01
                                         target:self
                                       selector:@selector(respondToTimer)
                                       userInfo:nil
                                        repeats:YES];
    [r addTimer: self.timer forMode:NSDefaultRunLoopMode];
}


/**
 *  Shows the auth info popover.
 *
 *  @param sender
 */
- (IBAction)showAuthPopOver:(UIButton*)sender
{
    [self showPopover:sender withPopoverController: self.advantagesController
            andDirection:UIPopoverArrowDirectionAny
            andOffset:CGPointMake(0, 15)];
}

/**
 *  Will be executed when the timer fires an event.
 */
-(void)respondToTimer
{
    static float time = 0.00;
    if (time <= 1.5) {
        [SVProgressHUD showProgress:time
                             status:@"Bearbeiten..."
                           maskType:SVProgressHUDMaskTypeGradient];
        time += 0.01;
    }
    else{
        [SVProgressHUD dismiss];
        time = 0;
        [self.timer invalidate];
        
        if ([self.authCodeField.text isEqualToString: @"123"]){
            [SVProgressHUD showSuccessWithStatus:@"Erfoglreich" ];
            [self dismissKeyboard];
            
            KBAAuth *auth = [KBADependencyInjector getByKey:@"auth"];
            Customer *customer = [auth identity];
            customer.authenticated = true;
            [super setBackBarButton];
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"Fehlgeschlagen!"];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.advantagesController = [KBAAuthAdvantagesController new];

    //setup titlefield properties
    JVFloatLabeledTextField *titleField = self.authCodeField;
    
    titleField.placeholder = @"Validierungscode";
    titleField.floatingLabel.text = @"Validierungscode";
    [titleField setup];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

	
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
//    if ([self.authCodeField isFirstResponder]) {
//        int height = 0;
//        
//        if ((UIApplication.sharedApplication.statusBarOrientation == UIDeviceOrientationLandscapeLeft
//            || UIApplication.sharedApplication.statusBarOrientation == UIDeviceOrientationLandscapeRight)) {
//            height = 200;
//        }
//        
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.3];
//        [UIView setAnimationDelay:0.1];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//        
//        self.view.frame = CGRectOffset(self.view.frame, 0, height);
//        
//        [UIView commitAnimations];
//    }
}

//TODO: remove observer view did close

bool keyboardShown;

-(void)keyboardDidShow:(NSNotification *)note
{
//    keyboardShown = YES;
//    NSDictionary *userInfo = [note userInfo];
//    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    int height = 0;
//    
//    if (UIApplication.sharedApplication.statusBarOrientation == UIDeviceOrientationLandscapeLeft
//        || UIApplication.sharedApplication.statusBarOrientation == UIDeviceOrientationLandscapeRight
//        || UIApplication.sharedApplication.statusBarOrientation == UIDeviceOrientationUnknown) {
//        height = kbSize.width;
//    }
//
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    [UIView setAnimationDelay:0.1];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    
//    self.view.frame = CGRectOffset(self.view.frame, 0, -height);
//    
//    [UIView commitAnimations];
}

-(void)keyboardWillHide:(NSNotification *)note
{
//    keyboardShown = NO;
//    NSDictionary *userInfo = [note userInfo];
//    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    int height = 0;
//    if (UIApplication.sharedApplication.statusBarOrientation == UIDeviceOrientationLandscapeLeft
//        || UIApplication.sharedApplication.statusBarOrientation == UIDeviceOrientationLandscapeRight
//        || UIApplication.sharedApplication.statusBarOrientation == UIDeviceOrientationUnknown) {
//        height = kbSize.width;
//    }
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    [UIView setAnimationDelay:0.1];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    
//    self.view.frame = CGRectOffset(self.view.frame, 0, height);
//    
//    [UIView commitAnimations];
}

-(void)dismissKeyboard
{
    [self.authCodeField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
