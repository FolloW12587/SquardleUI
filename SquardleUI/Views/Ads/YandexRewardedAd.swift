//
//  YandexRewardedAd.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 08.03.2023.
//

import YandexMobileAds
import SwiftUI

struct YandexRewardedAd: UIViewControllerRepresentable {
    var dismissClosure: () -> ()
    
    init(_ closure: @escaping () -> Void) {
        self.dismissClosure = closure
    }
    
    func makeUIViewController(context: Context) -> RewardedViewController {
        let controller = RewardedViewController()
        controller.dismissClosure = dismissClosure
        return controller
    }
    
    func updateUIViewController(_ uiViewController: RewardedViewController, context: Context) {
    }
}

class RewardedViewController: YandexBasicVC {
    var rewardedAd: YMARewardedAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rewardedAd = YMARewardedAd(adUnitID: "R-M-2190063-2")
        rewardedAd.delegate = self;
        rewardedAd.load()
    }
}

extension RewardedViewController: YMARewardedAdDelegate{
    func rewardedAd(_ rewardedAd: YMARewardedAd, didReward reward: YMAReward) {
        let message = "Rewarded ad did reward: \(reward.amount) \(reward.type)"
        print(message)
    }
    
    func rewardedAdDidLoad(_ rewardedAd: YMARewardedAd) {
        rewardedAd.present(from: self)
        print("Rewarded ad loaded")
    }
    
    func rewardedAdDidFail(toLoad rewardedAd: YMARewardedAd, error: Error) {
        print("Loading failed. Error:  \(error)")
        dismissClosure()
    }

    func rewardedAdDidClick(_ rewardedAd: YMARewardedAd) {
        print("Ad clicked")
    }

    func rewardedAd(_ rewardedAd: YMARewardedAd, didTrackImpressionWith impressionData: YMAImpressionData?) {
        print("Impression tracked")
    }
    
    func rewardedAdWillLeaveApplication(_ rewardedAd: YMARewardedAd) {
        print("Rewarded ad will leave application")
    }
    
    func rewardedAdDidFail(toPresent rewardedAd: YMARewardedAd, error: Error) {
        print("Failed to present rewarded ad. Error: \(error)")
        dismissClosure()
    }
    
    func rewardedAdWillAppear(_ rewardedAd: YMARewardedAd) {
        print("Rewarded ad will appear")
    }

    func rewardedAdDidAppear(_ rewardedAd: YMARewardedAd) {
        print("Rewarded ad did appear")
    }
    
    func rewardedAdWillDisappear(_ rewardedAd: YMARewardedAd) {
        print("Rewarded ad will disappear")
    }

    func rewardedAdDidDisappear(_ rewardedAd: YMARewardedAd) {
        print("Rewarded ad did disappear")
        dismissClosure()
    }
    
    func rewardedAd(_ rewardedAd: YMARewardedAd, willPresentScreen viewController: UIViewController?) {
        print("Rewarded ad will present screen")
    }
}

