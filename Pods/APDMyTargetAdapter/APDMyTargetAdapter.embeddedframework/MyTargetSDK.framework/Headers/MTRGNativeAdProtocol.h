//
//  MTRGNativeAdProtocol.h
//  myTargetSDK 5.6.0
//
//  Created by Andrey Seredkin on 10/02/2020.
//  Copyright © 2020 Mail.Ru Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTRGAdChoicesPlacement.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MTRGNativeAdProtocol <NSObject>

@property(nonatomic) MTRGAdChoicesPlacement adChoicesPlacement;

- (instancetype)initWithSlotId:(NSUInteger)slotId;

- (void)load;

- (void)loadFromBid:(NSString *)bidId;

- (void)registerView:(UIView *)containerView withController:(UIViewController *)controller;

- (void)registerView:(UIView *)containerView withController:(UIViewController *)controller withClickableViews:(nullable NSArray<UIView *> *)clickableViews;

- (void)unregisterView;

@end

NS_ASSUME_NONNULL_END
