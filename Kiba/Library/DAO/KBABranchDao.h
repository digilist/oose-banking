//
//  KBAFilialDao.h
//  Kiba
//
//  Created by 1fasselt on 19.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Branch;

@protocol KBABranchDao <NSObject>

- (Branch *)getBranchesNearPoint:(CGPoint)location;

@end
