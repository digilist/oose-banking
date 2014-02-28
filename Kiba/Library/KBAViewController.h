//
//  KBAViewController.h
//  Kiba
//
//  Created by Markus Fasselt on 26.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBAViewController : UIViewController<UISplitViewControllerDelegate>
-(void)setBackBarButton;
-(void)disableViewHierachy:(UIView *)view;
-(void)enableViewHierachy:(UIView *)view;
@property BOOL needsAuthentification;
@end
