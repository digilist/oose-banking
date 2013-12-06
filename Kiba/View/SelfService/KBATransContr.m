//
//  KBATransferController.m
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBATransContr.h"
#import "KBATableChooseTermAccContr.h"
#import "KBATableChooseDailyAccContr.h"


//help-classes––––––––––––––––––––––––––––––––––
@interface KBAChooseTermAccountContr: UIViewController
@property (nonatomic, strong) IBOutlet KBATableChooseTermAccContr* chooseTermAccTableContr;
@end

@implementation KBAChooseTermAccountContr
@end
//–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
@interface KBAChooseDailyAccountContr: UIViewController
@property (nonatomic, strong) IBOutlet KBATableChooseDailyAccContr* chooseAccTableContr;
@end

@implementation KBAChooseDailyAccountContr
@end
//–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

//private interface
@interface KBATransContr()
@property KBAChooseTermAccountContr* chooseTermAccContr;
@property KBAChooseDailyAccountContr* chooseDailyAccContr;
@property UIPopoverController* popController;
@property  (nonatomic, weak) IBOutlet UIButton* chooseTermButton;
@property  (nonatomic, weak) IBOutlet UIButton* chooseDailyButton;
@property  (nonatomic, weak) IBOutlet UILabel* termAccountLabel;
@property  (nonatomic, weak) IBOutlet UILabel* dailyAccountLabel;
@end

//global string identifier
NSNotificationCenter* transferChooseAccountNotifCenter;
const NSString* termAccountEntryChosen = @"termAccountEntryChosen";
const NSString* dailyAccountEntryChosen = @"dailyAccountEntryChosen";

@implementation KBATransContr

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.chooseTermAccContr = [KBAChooseTermAccountContr new];
        self.chooseDailyAccContr = [KBAChooseDailyAccountContr new];
       
        //needs to be created everytime with this controller
        //(gets freed everytime view gets closed)
        transferChooseAccountNotifCenter = [NSNotificationCenter new];
        
        [transferChooseAccountNotifCenter addObserver:self
                                             selector:@selector(respondToChosenTermAccountEntry:)
                                                 name:(NSString*)termAccountEntryChosen
                                               object:nil];
       
        [transferChooseAccountNotifCenter addObserver:self
                                             selector:@selector(respondToChosenDailyAccountEntry:)
                                                 name:(NSString*)dailyAccountEntryChosen
                                               object:nil];
    }
    return self;
}

-(void)respondToChosenTermAccountEntry:(NSNotification *)notification
{
    [self.popController dismissPopoverAnimated:YES];
    self.termAccountLabel.text = (NSString*)[notification object];
}

-(void)respondToChosenDailyAccountEntry:(NSNotification *)notification
{
    [self.popController dismissPopoverAnimated:YES];
    self.dailyAccountLabel.text = (NSString*)[notification object];
}

/**
 *  Display accounts to select from in popover-tableview.
 *  Depends on used button (daily or term).
 *
 *  @param sender pressed button
 */
-(IBAction)chooseAccount:(UIButton*)sender
{
    if ([sender isEqual:self.chooseTermButton]) {
        self.popController = [[UIPopoverController alloc]
                              initWithContentViewController:self.chooseTermAccContr];
    }
    else if([sender isEqual:self.chooseDailyButton]){
        self.popController = [[UIPopoverController alloc]
                              initWithContentViewController:self.chooseDailyAccContr];
    }
    
    CGPoint buttonPosition = sender.frame.origin;
    
    [self.popController presentPopoverFromRect:CGRectMake(buttonPosition.x, buttonPosition.y, 100, 100)
                                        inView:self.view
                      permittedArrowDirections:UIPopoverArrowDirectionDown
                                      animated:YES];
    
}
@end
