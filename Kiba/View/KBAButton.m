//
//  KBAButton.m
//  Kiba
//
//  Created by //// on 08.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAButton.h"

@implementation KBAButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor = KBATintColor;
        self.titleLabel.tintColor = KBATintColor;
        [self setTitleColor:KBATintColor forState:UIControlStateNormal];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.tintColor = KBATintColor;
        self.titleLabel.tintColor = KBATintColor;
        [self setTitleColor:KBATintColor forState:UIControlStateNormal];
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
