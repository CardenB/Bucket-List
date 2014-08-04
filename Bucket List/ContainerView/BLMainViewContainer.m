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

@interface BLMainViewContainer ()

@property UIScrollView *scrollView;
@property NSInteger pageNum;
@property NSArray *viewControllers;
@property CGFloat initialX;
@property CGFloat finalX;

@end
@implementation BLMainViewContainer


- (id)init
{
    

    self = [super init];

    if (self) {
        self.pageNum = 0;
    }
    return self;

    
}

- (void)viewDidLoad
{
    [self createScrollView];

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
    if (self.pageNum != page) {
        // Page has changed, do your thing!
        // ...
        // Finally, update previous page
        self.pageNum = page;
        [self updateNavigationBar];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updatePage];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updatePage];
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
