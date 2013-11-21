//
//  KBDetailViewController.h
//  Kiba
//
//  Created by Konstantin Möllers on 16.11.13.
//  Copyright (c) 2013 Projekt Kiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBADetailViewController : UIViewController <UISplitViewControllerDelegate>

@property id detailItem;

@property (strong, nonatomic) UIViewController *detailController;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
