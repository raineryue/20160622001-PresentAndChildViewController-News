//
//  RYNewsHomeViewController.m
//  20160622001-PresentAndChildViewController-News
//
//  Created by Rainer on 16/6/22.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "RYNewsHomeViewController.h"
#import "RYTitleLabel.h"
#import "RYYaoWenViewController.h"
#import "RYShiPinViewController.h"
#import "RYShangHaiViewController.h"
#import "RYCaiJingViewController.h"
#import "RYYuLeViewController.h"
#import "RYTiYuViewController.h"
#import "RYGuoJiViewController.h"

@interface RYNewsHomeViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation RYNewsHomeViewController

#pragma mark - 视图加载方法
/**
 *  控制器视图家在完成方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置自动调整内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 2.设置子控制器
    [self setupChildViewControllers];
    
    // 3.设置标题按钮
    [self setupNewsTitleItems];
    
    // 4.设置默认选中标签
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

/**
 *  设置子控制器
 */
- (void)setupChildViewControllers {
    RYYaoWenViewController *yaoWenViewController = [[RYYaoWenViewController alloc] init];
    yaoWenViewController.title = @"要闻";
    [self addChildViewController:yaoWenViewController];
    
    RYShiPinViewController *shiPinViewController = [[RYShiPinViewController alloc] init];
    shiPinViewController.title = @"视频";
    [self addChildViewController:shiPinViewController];
    
    RYShangHaiViewController *shangHaiViewController = [[RYShangHaiViewController alloc] init];
    shangHaiViewController.title = @"上海";
    [self addChildViewController:shangHaiViewController];
    
    RYCaiJingViewController *caiJingViewController = [[RYCaiJingViewController alloc] init];
    caiJingViewController.title = @"财经";
    [self addChildViewController:caiJingViewController];
    
    RYYuLeViewController *yuLeViewController = [[RYYuLeViewController alloc] init];
    yuLeViewController.title = @"娱乐";
    [self addChildViewController:yuLeViewController];
    
    RYTiYuViewController *tiYuViewController = [[RYTiYuViewController alloc] init];
    tiYuViewController.title = @"体育";
    [self addChildViewController:tiYuViewController];
    
    RYGuoJiViewController *guoJiViewController = [[RYGuoJiViewController alloc] init];
    guoJiViewController.title = @"国际";
    [self addChildViewController:guoJiViewController];
}

/**
 *  设置标题按钮
 */
- (void)setupNewsTitleItems {
    // 1.初始化坐标值
    CGFloat itemLabelX = 0;
    CGFloat itemLabelY = 0;
    CGFloat itemLabelW = 100;
    CGFloat itemLabelH = self.titleScrollView.frame.size.height;
    
    // 2.创建并设置标题标签
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        // 2.1.创建标题标签
        RYTitleLabel *itemLabel = [[RYTitleLabel alloc] init];
        
        // 2.2.设置标题标签的相关属性
        itemLabel.tag = i;
        itemLabel.text = [self.childViewControllers[i] title];
        // 设置默认选择的标题
        if (0 == i) itemLabel.scale = 1.0;
        
        // 2.3.添加标题标签的点击手势
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)];
        
        [itemLabel addGestureRecognizer:tapGestureRecognizer];
        
        // 2.4.计算并且设置标题标签的位置大小
        itemLabelX = itemLabelW * i;
        itemLabel.frame = CGRectMake(itemLabelX, itemLabelY, itemLabelW, itemLabelH);
        
        // 2.5.添加标题标签到滚动视图上
        [self.titleScrollView addSubview:itemLabel];
    }
    
    // 3.设置内容滚动视图的代理
    self.contentScrollView.delegate = self;
    
    // 4.设置标题滚动视图和内容滚动视图的内容尺寸
    self.titleScrollView.contentSize = CGSizeMake(itemLabelW * 7, self.titleScrollView.bounds.size.height);
    self.contentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 7, self.contentScrollView.bounds.size.height);
}

