//
//  KBABootstrap.m
//  Kiba
//
//  Created by 1fasselt on 19.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBABootstrap.h"
#import "KBADependencyInjector.h"

#import "KBABranchDao.h"
#import "KBABranchDaoDummy.h"
#import "KBABranchDaoRest.h"
#import "KBACustomerDao.h"
#import "KBACustomerDaoDummy.h"
#import "KBACustomerDaoRest.h"
#import "KBAAccountDao.h"
#import "KBAAccountDaoDummy.h"
#import "KBAAccountDaoRest.h"
#import "KBAAuth.h"
#import "KBAExchangeRateDao.h"
#import "KBAExchangeRateDaoRest.h"
#import "KBATransactionDao.h"
#import "KBATransactionDaoDummy.h"
#import "KBATransactionDaoRest.h"
#import "KBACreditRatingDao.h"
#import "KBACreditRatingDaoDummy.h"
#import "KBACreditRatingDaoRest.h"
#import "KBAMessageDao.h"
#import "KBAMessageDaoDummy.h"
#import "KBAMessageDaoRest.h"

@implementation KBABootstrap

/**
 * bootstrap our app :)
 *
 */
+ (void) bootstrap {
    [KBABootstrap initDependencyInjectorWitMode:@"dev"];
}

/**
 * Initialize the dependency injector with all neccessary dependencies.
 *
 */
+ (void) initDependencyInjectorWitMode:(NSString*) mode {

    id<KBABranchDao> branchDao;
    id<KBAExchangeRateDao> exchangeRateDao;
    id<KBACustomerDao> customerDao;
    id<KBAAccountDao> accountDAo;
    id<KBATransactionDao> transDao;
    id<KBACreditRatingDao> creditDao;
    id<KBAMessageDao> messageDao;
    KBAAuth *auth = [KBAAuth new];
    
    exchangeRateDao = [KBAExchangeRateDaoRest new];
    
    if ([mode isEqualToString:@"dev"]) { // if development / click dummy
        branchDao = [KBABranchDaoDummy new];
        customerDao = [KBACustomerDaoDummy new];
        accountDAo = [KBAAccountDaoDummy new];
        transDao = [KBATransactionDaoDummy new];
        creditDao = [KBACreditRatingDaoDummy new];
        messageDao = [KBAMessageDaoDummy new];
    }
    else {
        creditDao = [KBACreditRatingDaoRest new];
        branchDao = [KBABranchDaoRest new];
        customerDao = [KBACustomerDaoRest new];
        accountDAo = [KBAAccountDaoRest new];
        transDao = [KBATransactionDaoRest new];
        messageDao = [KBAMessageDaoRest new];
    }
    
    [KBADependencyInjector setObject:branchDao withKey:@"branchDao"];
    [KBADependencyInjector setObject:exchangeRateDao withKey:@"exchangeRateDao"];
    [KBADependencyInjector setObject:customerDao withKey:@"customerDao"];
    [KBADependencyInjector setObject:accountDAo withKey:@"accountDao"];
    [KBADependencyInjector setObject:auth withKey:@"auth"];
    [KBADependencyInjector setObject:transDao withKey:@"transDao"];
    [KBADependencyInjector setObject:creditDao withKey:@"creditDao"];
    [KBADependencyInjector setObject:messageDao withKey:@"messageDao"];
    [auth login: @"max" withPassword:@"test"];
    
}

@end
