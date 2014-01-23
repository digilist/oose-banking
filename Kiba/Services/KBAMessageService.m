//
//  KBAMessageService.m
//  Kiba
//
//  Created by 1fasselt on 21.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAMessageService.h"
#import "KBADependencyInjector.h"
#import "Message.h"
#import "KBAAuth.h"

@implementation KBAMessageService

/**
 *  Send a Message to the currently logged in identity.
 *
 *  @param message
 */
+(void) sendMessageToIdentityWithDescription:(NSString *) description
                                andContent:(NSString *)  content
                                   andSender: (NSString *) sender {
    
    Message *message = [[Message alloc] initWithDescription:description content:content sender:sender date:[NSDate new] msgId:nil];
    
    KBAAuth *auth = [KBADependencyInjector getByKey:@"auth"];
    [auth.identity.messages addObject:message];
    
}

@end
