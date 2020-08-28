//
//  OguryAdsDelegate.h
//  PresageSDK
//
//  Copyright © 2018 Ogury. All rights reserved.
//

#import "OGARewardItem.h"

typedef NS_ENUM(NSInteger, OguryAdsErrorType) {
    OguryAdsErrorLoadFailed                   = 0,
    OguryAdsErrorNoInternetConnection         = 1,
    OguryAdsErrorAdDisable                    = 2,
    OguryAdsErrorProfigNotSynced              = 3,
    OguryAdsErrorAdExpired                    = 4,
    OguryAdsErrorSdkInitNotCalled             = 5,
    OguryAdsErrorAnotherAdAlreadyDisplayed    = 6
};

@protocol OguryAdsOptinVideoDelegate;
@protocol OguryAdsOptinVideoDelegate
-(void)oguryAdsOptinVideoAdAvailable;
-(void)oguryAdsOptinVideoAdNotAvailable;
-(void)oguryAdsOptinVideoAdLoaded;
-(void)oguryAdsOptinVideoAdNotLoaded;
-(void)oguryAdsOptinVideoAdDisplayed;
-(void)oguryAdsOptinVideoAdClosed;
-(void)oguryAdsOptinVideoAdRewarded:(OGARewardItem *)item;
-(void)oguryAdsOptinVideoAdError:(OguryAdsErrorType)errorType;
@end

@protocol OguryAdsInterstitialDelegate;
@protocol OguryAdsInterstitialDelegate
-(void)oguryAdsInterstitialAdAvailable;
-(void)oguryAdsInterstitialAdNotAvailable;
-(void)oguryAdsInterstitialAdLoaded;
-(void)oguryAdsInterstitialAdNotLoaded;
-(void)oguryAdsInterstitialAdDisplayed;
-(void)oguryAdsInterstitialAdClosed;
-(void)oguryAdsInterstitialAdError:(OguryAdsErrorType)errorType;
@end

@protocol OguryAdsThumbnailAdDelegate;
@protocol OguryAdsThumbnailAdDelegate
-(void)oguryAdsThumbnailAdAdAvailable;
-(void)oguryAdsThumbnailAdAdNotAvailable;
-(void)oguryAdsThumbnailAdAdLoaded;
-(void)oguryAdsThumbnailAdAdNotLoaded;
-(void)oguryAdsThumbnailAdAdDisplayed;
-(void)oguryAdsThumbnailAdAdClosed;
-(void)oguryAdsThumbnailAdAdError:(OguryAdsErrorType)errorType;
@end


