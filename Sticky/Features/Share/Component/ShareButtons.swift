//
//  ShareButtons.swift
//  Sticky
//
//  Created by deo on 2021/02/01.
//

import SwiftUI

// MARK: - ShareButtons

struct ShareButtons: View {
    @EnvironmentObject var UIState : UIStateModel
    var body: some View {
        VStack(spacing: 16){
            RoundedRectangle(cornerRadius: 12)
                .frame(width: UIScreen.main.bounds.width * 260/360, height: UIScreen.main.bounds.height * 44/640, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(Button(action: {
                    NotificationCenter.default.post(name: .shareInstagram, object: nil, userInfo: ["index": UIState.activeCard])
                }, label: {
                    HStack{
                        Image("instagram-gray")
                        
                        Text("인스타그램 공유하기")
                            .font(Font.system(size: 17))
                            .foregroundColor(.white)
                    }
                }))
            
            Button(action: {
                NotificationCenter.default.post(name: .shareLocal, object: nil, userInfo: ["index": UIState.activeCard])
            }, label: {
                Text("다른 방법으로 공유하기")
                    .underline()
                    .font(Font.system(size: 17))
                    .bold()
                    .foregroundColor(.black)
            })
        }
    }
}

// MARK: - ShareButtons_Previews

struct ShareButtons_Previews: PreviewProvider {
    static var previews: some View {
        ShareButtons()
            .environmentObject(UIStateModel())
    }
}
