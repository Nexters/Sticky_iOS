//
//  Timer.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import SwiftUI

struct Timer: View {
    @EnvironmentObject private var popupState: PopupStateModel
    @State var sharePresented: Bool = false
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink(destination: MyPage()) {
                    Text("MyPage")
                }
                
                Button(action: {
                    popupState.isPresented = true
                }, label: {
                    Text("팝업")
                })
                
                NavigationLink(destination: Share()
                                .environmentObject(UIStateModel()),
                               isActive: $sharePresented) { EmptyView() }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.confirmPopup)){ _ in
            self.sharePresented = true
        }
        .popup(isPresented: $popupState.isPresented, rateOfWidth: 0.8){
            PopupMessage(isPresented: $popupState.isPresented, title: "챌린지 종료하기", description: "챌린지가 00때문에 종료되었습니다.\n최종기록을 공유할까요", confirmString: "공유하기", rejectString: "취소하기")
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
    
    func confirmInPopup(_ notification: Notification){
        self.sharePresented = true
    }
}



struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        return Timer()
            .popup(isPresented: .constant(true), rateOfWidth: 0.4){
                PopupMessage(isPresented: .constant(true), title: "챌린지 종료하기", description: "챌린지가 00때문에 종료되었습니다.\n최종기록을 공유할까요", confirmString: "공유하기", rejectString: "취소하기")
            }
            .edgesIgnoringSafeArea(.all)
    }
}
