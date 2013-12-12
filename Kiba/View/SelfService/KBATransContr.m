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
@property NSArray* checkElements;
@property UIPopoverController* popController;
@property  (nonatomic, weak) IBOutlet UIButton* chooseTermButton; //term == source
@property  (nonatomic, weak) IBOutlet UIButton* chooseDailyButton; //daily == destination
@property  (nonatomic, weak) IBOutlet UILabel* termAccountLabel; //term == source
@property  (nonatomic, weak) IBOutlet UILabel* dailyAccountLabel; //daily == destination
@property  (nonatomic, weak) IBOutlet UILabel* subTitleLabel;
@property  (nonatomic, weak) IBOutlet UIImageView* checkImageView;
@property (nonatomic, weak) IBOutlet UILabel* amountLabel;
@property (nonatomic, weak) IBOutlet UILabel* nameLabel;
@property (nonatomic, weak) IBOutlet UILabel* dateLabel;

@property (nonatomic, weak) IBOutlet UILabel* checkLine;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint* bottomConstraint;
@property (nonatomic, weak) IBOutlet UILabel* currencyLabel;
@property (nonatomic, weak) IBOutlet UITextField* amountField;

@property (nonatomic, strong) IBOutlet UIPanGestureRecognizer* panRecognizer;
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
    static BOOL initialResponse = YES;
    
    double duration;
    if (initialResponse) {
        duration = 0;
        initialResponse = NO;
    }
    else{
        duration = 0.5;
    }
    
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [UIView animateWithDuration:duration
                         animations:^{
                             self.bottomConstraint.constant = 110;
                             [self.view layoutIfNeeded];
                         }];
    }
    else{
        [UIView animateWithDuration:duration
                         animations:^{
                             self.bottomConstraint.constant = 40;
                             [self.view layoutIfNeeded];
                         }];
    }
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
    
    NSDateFormatter *DateFormatter = [NSDateFormatter new];
    [DateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    self.dateLabel.text =[DateFormatter stringFromDate:[NSDate date]];
    
    //recognize if tapped outside of amount text field
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.amountField.text = [NSString stringWithFormat:@"%.2f", 0.0];
    
    [self respondToOrientation: UIApplication.sharedApplication.statusBarOrientation];
    
    //create array with elements belonging to the check
    //needed in checkDragged
    self.checkElements = @[self.checkImageView, self.nameLabel,self.chooseTermButton,
                           self.chooseDailyButton, self.dateLabel,self.amountField,
                           self.termAccountLabel, self.dailyAccountLabel, self.amountLabel,
                           self.currencyLabel];
}

-(void)dismissKeyboard
{
    UITextField *activeTextField = nil;
    if ([self.amountField isEditing]) activeTextField = self.amountField;
    if (activeTextField) [activeTextField resignFirstResponder];
}

/**
 *  Receive term-account chosen in popover-tableview.
 *  Accounts are at moment send as string values
 *
 *  @param notification the notification send
 */
-(void)respondToChosenTermAccountEntry:(NSNotification *)notification
{
    [self.popController dismissPopoverAnimated:YES];
    self.termAccountLabel.text = [NSString stringWithFormat:@": %@",(NSString*)[notification object]];
}

/**
 *  Receive daily-account chosen in popover-tableview.
 *  Accounts are at moment send as string values
 *
 *  @param notification the notification send
 */
-(void)respondToChosenDailyAccountEntry:(NSNotification *)notification
{
    [self.popController dismissPopoverAnimated:YES];
    self.dailyAccountLabel.text = [NSString stringWithFormat:@": %@",(NSString*)[notification object]];
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
    
    //given size as arg. is irrelevant
    //size is defined through size of table-view in popover
    [self.popController presentPopoverFromRect:CGRectMake(buttonPosition.x, buttonPosition.y, 1, 1)
                                        inView:self.view
                      permittedArrowDirections:UIPopoverArrowDirectionDown
                                      animated:YES];
}


/**
 *  UITextField-Delegate method for UITextField* amountField.
 *  To resign first responder / give up focus after "return" is pressed.
 *
 *  @param aTextField amountField
 *
 *  @return ret. value irrelevant
 */
- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    return NO;
}

