//
//  KBAMessageService.h
//  Kiba
//
//  Created by 1fasselt on 21.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@interface KBAMessageService : NSObject

+(void) sendMessageToIdentityWithDescription:(NSString *) description
                                  andContent:(NSString *) content
                                  andSender:(NSString *) sender;

@end
