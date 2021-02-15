
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
    func captureBGImage(bgColor: LinearGradient?) -> UIImage {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let hosting = UIHostingController(rootView: BGView(color: bgColor))
        hosting.view.frame = window.frame
        
        // MARK: 레벨에 따른 배경색

//        hosting.view.backgroundColor = bgColor
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        
        return hosting.view.renderedImage
    }
    
    func captureCardImage(origin: CGPoint, size: CGSize) -> UIImage {
        let window = UIWindow(frame: CGRect(origin: origin, size: size))
        let hosting = UIHostingController(rootView: self)
        hosting.view.frame = window.frame
        
        hosting.view.clipsToBounds = true
        hosting.view.layer.cornerRadius = hosting.view.frame.height / 20
        
        // MARK: 레벨에 따른 배경색

        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        
        return hosting.view.renderedImage
    }
    
    func captureCardImageCongratulation(origin: CGPoint, size: CGSize) -> UIImage {
        let window = UIWindow(frame: CGRect(origin: origin, size: size))
        let hosting = UIHostingController(rootView: self)
        hosting.view.frame = window.frame
        hosting.view.backgroundColor = .clear
        hosting.view.clipsToBounds = true
        hosting.view.layer.cornerRadius = hosting.view.frame.height / 20
        
        // MARK: 레벨에 따른 배경색

        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        
        return hosting.view.renderedImage
    }
    
    func captureWithBG(origin: CGPoint, size: CGSize, bgColor: LinearGradient?) -> UIImage {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let mainView = UIHostingController(rootView: BGView(color: bgColor))
        let hosting = UIHostingController(rootView: self)
        mainView.view.frame = window.frame
        mainView.view.addSubview(hosting.view)
        
        hosting.view.frame = CGRect(origin: origin, size: size)
        hosting.view.backgroundColor = .clear
        hosting.view.clipsToBounds = true
        hosting.view.layer.cornerRadius = hosting.view.frame.height / 20
        if bgColor == nil {
            hosting.view.translatesAutoresizingMaskIntoConstraints = false
            hosting.view.centerYAnchor.constraint(equalTo: mainView.view.safeAreaLayoutGuide.centerYAnchor, constant: -60).isActive = true
            hosting.view.centerXAnchor.constraint(equalTo: mainView.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            hosting.view.widthAnchor.constraint(equalTo: mainView.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
            hosting.view.heightAnchor.constraint(equalTo: mainView.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.6).isActive = true
        }
        window.addSubview(mainView.view)
        window.makeKeyAndVisible()
        
        return mainView.view.renderedImage
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
