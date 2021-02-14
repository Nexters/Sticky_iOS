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
        VStack(spacing: 10){
            RoundedRectangle(cornerRadius: 12)
                .frame(width: UIScreen.main.bounds.width * 260/360, height: UIScreen.main.bounds.height * 44/640, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(Button(action: {
                    NotificationCenter.default.post(name: .shareLocal, object: nil, userInfo: ["index": UIState.activeCard])
                }, label: {
                    HStack{
                        Image("instagram-gray")
                        
                        Text("Share on Instagram")
                            .font(Font.system(size: 17))
                            .foregroundColor(.white)
                    }
                }))
            
            Button(action: {
                NotificationCenter.default.post(name: .shareLocal, object: nil, userInfo: ["index": UIState.activeCard])
            }, label: {
                Text("Share in other apps")
                    .font(Font.system(size: 17))
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
