//
//  KBABranchController.m
//  Kiba
//
//  Created by 1fasselt on 03.12.13.
//  Copyright (c) 2013 KiBa App. All rights reserved.
//

#import "KBAExchangeRateDao.h"
#import "KBADependencyInjector.h"

#import "KBABranchController.h"

#import "Branch.h"
#import "Currency.h"

static NSArray *currencies;

@interface KBABranchController ()

@property Branch *branch;
@property Currency *selectedCurrency;

// popovercontroller
@property (strong) UIPopoverController *popController;
@property (strong) UIViewController *popoverViewController;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *middleConstraint;
@end

@implementation KBABranchController

+ (void)initialize {
    id<KBAExchangeRateDao> exchangeRateDao = [KBADependencyInjector getByKey:@"exchangeRateDao"];
    currencies = [exchangeRateDao getExchangeRates];
}

- (id)initWithBranch: (Branch *) branch {
    self = [self init];
    
    if (self)
    {
        self.branch = branch;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self pickerView:self.currencyPickerView didSelectRow:0 inComponent:0];
    
    NSMutableString *openingHours = [NSMutableString new];
    for (int i = 0; i < self.branch.openHours.count; i++)
    {
        [openingHours appendFormat:@"%@\n", [self.branch.openHours[i] formatted]];
    }
    
    // Fill labels
    self.openingHoursLabel.text = openingHours;
    [self.openingHoursLabel sizeToFit];
    
    self.branchLabel.text = self.branch.name;
    [self.branchLabel sizeToFit];
    
    self.contactImage.image = self.branch.consultant.image;
    self.contactPersonLabel.text = self.branch.consultant.fullName;
    
    // Initialize currencies
    Currency *currency = currencies[0];
    [self.currencySelectButton setTitle:currency.formattedLabel forState:UIControlStateNormal];
    
    [self respondToOrientation: UIApplication.sharedApplication.statusBarOrientation
        inAnimatedDurationTime: 0.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return currencies.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    Currency *currency = currencies[row];
    
    return currency.formattedLabel;
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // value of picker view has changed
    self.selectedCurrency = currencies[row];
    [self onCurrencyReturned:self.currencyField];
}

#pragma mark Currency Logic

- (IBAction)showCurrencyPicker:(UIButton *)sender {
    
//    UIView *uiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    uiView.backgroundColor = [UIColor blackColor];
//    
//    UILabel *testLabel = [UILabel new];
//    testLabel.text = @"foo";
//    testLabel.frame = CGRectMake(0, 0, 100, 100);
//    [uiView addSubview:testLabel];
//    
//    // create popover view
//    self.popoverViewController = [UIViewController new];
//    self.preferredContentSize = CGSizeMake(320, 300);
//    self.popoverViewController.view = uiView;
//    
//    
//    // create popover
//    self.popController = [[UIPopoverController alloc] initWithContentViewController:self.popoverViewController];
//    //self.popoverController.delegate=self;
//    
//    [self.popController setPopoverContentSize:CGSizeMake(320, 264) animated:NO];
//    [self.popController presentPopoverFromRect:sender.frame
//                                            inView:self.view
//                          permittedArrowDirections:UIPopoverArrowDirectionDown
//                                          animated:YES];
    
}

/**
 *  Will be executed when the user enters a new currency value.
 *
 *  @param sender The currency field.
 */
- (IBAction)onCurrencyReturned:(UITextField *)sender {
    if (sender == self.currencyField) {
        NSString *currencyValue = sender.text;
        NSString *cleanCurrency = [self cleanCurrencyString:currencyValue];
        sender.text = cleanCurrency;
        
        float currency = cleanCurrency.floatValue;
        float euro = [self.selectedCurrency euroWithCurrency:currency];
        
        NSString *euroString = [NSString stringWithFormat:@"%.2f €", euro];
        
        [self.euroLabel setText:[euroString stringByReplacingOccurrencesOfString:@"." withString:@","]];
    }
}

/**
 *  Cleans a string to have a valid currency value.
 *
 *  @param subject The string to be cleaned.
 *
 *  @return A clean currency value.
 */
- (NSString *)cleanCurrencyString:(NSString *)subject {
    NSError *error = NULL;
    NSRegularExpression *forbiddenCharsRegex = [NSRegularExpression regularExpressionWithPattern:@"[^\\d,]+"
                                                                                         options:0
                                                                                           error:&error];
    if (!error) {
        NSString *cleanedString = [forbiddenCharsRegex stringByReplacingMatchesInString:subject options:0 range:NSMakeRange(0, subject.length) withTemplate:@""];
        NSRegularExpression *firstTrueMatchRegex = [NSRegularExpression regularExpressionWithPattern:@"\\d+(,\\d{2})?" options:0 error:&error];
        
        NSTextCheckingResult *match = [firstTrueMatchRegex firstMatchInString:cleanedString options:0 range:NSMakeRange(0, cleanedString.length)];
        
        if (match) {
            NSRange matchRange = match.range;
            return [cleanedString substringWithRange:matchRange];
        }
        
        return @"0,00";
    }
    
    return subject;
}

/**
 *  Set constraints and show/hide kiba icon
 *  based on iPad-orientation
 *
 *  @param orientation orientation to respond to
 */
-(void)respondToOrientation:(UIInterfaceOrientation)orientation
     inAnimatedDurationTime:(double)duration
{
    //animations if switch to portrait-mode
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [UIView animateWithDuration:duration
                         animations:^{
                             self.topConstraint.constant = 70;
                             self.middleConstraint.constant = 95;
                         }];
        
    }
    //animations if switch to landscape-mode
    else{
        [UIView animateWithDuration:duration
                         animations:^{
                             self.topConstraint.constant = 44;
                             self.middleConstraint.constant = 50;
                         }];
        
    }
    
    float newWidth = self.view.bounds.size.width / 4;
    
    [self.navigationView setFrame:CGRectMake(0, 205, newWidth, 192)];
    [self.phoneView setFrame:CGRectMake(newWidth, 205, newWidth, 192)];
    [self.emailView setFrame:CGRectMake(2 * newWidth, 205, newWidth, 192)];
    [self.currencyView setFrame:CGRectMake(3 * newWidth, 205, newWidth, 192)];
}


-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                               duration:(NSTimeInterval)duration
{
    [self respondToOrientation:toInterfaceOrientation
        inAnimatedDurationTime:0.2];
}

@end
