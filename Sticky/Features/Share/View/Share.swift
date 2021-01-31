//
//  Share.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/19.
//

import SwiftUI

// MARK: - Share

struct Share: View {
    // MARK: Internal

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var UIState: UIStateModel

//    init() {
//        let newNavAppearance = UINavigationBarAppearance()
//        newNavAppearance.configureWithTransparentBackground()
//        newNavAppearance.backgroundColor = .clear
//        UINavigationBar.appearance()
//            .standardAppearance = newNavAppearance
//    }

    var body: some View {
        ZStack {
            // 배경 Color
            Color.blue
                .edgesIgnoringSafeArea(.vertical)

            VStack {
                HStack(spacing: 16) {
                    Button("현재 기록") {
                        print("현재 기록")
                    }
                    .font(.title3)
                    .foregroundColor(UIState.activeCard == 0 ? .white : .gray)

                    Button("누적 기록") {
                        print("누적 기록")
                    }
                    .font(.title3)
                    .foregroundColor(UIState.activeCard == 1 ? .white : .gray)

                    Button("최근 뱃지") {
                        print("최근 뱃지")
                    }
                    .font(.title3)
                    .foregroundColor(UIState.activeCard == 2 ? .white : .gray)
                }
                .padding(.bottom, 36)
                .foregroundColor(Color.white)

                // 카드 슬라이드 뷰
                CardSlide(items: $items)

                HStack {
                    Text("나의")
                    Text(getBottomString()).bold()
                    Text("공유합니다")
                }
                .font(.title3)
                .foregroundColor(.white)
                .padding(.top, 20)

                HStack {
                    Rectangle()
                        .overlay(
                            Button(action: {
                                shareLocal()
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(.white)
                            }
                        )
                        .frame(width: 48, height: 48)
                        .cornerRadius(10)
                        .foregroundColor(Color("lightPurple"))

                    Spacer()
                        .frame(maxWidth: 60)

                    Button(action: {
                        shareInstagram()
                    }) {
                        Image("instagram")
                            .frame(width: 48, height: 48)
                            .foregroundColor(.white)
                    }
                    .frame(width: 48, height: 48)
                    .cornerRadius(10)
                }
                .padding(.top, 37)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton, trailing: downloadButton)
    }

    // MARK: Private

    // 카드에 담길 모델들 데이터
    @State private var items = [
        Card(id: 0, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
        Card(id: 1, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
        Card(id: 2, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
    ]

    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image("left-arrow")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
        }
    }

    private var downloadButton: some View {
        Button(action: {
            saveInPhoto(img: takeCapture())
        }) {
            Image(systemName: "download")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
        }
    }

    private func getBottomString() -> String {
        switch UIState.activeCard {
        case 0:
            return "현재 기록을"
        case 1:
            return "누적 기록을"
        case 2:
            return "최근 뱃지를"
        default:
            return "알수없음"
        }
    }
}

extension Share {
    func shareInstagram() {
        let img = takeCapture()
        if let urlScheme = URL(string: "instagram-stories://share") {
            if UIApplication.shared.canOpenURL(urlScheme) {
                let pasteboardItems = [["com.instagram.sharedSticker.stickerImage": img.pngData(), "com.instagram.sharedSticker.backgroundImage": img.pngData()]]

                let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60 * 5)]

                UIPasteboard.general.setItems(pasteboardItems, options: pasteboardOptions)

                UIApplication.shared.open(urlScheme as URL, options: [:], completionHandler: nil)
            } else {
                print("인스타 앱이 깔려있지 않습니다.")
            }
        }
    }

    func shareLocal() {
        let av = UIActivityViewController(activityItems: [takeCapture()], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

// MARK: - Share_Previews

struct Share_Previews: PreviewProvider {
    static var previews: some View {
        Share()
            .environmentObject(UIStateModel())
    }
}
