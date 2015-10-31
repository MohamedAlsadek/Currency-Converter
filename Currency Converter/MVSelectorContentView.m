/*
 * This file is part of the MVSelectorScrollView package.
 * (c) Andrea Bizzotto <bizz84@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE.md
 * file that was distributed with this source code.
 */


#import "MVSelectorContentView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MVSelectorContentView

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createLabel:text];
    }
    return self;
}

- (void)createLabel:(NSString *)text {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat itemWidth = screenRect.size.width / 3;
    
    CGSize size = self.frame.size;
    CGRect labelFrame = CGRectMake(0.0f, 0.0f, itemWidth , size.height);
    
    self.label = [[UILabel alloc] initWithFrame:labelFrame];
    self.label.text = text;
    self.label.font = [UIFont fontWithName:@"Helvetica-Bold" size:56.0];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.minimumScaleFactor = 0.5 ;
    self.label.adjustsFontSizeToFitWidth = YES ; 
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    
    [self addSubview:self.label];
}

- (void)setSelected:(BOOL)selected {
    
    float alpha = selected ? 1 : 0.3;
    self.label.textColor = [UIColor colorWithWhite:1.0 alpha:alpha];
}

@end
