//
//  UINavigationItem+iOS7Spacing.m
//
//  Created by Marius Kažemėkaitis on 2013-10-11.
//  Copyright (c) 2013 Lemon Labs. All rights reserved.
//

#import "UINavigationItem+iOS7Spacing.h"
#import <objc/runtime.h>

@implementation UINavigationItem (iOS7Spacing)

- (BOOL)isIOS7
{
    return ([[[UIDevice currentDevice] systemVersion] compare:@"7" options:NSNumericSearch] != NSOrderedAscending);
}

- (UIBarButtonItem *)spacer
{
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -11;
    return space;
}

- (void)mk_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
{
    if ([self isIOS7] && leftBarButtonItem) {
        [self mk_setLeftBarButtonItem:nil];
        [self mk_setLeftBarButtonItems:@[[self spacer], leftBarButtonItem]];
    } else {
        if ([self isIOS7]) {
            [self mk_setLeftBarButtonItems:nil];
        }
        [self mk_setLeftBarButtonItem:leftBarButtonItem];
    }
}

- (void)mk_setLeftBarButtonItems:(NSArray *)leftBarButtonItems
{
    if ([self isIOS7] && leftBarButtonItems && leftBarButtonItems.count > 0) {
        
        NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:leftBarButtonItems.count + 1];
        [items addObject:[self spacer]];
        [items addObjectsFromArray:leftBarButtonItems];
        
        [self mk_setLeftBarButtonItems:items];
    } else {
        [self mk_setLeftBarButtonItems:leftBarButtonItems];
    }
}

- (void)mk_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
{
    if ([self isIOS7] && rightBarButtonItem) {
        [self mk_setRightBarButtonItem:nil];
        [self mk_setRightBarButtonItems:@[[self spacer], rightBarButtonItem]];
    } else {
        if ([self isIOS7]) {
            [self mk_setRightBarButtonItems:nil];
        }
        [self mk_setRightBarButtonItem:rightBarButtonItem];
    }
}

- (void)mk_setRightBarButtonItems:(NSArray *)rightBarButtonItems
{
    if ([self isIOS7] && rightBarButtonItems && rightBarButtonItems.count > 0) {
        
        NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:rightBarButtonItems.count + 1];
        [items addObject:[self spacer]];
        [items addObjectsFromArray:rightBarButtonItems];
        
        [self mk_setRightBarButtonItems:items];
    } else {
        [self mk_setRightBarButtonItems:rightBarButtonItems];
    }
}

+ (void)mk_swizzle:(SEL)aSelector
{
    SEL bSelector = NSSelectorFromString([NSString stringWithFormat:@"mk_%@", NSStringFromSelector(aSelector)]);
    
    Method m1 = class_getInstanceMethod(self, aSelector);
    Method m2 = class_getInstanceMethod(self, bSelector);
    
    method_exchangeImplementations(m1, m2);
}

+ (void)load
{
    [self mk_swizzle:@selector(setLeftBarButtonItem:)];
    [self mk_swizzle:@selector(setLeftBarButtonItems:)];
    [self mk_swizzle:@selector(setRightBarButtonItem:)];
    [self mk_swizzle:@selector(setRightBarButtonItems:)];
}

@end