//
//  KBATableChooseAccContr.m
//  Kiba
//
//  Created by //// on 05.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBATableChooseTermAccContr.h"
const extern NSString* termAccountEntryChosen;
extern NSNotificationCenter* transferChooseAccountNotifCenter;


@implementation KBATableChooseTermAccContr

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.accounts = @[@"DE68 3672 5437 3642 0931 11",
                           @"DE01 9381 3452 4262 3352 32",
                           @"DE21 7362 9871 1276 0150 12",
                           @"DE90 1962 3764 3782 7862 71",
                           @"DE63 3653 3278 2190 4589 19",
                           @"DE22 3733 3782 4873 2218 59",
                           @"DE68 2105 0170 0012 3456 78"];
        //TO DO load accounts for user.
    }
    return self;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [transferChooseAccountNotifCenter postNotificationName: (NSString*)termAccountEntryChosen
                                                    object: [self.accounts objectAtIndex: indexPath.row]];
    
}

@end
