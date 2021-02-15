//
//  Share+.swift
//  Sticky
//
//  Created by deo on 2021/02/01.
//
import SwiftUI

/// 인스타그램 공유
func shareInstagram(bgImage: UIImage, cardImage: UIImage) {
    guard let urlScheme = URL(string: "instagram-stories://share") else {
        return
    }
    if !UIApplication.shared.canOpenURL(urlScheme) {
        print("인스타 앱이 안깔려 있습니다.")
        return
    }
    UIPasteboard.general.setItems(
        [
            [
                "com.instagram.sharedSticker.stickerImage": cardImage.pngData()!,
                "com.instagram.sharedSticker.backgroundImage": bgImage.pngData()!,
            ],
        ],
        options: [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60 * 5)]
    )

    UIApplication.shared.open(urlScheme as URL, options: [:], completionHandler: nil)
}

/// 로컬 저장
func shareLocal(image: UIImage) {
    let av = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
}
