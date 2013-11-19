//
//  KBMasterViewController.h
//  Kiba
//
//  Created by Konstantin Möllers on 16.11.13.
//  Copyright (c) 2013 Projekt Kiba. All rights reserved.
//

@import UIKit;

@class KBADetailViewController;

@interface KBAMasterViewController : UITableViewController

@property (strong, nonatomic) KBADetailViewController *detailViewController;
@property (strong, nonatomic) IBOutlet UITableView *mainLeftView;


@end
