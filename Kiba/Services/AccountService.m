//
//  AccountService.m
//  Kiba
//
//  Created by 1jendryc on 05.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "AccountService.h"

@implementation AccountService




+(void)calculateBalance:(Account *)account  AfterSend:(NSNumber *)amount{
    account.balance = [account.balance initWithLong:[account.balance longValue] - [amount longValue]];
}

+(void)calculateBalance:(Account *)account  AfterReceived:(NSNumber *)amount{
    account.balance = [account.balance initWithLong:[account.balance longValue] + [amount longValue]];
}

@end
