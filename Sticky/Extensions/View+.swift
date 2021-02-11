
import SwiftUI

extension UIView {
    var renderedImage: UIImage {
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
    
    func share(origin: CGPoint, size: CGSize) -> UIImage{
        let window = UIWindow(frame: UIScreen.main.bounds)
        let hosting = UIHostingController(rootView: self)
        hosting.view.frame = window.frame
        
        // MARK: 레벨에 따른 배경색
        hosting.view.backgroundColor = .yellow
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        
        return hosting.view.renderedImage
        
    }
    
    func takeCapture(origin: CGPoint, size: CGSize) -> UIImage {
        let window = UIWindow(frame: CGRect(origin: origin, size: size))
        let hosting = UIHostingController(rootView: self)
        hosting.view.frame = window.frame
        hosting.view.backgroundColor = .clear
        hosting.view.clipsToBounds = true
        hosting.view.layer.cornerRadius = hosting.view.frame.height / 20
        
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        
        return hosting.view.renderedImage
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
