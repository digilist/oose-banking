//
//  KBAUISegmentedControl.m
//  Kiba
//
//  Created by Schaarschmidt, Kevin Michael on 09.01.14.
//  Copyright (c) 2014 KiBa App. All rights reserved.
//

#import "KBAUISegmentedControl.h"

@implementation KBAUISegmentedControl

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
