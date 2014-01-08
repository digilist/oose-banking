//
//  KBATransferController.m
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBATransContr.h"
#import "KBAChooseAccountTableContr.h"


//private interface
@interface KBATransContr()
@property (nonatomic, strong) IBOutlet KBAChooseAccountTableContr *chooseAccContr;
@property NSArray *checkElements;
@property NSMutableArray *checkElementsPositions;
@property UIPopoverController* popController;
@property (nonatomic, weak) IBOutlet KBAButton *chooseSourceAccountButton;
@property (nonatomic, weak) IBOutlet KBAButton *chooseDestinationAccountButton;
@property (nonatomic, weak) IBOutlet UILabel *sourceAccountLabel;
@property (nonatomic, weak) IBOutlet UILabel *destinationAccountLabel;
@property (nonatomic, weak) UILabel *labelToSet; //label set in chooseAccount (points to source or dest)
@property (nonatomic, weak) IBOutlet UILabel *subTitleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *checkImageView;
@property (nonatomic, weak) IBOutlet UILabel *amountLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@property (nonatomic, weak) IBOutlet UILabel *checkLine;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (nonatomic, weak) IBOutlet UILabel *currencyLabel;
@property (nonatomic, weak) IBOutlet UITextField *amountField;

@property (nonatomic, strong) IBOutlet UIPanGestureRecognizer *panRecognizer;
@end

//notification center to inform about chosen accounts in popover-table-view
NSNotificationCenter *transferChooseAccountNotifCenter;
//global string identifier needed to send/recv notifications
const NSString *accountEntryChosen = @"accountEntryChosen";

@implementation KBATransContr

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //set view title displayed at very top
        self.title = @"Umbuchungen";
        
        /*add observer/listener to receive chosen accounts in popup-tableviews */
        //needs to be created everytime with this controller(is freed everytime view gets closed)
        transferChooseAccountNotifCenter = [NSNotificationCenter new];
        [transferChooseAccountNotifCenter addObserver:self
                                             selector:@selector(respondToChosenAccountEntry:)
                                                 name:(NSString *)accountEntryChosen
                                               object:nil];
    }
    return self;
}

