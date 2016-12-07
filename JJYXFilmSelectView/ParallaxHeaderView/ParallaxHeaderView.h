//
//  ParallaxHeaderView.h
//  ParallaxTableViewHeader
//
//  Created by Vinodh  on 26/10/14.
//  Copyright (c) 2014 Daston~Rhadnojnainva. All rights reserved.

//

#import <UIKit/UIKit.h>

#define kDefaultHeaderFrame CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)

static CGFloat kMaxTitleAlphaOffset = 100.0f;

@interface ParallaxHeaderView : UIView

@property (strong, nonatomic) UIScrollView *imageScrollView;

@property (nonatomic) UIImage *headerImage;


+ (id)parallaxHeaderViewWithImage:(UIImage *)image forSize:(CGSize)headerSize;
+ (id)parallaxHeaderViewWithCGSize:(CGSize)headerSize;
- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset;

/**
 *  在子类实现，设置heard的内容
 */
- (void)createParallaxHeaderViewUI;

- (void)setHeaderImageWithUrl:(NSString *)url;

@end

