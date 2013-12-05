//
//  KBATableChooseDailyAccountContr.m
//  Kiba
//
//  Created by //// on 05.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBATableChooseDailyAccContr.h"

@interface KBATableChooseDailyAccContr ()
@property NSArray* accounts;
@end

@implementation KBATableChooseDailyAccContr

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.accounts = @[@"Konto11",
                          @"Konto12",
                          @"Konto13",
                          @"Konto14",
                          @"Konto15",
                          @"Konto16",
                          @"Konto17"];
        
    }
    return self;
}
@end
