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

@implementation KBABootstrap

/**
 * bootstrap our app :)
 *
 */
+ (void) bootstrap {
    [KBABootstrap initDependencyInjector];
}

/**
 * Initialize the dependency injector with all neccessary dependencies.
 *
 */
+ (void) initDependencyInjector {
    
    id<KBABranchDao> branchDao;
    
    if (true) { // if development / click dummy
        branchDao = [KBABranchDaoDummy new];
    }
    else {
        branchDao = [KBABranchDaoRest new];
    }
    
    [KBADependencyInjector setObject:branchDao withKey:@"branchDao"];
}

@end
