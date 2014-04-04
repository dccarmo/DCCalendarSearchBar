//
//  DCCalendarSearchBarViewController.h
//  CalendarSearchBar
//
//  Created by Diogo do Carmo on 29/03/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCCalendarSearchBarViewController : UIViewController

//The UISearchBar is exposed here for appearance customization
@property (nonatomic) UISearchBar *searchBar;

//Call this initializer to set everything up
- (instancetype)initWithDataSourceViewController:(UIViewController)dataSourceViewController;

@end