#pragma mark - 触摸事件处理
/**
 *  点击手势事件处理
 */
- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)panGestureRecognizer {
    // 1.当前点击的title索引
    NSInteger index = panGestureRecognizer.view.tag;
    
    // 2.获取当前内容滚动试图的偏移量
    CGPoint contentOffset = self.contentScrollView.contentOffset;
    
    // 3.计算新的x的偏移量
    contentOffset.x = self.contentScrollView.bounds.size.width * index;
    
    // 4.重新设置内容滚动视图的偏移量
    [self.contentScrollView setContentOffset:contentOffset animated:YES];
}

#pragma mark - 私有辅助方法
/**
 *  随机一个颜色
 */
- (UIColor *)randomColor {
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    
    UIColor *randomColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    
    return randomColor;
}

#pragma mark - 代理方法实现
/**
 *  滚动中
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 1.获取偏移比例
    CGFloat contentOffsetScale = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // 2.获取需要操作的左边标题标签
    // 2.1.获取左边的标题标签的索引
    NSInteger leftLabelIndex = contentOffsetScale;
    // 2.2.获取左边的标题标签
    RYTitleLabel *leftLabel = self.titleScrollView.subviews[leftLabelIndex];
    
    // 3.获取需要操作的右边标题标签
    // 3.1.获取右边的标题标签的索引
    NSInteger rightLabelIndex = leftLabelIndex + 1;
    // 3.2.获取右边的标题标签
    RYTitleLabel *rightLabel = rightLabelIndex == self.titleScrollView.subviews.count ? nil : self.titleScrollView.subviews[rightLabelIndex];
    
    // 4.计算左边的标题标签的偏移比例
    CGFloat rightContentOffsetScale = contentOffsetScale - leftLabelIndex;
    // 5.计算右边的标题标签的偏移比例
    CGFloat leftContentOffsetScale = 1 - rightContentOffsetScale;
    
    // 6.设置左右标签的偏移比例值
    leftLabel.scale = leftContentOffsetScale;
    rightLabel.scale = rightContentOffsetScale;
}

/**
 *  滚动结束
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/**
 *  停止滚动动画时掉用
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 1.计算内容滚动视图的位置大小变量
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat contentScrollViewW = scrollView.bounds.size.width;
    CGFloat contentScrollViewH = scrollView.bounds.size.height;
    
    // 2.获取当前滚动的页数
    NSInteger index = contentOffsetX / contentScrollViewW;
    
    // 3.获取当前页的标题标签
    RYTitleLabel *titleLabel = self.titleScrollView.subviews[index];
    
    // 3.1.获取当前页的标题标签的偏移量
    CGPoint titleLabelContentOffset = self.titleScrollView.contentOffset;
    // 3.2.计算当前页的标题标签处在中点时X的偏移量
    titleLabelContentOffset.x = titleLabel.center.x - contentScrollViewW * 0.5;
    
    // 3.3.设置左边的边界值
    if (titleLabelContentOffset.x < 0) titleLabelContentOffset.x = 0;
    
    // 3.4.设置右边的边界值
    // 3.5.计算最大X的偏移量
    CGFloat maxContentOffsetX = self.titleScrollView.contentSize.width - contentScrollViewW;
    if (titleLabelContentOffset.x > maxContentOffsetX) titleLabelContentOffset.x = maxContentOffsetX;
    
    // 3.6.设置标题滚动视图的偏移量
    [self.titleScrollView setContentOffset:titleLabelContentOffset animated:YES];
    
    // 4.取出当前页的控制器
    UIViewController *currentViewController = self.childViewControllers[index];
    
    // 5.如果当前页的控制器已经添加到当前控制器上了，直接返回
    if ([currentViewController isViewLoaded]) return;
    
    // 6.设置当前控制器视图的Frame
    currentViewController.view.frame = CGRectMake(contentOffsetX, 0, contentScrollViewW, contentScrollViewH);
    
    // 7.讲当前控制器视图添加到本视图上
    [scrollView addSubview:currentViewController.view];
}

@end
