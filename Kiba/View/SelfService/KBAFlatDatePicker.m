/*
 The MIT License (MIT)
 
 Copyright (c) 2013 Steven Shen
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

//
//  KBAFlatDatePicker.m
//  FlatDatePicker
//
//  Created by Shen Steven on 5/29/13.
//  Copyright (c) 2013 theXingApp. All rights reserved.
//

#import "KBAFlatDatePicker.h"
@import QuartzCore;

@class KBAFlatDatePickerCollectionView;

#define kNumberOfCellPerRow 3.0f

#pragma mark - KBADatePickerLayoutAttriutes
@interface KBADatePickerLayoutAttributes : UICollectionViewLayoutAttributes
@property (nonatomic, strong) CAGradientLayer *gradient;
@end

@implementation KBADatePickerLayoutAttributes

- (id)copyWithZone:(NSZone *)zone {
	KBADatePickerLayoutAttributes *attributes = [super copyWithZone:zone];
	attributes.gradient = _gradient;
	return attributes;
}

- (BOOL)isEqual:(id)object {
	BOOL equal = [super isEqual:object];
	if (!equal)
		return NO;
    
	return [self.gradient isEqual:[(KBADatePickerLayoutAttributes *)object gradient]];
}

@end

#pragma mark - KBAFlatDatePickerFlowLayout
@interface KBAFlatDatePickerFlowLayout : UICollectionViewFlowLayout
@end

@implementation KBAFlatDatePickerFlowLayout

- (void)prepareLayout {
	self.scrollDirection = UICollectionViewScrollDirectionVertical;
	self.minimumInteritemSpacing = 0;
	self.minimumLineSpacing = 0;
	self.itemSize = CGSizeMake(self.collectionView.frame.size.width, ((CGFloat)(self.collectionView.frame.size.height) / kNumberOfCellPerRow));
    
	CGFloat h = (CGFloat)self.collectionView.frame.size.height / 2.0f - (CGFloat)self.itemSize.height / 2.0f;
	self.sectionInset = UIEdgeInsetsMake(h, 0, h, 0);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
	NSMutableArray *array = [NSMutableArray arrayWithArray:[super layoutAttributesForElementsInRect:rect]];
    
	for (KBADatePickerLayoutAttributes *attr in array) {
		[self applyAttributes:attr];
	}
    
	return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
	KBADatePickerLayoutAttributes *attributes = (KBADatePickerLayoutAttributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
	[self applyAttributes:attributes];
	return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
	return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
	NSInteger page = roundf(self.collectionView.contentOffset.y / self.itemSize.height);
	return CGPointMake(proposedContentOffset.x, page * self.itemSize.height);
}

- (void)applyAttributes:(KBADatePickerLayoutAttributes *)attributes {
	CGRect visibleRect;
    
	visibleRect.origin = self.collectionView.contentOffset;
	visibleRect.size = self.collectionView.frame.size;
    
	CGFloat distance = CGRectGetMidY(visibleRect) - attributes.center.y;
	if (distance < self.itemSize.height / 2 && distance > -(self.itemSize.height / 2)) {
		attributes.gradient = nil;
		return;
	}
    
	UICollectionView *collectionView = (UICollectionView *)(self.collectionView);
	UIColor *color = collectionView.backgroundColor;
    
	CAGradientLayer *graident = [CAGradientLayer layer];
	graident.frame = (CGRect) {CGPointZero, self.itemSize };
	if (distance < 0) {
		if (distance >= -((self.itemSize.height * 3) / 2)) {
			graident.colors = @[
                                (id)[[color colorWithAlphaComponent:0.3] CGColor],
                                (id)[[color colorWithAlphaComponent:0.5] CGColor],
                                (id)[[color colorWithAlphaComponent:0.6] CGColor]
                                ];
		}
		else {
			graident.colors = @[
                                (id)[[color colorWithAlphaComponent:0.6] CGColor],
                                (id)[[color colorWithAlphaComponent:0.7] CGColor]
                                ];
		}
	}
	else {
		if (distance <= (self.itemSize.height * 3 / 2)) {
			graident.colors = @[
                                (id)[[color colorWithAlphaComponent:0.6] CGColor],
                                (id)[[color colorWithAlphaComponent:0.5] CGColor],
                                (id)[[color colorWithAlphaComponent:0.3] CGColor]
                                ];
		}
		else {
			graident.colors = @[
                                (id)[[color colorWithAlphaComponent:0.7] CGColor],
                                (id)[[color colorWithAlphaComponent:0.6] CGColor]
                                ];
		}
	}
    
	attributes.gradient = graident;
}

+ (Class)layoutAttributesClass {
	return [KBADatePickerLayoutAttributes class];
}

@end

#pragma mark - KBAFlatDateViewCell
@interface KBAFlatDateViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation KBAFlatDateViewCell

- (void)initialization {
	self.backgroundColor = [UIColor clearColor];
	self.textLabel = [[UILabel alloc] initWithFrame:(CGRect) {CGPointZero, self.frame.size }];
	self.textLabel.backgroundColor = [UIColor clearColor];
	self.textLabel.textAlignment = NSTextAlignmentCenter;
	self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self addSubview:self.textLabel];
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self initialization];
        
	}
	return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
	[super applyLayoutAttributes:layoutAttributes];
    
	KBADatePickerLayoutAttributes *attributes = (KBADatePickerLayoutAttributes *)layoutAttributes;
    
	if (self.gradientLayer) {
		[self.gradientLayer removeFromSuperlayer];
		self.gradientLayer = nil;
	}
    
	if (attributes.gradient) {
		[self.textLabel.layer insertSublayer:attributes.gradient atIndex:0];
		self.gradientLayer = attributes.gradient;
	}
}

@end

@interface KBAFlatDatePickerCollectionView : UICollectionView

@property (nonatomic, readonly) NSIndexPath *currentSelectedIndexPath;

@end

@implementation KBAFlatDatePickerCollectionView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
	self = [super initWithFrame:frame collectionViewLayout:layout];
	if (self) {
		self.showsVerticalScrollIndicator = NO;
		self.alwaysBounceVertical = NO;
		self.bounces = NO;
		[self registerClass:[KBAFlatDateViewCell class] forCellWithReuseIdentifier:@"datePickerCell"];
	}
	return self;
}

- (NSIndexPath *)currentSelectedIndexPath {
	CGSize itemSize = [(KBAFlatDatePickerFlowLayout *)self.collectionViewLayout itemSize];
	NSInteger row = round(self.contentOffset.y / itemSize.height);
	return [NSIndexPath indexPathForRow:row inSection:0];
}

@end

#pragma mark - KBAFlatDatePicker
@interface KBAFlatDatePicker () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) KBAFlatDatePickerCollectionView *scrollerYear;
@property (nonatomic, strong) KBAFlatDatePickerCollectionView *scrollerMonth;
@property (nonatomic, strong) KBAFlatDatePickerCollectionView *scrollerDay;

@property (nonatomic, strong) KBAFlatDatePickerCollectionView *scrollerHour;
@property (nonatomic, strong) KBAFlatDatePickerCollectionView *scrollerMinute;
@property (nonatomic, strong) KBAFlatDatePickerCollectionView *scrollerAPM;

@property (nonatomic, assign) NSRange yearRange;
@end

@implementation KBAFlatDatePicker {
	NSDate *_initiateDate;
	NSDate *_dateSet;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
	}
	return self;
}

- (void)awakeFromNib {
    [[KBAFlatDatePicker appearance] setFont:[UIFont fontWithName:Nil size:22]];
    
    [[KBAFlatDatePicker appearance] setTextColor:[UIColor blackColor]];
    [[KBAFlatDatePicker appearance] setBackgroundColor: KBATintColor];
    [[KBAFlatDatePicker appearance] setGradientColor:[UIColor whiteColor]];
    
//    [[KBAFlatDatePicker appearance] setTextColor:[UIColor blackColor]];
//    [[KBAFlatDatePicker appearance] setBackgroundColor:[UIColor blackColor]];
//    [[KBAFlatDatePicker appearance] setGradientColor:[UIColor whiteColor]];

}

- (void)initialize {
	BOOL initiate = NO;
	CGFloat _separatorWidth = 2;
    
	CGFloat _longWidth, _shortWidth;
	_longWidth = 0.35 * (self.frame.size.width - _separatorWidth * 2);
	_shortWidth = 0.3 * (self.frame.size.width - _separatorWidth * 2);
    
	KBAFlatDatePickerFlowLayout *flowLayout1 = [KBAFlatDatePickerFlowLayout new];
	KBAFlatDatePickerFlowLayout *flowLayout2 = [KBAFlatDatePickerFlowLayout new];
	KBAFlatDatePickerFlowLayout *flowLayout3 = [KBAFlatDatePickerFlowLayout new];
    
	if (_datePickerMode == KBAFlatDatePickerModeDate) {
		if (!_scrollerYear) {
			self.scrollerYear = [[KBAFlatDatePickerCollectionView alloc]
                                 initWithFrame:CGRectZero
                                 collectionViewLayout:flowLayout1];
            
			self.scrollerYear.delegate = self;
			self.scrollerYear.dataSource = self;
			initiate = YES;
			[self addSubview:self.scrollerYear];
		}
		flowLayout1.itemSize = CGSizeMake(_longWidth, self.frame.size.height / kNumberOfCellPerRow);
		self.scrollerYear.frame = CGRectMake(0, 0, _longWidth, self.frame.size.height);
        
		if (!_scrollerMonth) {
			self.scrollerMonth = [[KBAFlatDatePickerCollectionView alloc]
                                  initWithFrame:CGRectZero
                                  collectionViewLayout:flowLayout2];
            
			self.scrollerMonth.delegate = self;
			self.scrollerMonth.dataSource = self;
			initiate = YES;
			[self addSubview:self.scrollerMonth];
		}
		flowLayout2.itemSize = CGSizeMake(_longWidth, self.frame.size.height / kNumberOfCellPerRow);
		self.scrollerMonth.frame = CGRectMake(_separatorWidth + _longWidth, 0, _longWidth, self.frame.size.height);
        
		if (!_scrollerDay) {
			self.scrollerDay = [[KBAFlatDatePickerCollectionView alloc]
                                initWithFrame:CGRectZero
                                collectionViewLayout:flowLayout3];
            
			self.scrollerDay.delegate = self;
			self.scrollerDay.dataSource = self;
			initiate = YES;
			[self addSubview:self.scrollerDay];
		}
		flowLayout3.itemSize = CGSizeMake(_shortWidth, self.frame.size.height / kNumberOfCellPerRow);
		self.scrollerDay.frame = CGRectMake(_separatorWidth * 2 + _longWidth * 2, 0, _shortWidth, self.frame.size.height);
	}
	else if (_datePickerMode == KBAFlatDatePickerModeTime) {
		if (!_scrollerHour) {
			self.scrollerHour = [[KBAFlatDatePickerCollectionView alloc]
                                 initWithFrame:CGRectZero
                                 collectionViewLayout:flowLayout1];
            
			self.scrollerHour.delegate = self;
			self.scrollerHour.dataSource = self;
			initiate = YES;
			[self addSubview:self.scrollerHour];
		}
		flowLayout1.itemSize = CGSizeMake(_longWidth, self.frame.size.height / kNumberOfCellPerRow);
		self.scrollerHour.frame = CGRectMake(0, 0, _longWidth, self.frame.size.height);
        
		if (!_scrollerMinute) {
			self.scrollerMinute = [[KBAFlatDatePickerCollectionView alloc]
                                   initWithFrame:CGRectZero
                                   collectionViewLayout:flowLayout2];
            
			self.scrollerMinute.delegate = self;
			self.scrollerMinute.dataSource = self;
			initiate = YES;
			[self addSubview:self.scrollerMinute];
		}
		flowLayout2.itemSize = CGSizeMake(_longWidth, self.frame.size.height / kNumberOfCellPerRow);
		self.scrollerMinute.frame = CGRectMake(_separatorWidth + _longWidth, 0, _longWidth, self.frame.size.height);
        
		if (!_scrollerAPM) {
			self.scrollerAPM = [[KBAFlatDatePickerCollectionView alloc]
                                initWithFrame:CGRectZero
                                collectionViewLayout:flowLayout3];
            
			self.scrollerAPM.delegate = self;
			self.scrollerAPM.dataSource = self;
			initiate = YES;
			[self addSubview:self.scrollerAPM];
		}
		flowLayout3.itemSize = CGSizeMake(_shortWidth, self.frame.size.height / kNumberOfCellPerRow);
		self.scrollerAPM.frame = CGRectMake(_separatorWidth * 2 + _longWidth * 2, 0, _shortWidth, self.frame.size.height);
	}
    
	NSDate *date = [NSDate date];
	if (_initiateDate)
		date = _initiateDate;
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dateComponents =
    [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSTimeZoneCalendarUnit)
                fromDate:date];
    
	NSRange range;
    //limit range to this year
//	range.location = dateComponents.year - 5;
//	range.length = 6;
//	self.yearRange = range;
    
	range.location = dateComponents.year - 5;
	range.length = 8;
	self.yearRange = range;
    
	self.layer.cornerRadius = 5.0f;
    
	self.clipsToBounds = YES;
	self.layer.cornerRadius = 5;
    
	if (initiate && !_initiateDate) {
		[self setDate:date];
	}
}

- (void)reloadData {
    
	[self.scrollerYear reloadData];
	[self.scrollerMonth reloadData];
	[self.scrollerMinute reloadData];
	[self.scrollerDay reloadData];
	[self.scrollerAPM reloadData];
	[self.scrollerHour reloadData];
}

- (void)setTextColor:(UIColor *)textColor {
	_textColor = textColor;
    
	[self reloadData];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[self initialize];
    
	CAGradientLayer *(^createGradient) (CGRect) = ^CAGradientLayer *(CGRect frame) {
		CAGradientLayer *gradient = [CAGradientLayer layer];
		gradient.colors = @[
                            (id)[[self.gradientColor colorWithAlphaComponent:0.7] CGColor],
                            (id)[[self.gradientColor colorWithAlphaComponent:0.5] CGColor],
                            (id)[[self.gradientColor colorWithAlphaComponent:0.3] CGColor],
                            (id)[[self.gradientColor colorWithAlphaComponent:0] CGColor],
                            (id)[[self.gradientColor colorWithAlphaComponent:0.3] CGColor],
                            (id)[[self.gradientColor colorWithAlphaComponent:0.5] CGColor],
                            (id)[[self.gradientColor colorWithAlphaComponent:0.7] CGColor],
                            ];
        
		gradient.frame = frame;
		return gradient;
	};
    
	CAGradientLayer *gradientForHolder = createGradient((CGRect) {CGPointZero, self.frame.size });
    
	for (CALayer *layer in self.layer.sublayers) {
		if ([layer isKindOfClass:[CAGradientLayer class]]) {
			[layer removeFromSuperlayer];
			break;
		}
	}
	[self.layer addSublayer:gradientForHolder];
    
	self.scrollerYear.backgroundColor = self.gradientColor;
	self.scrollerMonth.backgroundColor = self.gradientColor;
	self.scrollerDay.backgroundColor = self.gradientColor;
	self.scrollerMinute.backgroundColor = self.gradientColor;
	self.scrollerHour.backgroundColor = self.gradientColor;
	self.scrollerAPM.backgroundColor = self.gradientColor;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	NSInteger numberOfItems = 0;
    
	if (collectionView == self.scrollerYear) {
		numberOfItems = self.yearRange.length;
	}
	else if (collectionView == self.scrollerMonth) {
		numberOfItems = 12;
	}
	else if (collectionView == self.scrollerDay) {
		if (_dateSet) {
			NSRange dayRange = [[NSCalendar currentCalendar]
                                rangeOfUnit:NSDayCalendarUnit
                                inUnit:NSMonthCalendarUnit
                                forDate:_dateSet];
            
			numberOfItems = dayRange.length;
		}
		else if (self.date) {
			NSRange dayRange = [[NSCalendar currentCalendar]
                                rangeOfUnit:NSDayCalendarUnit
                                inUnit:NSMonthCalendarUnit
                                forDate:self.date];
            
			numberOfItems = dayRange.length;
		}
		else {
			numberOfItems = 31;
		}
	}
	else if (collectionView == self.scrollerHour) {
		numberOfItems = 12;
	}
	else if (collectionView == self.scrollerMinute) {
		numberOfItems = 60;
	}
	else if (collectionView == self.scrollerAPM) {
		numberOfItems = 2;
	}
    
	return numberOfItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	KBAFlatDateViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"datePickerCell" forIndexPath:indexPath];
    
	cell.textLabel.font = self.font;
	cell.textLabel.textColor = self.textColor;
    
	if (collectionView == self.scrollerYear) {
		cell.textLabel.text = [NSString stringWithFormat:@"%u", (self.yearRange.location + indexPath.row)];
	}
	else if (collectionView == self.scrollerMonth) {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		formatter.locale = [NSLocale currentLocale];
        
		cell.textLabel.text = [NSString stringWithFormat:@"%@", [formatter.shortMonthSymbols objectAtIndex:indexPath.row]];
	}
	else if (collectionView == self.scrollerDay) {
		cell.textLabel.text = [NSString stringWithFormat:@"%d", (indexPath.row + 1)];
	}
	else if (collectionView == self.scrollerHour) {
		cell.textLabel.text = [NSString stringWithFormat:@"%02d", indexPath.row + 1];
	}
	else if (collectionView == self.scrollerMinute) {
		cell.textLabel.text = [NSString stringWithFormat:@"%02ld", (long)indexPath.row];
	}
	else {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		formatter.locale = [NSLocale currentLocale];
		if (indexPath.row == 0)
			cell.textLabel.text = formatter.AMSymbol;
		else
			cell.textLabel.text = formatter.PMSymbol;
	}
    
	return cell;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	if (!decelerate)
		[self endScrollForScrollView:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	[self endScrollForScrollView:scrollView];
}

- (void)endScrollForScrollView:(UIScrollView *)scrollView {
	if (scrollView == self.scrollerYear) {
		[self.scrollerDay reloadData];
	}
	else if (scrollView == self.scrollerMonth) {
		[self.scrollerDay reloadData];
	}
	else if (scrollView == self.scrollerDay) {
		// nothing
	}
	else if (scrollView == self.scrollerHour) {
		NSIndexPath *indexPath = [self.scrollerHour currentSelectedIndexPath];
		if (indexPath.row == 11) {
			NSIndexPath *apmIndexPath = [self.scrollerAPM currentSelectedIndexPath];
			NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:!apmIndexPath.row inSection:0];
			[self.scrollerAPM scrollToItemAtIndexPath:newIndexPath
                                     atScrollPosition:UICollectionViewScrollPositionCenteredVertically
                                             animated:YES];
		}
	}
    
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setDate:(NSDate *)date {
	[self setDate:date animated:NO];
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated {
	if (!_initiateDate)
		_initiateDate = date;
    
	_dateSet = date;
    
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dateComponents =
    [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |
                          NSHourCalendarUnit | NSMinuteCalendarUnit | NSTimeZoneCalendarUnit)
                fromDate:date];
    
	NSInteger yIndex = dateComponents.year - self.yearRange.location;
	NSInteger currentYearIndex = [self.scrollerYear currentSelectedIndexPath].row;
	if (yIndex != currentYearIndex) {
		[self.scrollerYear scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:yIndex inSection:0]
                                  atScrollPosition:UICollectionViewScrollPositionCenteredVertically
                                          animated:animated];
		[self.scrollerDay reloadData];
	}
    
	NSInteger currentMonthIndex = [self.scrollerMonth currentSelectedIndexPath].row;
	if (dateComponents.month != currentMonthIndex) {
		[self.scrollerMonth scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:dateComponents.month - 1 inSection:0]
                                   atScrollPosition:UICollectionViewScrollPositionCenteredVertically
                                           animated:animated];
		[self.scrollerDay reloadData];
	}
    
	NSInteger currentDayIndex = [self.scrollerDay currentSelectedIndexPath].row;
	if (dateComponents.day != currentDayIndex) {
		[self.scrollerDay scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:dateComponents.day - 1 inSection:0]
                                 atScrollPosition:UICollectionViewScrollPositionCenteredVertically
                                         animated:animated];
	}
    
    
	NSInteger currentHourIndex = [self.scrollerHour currentSelectedIndexPath].row;
	NSInteger hour = (dateComponents.hour % 12);
	if (hour != (currentHourIndex + 1)) {
		if (hour == 0)
			hour = 11;
		else
			hour = hour - 1;
		[self.scrollerHour scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:hour inSection:0]
                                  atScrollPosition:UICollectionViewScrollPositionCenteredVertically
                                          animated:animated];
	}
    
	NSInteger currentMinIndex = [self.scrollerMinute currentSelectedIndexPath].row;
	if (dateComponents.minute != currentMinIndex) {
		[self.scrollerMinute scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:dateComponents.minute inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionCenteredVertically
                                            animated:animated];
	}
    
	NSInteger currentAPMIndex = [self.scrollerAPM currentSelectedIndexPath].row;
	NSInteger APM =  0;
	if (dateComponents.hour > 11)
		APM = 1;
	if (APM != currentAPMIndex) {
		[self.scrollerAPM scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:APM inSection:0]
                                 atScrollPosition:UICollectionViewScrollPositionCenteredVertically
                                         animated:animated];
	}
    
	_dateSet = nil;
}

- (NSDate *)date {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dComps = [[NSDateComponents alloc] init];
    
	NSInteger currentYearIndex = [self.scrollerYear currentSelectedIndexPath].row;
	NSInteger currentMonthIndex = [self.scrollerMonth currentSelectedIndexPath].row;
	NSInteger currentDayIndex = [self.scrollerDay currentSelectedIndexPath].row;
    
	if (currentMonthIndex == 1) {
		NSInteger year = currentYearIndex + self.yearRange.location;
		BOOL isLeapYear = ((year % 100 != 0) && (year % 4 == 0)) || (year % 400 == 0);
		NSInteger days = isLeapYear ? 29 : 28;
		if (currentDayIndex + 1 > days) {
			currentDayIndex = days - 1;
		}
	}
	else if (currentMonthIndex == 1 || currentMonthIndex == 3 ||
             currentMonthIndex == 5 || currentMonthIndex == 8 ||
             currentMonthIndex == 10) {
                                        if (currentDayIndex + 1 > 30) {
                                            currentDayIndex = 29;
		}
	}
    
	dComps.year = currentYearIndex + self.yearRange.location;
	dComps.month = currentMonthIndex + 1;
	dComps.day = currentDayIndex + 1;
    
	NSInteger currentHourIndex = [self.scrollerHour currentSelectedIndexPath].row;
	NSInteger currentMinIndex = [self.scrollerMinute currentSelectedIndexPath].row;
	NSInteger currentAPMIndex = [self.scrollerAPM currentSelectedIndexPath].row;
    
	//12-hour clock:12:15 AM --> 24-hour clock:00:15
	//http://en.wikipedia.org/wiki/24-hour_clock
    
	BOOL isAM = currentAPMIndex == 0;
	if (currentHourIndex == 11) {
		dComps.hour = isAM ? 0 : 12;
	}
	else {
		dComps.hour = isAM ? (currentHourIndex + 1) : (currentHourIndex + 13);
	}
    
	dComps.minute = currentMinIndex;
    
	dComps.timeZone = [NSTimeZone systemTimeZone];
    
	return [calendar dateFromComponents:dComps];
}

@end
