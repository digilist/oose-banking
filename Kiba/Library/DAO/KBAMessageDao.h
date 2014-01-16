//
//  KBAMessageDao.h
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 16.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer.h"


@protocol KBAMessageDao <NSObject>

- (NSMutableArray *) messagesForCustomer: (Customer *)customer;

@end
