
//
//  CardSlide.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/19.
//

import SwiftUI

// MARK: - CardSlide

// CardSlide -> 카드 슬라이드 뷰 전체
// Card -> 카드에 들어갈 정보를 담는 구조체 타입
// UIStateModel -> 현재 카드id와 scroll 값을 통해 UI를 Published하는 EnvironmentOb
// Carousel -> 카드 Item들이 담길 Horizon 스크롤 가능한 뷰
// Item -> 카드의 정보가 입력되는 UI

struct CardSlide: View {
    // MARK: Internal

    @EnvironmentObject var UIState: UIStateModel
    @EnvironmentObject var challengeState: ChallengeState
    @EnvironmentObject var shareViewModel: ShareViewModel
    @EnvironmentObject var user: User
    @ObservedObject var badgeViewModel: BadgeViewModel

    @Binding var items: [Card]
    let randomBodyText_KR = ["와우! 끈기가 대단해요", "정말 대단해요!", "와 진짜 믿을수 없어"]
    let randomBodyText_EN = ["Exellent..!", "Is this real?", "Wow, I can't believe it.", "Unbelievable", "That's amazing", "I'm proud of you"]
    @State var randomNumber = Int.random(in: 0...5)
    let spacing: CGFloat = 16
    // 숨겨진 카드의 보여질 width
    let widthOfHiddenCards: CGFloat = 40 /// UIScreen.main.bounds.width - 10
    // 카드의 Height
    let cardHeight: CGFloat = 368 // UIScreen.main.bounds.height * 0.5
    let badgeList = ["monthly_10", "monthly_10", "monthly_10"]

    var body: some View {
        // 각 카드 사이의 너비

        return Carousel(
            numberOfItems: 2,
            spacing: spacing,
            widthOfHiddenCards: widthOfHiddenCards) {
                // items를 돌며 생성
                challengeCard
                badgeCard
        }
    }

    // MARK: Private

