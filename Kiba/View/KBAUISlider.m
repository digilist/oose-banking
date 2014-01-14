//
//  KBAUISlider.m
//  Kiba
//
//  Created by 1jendryc on 14.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAUISlider.h"


@implementation KBAUISlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       self.tintColor = KBATintColor;
//     [self setMinimumTrackTintColor: KBATintColor];
        //[self setMaximumTrackTintColor:KBATintColor];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
         self.tintColor = KBATintColor;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
