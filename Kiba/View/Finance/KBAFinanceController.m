//
//  KBAFinanceController.m
//  Kiba
//
//  Created by Marco F. Jendryczko on 07.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAFinanceController.h"
#import "KBAAppointmentContr.h"
#import "KBADependencyInjector.h"
#import "KBACustomerDao.h"
#import "ASValueTrackingSlider.h"

@interface KBAFinanceController ()

@property (nonatomic, weak) IBOutlet ASValueTrackingSlider *sumSlider;
@property (nonatomic, weak) IBOutlet ASValueTrackingSlider *lengthSlider;
@property (nonatomic, weak) IBOutlet ASValueTrackingSlider *interestSlider;
@property (nonatomic, weak) IBOutlet ASValueTrackingSlider *rateSlider;

@property (nonatomic, weak) IBOutlet UILabel *sumLabel;
@property (nonatomic, weak) IBOutlet UILabel *lengthLabel;
@property (nonatomic, weak) IBOutlet UILabel *interestLabel;
@property (nonatomic, weak) IBOutlet UILabel *rateLabel;
@property (nonatomic, weak) IBOutlet UILabel *creditSum;

@property double interest;
@property int length;
@property int sum;
@property float rate;
@property float credit;
@property int sliderValue;

@property NSDictionary *sliderLabel;
@property NSDictionary *sliderLabel2;
@property NSDictionary *creditInterest;
@property NSMutableArray *sliderSteps;

extern NSNotificationCenter *dismissNotifCenter;
const extern NSString *dismissPopover;

//popover
@property (strong) UIPopoverController *popController;
@property (nonatomic, strong) KBAAppointmentContr *financeAppController;

@end

@implementation KBAFinanceController

