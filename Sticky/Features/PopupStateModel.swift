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
    @Published var popupStyle = PopupStyle.exit
}

// MARK: - PopupStyle

enum PopupStyle {
    case exit
    case fail
    case outing
    case failDuringOuting

    // MARK: Internal

    func getMessage() -> Message {
        switch self {
        case .exit:
            return Message(
                style: .exit,
                title: "챌린지 종료하기",
                description: "앗! 지금까지의 쌓은 연속기록이 사라집니다!\n정말 챌린지를 종료하시겠어요?",
                confirmString: "그만 할래요",
                rejectString: "계속 할게요"
            )
        case .fail:
            return Message(
                style: .fail,
                title: "챌린지 종료",
                description: "위치를 이탈하여 챌린지가 종료되었습니다.\n최종 기록을 공유할까요?",
                confirmString: "네! 공유할래요",
                rejectString: "안할래요"
            )
        case .outing:
            return Message(
                style: .outing,
                title: "외출하기",
                description: "하트 1개당 20분 외출할 수 있어요.\n시간을 넘기면 챌린지가 종료됩니다.",
                confirmString: "하트 사용해서 외출하기",
                rejectString: "취소하기"
            )
        case .failDuringOuting:
            return Message(
                style: .outing,
                title: "외출 실패",
                description: "20분의 외출 시간동안 집으로 들어오지 못했어요.\n최종 기록을 공유할까요?",
                confirmString: "네! 공유할래요",
                rejectString: "안할래요"
            )
        }
    }
}
