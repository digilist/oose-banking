//
//  KBATableChooseAccContr.m
//  Kiba
//
//  Created by //// on 05.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBATableChooseTermAccContr.h"

@interface KBATableChooseTermAccContr ()
@end

@implementation KBATableChooseTermAccContr

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.accounts = @[@"Konto1",
                           @"Konto2",
                           @"Konto3",
                           @"Konto4",
                           @"Konto5",
                           @"Konto6",
                           @"Konto7"];
    }
    return self;
}
@end
