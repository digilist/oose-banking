//
//  KBAMessageController.m
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 16.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAMessageController.h"

@interface KBAMessageController ()

@property Message *message;

@end

@implementation KBAMessageController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/**
 *  Initializes the view with a message.
 *
 *  @param message The Message to display.
 *
 *  @return A new view.
 */
- (id)initWithMessage:(Message *)message
{
    self = [super initWithNibName:@"KBAMessageController" bundle:nil];
    if (self) {
        self.message = message;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Init view
    
    self.messageContent.textContainerInset = UIEdgeInsetsMake(0, -5, 0, 0);
    self.heading.text = self.message.description;
    self.messageContent.text = self.message.content;
    self.sender.text = self.message.sender;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
