//
//  Share.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/19.
//

import SwiftUI

struct Share: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var UIState: UIStateModel

    init() {
        let newNavAppearance = UINavigationBarAppearance()
        newNavAppearance.configureWithTransparentBackground()
        newNavAppearance.backgroundColor = .clear
        UINavigationBar.appearance()
            .standardAppearance = newNavAppearance
    }

    var body: some View {
        ZStack {
            Color.blue

            VStack {
                HStack(spacing: 16) {
                    Button("현재 기록") {
                        print("현재 기록")
                    }.font(.title3)

                    Button("누적 기록") {
                        print("누적 기록")
                    }.font(.title3)

                    Button("최근 기록") {
                        print("최근 기록")
                    }.font(.title3)
                }
                .padding(.bottom, 36)
                .foregroundColor(Color.white)

                CardSlide()

                Text("나의 현재기록을 공유합니다")
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
        .edgesIgnoringSafeArea(.vertical)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton, trailing: downloadButton)
    }

    var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image("left-arrow")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
        }
    }

    var downloadButton: some View {
        Button(action: {
            saveInPhoto(img: takeCapture())
        }) {
            Image(systemName: "download")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
        }
    }
}

extension Share {
    func shareInstagram() {
        let img = takeCapture()
        if let urlScheme = URL(string: "instagram-stories://share") {
            if UIApplication.shared.canOpenURL(urlScheme) {
                let pasteboardItems = [["com.instagram.sharedSticker.stickerImage": img.pngData(),"com.instagram.sharedSticker.backgroundImage": img.pngData()]]

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

struct Share_Previews: PreviewProvider {
    static var previews: some View {
        Share()
            .environmentObject(UIStateModel())
    }
}
