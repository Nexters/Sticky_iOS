//
//  Onboarding.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import SwiftUI

// MARK: - Onboarding

struct Onboarding: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var SlideGesture = CGSize.zero
    @State var SlideOne = false
    @State var SlideOnePrevious = false
    @State var SlideTwo = false
    @State var SlideTwoPrevious = false
    @State var isEndOnboarding = false
    @State var isEndAboutSticky = false
    var type: Int

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SearchAddress(), isActive: $isEndOnboarding) {
                    EmptyView()
                }
                HStack {
                    Spacer()
                    Button(action: {
                        isEndOnboarding = true
                    }, label: {
                        Text("건너뛰기")
                    }).padding(.trailing, 16)
                        .padding(.top, 16)
                        .font(.custom("AppleSDGothicNeo", size: 14))
                        .foregroundColor(Color.GrayScale._500)
                        .isHidden(type != 0)
                }
                Spacer()
                ZStack {
                    Onboarding3()
                        .offset(x: SlideGesture.width)
                        .offset(x: SlideTwo ? 0 : 500)
                        .animation(.spring())

                        .gesture(
                            DragGesture().onChanged { value in
                                self.SlideGesture = value.translation
                            }
                            .onEnded { _ in
                                if self.SlideGesture.width > 150 {
                                    self.SlideTwo = false
                                    self.SlideTwoPrevious = true
                                }
                                self.SlideGesture = .zero
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()
                            }
                        )

                    Onboarding2()
                        .offset(x: SlideGesture.width)
                        .offset(x: SlideOne ? 0 : 500)
                        .offset(x: SlideOnePrevious ? 500 : 0)
                        .offset(x: SlideTwo ? -500 : 0)
                        .animation(.spring())

                        .gesture(
                            DragGesture().onChanged { value in
                                self.SlideGesture = value.translation
                            }
                            .onEnded { _ in
                                if self.SlideGesture.width < -150 {
                                    self.SlideOne = true
                                    self.SlideTwo = true
                                }

                                if self.SlideGesture.width > 150 {
                                    self.SlideOnePrevious = true
                                    self.SlideOne = false
                                }
                                self.SlideGesture = .zero
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()
                            }
                        )

                    Onboarding1()
                        .offset(x: SlideGesture.width)
                        .offset(x: SlideOne ? -500 : 0)

                        .animation(.spring())

                        .gesture(
                            DragGesture().onChanged { value in
                                self.SlideGesture = value.translation
                            }
                            .onEnded { _ in
                                if self.SlideGesture.width < -150 {
                                    self.SlideOne = true
                                    self.SlideOnePrevious = false
                                }
                                self.SlideGesture = .zero
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()
                            }
                        )
                }
                Spacer()
                HStack {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(SlideOne ? Color.GrayScale._200 : Color.Palette.primary)
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(SlideOne && !SlideTwo ? Color.Palette.primary : Color.GrayScale._200)
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(SlideTwo ? Color.Palette.primary : Color.GrayScale._200)
                }
                .padding(.bottom, 28)
                ZStack {
                    Button(action: {
                        if type == 0 {
                            self.isEndOnboarding = true
                        } else {
                            NotificationCenter.default.post(name: .endAboutSticky, object: nil)
                        }
                    }, label: {
                        Text(type == 0 ? "시작하기" : "완료")
                            .font(.custom("AppleSDGothicNeo", size: 17))
                            .foregroundColor(Color.white)
                    })
                        .frame(width: 160, height: 60)
                        .background(Color.Palette.primary)
                        .cornerRadius(20)
                        .animation(.spring())
                        .offset(x: SlideTwo ? 0 : 500)
                        .shadow(color: Color("shadow"), radius: 24, x: 0, y: 4)

                    Button(action: {
                        if !SlideOne {
                            self.SlideOne = true
                            self.SlideOnePrevious = false
                        } else if !SlideTwo {
                            self.SlideOne = true
                            self.SlideTwo = true
                        }
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }, label: {
                        Text("다음")
                            .font(.custom("AppleSDGothicNeo", size: 17))
                            .foregroundColor(Color.Palette.primary)

                    })
                        .frame(width: 160, height: 60)
                        .background(Color.white)
                        .cornerRadius(20)
                        .animation(.spring())
                        .offset(x: SlideTwo ? -500 : 0)
                        .shadow(color: Color("shadow"), radius: 24, x: 0, y: 4)
                }
                .padding(.bottom, 32)
            }
            .navigationBarHidden(true)
            .onReceive(NotificationCenter.default.publisher(for: .endAboutSticky), perform: { _ in

                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

// MARK: - Onboarding_Previews

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding(type: 0)
    }
}
