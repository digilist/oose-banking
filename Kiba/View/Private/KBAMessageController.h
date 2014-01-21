//
//  KBAMessageController.h
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 16.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAViewController.h"
#import "Message.h"

@interface KBAMessageController : KBAViewController

@property (weak, nonatomic) IBOutlet UILabel *heading;
@property (weak, nonatomic) IBOutlet UILabel *sender;
@property (weak, nonatomic) IBOutlet UITextView *messageContent;

- (id)initWithMessage:(Message *)message;

@end
