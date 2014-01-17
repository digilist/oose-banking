//
//  CustomIOS7AlertView.h
//  CustomIOS7AlertView
//
//  Created by Richard on 20/09/2013.
//  Copyright (c) 2013 Wimagguc.
//
//  Lincesed under The MIT License (MIT)
//  http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>


@class KBAAlertView;
@protocol KBAAlertViewDelegate

- (void)kbaAlertView: (KBAAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface KBAAlertView : UIView<KBAAlertViewDelegate>

@property (nonatomic, strong) UIView *parentView;    // The parent view this 'dialog' is attached to
@property (nonatomic, strong) UIView *dialogView;    // Dialog's container view
@property (nonatomic, strong) UIView *containerView; // Container within the dialog (place your ui elements here)
@property (nonatomic, strong) UIView *buttonView;    // Buttons on the bottom of the dialog

@property (nonatomic, weak) id<KBAAlertViewDelegate> delegate;
@property (nonatomic, strong) NSArray *buttonTitles;
@property (nonatomic, assign) BOOL useMotionEffects;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTextLabel;

@property (copy) void (^onButtonTouchUpInside)(KBAAlertView *alertView, int buttonIndex) ;

- (id)init;

- (void)show;
- (void)close;

- (IBAction)customIOS7dialogButtonTouchUpInside:(id)sender;
- (void)setOnButtonTouchUpInside:(void (^)(KBAAlertView *alertView, int buttonIndex))onButtonTouchUpInside;

- (void)deviceOrientationDidChange: (NSNotification *)notification;
- (void)dealloc;

@end
