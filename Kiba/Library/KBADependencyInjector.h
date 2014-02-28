//
//  KBADependencyInjector.h
//  Kiba
//
//  Created by Markus Fasselt on 19.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBADependencyInjector : NSObject

+ (id) getByKey:(NSString*)key;
+ (void) setObject:(id)object withKey:(NSString*)key ;
+ (BOOL) hasDependency:(NSString *)key;

@end