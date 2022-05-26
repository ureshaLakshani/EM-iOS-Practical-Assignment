//
//  CustomUIImageView.swift
//  ios_assignment
//
//  Created by uresha lakshani on 2021-05-21.
//

import UIKit
import Kingfisher
import Alamofire
import AlamofireImage
import SDWebImage

@IBDesignable class CustomUIImageView: UIImageView {

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
    }
    
    func setImageView(img:String)  {
        let paseholder = UIImage(named: "paseholder")!
//        kf.setImage(with: url, placeholder: image)
        setImageWithUrl(img, placeholderImage: paseholder)
        
    }
}

extension UIImageView {
    func setImageWithUrl(_ urlString: String, placeholderImage: UIImage = UIImage()) {
        print(urlString)
        if let url = URL(string: urlString) {
//            af_setImage(withURL: url, placeholderImage: placeholderImage)
            sd_setImage(with: url, placeholderImage: placeholderImage)

        }
    }
}

extension UIButton {
    func setImageWithUrl(_ urlString: String, isBackground: Bool = false, state: UIControl.State = .normal, placeholderImage: UIImage = UIImage()) {
        if let url = URL(string: urlString) {
            switch isBackground {
            case true:
                self.af_setBackgroundImage(for: state, url: url, placeholderImage: placeholderImage)
            default:
                self.af_setImage(for: state, url: url, placeholderImage: placeholderImage)
            }
        }
    }
}