    private var badgeCard: some View {
        CardItem(
            id: 1,
            spacing: spacing,
            widthOfHiddenCards: widthOfHiddenCards,
            cardHeight: cardHeight,
            bgColor: bgColor) {
                GeometryReader { gr in
                    VStack(alignment: .center) {
                        Image("logo-gray")
                            .frame(width: 56, height: 16)
                            .padding(.top, 24)

                        // MARK: 뱃지 갯수에 따른 코멘트 변경

                        Text("벌써 절반 넘게 모았어요!")
                            .font(Font.system(size: 18))
                            .foregroundColor(.white)
                            .frame(width: 216, height: 48)

                        let badges = badgeViewModel.specials + badgeViewModel.monthly + badgeViewModel.continuous
                        Text("\(countActiveBadges(badges: badges))")
                            .frame(width: 200, height: 64, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
                            .font(.custom("Modak", size: 88))
                            .padding(.top, 8)
                            .foregroundColor(.white)

                        Text("받은 배지")
                            .foregroundColor(.gray)
                            .padding(.bottom, 10)

                        ScrollView(.horizontal) {
                            HStack(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/, spacing: 15) {
                                // MARK: 뱃지 공유 카드: 뱃지 최소 0개 최대 3개

                                if let latestSpecial = latestBadge(
                                    badges: badgeViewModel.specials)
                                {
                                    Image(latestSpecial.image)
                                        .scaleEffect(1.4)
                                }
                                if let latestMonthly = latestBadge(
                                    badges: badgeViewModel.monthly)
                                {
                                    Image(latestMonthly.image)
                                        .scaleEffect(1.4)
                                }
                                if let latestContinous = latestBadge(
                                    badges: badgeViewModel.continuous)
                                {
                                    Image(latestContinous.image)
                                        .scaleEffect(1.4)
                                }
                            }
                            .frame(width: gr.frame(in: .local).size.width, height: 130, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
                        }
                        .fixedSize()
                        .disabled(true)
                    }.frame(width: gr.frame(in: .global).size.width, height: gr.frame(in: .global).height, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
                        .background(Color.Card.badge_card)
                }
        }
        .shadow(color: Color.black.opacity(0.16), radius: 4, x: 0, y: 4)
        .foregroundColor(Color.white)
        .cornerRadius(40)
        .transition(AnyTransition.slide)
        .animation(.spring())
    }

    private var challengeCard: some View {
        let timeData = shareViewModel.seconds.toTimeData()
        return CardItem(
            // 카드 UI의 id
            id: 0,
            // 카드 사이의 너비
            spacing: spacing,
            // 가려진 카드의 너비
            widthOfHiddenCards: widthOfHiddenCards,
            // 카드의 높이
            cardHeight: cardHeight,
            bgColor: bgColor) {
                GeometryReader { gr in
                    ZStack {
                        Image("shareBg_level\(String(format: "%02d", level))")

                        VStack {
                            Image("logo-gray")
                                .frame(width: 56, height: 16)
                                .padding(.top, 24)
                            HStack(spacing: 24) {
                                // Day
                                VStack {
                                    Text(String(timeData.day))
                                        .font(.custom("Modak", size: 80))
                                        .frame(height: 64)
                                        .padding(.bottom, 1)

                                    Text("일")
                                        .font(.system(size: 17, weight: .heavy, design: .default))
                                        .frame(width: 96)
                                }
                                .isHidden(isDayTextHidden, remove: isDayTextHidden)
                                .foregroundColor(.white)

                                // Hour
                                VStack {
                                    Text(String(timeData.hour))
                                        .font(.custom("Modak", size: 80))
                                        .frame(height: 64)
                                        .padding(.bottom, 1)
                                    Text("시간")
                                        .font(.system(size: 17, weight: .heavy, design: .default))
                                        .frame(width: 96)
                                }
                                .isHidden(isHourTextHidden, remove: isHourTextHidden)
                                .foregroundColor(.white)

                                // 얘 높이가 Text랑 달라서 그룹지어서 처리해야함
                                // Minute
                                VStack {
                                    StrokeText(
                                        text: String(timeData.minute),
                                        size: 80,
                                        fontColor: .white)
                                        .frame(height: 64)
                                        .padding(.bottom, 1)

                                    Text("분")
                                        .foregroundColor(.white)
                                        .font(.system(size: 17, weight: .heavy, design: .default))
                                        .frame(width: 96)
                                }
                                .isHidden(!isDayTextHidden, remove: !isDayTextHidden)
                                .foregroundColor(.white)
                            }
                            .frame(width: 216)
                            .padding(.top, 24)
                            Text(getRandomText())
                                .padding(.top, 12)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }.frame(width: gr.frame(in: .global).size.width, height: gr.frame(in: .global).height, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
                        .background(bgColor)
                }
        }
        .foregroundColor(Color.white)
        .cornerRadius(40)
        .shadow(color: Color.black.opacity(0.16), radius: 4, x: 0, y: 4)
        .transition(AnyTransition.slide)
        .animation(.spring())
    }

    private var bgColor: LinearGradient {
        // MARK: 색 변경해야 함

        switch level {
        case 1:
            return Color.Sticky.blue
        case 2:
            return Color.Sticky.yellow
        case 3:
            return Color.Sticky.green
        case 4:
            return Color.Sticky.red
        default:
            print("CardSlide - Should implement level over '4'")
            return Color.Sticky.blue
        }
    }

    private var level: Int {
        switch Tier.of(hours: (user.accumulateSeconds + challengeState.timeData.toSeconds()) / 3600).level {
        case 1...3:
            return 1
        case 4...6:
            return 2
        case 7...9:
            return 3
        case 10:
            return 4
        default:
            print("CardSlide - Should implement level over '4'")
            return 5
        }
    }

    private var isDayTextHidden: Bool {
        return challengeState.timeData.day > 0 ? false : true
    }

    private var isHourTextHidden: Bool {
        return challengeState.timeData.hour > 0 ? false : true
    }

    private func getRandomText() -> String {
        if Locale.current.regionCode == "KR" {
            return randomBodyText_KR[randomNumber % 3]
        } else {
            return randomBodyText_EN[randomNumber]
        }
    }
}

// MARK: - UIStateModel

public class UIStateModel: ObservableObject {
    @Published var activeCard: Int = 0
    @Published var screenDrag: Float = 0.0
}

// MARK: - CardSlide_Previews

struct CardSlide_Previews: PreviewProvider {
    static var previews: some View {
        CardSlide(badgeViewModel: BadgeViewModel(), items: .constant(items))
            .environmentObject(UIStateModel())
            .environmentObject(ChallengeState())
            .environmentObject(User())
    }
}

// TestItems
let items = [
    Card(id: 0, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
    Card(id: 1, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
    Card(id: 2, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
]
