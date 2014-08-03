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
    self.pageNum = 1;
    if (self) {
        
        CGFloat totalWidth = 2*self.view.frame.size.width;
        CGFloat maxHeight = self.view.frame.size.height;

        
        BLListManager *listManager = [[BLListManager alloc] initWithStyle:UITableViewStylePlain delegate:self];
        [self addChildViewController:listManager];
        [listManager didMoveToParentViewController:self];
        [self.scrollView addSubview:listManager.view];
        
        BLProfileView *profileView = [[BLProfileView alloc] init];
        [self addChildViewController:profileView];
        [profileView didMoveToParentViewController:self];
        [self.scrollView addSubview:profileView.view];

        

        
        CGRect viewFrame = ((UIViewController *)profileView).view.frame;
        viewFrame.origin.x = viewFrame.size.width;
        listManager.view.frame = viewFrame;
        
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height );
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.scrollEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.scrollsToTop = NO;
        self.scrollView.contentSize = CGSizeMake(totalWidth, maxHeight);
        self.scrollView.delegate = self;
        //set frame to start page
        [self scrollFrame];

        
        
    }
    return self;

    
}

- (id)initWithViewControllers:(NSArray *)viewControllers startPage:(NSInteger)pageNumber
{
    
    self = [super init];
    self.viewControllers = viewControllers;
    self.pageNum = pageNumber;
    if (self) {

        CGFloat totalWidth = 0;
        CGFloat maxHeight = 0;

        //add vcs in opposite order because it's a stack
        for( int i = (int) ([viewControllers count] - 1); i >= 0; i-- )
        {
            UIViewController *vc = self.viewControllers[i];

            totalWidth += CGRectGetWidth(vc.view.frame);
            CGFloat vcHeight = CGRectGetHeight(vc.view.frame);
            if (maxHeight < vcHeight ) {
                maxHeight = vcHeight;
            }
            
            //add each view to the container hierarchy
            [self addChildViewController:vc];

            [vc didMoveToParentViewController:self];
            if( i != [viewControllers count] - 1 )
            {
                CGRect viewFrame = ((UIViewController *)viewControllers[i+1]).view.frame;
                viewFrame.origin.x = viewFrame.size.width;
                vc.view.frame = viewFrame;
            }
            [self.scrollView addSubview:vc.view];
        }
        
        //CGRect frame = CGRectMake(0, 0, totalWidth, maxHeight);
        /*
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.scrollEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.scrollsToTop = NO;
        //self.scrollView.contentSize = CGSizeMake(totalWidth, maxHeight);
        self.scrollView.delegate = self;
        //set frame to start page
        //[self scrollFrame];
*/
        
        
    }
    return self;
}
         

- (void)scrollFrame
{
    CGRect frame = self.view.frame;
    frame.origin.x = frame.size.width*self.pageNum;
    frame.origin.y = 0;
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
    CGFloat totalWidth = 3*self.view.frame.size.width;
    CGFloat maxHeight = self.view.frame.size.height;
    
    /*
    //add vcs in opposite order because it's a stack
    for( int i = (int) (2); i >= 0; i-- )
    {
        
        //add each view to the container hierarchy
        [self addChildViewController:vc];
        [self.scrollView addSubview:vc.view];
        [vc didMoveToParentViewController:self];
        if( i != 2 )
        {
            CGRect viewFrame = self.view.frame;
            viewFrame.origin.x = viewFrame.size.width;
            vc.view.frame = viewFrame;
        }
    }
     */
    //CGRect frame = CGRectMake(0, 0, totalWidth, maxHeight);
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.contentSize = CGSizeMake(totalWidth, maxHeight);
    self.scrollView.delegate = self;
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
