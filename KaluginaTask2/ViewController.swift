//
//  ViewController.swift
//  KaluginaTask2
//
//  Created by  MAC on 8/27/20.
//

import UIKit
import Appodeal
class ViewController: UIViewController {
    
    @IBOutlet weak var interstitialPlacementField: UITextField!
    @IBOutlet weak var bannerPlacementField: UITextField!
    @IBOutlet weak var rewardedVPlacementField: UITextField!
    var count = 0
    
    // MARK: Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Appodeal.setInterstitialDelegate(self)
        Appodeal.setBannerDelegate(self)
        Appodeal.setRewardedVideoDelegate(self)
    }
    
    // MARK: Actions
    @IBAction func showButtonPressed(_ sender: UIButton) {
        Appodeal.hideBanner()
        guard
            let placement = interstitialPlacementField.text,
            Appodeal.isInitalized(for: .interstitial),
            Appodeal.canShow(.interstitial, forPlacement: placement)
            else {
                return
        }
        Appodeal.showAd(.interstitial,
                        forPlacement: placement,
                        rootViewController: self)
    }
    
    @IBAction func bannerTopButtonPressed(_ sender: UIButton) {
        if count < 5 {
        guard
            let placement = bannerPlacementField.text,
            Appodeal.isInitalized(for: . banner),
            Appodeal.canShow(.banner, forPlacement: placement)
            else {
                return
        }
        Appodeal.showAd(.bannerTop,
                        forPlacement: placement,
                        rootViewController: self)
            count += 1
        }
        else {
            Appodeal.hideBanner()
            sender.isEnabled = false
            sender.backgroundColor = .gray
        }
    }

    @IBAction func showRewardedVButtonPressed(_ sender: UIButton) {
        guard
            let placement = rewardedVPlacementField.text,
            Appodeal.isInitalized(for: .rewardedVideo),
            Appodeal.canShow(.rewardedVideo, forPlacement: placement)
        else {
            return
        }
        Appodeal.showAd(.rewardedVideo,
                        forPlacement: placement,
                        rootViewController: self)
    }
}

extension ViewController: AppodealInterstitialDelegate {
    func interstitialDidLoadAdIsPrecache(_ precache: Bool) {}
    func interstitialDidFailToLoadAd() {}
    func interstitialDidFailToPresent() {}
    func interstitialWillPresent() {}
    func interstitialDidDismiss() {}
    func interstitialDidClick() {}

}

extension ViewController: AppodealBannerDelegate {
    func bannerDidLoadAdIsPrecache(_ precache: Bool) {}
    func bannerDidFailToLoadAd() {}
    func bannerDidClick() {}
    func bannerDidShow() {}
}

extension ViewController: AppodealRewardedVideoDelegate {
    func rewardedVideoDidLoadAdIsPrecache(_ precache: Bool) {}
    func rewardedVideoDidFailToLoadAd() {}
    func rewardedVideoDidFailToPresentWithError(_ error: Error) {}
    func rewardedVideoDidPresent() {}
    func rewardedVideoWillDismissAndWasFullyWatched(_ wasFullyWatched: Bool) {}
    func rewardedVideoDidFinish(_ rewardAmount: float_t, name rewardName: String?) {}
}


