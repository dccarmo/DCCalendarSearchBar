//
//  DCTransitionAnimator.m
//  CalendarSearchBar
//
//  Created by Diogo do Carmo on 29/03/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import "DCCalendarSearchBarTransitionAnimator.h"

@implementation DCCalendarSearchBarTransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.4f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSInteger statusBarPlusNavigationBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + 44; //The navigation bar height might change in the future
    CGRect endFrame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height); //This animation is only meant to be used in portrait mode
    CGRect startFrame;
    
    if ([self isPresenting]) {
        fromViewController.view.userInteractionEnabled = NO;
        
        [transitionContext.containerView addSubview:fromViewController.view];
        [transitionContext.containerView addSubview:toViewController.view];
        
        startFrame = endFrame;
        startFrame.origin.y += -statusBarPlusNavigationBarHeight;
        
        toViewController.view.frame = startFrame;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toViewController.view.frame = endFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
    else {
        toViewController.view.userInteractionEnabled = YES;
        
        [transitionContext.containerView addSubview:toViewController.view];
        [transitionContext.containerView addSubview:fromViewController.view];
        
        endFrame.origin.y += -statusBarPlusNavigationBarHeight;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.frame = endFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

- (BOOL)isPresenting
{
    return _presenting;
}

@end
