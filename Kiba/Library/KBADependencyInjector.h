//
//  KBADependencyInjector.h
//  Kiba
//
//  Created by 1fasselt on 19.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBADependencyInjector : NSObject

+ (id) getByKey:(NSString*)key;
+ (void) setObject:(id)object withKey:(NSString*)key ;

@end