//
//  Reward.swift
//  AdMob-Reward-Demo
//
//  Created by TAISHIN MIYAMOTO on 2022/05/07.
//

import GoogleMobileAds

class Reward: NSObject, GADFullScreenContentDelegate, ObservableObject {
    @Published var rewardLoaded: Bool = false
    var rewardedAd: GADRewardedAd?

    override init() {
        super.init()
        LoadReward()
    }

    // リワード広告の読み込み
    func LoadReward() {
        GADRewardedAd.load(withAdUnitID: "ca-app-pub-3940256099942544/1712485313", request: GADRequest()) { (ad, error) in
            if let _ = error {
                print("😭: 読み込みに失敗しました")
                self.rewardLoaded = false
                return
            }
            print("😍: 読み込みに成功しました")
            self.rewardLoaded = true
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self
        }
    }

    // リワード広告の表示
    func ShowReward() {
        let root = UIApplication.shared.windows.first?.rootViewController
        if let ad = rewardedAd {
            ad.present(fromRootViewController: root!, userDidEarnRewardHandler: {
                print("😍: 報酬を獲得しました")
                self.rewardLoaded = false
                self.LoadReward()
            })
        } else {
            print("😭: 広告の準備ができていませんでした")
            self.rewardLoaded = false
            self.LoadReward()
        }
    }
}
