//
//  ContentView.swift
//  AdMob-Reward-Demo
//
//  Created by TAISHIN MIYAMOTO on 2022/05/07.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var reward = Reward()
    var body: some View {
        Button(action: {
            reward.ShowReward()
        }) {
            Text(reward.rewardLoaded ? "リワード広告表示" : "読み込み中...")
        }
        .onAppear() {
            reward.LoadReward()
        }
        .disabled(!reward.rewardLoaded)
    }
}
