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


//help-classes–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
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
//–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

//private interface
@interface KBATransContr()
@property KBAChooseTermAccountContr* chooseTermAccContr;
@property KBAChooseDailyAccountContr* chooseDailyAccContr;
@property UIPopoverController* popController;
@property  (nonatomic, weak) IBOutlet UIButton* chooseTermButton;
@property  (nonatomic, weak) IBOutlet UIButton* chooseDailyButton;
@property  (nonatomic, weak) IBOutlet UILabel* termAccountLabel;
@property  (nonatomic, weak) IBOutlet UILabel* dailyAccountLabel;
@property  (nonatomic, weak) IBOutlet UILabel* subTitleLabel;
@property  (nonatomic, weak) IBOutlet UIImageView* checkImageView;
@end

//notification center to inform about chosen accounts in popover-table-view
NSNotificationCenter* transferChooseAccountNotifCenter;
//global string identifier needed to send/recv notifications
const NSString* termAccountEntryChosen = @"termAccountEntryChosen";
const NSString* dailyAccountEntryChosen = @"dailyAccountEntryChosen";

@implementation KBATransContr

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //set view title displayed at very top
        self.title = @"Umbuchung von ihrem Sparkonto";
        
        //account controller which own the table views
        //used in popover
        self.chooseTermAccContr = [KBAChooseTermAccountContr new];
        self.chooseDailyAccContr = [KBAChooseDailyAccountContr new];
       
       
        /*add observer/listener to receive chosen accounts in popup-tableviews */
    
        //needs to be created everytime with this controller(is freed everytime view gets closed)
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

-(void)respondToOrientation:(UIInterfaceOrientation)orientation
{
    
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                               duration:(NSTimeInterval)duration
{
    [self respondToOrientation:toInterfaceOrientation];
}

-(void)viewDidLoad
{
    self.subTitleLabel.numberOfLines = 2;
    //title set programatically to realise linebreak in label. (2 lines needed)
    self.subTitleLabel.text = @"Buchen Sie Geld von ihrem Sparkonto\nohne Verzögerung auf ihr Tageskonto.";
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    self.dateLabel.text =[DateFormatter stringFromDate:[NSDate date]];
    
    self.amountField.text = [NSString stringWithFormat:@"%.2f", 0.0];
}

/**
 *  Receive term-account chosen in popover-tableview.
 *  Accounts are at moment send as string values
 *
 *
 *  @param notification the notification send
 */
-(void)respondToChosenTermAccountEntry:(NSNotification *)notification
{
    [self.popController dismissPopoverAnimated:YES];
    self.termAccountLabel.text = [NSString stringWithFormat:@"IBAN: %@",(NSString*)[notification object]];
}

/**
 *  Receive daily-account chosen in popover-tableview.
 *  Accounts are at moment send as string values
 *
 *
 *  @param notification the notification send
 */
-(void)respondToChosenDailyAccountEntry:(NSNotification *)notification
{
    [self.popController dismissPopoverAnimated:YES];
    self.dailyAccountLabel.text = [NSString stringWithFormat:@"IBAN: %@",(NSString*)[notification object]];
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

/**
 *  Changes view to transfer view.
 *
 *  @param sender
 */
- (IBAction)chooseAmount:(UITextField*)sender
{
    self.amountField.text = [NSString stringWithFormat:@"%@", sender.text];
}

@end
