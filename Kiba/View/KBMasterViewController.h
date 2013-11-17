//
//  KBMasterViewController.h
//  Kiba
//
//  Created by Konstantin Möllers on 16.11.13.
//  Copyright (c) 2013 Projekt Kiba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KBDetailViewController;

@interface KBMasterViewController : UITableViewController

@property (strong, nonatomic) KBDetailViewController *detailViewController;

@end
