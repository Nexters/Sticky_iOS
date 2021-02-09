//
//  View+.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/20.
//

import SwiftUI

extension UIView{
    var renderedImage: UIImage{
        let rect = self.bounds
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        self.layer.render(in: context)
        
        let capturedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        return capturedImage
    }
}

extension View {
    
    func takeCapture(origin: CGPoint, size: CGSize) -> UIImage {
        let window = UIWindow(frame: CGRect(origin: origin, size: size))
        let hosting = UIHostingController(rootView: self)
        hosting.view.frame = window.frame
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        
        return hosting.view.renderedImage
        
//        var image: UIImage?
        
//        guard let currentLayer = UIApplication
//            .shared
//            .windows
//            .first(where: { $0.isKeyWindow })?
//            .layer else { return UIImage() }
//
//        let currentScale = UIScreen.main.scale
//        UIGraphicsBeginImageContextWithOptions(currentLayer.frame.size, false, currentScale)
//
//        guard let currentContext = UIGraphicsGetCurrentContext() else { return UIImage() }
//        currentLayer.render(in: currentContext)
//        image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
        
        

    }

    func saveInPhoto(img: UIImage) {
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
    }
    
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
            if hidden {
                if !remove {
                    self.hidden()
                }
            } else {
                self
            }
        }
}
