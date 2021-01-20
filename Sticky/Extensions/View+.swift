//
//  View+.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/20.
//

import SwiftUI

extension View {
    func takeCapture() -> UIImage {
        var image: UIImage?
        
        guard let currentLayer = UIApplication
            .shared
            .windows
            .first(where: { $0.isKeyWindow })?
            .layer else { return UIImage() }
        
        let currentScale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(currentLayer.frame.size, false, currentScale)

        guard let currentContext = UIGraphicsGetCurrentContext() else { return UIImage() }
        currentLayer.render(in: currentContext)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image ?? UIImage()
    }

    func saveInPhoto(img: UIImage) {
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
    }

    func sharePicture(img: UIImage) {
        let av = UIActivityViewController(activityItems: [img], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}
