//
//  KBATableChooseDailyAccountContr.m
//  Kiba
//
//  Created by //// on 05.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBATableChooseDailyAccContr.h"
#import "KBADependencyInjector.h"
#import "KBAAccountDao.h"
#import "Account.h"
#import "KBAAuth.h"


const extern NSString* dailyAccountEntryChosen;
extern NSNotificationCenter* transferChooseAccountNotifCenter;

@implementation KBATableChooseDailyAccContr

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        id<KBAAccountDao> accountDao = [KBADependencyInjector getByKey:@"accountDao"];
        KBAAuth *auth = [KBADependencyInjector getByKey:@"auth"];
        self.customer = [auth getIdentity];
        self.accounts = [accountDao getAccounts:self.customer];
        
    }
    return self;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    Account *account = [self.accounts objectAtIndex: indexPath.row];
    [transferChooseAccountNotifCenter postNotificationName: (NSString*)dailyAccountEntryChosen
                                                    object: account.name];
}
@end
