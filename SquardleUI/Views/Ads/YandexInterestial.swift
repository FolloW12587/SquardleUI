//
//  YandexInterestial.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 06.02.2023.
//

import YandexMobileAds
import SwiftUI

struct YandexInterstitial: UIViewControllerRepresentable {
    var dismissClosure: () -> ()
    
    init(_ closure: @escaping () -> Void) {
        self.dismissClosure = closure
    }
    
    func makeUIViewController(context: Context) -> InterstitialViewController {
        let controller = InterstitialViewController()
        controller.dismissClosure = dismissClosure
        return controller
    }
    
    func updateUIViewController(_ uiViewController: InterstitialViewController, context: Context) {
    }
}

class InterstitialViewController: UIViewController {
    var interstitialAd: YMAInterstitialAd!
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    var dismissClosure: (() -> ())!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        interstitialAd = YMAInterstitialAd(adUnitID: "R-M-2190063-1")
        interstitialAd.delegate = self;
        interstitialAd.load()
    }
}

extension InterstitialViewController: YMAInterstitialAdDelegate{
    func interstitialAdDidLoad(_ interstitialAd: YMAInterstitialAd) {
        interstitialAd.present(from: self)
        print("Ad loaded")
    }

    func interstitialAdDidFail(toLoad interstitialAd: YMAInterstitialAd, error: Error) {
        print("Loading failed. Error: \(error)")
        dismissClosure()
    }

    func interstitialAdDidClick(_ interstitialAd: YMAInterstitialAd) {
        print("Ad clicked")
    }

    func interstitialAd(_ interstitialAd: YMAInterstitialAd, didTrackImpressionWith impressionData: YMAImpressionData?) {
        print("Impression tracked")
    }

    func interstitialAdWillLeaveApplication(_ interstitialAd: YMAInterstitialAd) {
        print("Will leave application")
    }

    func interstitialAdDidFail(toPresent interstitialAd: YMAInterstitialAd, error: Error) {
        print("Failed to present interstitial. Error: \(error)")
        dismissClosure()
    }

    func interstitialAdWillAppear(_ interstitialAd: YMAInterstitialAd) {
        print("Interstitial ad will appear")
    }

    func interstitialAdDidAppear(_ interstitialAd: YMAInterstitialAd) {
        print("Interstitial ad did appear")
    }

    func interstitialAdWillDisappear(_ interstitialAd: YMAInterstitialAd) {
        print("Interstitial ad will disappear")
    }

    func interstitialAdDidDisappear(_ interstitialAd: YMAInterstitialAd) {
        print("Interstitial ad did disappear")
        dismissClosure()
    }

    func interstitialAd(_ interstitialAd: YMAInterstitialAd, willPresentScreen webBrowser: UIViewController?) {
        print("Interstitial ad will present screen")
    }
}
