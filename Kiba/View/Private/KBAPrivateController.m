//
//  KBAPrivateController.m
//  Kiba
//
//  Created by Schaarschmidt, Michael on 16.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAPrivateController.h"
#import "KBADependencyInjector.h"
#import "KBAAuth.h"
#import "KBAMessageController.h"

@interface KBAPrivateController ()

@property KBAAuth *auth;
@property (readonly) NSMutableArray *messages;

@end

@implementation KBAPrivateController

#pragma mark View requirements

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Init Dependency Injection
    self.auth = [KBADependencyInjector getByKey:@"auth"];
    
    // Init table view
    self.messageTableView.delegate = self;
    self.messageTableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  Returns the message from the identity.
 *
 *  @return a bunch of messages.
 */
- (NSMutableArray *)messages
{
    return self.auth.identity.messages;
}

#pragma mark Table View methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message *selectedMessage = [self.messages objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:[[KBAMessageController alloc] initWithMessage:selectedMessage] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message *selectedMessage = [self.messages objectAtIndex:indexPath.row];
    NSString *ci = [NSString stringWithFormat:@"Message #%@", selectedMessage.msgId];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ci];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ci];
    }
    cell.textLabel.text = selectedMessage.description;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:cell.textLabel.font, NSFontAttributeName, nil];
    NSUInteger textWidth = [cell.textLabel.text sizeWithAttributes:attributes].width + 26;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(
                                                               textWidth,
                                                               0,
                                                               tableView.frame.size.width - textWidth - 8,
                                                               cell.frame.size.height
                                                            )];
    label.text = selectedMessage.content;
    label.numberOfLines = 1;
    label.textColor = [UIColor lightGrayColor];
    [cell addSubview:label];
    
    return cell;
}

@end
