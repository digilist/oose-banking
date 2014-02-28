//
//  KBADependencyInjector.m
//  Kiba
//
//  Created by Markus Fasselt on 19.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBADependencyInjector.h"

static NSMutableDictionary* dependencies;

@implementation KBADependencyInjector

+ (void) initialize {
    dependencies = [NSMutableDictionary new];
}

/**
 * get the registered dependency for {key}.
 *
 */
+ (id) getByKey:(NSString *)key {
    id dependency = [dependencies valueForKey: key];
    NSAssert(dependency != nil, @"Requested dependency is not set");
    return dependency;
}

/**
 * save an dependency with key {key}
 *
 */
+ (void) setObject:(id)object withKey:(NSString*)key {
    [dependencies setValue:object forKey:key];
}

/**
 *  Return true, if a dependency exists.
 *
 *  @param key The key of the dependecy
 *
 *  @return true if exists
 */
+ (BOOL)hasDependency:(NSString *)key {
    return [dependencies objectForKey:key] != nil;
}

@end
