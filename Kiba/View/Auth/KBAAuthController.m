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

@interface KBAAuthController ()
@property (nonatomic, weak) IBOutlet UITextField *authCodeField;
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
//    CGRect cgr = self.comicView.bounds;
//    cgr.origin.x += 1.5f/2;
//    cgr.origin.y += 1.5f/2;
//    
//    cgr.size.width -= 1.5f;
//    cgr.size.height -= 1.5f;
//    
//    UIBezierPath *borderpath = [UIBezierPath bezierPathWithRect:cgr];
//    [borderpath setLineWidth:1.5f];
//    [[UIColor blackColor] set];
//    [borderpath stroke];
    
//    self.comicView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.comicView.layer.borderWidth = 1.0;
//    self.comicView.layer.shadowColor = (__bridge CGColorRef)([UIColor clearColor]);
//    self.comicView.layer.shadowOffset = CGSizeMake(0, 0);
//    self.comicView.layer.shadowRadius = 0.0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
