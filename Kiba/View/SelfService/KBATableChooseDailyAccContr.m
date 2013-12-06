//
//  KBATableChooseDailyAccountContr.m
//  Kiba
//
//  Created by //// on 05.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBATableChooseDailyAccContr.h"
const extern NSString* dailyAccountEntryChosen;
extern NSNotificationCenter* transferChooseAccountNotifCenter;

@implementation KBATableChooseDailyAccContr

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.accounts = @[@"Konto11",
                          @"Konto12",
                          @"Konto13",
                          @"Konto14",
                          @"Konto15",
                          @"Konto16",
                          @"Konto17"];
    }
    return self;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [transferChooseAccountNotifCenter postNotificationName: (NSString*)dailyAccountEntryChosen
                                                    object: [self.accounts objectAtIndex: indexPath.row]];
}
@end
