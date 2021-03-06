
import UIKit
import Appodeal
class ViewController: UIViewController {
    
    @IBOutlet weak var interstitialPlacementField: UITextField!
    @IBOutlet weak var bannerPlacementField: UITextField!
    @IBOutlet weak var rewardedVPlacementField: UITextField!
    var bannerCount = 0
    var rewardedVCount = 0
    
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
        sender.isUserInteractionEnabled = false
        sender.backgroundColor = .gray
        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0) {
            sender.isUserInteractionEnabled = true
            sender.backgroundColor = .systemBlue
        }
        
    }
    
    @IBAction func bannerTopButtonPressed(_ sender: UIButton) {
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
    }
    
    @IBAction func showRewardedVButtonPressed(_ sender: UIButton) {
        Appodeal.hideBanner()
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
        rewardedVCount += 1
        if rewardedVCount == 3 {
            sender.isUserInteractionEnabled = false
            sender.backgroundColor = .gray
        }
    }

    @IBAction func nativeButtonPressed(_ sender: Any) {
        Appodeal.hideBanner()
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
    func bannerDidShow() {
        bannerCount += 1
        if bannerCount == 5 {
            Appodeal.hideBanner()
        }
    }
}

extension ViewController: AppodealRewardedVideoDelegate {
    func rewardedVideoDidLoadAdIsPrecache(_ precache: Bool) {}
    func rewardedVideoDidFailToLoadAd() {}
    func rewardedVideoDidFailToPresentWithError(_ error: Error) {}
    func rewardedVideoDidPresent() {}
    func rewardedVideoWillDismissAndWasFullyWatched(_ wasFullyWatched: Bool) {}
    func rewardedVideoDidFinish(_ rewardAmount: float_t, name rewardName: String?) {}
}


