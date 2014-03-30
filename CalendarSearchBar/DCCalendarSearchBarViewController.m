//
//  DCCalendarSearchBarViewController.m
//  CalendarSearchBar
//
//  Created by Diogo do Carmo on 29/03/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import "DCCalendarSearchBarViewController.h"

//Support
#import "DCCalendarSearchBarTransitionAnimator.h"

@interface DCCalendarSearchBarViewController () <UISearchBarDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic) UITableViewController *dataSourceViewController;
@property (nonatomic) UISearchDisplayController *searchController;

@end

@implementation DCCalendarSearchBarViewController

- (instancetype)initWithDataSourceViewController:(id)dataSourceViewController
{
    self = [super init];
    if (self) {
        self.dataSourceViewController = dataSourceViewController;
        
        [self setUpSearchController];
        
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (instancetype)init
{
    self = [self initWithDataSourceViewController:nil];
    if (self) {
        NSLog(@"You shouldn't be using this initializer, use \"initWithDataSourceViewController:\" instead.");
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.searchController setActive:YES animated:YES];
    [self.searchBar becomeFirstResponder];
}

- (void)setUpSearchController
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    self.searchBar.delegate = self;
    
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.searchResultsDataSource = (id<UITableViewDataSource>) self.dataSourceViewController;
    self.searchController.searchResultsDelegate = (id<UITableViewDelegate>) self.dataSourceViewController;
    self.searchController.delegate = (id<UISearchDisplayDelegate>) self.dataSourceViewController;;
    
    [self.view addSubview:self.searchBar];
}

- (void)dismissDataSourceViewController
{
    [self.searchController setActive:NO animated:YES];
    [self.searchBar resignFirstResponder];
    [self.dataSourceViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    DCCalendarSearchBarTransitionAnimator *animator = [DCCalendarSearchBarTransitionAnimator new];
    animator.presenting = YES;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    DCCalendarSearchBarTransitionAnimator *animator = [DCCalendarSearchBarTransitionAnimator new];
    animator.presenting = NO;
    return animator;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self dismissDataSourceViewController];
}

@end
