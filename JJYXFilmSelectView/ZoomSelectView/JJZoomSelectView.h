//
//  JJZoomSelectView.h
//  JJYXFilmSelectView
//
//  Created by avatar on 16/1/25.
//  Copyright © 2016年 sujunjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JJZoomSelectViewDelegate <NSObject>

@optional

/**
 *  点击事件
 */
-(void)itemdidSelectItemAtIndex:(NSInteger)index;

@end

@protocol JJZoomSelectViewDataSource <NSObject>

/**
 *  子view个数
 */
-(NSInteger)numberOfItems;

/**
 *  刷新数据遍历子view
 *
 *  @param view  遍历的子view
 *  @param index index
 *
 *  @return 遍历的子view
 */
-(UIView *)item:(UIView *)view updateAtIndex:(NSInteger)index;


@end


@interface JJZoomSelectView : UIView

@property (nonatomic, weak) id<JJZoomSelectViewDelegate>   delegate;
@property (nonatomic, weak) id<JJZoomSelectViewDataSource> dataSource;
/**
 *  创建
 *
 *  @param frame 整view的fram
 *  @param size  选择项的size
 *  @param cla   子view的类
 *  @param ratoi 缩小倍数
 *  @param space 子view的间距
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame subViewSize:(CGSize)size itemClass:(Class)cla  ratio:(double)ratoi space:(double)space;


/**
 *  刷新数据
 */
- (void)reloadData;

@end
