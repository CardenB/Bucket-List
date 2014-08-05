//
//  BLMainViewContainer.m
//  Bucket List
//
//  Created by Carden Bagwell on 8/3/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "BLMainViewContainer.h"
#import "BLListManager.h"
#import "BLProfileView.h"
#import "BLChildViewController.h"
#import "BLDesignFactory.h"
#import "BLSubclassConfigViewController.h"

@interface BLMainViewContainer ()

@property UIScrollView *scrollView;
@property NSInteger pageNum;
@property NSArray *viewControllers;
@property CGFloat initialX;
@property CGFloat finalX;

@property BOOL preventUpwardScrolling;
@property BOOL preventLeftScrolling;
@property BOOL preventRightScrolling;
@property BOOL preventDownwardScrolling;


@end
@implementation BLMainViewContainer

static NSInteger kNumPages = 2;


- (id)init
{
    

    self = [super init];

    if (self) {
        self.pageNum = 0;
        _preventDownwardScrolling = NO;
        _preventUpwardScrolling = NO;
        _preventRightScrolling = NO;
        _preventLeftScrolling = NO;
    }
    return self;

    
}

- (id)initWithPresenterDelegate:(id<BLPresenterDelegate>)delegate
{
    self = [self init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [self createScrollView];
    [self.view setBackgroundColor:[BLDesignFactory mainBackgroundColor]];

}

- (void)createScrollView
{
    CGFloat totalWidth = 2*self.view.frame.size.width;
    CGFloat maxHeight = self.view.frame.size.height;
    //status bar size space added to top of scroll view for some reason, origin.y has to be -20
    CGRect frame = CGRectMake(0, -20, self.view.frame.size.width, maxHeight);
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.contentSize = CGSizeMake(totalWidth, maxHeight);
    self.scrollView.delegate = self;
    //set frame to start page

    
    
    BLListManager *listManager = [[BLListManager alloc] initWithStyle:UITableViewStylePlain delegate:self];
    [self addChildViewController:listManager];
    [listManager didMoveToParentViewController:self];
    [self.scrollView addSubview:listManager.view];
     
    
    BLProfileView *profileView = [[BLProfileView alloc] initWithNavigationDelegate:self];
    [self addChildViewController:profileView];
    [profileView didMoveToParentViewController:self];
    [self.scrollView addSubview:profileView.view];
    [self.scrollView setAutoresizesSubviews:NO];
    [self.view setAutoresizesSubviews:NO];
    
    
    
    [self scrollFrameToPage:1];
    CGRect viewFrame = ((UIViewController *)profileView).view.frame;
    viewFrame.origin.x = viewFrame.size.width;
    listManager.view.frame = viewFrame;
    [self.view addSubview:self.scrollView];
    [self.scrollView setBackgroundColor:[BLDesignFactory mainBackgroundColor]];
}

#pragma mark - Paging

- (void)scrollFrameToPage:(NSInteger)pageNumber
{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width*pageNumber;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
}
- (void)navigateLeft
{
    [self scrollFrameToPage:self.pageNum-1];
}
- (void)navigateRight
{
    [self scrollFrameToPage:self.pageNum+1];
}

- (void)updateNavigationBar
{
    unsigned long index = self.childViewControllers.count - self.pageNum - 1;
    [(id<BLChildViewController>)self.childViewControllers[index] updateNavigationBar];
    
}

- (void)updatePage
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    if (self.pageNum != page && page < kNumPages) {
        // Page has changed, do your thing!
        // ...
        // Finally, update previous page
        self.pageNum = page;
        [self updateNavigationBar];
    }
}

- (void)killScroll:(UIScrollView *)scrollView
{
    CGPoint offset = self.scrollView.contentOffset;
    offset.x -= 1.0;
    offset.y -= 1.0;
    [scrollView setContentOffset:offset animated:NO];
    offset.x += 1.0;
    offset.y += 1.0;
    [scrollView setContentOffset:offset animated:NO];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    

    
    if (scrollView.contentOffset.x >= 0
        && scrollView.contentOffset.x <= (kNumPages - 1)*scrollView.frame.size.width + 5) {
        [self updatePage];
    } else {
        if (scrollView.contentOffset.x <= 5) {
            offset.x = 0;
            [scrollView setContentOffset:offset animated:NO];
        } else if( scrollView.contentOffset.x >= (kNumPages - 1)*scrollView.frame.size.width - 5) {
            offset.x = (kNumPages - 1)*scrollView.frame.size.width;
            [scrollView setContentOffset:offset animated:NO];
        }
    }

    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //prevent upward scrolling on profile view
    if (scrollView.contentOffset.x >= 0
        && scrollView.contentOffset.x <= scrollView.frame.size.width) {
        _preventUpwardScrolling = YES;
    }
    if (scrollView.contentOffset.x <= 5) {
        _preventLeftScrolling = YES;
    } else if( scrollView.contentOffset.x >= (kNumPages - 1)*scrollView.frame.size.width - 5) {
        _preventRightScrolling = YES;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updatePage];
    _preventUpwardScrolling = NO;
    _preventDownwardScrolling = NO;
    _preventLeftScrolling = NO;
    _preventRightScrolling = NO;

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _preventUpwardScrolling = NO;
    _preventDownwardScrolling = NO;
    _preventLeftScrolling = NO;
    _preventRightScrolling = NO;
}

- (void)presentLogInViewFromPresentingViewController
{
    UIViewController *initialController = [[BLSubclassConfigViewController alloc]
                                           initWithDelegate:self.delegate];
    [self.delegate presentAsMainViewController:initialController];
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
