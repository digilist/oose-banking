//
//  KBACreditRatingDao.h
//  Kiba
//
//  Created by Marco F. Jendryczko on 16.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreditRating.h"

@protocol KBACreditRatingDao <NSObject>

-(CreditRating*) getCreditRating;

@end
