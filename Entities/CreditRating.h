//
//  CreditRating.h
//  Kiba
//
//  Created by 1jendryc on 21.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreditRating : NSObject

// TODO: Was für ein Status Enums?
@property NSString* status;
@property NSNumber* creditLimit;
@property NSNumber* riskLevel;

@end
