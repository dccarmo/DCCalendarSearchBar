//
//  DCTransitionAnimator.h
//  CalendarSearchBar
//
//  Created by Diogo do Carmo on 29/03/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCCalendarSearchBarTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic,getter = isPresenting) BOOL presenting;

@end