-(void)viewDidLoad
{
    //self.subTitleLabel.numberOfLines = 2;
    //self.subTitleLabel.text = @"Umbuchung vornehmen!";
    
    NSDateFormatter *DateFormatter = [NSDateFormatter new];
    [DateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    self.dateLabel.text =[DateFormatter stringFromDate:[NSDate date]];
    
    //recognize if tapped outside of amount text field
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.amountField.text = [NSString stringWithFormat:@"%.2f", 0.0];
    
    [self respondToOrientation: UIApplication.sharedApplication.statusBarOrientation inAnimatedDurationTime: 0];
    
    //create array with elements belonging to the check needed in checkDragged
    self.checkElements = @[self.checkImageView, self.nameLabel,self.chooseSourceAccountButton,
                           self.chooseDestinationAccountButton, self.dateLabel,self.amountField,
                           self.sourceAccountLabel, self.destinationAccountLabel, self.amountLabel,
                           self.currencyLabel];
    
    //array to remember center positions
    self.checkElementsPositions = [NSMutableArray new];
    
    // Custom Cheque fonts
    UIFont *chequeFont = [UIFont fontWithName:@"OCR A Std" size:18];
    self.nameLabel.font = chequeFont;
    self.amountLabel.font = chequeFont;
    self.sourceAccountLabel.font = chequeFont;
    self.dateLabel.font = chequeFont;
    self.amountField.font = chequeFont;
    self.destinationAccountLabel.font = chequeFont;
}

-(void)respondToOrientation:(UIInterfaceOrientation)orientation
     inAnimatedDurationTime:(double)duration
{
    [UIView animateWithDuration:duration
                     animations:^{
                        if (orientation == UIInterfaceOrientationPortrait ||
                             orientation == UIInterfaceOrientationPortraitUpsideDown) {
                                 
                                self.bottomConstraint.constant = 110;
                        }
                        else{
                                self.bottomConstraint.constant = 40;
                        }
                        [self.view setNeedsLayout];
                     }];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                               duration:(NSTimeInterval)duration
{
    [self respondToOrientation:toInterfaceOrientation inAnimatedDurationTime:0.5];
}



-(void)dismissKeyboard
{
    UITextField *activeTextField = nil;
    if ([self.amountField isEditing]){
        activeTextField = self.amountField;
    }
    if (activeTextField){
        [activeTextField resignFirstResponder];
    }
}

/**
 *  Receive term-account chosen in popover-tableview.
 *  Accounts are at moment send as string values
 *
 *  @param notification the notification send
 */
-(void)respondToChosenAccountEntry:(NSNotification *)notification
{
    [self.popController dismissPopoverAnimated:YES];
    self.labelToSet.text = [NSString stringWithFormat:@"%@",(NSString*)[notification object]];
}

/**
 *  Display accounts to select from in popover-tableview.
 *  Depends on used button (daily or term).
 *
 *  @param sender pressed button
 */
-(IBAction)chooseAccount:(KBAButton *)sender
{
    self.popController = [[UIPopoverController alloc]
                          initWithContentViewController:self.chooseAccContr];
    
    CGPoint buttonPosition = sender.frame.origin;
    
    //given size as arg. is irrelevant
    //size is defined through size of table-view in popover
    [self.popController presentPopoverFromRect:CGRectMake(buttonPosition.x, buttonPosition.y, 1, 1)
                                        inView:self.view
                      permittedArrowDirections:UIPopoverArrowDirectionDown
                                      animated:YES];
    
    if ([sender isEqual:self.chooseSourceAccountButton]) {
        self.labelToSet = self.sourceAccountLabel;
    }
    else{
        self.labelToSet = self.destinationAccountLabel;
    }
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
    if(recognizer.state == UIGestureRecognizerStateBegan){
        for (UIView* element in self.checkElements) {
            //capture positions at start of dragging
            //all elements inherit from UIView (they all have a center attribute)
            [self.checkElementsPositions addObject:[NSValue valueWithCGPoint: element.center]];
        }
    }
    
    //get amount of dragged points
    CGPoint translation = [recognizer translationInView:self.view];
    
    //only allow to drag check downwards
    if (translation.y < 0) {
        translation.y = 0;
    }
    
    //shift all elements belonging to check
    for (UIView* element in self.checkElements) {
        element.center = CGPointMake(element.center.x, element.center.y + translation.y);
    }
    [recognizer setTranslation:CGPointMake(0, 0) inView:recognizer.view];

    
    //if dragging ended
    if(recognizer.state == UIGestureRecognizerStateEnded ||
       recognizer.state == UIGestureRecognizerStateCancelled) {
        
        //if check-y-center was dragged below label "..hier hinüberziehen"
        if (self.checkLine.center.y < self.checkImageView.center.y) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Bestätige Transaktion"
                                                                message:@"Bitte bestätigen sie ihre Transaktion"
                                                               delegate:self
                                                      cancelButtonTitle:@"Abbrechen"
                                                      otherButtonTitles:@"Bestätigen", nil];
            [alertView setAlertViewStyle:UIAlertViewStyleDefault];
            [alertView show];
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            //put back elements to original position
            for (int i = 0; i < [self.checkElements count]; ++i) {
                UIView *element = [self.checkElements objectAtIndex:i];
                NSValue *centerPos = [self.checkElementsPositions objectAtIndex:i];
                element.center = [centerPos CGPointValue];
            }
            [self.checkElementsPositions removeAllObjects];
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
    [numberFormatter setNumberStyle: NSNumberFormatterSpellOutStyle];
    
    //TODO: regex to check if inserted value is in correct format
    
    //obtain amount values from string
    NSNumber *euroValue = [NSNumber numberWithDouble: floor([sender.text doubleValue])];
    //round needed due to erros in floating point representation (like 22.99999 cents instead of 23)
    int cents = round((([sender.text doubleValue] - floor([sender.text doubleValue]))*100));
    NSNumber *centValue = [NSNumber numberWithInt: cents];
    
    //spell out single parts
    NSString *wordEuro = [numberFormatter stringFromNumber:euroValue];
    NSString *wordCent = [numberFormatter stringFromNumber:centValue];
    
    //combine parts and set label-text
    self.amountLabel.text = [NSString stringWithFormat:@"%@ Euro und %@ Cent", wordEuro, wordCent];
}

@end