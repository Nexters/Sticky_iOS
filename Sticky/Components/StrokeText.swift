//
//  StrokeText.swift
//  Sticky
//
//  Created by deo on 2021/01/31.
//

import SwiftUI

// MARK: - StrokeText

struct StrokeText: UIViewRepresentable {
    var text: String
    var width: CGFloat = 1.0
    var font: String = "Modak"
    var size: CGFloat = 30
    var fontColor = UIColor.black

    func makeUIView(context: Context) -> UILabel {
        let attributedStringParagraphStyle = NSMutableParagraphStyle()
        attributedStringParagraphStyle.alignment = NSTextAlignment.center
        let attributedString = NSAttributedString(
            string: "\(text)",
            attributes: [
                NSAttributedString.Key.paragraphStyle: attributedStringParagraphStyle,
                NSAttributedString.Key.strokeWidth: width,
                NSAttributedString.Key.foregroundColor: fontColor,
                NSAttributedString.Key.strokeColor: fontColor,
                NSAttributedString.Key.font: UIFont(name: "\(font)", size: size)!
            ]
        )

        let strokeLabel = UILabel(frame: CGRect.zero)
        strokeLabel.attributedText = attributedString
        strokeLabel.backgroundColor = UIColor.clear
        strokeLabel.sizeToFit()
        strokeLabel.center = CGPoint(x: 0.0, y: 0.0)
        return strokeLabel
    }

    func updateUIView(_ uiView: UILabel, context: Context) {}
}

// MARK: - StrokeText_Previews

struct StrokeText_Previews: PreviewProvider {
    static var previews: some View {
        StrokeText(text: "Sticky", size: 100)
    }
}
