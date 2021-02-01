//
//  PopupStateModel.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/24.
//

import Foundation

// MARK: - PopupStateModel

public class PopupStateModel: ObservableObject {
    @Published var isPresented: Bool = false
}

// MARK: - PopupStyle

enum PopupStyle {
    static let exit = Message(title: "챌린지 종료하기", description: """
    앗! 지금까지의 쌓은 연속기록이 사라집니다!
    정말 챌린지를 종료하시겠어요?
    """, confirmString: "그만 할래요", rejectString: "계속 할게요")
    static let fail = Message(title: "챌린지 종료", description: """
    위치를 이탈하여 챌린지가 종료되었습니다.
    최종 기록을 공유할까요?
    """, confirmString: "네! 공유할래요", rejectString: "안할래요")
    static let outing = Message(title: "외출하기", description: """
    하트 1개당 20분 외출할 수 있어요.
    시간을 넘기면 챌린지가 종료됩니다.
    """, confirmString: "하트 사용해서 외출하기", rejectString: "취소하기")
}
