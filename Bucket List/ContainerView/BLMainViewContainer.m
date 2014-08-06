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
#import "BLFriendsManager.h"
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

static NSInteger kNumPages = 3;


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
    CGFloat totalWidth = kNumPages*self.view.frame.size.width;
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

    
    //Set up the child view controllers
    //add in the order you want them to sit, from left to right, for indexing purposes (used in update navigation bar)
    
    BLProfileView *profileView = [[BLProfileView alloc] initWithNavigationDelegate:self];
    [self addChildViewController:profileView];
    [profileView didMoveToParentViewController:self];
    [self.scrollView addSubview:profileView.view];
    
    BLListManager *listManager = [[BLListManager alloc] initWithStyle:UITableViewStylePlain delegate:self];
    [self addChildViewController:listManager];
    [listManager didMoveToParentViewController:self];
    [self.scrollView addSubview:listManager.view];
    
    BLFriendsManager *friendsListView =  [[BLFriendsManager alloc] initWithNavigationDelegate:self];
    [self addChildViewController:friendsListView];
    [friendsListView didMoveToParentViewController:self];
    [self.scrollView addSubview:friendsListView.view];
    
    
    

    //set subview locations
    CGRect listManagerViewFrame = profileView.view.frame;
    listManagerViewFrame.origin.x = listManagerViewFrame.size.width;
    listManager.view.frame = listManagerViewFrame;
    
    CGRect friendsListViewFrame = listManager.view.frame;
    friendsListViewFrame.origin.x = friendsListViewFrame.size.width*2;
    friendsListView.view.frame = friendsListViewFrame;
    
    //scroll to display list manager
    [self scrollFrameToPage:1];
    
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

- (void)updateNavigationBar
{
    //unsigned long index = kNumPages - 1 - self.pageNum;
    [(id<BLChildViewController>)self.childViewControllers[self.pageNum] updateNavigationBar];
    
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

/*
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
*/

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

#pragma mark - Navigation Delegate

- (void)navigateLeft
{
    [self scrollFrameToPage:self.pageNum-1];
}

- (void)navigateRight
{
    [self scrollFrameToPage:self.pageNum+1];
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
