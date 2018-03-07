//
//  ViewController.m
//  JJYXFilmSelectView
//
//  Created by avatar on 16/1/25.
//  Copyright © 2016年 sujunjie. All rights reserved.
//

#import "ViewController.h"
#import "JJZoomSelectView.h"


@interface ViewController ()<JJZoomSelectViewDataSource,JJZoomSelectViewDelegate>

@property(nonatomic, strong)JJZoomSelectView * sjj;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *view0 = [UIView new];
    view0.backgroundColor = [UIColor redColor];
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor grayColor];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor brownColor];
    
    UIView *view3 = [UIView new];
    view3.backgroundColor = [UIColor orangeColor];
    
    UIView *view4 = [UIView new];
    view4.backgroundColor = [UIColor purpleColor];
    
    UIView *view5 = [UIView new];
    view5.backgroundColor = [UIColor yellowColor];
    
    UIView *view6 = [UIView new];
    view6.backgroundColor = [UIColor cyanColor];
    
    UIView *view7 = [UIView new];
    view7.backgroundColor = [UIColor magentaColor];
    
    UIView *view8 = [UIView new];
    view8.backgroundColor = [UIColor blackColor];
    
    _sjj = [[JJZoomSelectView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 250) subViewSize:CGSizeMake(250, 250) itemClass:[UIView class] ratio:0.8 space:20];
    _sjj.delegate = self;
    _sjj.dataSource = self;
    [self.view addSubview:_sjj];
    
    [self performSelector:@selector(up) withObject:nil afterDelay:1];
    
    [self performSelector:@selector(up) withObject:nil afterDelay:2];
    
}

- (void)up{
    [_sjj reloadData];
}

-(NSInteger)numberOfItems
{
    return 8;
}

-(UIView *)item:(UIView *)view updateAtIndex:(NSInteger)index
{
    return view;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    /*
     hhh
     */
}

@end
