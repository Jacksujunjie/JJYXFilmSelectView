# JJYXFilmSelectView
类电影票选票的滚动页，有缩放、模糊功能。


1、用法：
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

2.代理

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