- (id)init
{
    self = [super init];
    if (self) {
        self.needsAuthentification = YES;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.financeAppController = [KBAAppointmentContr new];
    
    //Datenstruktur
    self.sliderSteps = [[NSMutableArray alloc] init];
    
    [self updateValue:self.sumSlider];
    [self updateValue:self.lengthSlider];
    [self updateValue:self.interestSlider];
    
    [self initUpdate];
    [self calculateSliderSteps];
    
    [self updateAllValues];
    [self updateValue:self.rateSlider];
    
    [self calculateCreditSum];
    [self calculateRate];
   
    [self calculateInterest];
    //[self calculateRateLimits];
    
    self.rateSlider.minimumValue = 0;
    self.rateSlider.maximumValue = self.lengthSlider.maximumValue - self.lengthSlider.minimumValue;
    self.rate = [[self.sliderSteps objectAtIndex:self.length] floatValue];
    
    //UI Label Attributes
    [self.creditSum setFont:[UIFont boldSystemFontOfSize:18]];
    
    /*add observer/listener to receive message in popup-tableviews */
    //needs to be created everytime with this controller(is freed everytime view gets closed)
    dismissNotifCenter = [NSNotificationCenter new];
    [dismissNotifCenter addObserver:self
                           selector:@selector(closePopover)
                               name:(NSString *)dismissPopover
                             object:nil];
    
    //sync popover values with label values 
    self.sumSlider.externalLabelValue = self.sumLabel;
    self.lengthSlider.externalLabelValue = self.lengthLabel;
    self.interestSlider.externalLabelValue = self.interestLabel;
    self.rateSlider.externalLabelValue = self.rateLabel;
}

- (void)dealloc
{
    [dismissNotifCenter removeObserver:self
                                  name:(NSString *)dismissPopover
                                object:nil];
}

-(void)initUpdate
{
    self.interest = (double)(round(self.interestSlider.value)/1000);
    self.length = self.lengthSlider.value;
    self.sum = (int)self.sumSlider.value;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  initiates the dictionary
 */
-(void)initDic {
    self.sliderLabel = [NSDictionary dictionaryWithObjectsAndKeys:
                        self.sumLabel, @"sum", self.lengthLabel, @"length", self.interestLabel, @"interest", self.rateLabel, @"rate", nil];
    self.creditInterest =  [[KBADependencyInjector getByKey:@"customerDao"] customerWithName:nil andPassword:nil].creditRating.financingMatrix ;
}
/**
 *  updates the label values of given slider.
 *
 *  @param slider the currently used slider
 */
- (void)updateValue: (UISlider *) slider {
    [self initDic];
    UILabel *label = ((UILabel*) [self.sliderLabel objectForKey:slider.restorationIdentifier]);
    NSString *value = [NSString stringWithFormat: @"%d %@", (int)slider.value, label.restorationIdentifier];
    if ([slider isEqual:self.interestSlider]) {
        label.text = [NSString stringWithFormat: @"%0.1f %%", (double)slider.value/10];
    }
    else if ([slider isEqual:self.rateSlider]) {
        label.text = [NSString stringWithFormat: @"%0.2f €", [[self.sliderSteps objectAtIndex: ((int)slider.value)] floatValue] ];
    }
    else {
        label.text = value;
    }
}

-(void)updateAllValues{
    self.interest = (double)(round(self.interestSlider.value)/1000);
    self.length = self.lengthSlider.value;
    self.sum = (int)self.sumSlider.value;
    self.rate = [[self.sliderSteps objectAtIndex: ((int) self.rateSlider.value)]floatValue];
  //  NSLog(@"%f, %d, %d, %f" , self.interest, self. length, self.sum, self.rate);
}

/**
 *  Calculates the other values when the rate slider is moved
 */
-(void)calculateYears{
     // int length = - (log(1-((self.interest*self.sum)/self.rate))/(log(1+self.interest)));
    self.length = self.lengthSlider.maximumValue - (int) self.rateSlider.value;;
    self.lengthSlider.value = self.length;
    [self updateValue:self.lengthSlider];
}

-(void)calculateCreditSum{
    self.credit = self.sum * (self.interest*pow((1+self.interest),self.length) )/(pow((1+self.interest),self.length) -1) * self.length;
    self.creditSum.text = [NSString stringWithFormat:@"%0.f €", self.credit];
}

-(void)calculateRate{
    
//    self.rate = (float) self.credit / self.length;
//    self.rateSlider.value = self.rate;
  //  NSLog(@"%f, %d %f" , self.rate,self.length, self.rateSlider.value);
    self.rate = [[self.sliderSteps objectAtIndex:(self.lengthSlider.maximumValue - (int)self.length)] floatValue] ;
    self.rateSlider.value = self.lengthSlider.maximumValue - (int)self.length;
    [self updateValue:self.rateSlider];
   // NSLog(@"%f, %d %f" , self.rate,self.length, self.rateSlider.value);
    
}

-(void)calculateInterest{
    self.interest = [[self.creditInterest objectForKey: [NSNumber numberWithInt:self.length ]] doubleValue]/1000;
    self.interestSlider.value = [[self.creditInterest objectForKey: [NSNumber numberWithInt:self.length ]] doubleValue];
    [self updateValue:self.interestSlider];
    
    
}

-(IBAction)scheduleYears{
    [self updateAllValues];
    [self calculateInterest];
    [self calculateRate];
    [self calculateCreditSum];
    [self updateValue:self.lengthSlider];
    

}

-(IBAction)scheduleInterest{
    [self updateAllValues];
    [self calculateRate];
    [self calculateYears];
    [self calculateCreditSum];
    [self updateValue:self.interestSlider];
}

-(IBAction)scheduleCreditSum{
    [self updateAllValues];
    [self calculateSliderSteps];
    [self calculateRate];
    [self calculateInterest];
  //  [self calculateYears];
    [self calculateCreditSum];
    self.creditSum.text = [NSString stringWithFormat:@"%0.f €", self.credit];
   // [self calculateRateLimits];
    [self updateValue:self.sumSlider];
}

-(IBAction)scheduleRate{
    [self updateAllValues];
  // NSLog(@" 1 -> %d", self.length);
    [self calculateCreditSum];
    //  NSLog(@" 2 -> %d", self.length);
    [self calculateYears];
     //  NSLog(@" 3 -> %d", self.length);
    [self calculateInterest];
     //   NSLog(@" 4 -> %d", self.length);
    [self updateValue:self.rateSlider];
}

-(void)calculateRateLimits{
    
    double longInterest = [[self.creditInterest objectForKey: [NSNumber numberWithInt:self.lengthSlider.maximumValue ]] doubleValue]/1000;
    double shortInterest = [[self.creditInterest objectForKey: [NSNumber numberWithInt:self.lengthSlider.minimumValue ]] doubleValue]/1000;
    
    float longCredit = self.sum * (longInterest*pow((1+longInterest),30) )/(pow((1+longInterest),30) -1) * 30;
    float shortCredit = self.sum * (shortInterest*pow((1+shortInterest),3) )/(pow((1+shortInterest),3) -1) * 3;
    
    float minRate = (float) longCredit / 30;
    float maxRate = (float) shortCredit / 3;
    
    self.rateSlider.minimumValue = minRate;
    self.rateSlider.maximumValue = maxRate;
  //  NSLog(@"MinRate: %f ; MaxRate: %f", minRate, maxRate);
}

-(void)calculateSliderSteps{
    NSMutableArray *newSteps = [[NSMutableArray alloc]init];
    for (int a = self.lengthSlider.maximumValue; a>=0; a--) {
        if(a >= (self.lengthSlider.minimumValue))
        {
            double currenInterest = [[self.creditInterest objectForKey: [NSNumber numberWithInt:a]] doubleValue]/1000;
            
        float c = self.sum * (currenInterest*pow((1+currenInterest),a) )/(pow((1+currenInterest),a) -1) * a / a;
            [newSteps insertObject:[NSNumber numberWithFloat:c] atIndex:30-a];
        }
        else
        {
            [newSteps insertObject:[NSNumber numberWithFloat:0] atIndex:30-a];
        }
    }
    self.sliderSteps = newSteps;
    
}

-(IBAction)requestAppointment: (UIButton *) sender {
    [self showPopover:sender withPopoverController: self.financeAppController
         andDirection:UIPopoverArrowDirectionAny
            andOffset:CGPointMake(0, 15)];
}

/**
 *  Show a Popover
 */
- (void)showPopover: (UIButton *)sender withPopoverController:(UIViewController *)popoverController
       andDirection: (UIPopoverArrowDirection) popoverDirection
          andOffset: (CGPoint) offset{
    
    self.popController = [[UIPopoverController alloc]
                          initWithContentViewController:popoverController];
    
    CGPoint buttonPosition = sender.frame.origin;
    buttonPosition.x += sender.superview.frame.origin.x;
    buttonPosition.y += sender.superview.frame.origin.y;
    
    buttonPosition.x += offset.x;
    buttonPosition.y += offset.y;
    
    //given size as arg. is irrelevant
    //size is defined through size of view in popover
    [self.popController presentPopoverFromRect:CGRectMake(buttonPosition.x, buttonPosition.y, 1, 1)
                                        inView:self.view
                      permittedArrowDirections:popoverDirection
                                      animated:YES];
}

-(void)closePopover {
    [self.popController dismissPopoverAnimated:YES];
}

@end