/**
 *  Drag all elements belonging to the check
 *  gesture move.
 *
 *  @param recognizer recognizes the pan/drag gesture
 */
-(IBAction)checkDragged:(UIPanGestureRecognizer*)recognizer
{
    static CGPoint initialCheckCenter, initialNameLabelCenter, initialTermButtonCenter,
    initialDailyButtonCenter, initialDateLabelCenter, initialAmountFieldCenter,
    initialTermAccountLabelCenter, initialDailyAccountLabelCenter, initialAmountLabelCenter,
    initialCurrencyLabelCenter;
    
    if(recognizer.state == UIGestureRecognizerStateBegan){
        initialCheckCenter = self.checkImageView.center;
        initialNameLabelCenter = self.nameLabel.center;
        initialTermButtonCenter = self.chooseTermButton.center;
        initialDailyButtonCenter = self.chooseDailyButton.center;
        initialDateLabelCenter = self.dateLabel.center;
        initialAmountFieldCenter = self.amountField.center;
        initialTermAccountLabelCenter = self.termAccountLabel.center;
        initialDailyAccountLabelCenter = self.dailyAccountLabel.center;
        initialAmountLabelCenter = self.amountLabel.center;
        initialCurrencyLabelCenter = self.currencyLabel.center;
    }
    
    //get amount of dragged points
    CGPoint translation = [recognizer translationInView:self.view];
    
    //only allow to drag check downwards
    if (translation.y < 0) {
        translation.y = 0;
    }
    
    //shift all elements belonging to check
    //all elements inherit from UIView (they all have a center attribute)
    for (UIView* element in self.checkElements) {
        element.center = CGPointMake(element.center.x, element.center.y + translation.y);
    }
    [recognizer setTranslation:CGPointMake(0, 0) inView:recognizer.view];

    
    //put elements back to their initial postion
    if(recognizer.state == UIGestureRecognizerStateEnded ||
       recognizer.state == UIGestureRecognizerStateCancelled) {
        [UIView animateWithDuration:0.25 animations:^{
            
            if (self.checkLine.center.y < self.checkImageView.center.y) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Bestätige Transaktion"
                                                                    message:@"Bitte bestätigen sie ihre Transaktion"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Abbrechen"
                                                          otherButtonTitles:@"Bestätigen", nil];
                [alertView setAlertViewStyle:UIAlertViewStyleDefault];
                [alertView show];
            }
            
            self.checkImageView.center = initialCheckCenter;
            self.nameLabel.center = initialNameLabelCenter;
            self.chooseTermButton.center= initialTermButtonCenter;
            self.chooseDailyButton.center = initialDailyButtonCenter;
            self.dateLabel.center= initialDateLabelCenter;
            self.chooseDailyButton.center = initialDailyButtonCenter;
            self.dateLabel.center= initialDateLabelCenter;
            self.amountField.center = initialAmountFieldCenter;
            self.termAccountLabel.center = initialTermAccountLabelCenter;
            self.dailyAccountLabel.center = initialDailyAccountLabelCenter;
            self.amountLabel.center = initialAmountLabelCenter;
            self.currencyLabel.center = initialCurrencyLabelCenter;
            


                
       
            
        }];
    }
}

/**
 *  Respond to chosen amount.
 *  Displays amount in written words (german) in label.
 *
 *  @param sender
 */
- (IBAction)chooseAmount:(UITextField*)sender
{
    //create number-formatter with german localization
    NSLocale *german = [[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    [numberFormatter setLocale:german];
    [numberFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    
    //TODO: regex to check if inserted value is in correct format
    
    //obtain amount values from string
    NSNumber *euroValue = [NSNumber numberWithDouble: floor([sender.text doubleValue])];
    //round needed due to erros in floating point representation (like 22.99999 cents instead of 23)
    int cents = round((([sender.text doubleValue] - floor([sender.text doubleValue]))*100));
    NSNumber *centValue = [NSNumber numberWithInt: cents];
    
    //spell out single parts
    NSString* wordEuro = [numberFormatter stringFromNumber:euroValue];
    NSString* wordCent = [numberFormatter stringFromNumber:centValue];
    
    //combine parts and set label-text
    self.amountLabel.text = [NSString stringWithFormat:@"%@ Euro und %@ Cent", wordEuro, wordCent];
}

@end