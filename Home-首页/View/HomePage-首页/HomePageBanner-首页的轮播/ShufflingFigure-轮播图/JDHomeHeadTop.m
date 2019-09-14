//
//  JDHomeHeadTop.m
//  SmartEasyBuyCarDemo
//
//  Created by Moumou on 17/7/1.
//  Copyright © 2017年 陈洋的MBP. All rights reserved.
//

#import "JDHomeHeadTop.h"

#import "HeadLinesCollectionViewCell.h"


#pragma mark - 注册的cell
static NSString *kJDHeadLinesCollectionViewCell = @"HeadLinesCollectionViewCell";

#pragma mark - 可配置的数据

//轮播的时间
static const NSTimeInterval kJDAnimationDuration = 3.0;

@interface JDHomeHeadTop ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView * collectionView;

/**  定时器 */
@property (nonatomic, strong) NSTimer * timer;

/** 头部页数  */
@property(nonatomic, strong) UIPageControl *pageControl;

/**  轮播图 */
@property (nonatomic, strong) NSMutableArray * wheelArray;

/**  轮播图下面的点击滚动 */
@property (nonatomic, strong) UIScrollView *scrollView;

/**  分类的页码 */
@property(nonatomic, assign) BOOL cancelTimer;



@end

@implementation JDHomeHeadTop

- (id)initWithBaranerView:(CGRect )rect{
    
    self = [super initWithFrame:rect];
    
    if (self) {
        
        self.backgroundColor = UIColor.zt_backgroundView;

    }
    return self;
}

- (id)initWithNoTimerBaranerView:(CGRect)rect{
    self = [super initWithFrame:rect];
    
    if (self) {
        
        self.cancelTimer = YES;

    }
    return self;
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [flowLayout setMinimumLineSpacing:0];
        [flowLayout setMinimumInteritemSpacing:0];

         _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                                             collectionViewLayout:flowLayout];
        
        
        [self addSubview:_collectionView];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = UIColor.clearColor;
        
        NSIndexPath *currrentIndexPath = [[self.collectionView indexPathsForVisibleItems]lastObject];
        NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currrentIndexPath.item inSection:0.5];
        NSInteger nextSection = currentIndexPathReset.section;
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:1 inSection:nextSection];
        
        [_collectionView scrollToItemAtIndexPath:nextIndexPath
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:YES];

        
        [self registrationCollectionView];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.currentPage = 0;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.pageIndicatorTintColor = [UIColor clearColor];
        
        [_pageControl setValue:[UIImage imageNamed:@"HomePageIndicator"]
                    forKeyPath:@"_pageImage"];
        [_pageControl setValue:[UIImage imageNamed:@"HomePageIndicatorChoose"]
                    forKeyPath:@"_currentPageImage"];
        
        [self addSubview:_pageControl];
        
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.collectionView.mas_bottom);
            make.right.mas_equalTo(-10);
        }];
        
        _pageControl.transform = CGAffineTransformScale(CGAffineTransformIdentity, 6.0/9.0, 6.0/9.0);

        
    }
    return _pageControl;
}

- (NSMutableArray *)wheelArray{
    if (!_wheelArray) {
        _wheelArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _wheelArray;
}

- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        
        _scrollView = [UIScrollView new];
        
        _scrollView.backgroundColor = [UIColor redColor];
        
    }
    
    return _scrollView;
}


#pragma mark - 注册cell
- (void)registrationCollectionView{
    [_collectionView registerNib:[UINib nibWithNibName:@"HeadLinesCollectionViewCell"
                                                bundle:nil]
      forCellWithReuseIdentifier:kJDHeadLinesCollectionViewCell];
    
}

#pragma mark - collection代理
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
         return self.wheelArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HeadLinesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kJDHeadLinesCollectionViewCell
                                                                                  forIndexPath:indexPath];
    cell.imageString = self.wheelArray[indexPath.row];
    
    return cell;

   
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(HeadLinesCollectionViewClick:)]) {
        [self.delegate HeadLinesCollectionViewClick:[NSString stringWithFormat:@"%zu", indexPath.row]];
    }

}

////定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionViewCell *)collectionView
                  layout:(nonnull UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
   return CGSizeMake(self.frame.size.width, self.frame.size.height);
   
}

//上下左右的距离
- (UIEdgeInsets)collectionView:(UICollectionViewCell *)collectionView
                        layout:(nonnull UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - 设置当前的cell
- (void)nextImage {
    
    //设置当前 indePath
    NSIndexPath *currrentIndexPath = [[self.collectionView indexPathsForVisibleItems]lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currrentIndexPath.item
                                                             inSection:0.5];

    // 设置下一个滚动的item
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    
    if (nextItem !=self.wheelArray.count) {
        if (self.wheelArray.count) {
            NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
            
            [self.collectionView scrollToItemAtIndexPath:nextIndexPath
                                        atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                                animated:YES];
        }
    }
}

#pragma mark - 添加定时器
- (void)addTimer {
    
    if (!_timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:kJDAnimationDuration
                                                      target:self
                                                    selector:@selector(nextImage)
                                                    userInfo:nil
                                                     repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
}

#pragma mark 删除定时器
-(void) removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    
    if (self.collectionView.contentOffset.x == self.frame.size.width * (self.wheelArray.count - 1)) {
        
        _collectionView.contentOffset = CGPointMake(0, 0);
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1
                                                     inSection:0];
        
        [_collectionView scrollToItemAtIndexPath:indexPath
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:YES];

    }
    
}



//添加数据源
- (void)setDataArray:(NSArray *)dataArray{
    if (dataArray) {
        
        if (self.wheelArray.count) {
            
            [self.wheelArray removeAllObjects];
            
        }
        
        [self.wheelArray addObject:dataArray.lastObject];
        
        [self.wheelArray addObjectsFromArray:dataArray];
        
        [self.wheelArray addObject:dataArray.firstObject];
        
        [self.collectionView reloadData];
        
        self.pageControl.numberOfPages = self.wheelArray.count - 2;
        
        [self.collectionView reloadData];
        
        [self addTimer];

    }
    
}

- (void)setClassifficationDataArray:(NSArray *)classifficationDataArray{
    if (classifficationDataArray) {
        
        if (self.wheelArray.count) {
            
            [self.wheelArray removeAllObjects];
            
        }
        
        [self.collectionView reloadData];
        
        self.pageControl.numberOfPages = self.wheelArray.count - 2;
        
        [self addTimer];
    }
}


//手动切换 和 自动轮播 的切换
-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if (self.collectionView == scrollView) {
        [self removeTimer];
    }
    
}

#pragma mark 当用户停止的时候调用
-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
   
    if (self.collectionView == scrollView) {
        if (!self.cancelTimer) {
            [self addTimer];
        }
        
        
    }
    
}

#pragma mark 设置页码

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (self.collectionView == scrollView) {
        
        int page = (int) (scrollView.contentOffset.x/self.frame.size.width - 0.5);
        
        self.pageControl.currentPage =page;

    }

    if (self.collectionView.contentOffset.x == 0) {
        
        CGFloat x = _collectionView.contentSize.width - self.frame.size.width * 2;
        
        _collectionView.contentOffset = CGPointMake(x, 0);
        
    }else if (self.collectionView.contentOffset.x == _collectionView.contentSize.width - self.frame.size.width) {
        
        _collectionView.contentOffset = CGPointMake(self.frame.size.width, 0);
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        
        [_collectionView scrollToItemAtIndexPath:indexPath
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:YES];
        
    }
    
}


@end
