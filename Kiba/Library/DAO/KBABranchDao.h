//
//  KBAFilialDao.h
//  Kiba
//
//  Created by Markus Fasselt on 19.11.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KBABranchDao <NSObject>

- (NSArray *)getBranchesNearPoint:(CGPoint)location;

@end
