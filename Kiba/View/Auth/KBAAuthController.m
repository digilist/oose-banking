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

const static CGFloat kJVFieldHeight = 44.0f;
const static CGFloat kJVFieldHMargin = 10.0f;
const static CGFloat kJVFieldFontSize = 16.0f;
const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

@interface KBAAuthController ()
@property (nonatomic, weak) IBOutlet JVFloatLabeledTextField *authCodeField;
@property (nonatomic, weak) IBOutlet UIView *comicView;
@property NSTimer *timer;
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
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"Fehlgeschlagen!"];
        }
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //setup titlefield properties
    JVFloatLabeledTextField *titleField = self.authCodeField;
    titleField.placeholder = @"Validierungscode hier eingeben";
    titleField.floatingLabel.text = @"Ihr Validierungscode";
    [titleField setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
