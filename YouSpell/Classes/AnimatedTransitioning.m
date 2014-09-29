//
//  AnimatedTransitioning.m
//  YouSpell
//
//  Created by Giovanni Barreira Ferraro on 9/27/14.
//  Copyright (c) 2014 giovannibf. All rights reserved.
//

#import "AnimatedTransitioning.h"
#import "WinLose.h"
#import "DefinitionView.h"

@implementation AnimatedTransitioning

//===================================================================
// - UIViewControllerAnimatedTransitioning
//===================================================================

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *inView = [transitionContext containerView];
    DefinitionView *toVC = (DefinitionView *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    WinLose *fromVC = (WinLose *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [inView addSubview:toVC.view];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    [toVC.view setFrame:CGRectMake(0, screenRect.size.height, fromVC.view.frame.size.width, fromVC.view.frame.size.height)];
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                         
                         [toVC.view setFrame:CGRectMake(0, 0, fromVC.view.frame.size.width, fromVC.view.frame.size.height)];
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

@end
