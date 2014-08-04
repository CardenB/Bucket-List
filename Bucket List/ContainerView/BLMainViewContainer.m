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

@interface BLMainViewContainer ()

@property UIScrollView *scrollView;
@property NSInteger pageNum;
@property NSArray *viewControllers;

@end
@implementation BLMainViewContainer


- (id)init
{
    

    self = [super init];

    if (self) {
        self.pageNum = 1;
    }
    return self;

    
}
         

- (void)scrollFrame
{
    CGRect frame = self.view.frame;
    frame.origin.x = frame.size.width*self.pageNum;
    frame.origin.y = -20;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}
- (void)navigateLeft
{
    self.pageNum--;
    [self scrollFrame];
}
- (void)navigateRight
{
    self.pageNum++;
    [self scrollFrame];
}

- (void)viewDidLoad
{
    [self createScrollView];
}

- (void)createScrollView
{
    CGFloat totalWidth = 2*self.view.frame.size.width;
    CGFloat maxHeight = self.view.frame.size.height;
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, maxHeight);
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.contentSize = CGSizeMake(totalWidth, maxHeight);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView.delegate = self;
    //set frame to start page
    //[self scrollFrame];
    
    BLListManager *listManager = [[BLListManager alloc] initWithStyle:UITableViewStylePlain delegate:self];
    [self addChildViewController:listManager];
    [listManager didMoveToParentViewController:self];
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.contentOffset = CGPointZero;
    
    [self.scrollView addSubview:listManager.view];
    
    BLProfileView *profileView = [[BLProfileView alloc] init];
    [self addChildViewController:profileView];
    [profileView didMoveToParentViewController:self];
    [self.scrollView addSubview:profileView.view];
    
    
    
    
    CGRect viewFrame = ((UIViewController *)profileView).view.frame;
    viewFrame.origin.x = viewFrame.size.width;
    listManager.view.frame = viewFrame;
    [self.view addSubview:self.scrollView];
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
