//
//  More.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import SwiftUI

// MARK: - More

struct More: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isPresented: Bool=false
    @State private var selection: String?
    @Binding var more: Bool

    var body: some View {
        ZStack {
            VStack {
                List {
                    Button(action: { self.isPresented=true }) {
                        LinkItem(text: "주소 변경")
                    }
                    Button(action: { self.selection="about" }) {
                        LinkItem(text: "스티키에 대해서")
                    }
                    Button(action: { self.selection="version" }) {
                        LinkItem(text: "버전 정보")
                    }
                    Button(action: { self.selection="license" }) {
                        LinkItem(text: "오픈소스 라이센스")
                    }
                }
                .foregroundColor(.black)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backButton)
                .navigationBarTitle("더보기", displayMode: .inline)
            }
            ModalView(
                isPresented: $isPresented,
                confirmHandler: { print("다지워~") },
                title: "주소 변경하기",
                description: "주소를 변경하면 지금까지 쌓은 모든 기록이 사라집니다.정말 주소를 변경하고 새로 시작 하시겠어요?",
                ok: "계정 초기화하기",
                okButtonColor: Color.Palette.negative,
                cancel: "취소하기"
            )
            .isHidden(!isPresented)
            .ignoresSafeArea(.all)
        }
        NavigationLink(
            destination: SearchAddress(),
            tag: "address",
            selection: $selection
        ) {
            EmptyView()
        }
        NavigationLink(
            destination: Text("Sticky"),
            tag: "about",
            selection: $selection
        ) {
            EmptyView()
        }
        NavigationLink(
            destination: Text("version"),
            tag: "version",
            selection: $selection
        ) {
            EmptyView()
        }
        NavigationLink(
            destination: Text("license"),
            tag: "license",
            selection: $selection
        ) {
            EmptyView()
        }
    }

    var backButton: some View {
        Button(action: focusRelease) {
            HStack {
                Image("back")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
            }
        }
    }

    func focusRelease() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - More_Previews

struct More_Previews: PreviewProvider {
    static var previews: some View {
        More(more: .constant(true))
    }
}
