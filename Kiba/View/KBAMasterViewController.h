//
//  KBMasterViewController.h
//  Kiba
//
//  Created by Konstantin Möllers on 16.11.13.
//  Copyright (c) 2013 Projekt Kiba. All rights reserved.
//

@import UIKit;

@interface KBAMasterViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *mainLeftView;
@property(nonatomic, retain) UIColor *barTintColor;
@property(nonatomic, retain) UIColor *tintColor;

@end
