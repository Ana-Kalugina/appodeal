//
//  OguryAdsThumbnailAd.h
//  OguryAds
//
//  Created by Mihai-Cristian SAVA on 8/8/19.
//  Copyright © 2019 Ogury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OguryAdsDelegate.h"
#import <CoreGraphics/CGGeometry.h>
#import "UIKit/UIKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface OguryAdsThumbnailAd : NSObject

@property (nonatomic, weak) id <OguryAdsThumbnailAdDelegate> thumbnailAdDelegate;
@property (nonatomic, assign) BOOL isLoaded;
@property (nonatomic, strong) NSString  * _Nullable adUnitID;
- (instancetype _Nullable)initWithAdUnitID:( NSString* _Nullable )adUnitID;

-(void)load:(CGSize)thumbnailSize;
-(void)show:(CGPoint)position;
-(void)showInScene:(UIWindowScene*)scene atPosition:(CGPoint)position API_AVAILABLE(ios(13.0));

-(void)setBlacklistViewControllers:(NSArray<NSString*>* _Nullable)viewControllers;
-(void)setWhitelistBundleIdentifiers:(NSArray<NSString*>* _Nullable)bundleIdentifiers;
@end

NS_ASSUME_NONNULL_END
