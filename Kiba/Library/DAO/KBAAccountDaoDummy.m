//
//  KBAAccountDaoDummy.m
//  Kiba
//
//  Created by Michael Schaarschmidt on 12.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAAccountDaoDummy.h"
#import "Account.h"
#include <stdlib.h>

@implementation KBAAccountDaoDummy

/**
 *  Returns dummy accounts.
 *
 *  @param customer
 *
 *  @return the accounts
 */
- (NSArray *) getAccounts:(Customer *)customer {
    Account *accountA = [[Account alloc] initWithBalance: @1000
                                               overDraft: @0
                                               accountNr: @1004006661111
                                                    name: @"mein Sparkonto"
                                                   owner: customer];
    
    Account *accountB = [[Account alloc] initWithBalance: @500
                                               overDraft: @0
                                               accountNr: @10040066611145
                                                    name: @"mein Girokonto"
                                                   owner: customer];
    
    return @[accountA, accountB];
}

/**
 *  Returns the turnover for an account.
 *
 *  @param account The account.
 *
 *  @return an array over 30 days.
 */
- (NSArray *)turnoverForAccount:(Account *)account {
    NSMutableArray *mutableData = [[NSMutableArray alloc] init];
    double balance = (arc4random() % 50000) / 100.0;
    
    for (int i = -30; i <= 0; i++) {
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:i * 86400];
        NSNumber *time = [NSNumber numberWithDouble:date.timeIntervalSince1970 * 1000];
        balance += arc4random() % 3000 / 100.0 - 15;
        NSArray *entry = @[time, [NSNumber numberWithDouble:balance]];
        
        [mutableData addObject:entry];
    }
    
    return [NSArray arrayWithArray:mutableData];
}

@end
