//
//  KBAFinanceController.m
//  Kiba
//
//  Created by 1jendryc on 07.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAFinanceController.h"

@interface KBAFinanceController ()

@property (nonatomic, weak) IBOutlet UISlider *sumSlider;
@property (nonatomic, weak) IBOutlet UISlider *lengthSlider;
@property (nonatomic, weak) IBOutlet UISlider *interestSlider;
@property (nonatomic, weak) IBOutlet UISlider *rateSlider;

@property (nonatomic, weak) IBOutlet UILabel *sumLabel;
@property (nonatomic, weak) IBOutlet UILabel *lengthLabel;
@property (nonatomic, weak) IBOutlet UILabel *interestLabel;
@property (nonatomic, weak) IBOutlet UILabel *rateLabel;
@property (nonatomic, weak) IBOutlet UILabel *creditSum;

@property double interest;
@property int length;
@property int sum;
@property float rate;


@property NSDictionary *sliderLabel;
@property NSDictionary *sliderLabel2;


@end

@implementation KBAFinanceController

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
    // Do any additional setup after loading the view from its nib.
    [self updateValue:self.sumSlider];
        [self updateValue:self.lengthSlider];
        [self updateValue:self.interestSlider];
        [self updateValue:self.rateSlider];
    [self mortgageOver:self.sumSlider];
    
//    self.interest = (double)(round(self.interestSlider.value)/1000);
//    self.length = self.lengthSlider.value;
//    self.sum = (int)self.sumSlider.value;
//    self.rate = self.rateSlider.value;

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
}
/**
 *  updates the label values of given slider.
 *
 *  @param slider the currently used slider
 */
- (IBAction)updateValue: (UISlider *) slider {
    [self initDic];
    UILabel *label = ((UILabel*) [self.sliderLabel objectForKey:slider.restorationIdentifier]);
    NSString *value = [NSString stringWithFormat: @"%d %@", (int)slider.value, label.restorationIdentifier];
    if ([slider isEqual:self.interestSlider]) {
        label.text = [NSString stringWithFormat: @"%0.1f %%", (double)slider.value/10];
    }
    else if ([slider isEqual:self.rateSlider]) {
        label.text = [NSString stringWithFormat: @"%0.2f €", (double)slider.value];
    }
    else {
        label.text = value;
    }
   int lab2 = [[self.sliderLabel allValues]count];
    NSLog(@"%@ , %d", value, lab2);
    
    //[self updateAllValues];
    
}
/**
 *  Calculates the mortgage
 */
-(IBAction)mortgageOver: (UISlider *) slider{
    self.rate = (double)(round(self.interestSlider.value)/1000);
    self.length = self.lengthSlider.value;
    self.sum = (int)self.sumSlider.value;
    int a = self.sum * (self.rate*pow((1+self.rate),self.length) )/(pow((1+self.rate),self.length) -1) * self.length;
    self.creditSum.text = [NSString stringWithFormat:@"%d €", a];
    NSLog(@"%f", self.rate);
    
    self.rateSlider.value = (float) a / self.length;
    [self updateValue:self.rateSlider];
}

-(void)updateAllValues{
    self.interest = (double)(round(self.interestSlider.value)/1000);
    self.length = self.lengthSlider.value;
    self.sum = (int)self.sumSlider.value;
    self.rate = self.rateSlider.value;
    
}
/**
 *  Calculates the other values when the rate slider is moved
 *
 *  @param slider RateSlider
 */
-(IBAction)calculateRates{
 //   float b = (self.sum/((1/self.interest)*(1-(1/(pow((1+self.interest),self.length))))));
        
    
}





@end
