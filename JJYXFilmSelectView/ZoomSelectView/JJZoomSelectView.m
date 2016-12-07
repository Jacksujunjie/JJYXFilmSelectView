//
//  JJZoomSelectView.m
//  JJYXFilmSelectView
//
//  Created by avatar on 16/1/25.
//  Copyright © 2016年 sujunjie. All rights reserved.
//

#import "JJZoomSelectView.h"
#import "UIView+SDAutoLayout.h"
#import "UIImage+ImageEffects.h"

@interface JJZoomSelectView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView   *scrollview;
@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, strong) NSMutableArray *bluredImageViews;
@property (nonatomic, strong) Class          subClass;

@property (nonatomic, assign) CGSize       subViewSize;

@property (nonatomic, assign) double       selWidth;
@property (nonatomic, assign) double       selHeight;

@property (nonatomic, assign) double       norWidth;
@property (nonatomic, assign) double       norHeight;

@property (nonatomic, assign) double       pageWidth;

@end


@implementation JJZoomSelectView

- (id)initWithFrame:(CGRect)frame subViewSize:(CGSize)size itemClass:(Class)cla  ratio:(double)ratio space:(double)space
{
    if(!cla)
    {
        return nil;
    }
    
    if(self = [self init])
    {
        self.subClass    = cla;
        self.frame       = frame;
        self.subViewSize = size;
        self.selHeight   = size.height;
        self.selWidth    = size.width;
        self.norHeight   = size.height * ratio;
        self.norWidth    = size.width  * ratio;
        self.pageWidth   = self.selWidth + (space * 2- (self.selWidth - self.norWidth));
        
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake((self.width - _pageWidth)/2, 0, _pageWidth, self.height)];
    _scrollview.delegate = self;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.decelerationRate = UIScrollViewDecelerationRateFast;
    _scrollview.pagingEnabled = YES;
    _scrollview.clipsToBounds = NO;
    [self addSubview:_scrollview];
    
}

- (void)reloadData
{
    [self viewsAddTap];
}

- (void)viewsAddTap
{
    long count = 0;
    NSArray *arr = _viewArray;
    _viewArray        = [NSMutableArray array];
    
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItems)])
    {
        count = [self.dataSource numberOfItems];
    }
    _scrollview.contentSize = CGSizeMake(_pageWidth * count, self.height);

    _bluredImageViews = [NSMutableArray arrayWithCapacity:count];
    
    for(int i = 0; i < count; i++)
    {
        UIView *view = nil;
        
        if(arr.count > i)
        {
            view = arr[i];
        }
        else
        {
            view = [[_subClass alloc] init];
        }
        
        if(self.dataSource && [self.dataSource respondsToSelector:@selector(item:updateAtIndex:)])
        {
            view = [self.dataSource item:view updateAtIndex:i];
        }
        
        [_viewArray addObject:view];
        
        if (i==0) {
            view.size = CGSizeMake(_selWidth, _selHeight);
        }else{
            view.size = CGSizeMake(_norWidth, _norHeight);
        }
        
        view.center = CGPointMake(i * _pageWidth + _pageWidth/2, self.height/2);
        view.tag    = i;
        [_scrollview addSubview:view];
        view.clipsToBounds = YES;
        
        UIImageView *im = [UIImageView new];
        [view addSubview:im];
         im.image = [UIImage imageNamed:@"loading640x1136"];
        im.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
        [view addGestureRecognizer:tap];
        
        UIImageView *bluredImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _selWidth, _selHeight)];
        bluredImageView.autoresizingMask = view.autoresizingMask;
        [view addSubview:bluredImageView];
        
        [_bluredImageViews addObject:bluredImageView];

        bluredImageView.alpha = 0;
        
        [self refreshBlurViewForNewImage:bluredImageView];

    }
}

- (void)clickView:(UITapGestureRecognizer *)tap
{
    UIView *view = (UIView *)tap.view;
    NSInteger tag = view.tag;
    
    if (_delegate && [_delegate respondsToSelector:@selector(itemdidSelectItemAtIndex:)]) {
        [_delegate itemdidSelectItemAtIndex:tag];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int currentIndex = scrollView.contentOffset.x/(_pageWidth);
    
    if(_viewArray.count < 1)
    {
        return;
    }
    
    UIView *currentView;
    UIView *bluCurrentView;
    
    if(currentIndex <= _viewArray.count-1 && currentIndex >= 0)
    {
        currentView    = _viewArray[currentIndex];
        bluCurrentView = _bluredImageViews[currentIndex];
    }
    
    
    int rightIndex = currentIndex+1;
    
    UIImageView *rightView;
    UIImageView *bluRightView;
    
    if(rightIndex <= _viewArray.count-1 && rightIndex >= 0)
    {
        rightView      = _viewArray[rightIndex];
        bluRightView   = _bluredImageViews[rightIndex];;
    }
    
    CGFloat scale =  fabs((scrollView.contentOffset.x-currentIndex*(_pageWidth))/(_pageWidth));
    
    CGFloat width  = _selWidth - scale*(_selWidth - _norWidth);
    CGFloat height = _selHeight - scale*(_selHeight - _norHeight);
    
    width  = _norWidth > width ? _norWidth:width;
    height = _norHeight > height ? _norHeight:height;
    width  = _selWidth < width ? _selWidth:width;
    height = _selHeight < height ? _selHeight:height;
    
    CGRect rect       = currentView.frame;
    CGPoint center    = currentView.center;
    rect.size         = CGSizeMake(width, height);
    currentView.frame = rect;
    currentView.center= center;
    
    bluCurrentView.alpha = MAX(scale * 0.7, 0);
    

    width  = _norWidth + scale*(_selWidth - _norWidth);
    height = _norHeight + scale*(_selHeight - _norHeight);
    
    width  = _norWidth > width ? _norWidth:width;
    height = _norHeight > height ? _norHeight:height;
    width  = _selWidth < width ? _selWidth:width;
    height = _selHeight < height ? _selHeight:height;
    
    rect            = rightView.frame;
    center          = rightView.center;
    rect.size       = CGSizeMake(width, height);
    rightView.frame = rect;
    rightView.center= center;
    
    bluRightView.alpha = MAX((1-scale) * 0.7, 0);

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    long currentIndex = MAX(0, roundf(scrollView.contentOffset.x/_pageWidth));
    
    currentIndex      = MIN(currentIndex, _viewArray.count-1);
    
    if (_delegate && [_delegate respondsToSelector:@selector(itemdidSelectItemAtIndex:)]) {
        [_delegate itemdidSelectItemAtIndex:currentIndex];
    }

}

- (UIImage *)screenShotOfView:(UIImageView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.size, YES, 0.0);
    [self drawViewHierarchyInRect:view.frame afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)refreshBlurViewForNewImage:(UIImageView *)imageView
{
    UIImage *screenShot = [self screenShotOfView:imageView];
    screenShot = [screenShot applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:0.6 alpha:0.2] saturationDeltaFactor:1.0 maskImage:nil];
    imageView.image = screenShot;
}


-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    UIView* child = nil;
    if ((child = [super hitTest:point withEvent:event]) == self)
        return self.scrollview;
    return child;
}

@end
