//
//  Summary.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import SwiftUI

// MARK: - Summary

struct Summary: View {
    /// 누적 시간
    var seconds: Int
    @Binding var selection: ShareType?
    @EnvironmentObject var user: User
    @EnvironmentObject var shareViewModel: ShareViewModel

    var body: some View {
        let tier = Tier(level: user.level)
        let remainNextLevel = tier.next() - user.accumulateSeconds
        return VStack(alignment: .trailing) {
            HStack(alignment: .top) {
                Spacer()
                VStack {
                    Button(action: {
                        selection = ShareType.card
                        shareViewModel.badge = Badge(
                            badgeType: BadgeType.level,
                            badgeValue: String(tier.level),
                            _name: "LV\(tier.level) \(tier.name())"
                        )
                        shareViewModel.seconds = seconds
                    }) {
                        Image("level\(tier.level)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height: 140)
                            .padding(.bottom, 16)
                    }
                    // 레벨 변환
                    HStack(spacing: 4) {
                        Text("Lv\(tier.level)")
                            .foregroundColor(Color(tier.color()))
                            .font(.system(size: 24))
                            .bold()
                        Text("\(tier.name())")
                            .font(.system(size: 24))
                            .bold()
                    }
                    .padding(.bottom, 4)

                    VStack(spacing: 4) {
                        // 현재 누적 시간
                        Text("\(seconds.ToDaysHoursMinutes())")
                            .kerning(-0.3)
                            .font(.system(size: 20))

                        // 다음 레벨 계산
                        if tier.level < 10 {
                            Text("다음 레벨까지 \(remainNextLevel.ToDaysHoursMinutes()) 남았습니다")
                                .kerning(-0.3)
                                .font(.system(size: 14))
                                .foregroundColor(Color.GrayScale._600)
                        }
                    }
                }
                Spacer()
            }.overlay(
                HStack {
                    Spacer()
                    VStack {
                        NavigationLink(
                            destination: TierInformation()
                        ) {
                            Text("등급정보")
                                .underline()
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                }
            )
        }
    }
}

// MARK: - Summary_Previews

struct Summary_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.GrayScale._100.ignoresSafeArea()
            Summary(seconds: 10, selection: .constant(ShareType.card))
                .environmentObject(ShareViewModel())
                .border(Color.black)
        }
    }
}
