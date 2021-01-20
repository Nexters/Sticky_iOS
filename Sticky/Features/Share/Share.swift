//
//  Share.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/19.
//

import SwiftUI

struct Share: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    init() {
        let newNavAppearance = UINavigationBarAppearance()
        newNavAppearance.configureWithTransparentBackground()
        newNavAppearance.backgroundColor = .clear
        UINavigationBar.appearance()
            .standardAppearance = newNavAppearance
    }

    var body: some View {
        ZStack {
            Color.purple

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
                }.padding(.bottom, 36)

                CardSlide()

                Text("나의 현재기록을 공유합니다")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.top, 20)

                HStack {
                    Rectangle()
                        .overlay(
                            Button(action: {
                                // 로컬 공유하기
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
                        // 인스타 스토리 공유
                    }) {
                        Image("instagram")
                            .frame(width: 48, height: 48)
                            .foregroundColor(.white)
                    }
                    .frame(width: 48, height: 48)
                    .cornerRadius(10)
                }
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
            // 다운로드
        }) {
            Image(systemName: "download")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
        }
    }
}

struct Share_Previews: PreviewProvider {
    static var previews: some View {
        Share()
            .environmentObject(UIStateModel())
    }
}
