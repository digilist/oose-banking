//
//  KBAUISlider.m
//  Kiba
//
//  Created by Marco F. Jendryczko on 14.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAUISlider.h"


@implementation KBAUISlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       self.tintColor = KBATintColor;
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
@end
