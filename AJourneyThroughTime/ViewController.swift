//
//  AppDelegate.swift
//  AJourneyThroughTime
//
//  Created by Cenker Soyak on 17.10.2023.
//

import UIKit
import SnapKit
import RevenueCat

class ViewController: UIViewController {
    
    let purchaseButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        createUI()
    }
    func createUI() {
        let photo = UIView(frame: CGRect(x: 50, y: 150, width: 300, height: 400))
        photo.layer.borderWidth = 1
        photo.layer.cornerRadius = 10
        photo.layer.shadowColor = UIColor.black.cgColor
        photo.layer.shadowOffset = CGSize(width: 5, height: 5)
        photo.layer.shadowOpacity = 0.5
        photo.layer.shadowRadius = 5
        view.addSubview(photo)
        
        let photoView = UIImageView()
        photoView.image = UIImage(named: "photo")
        photoView.contentMode = .scaleToFill
        view.addSubview(photoView)
        photoView.snp.makeConstraints { make in
            make.top.equalTo(photo.snp.top)
            make.left.equalTo(photo.snp.left)
            make.right.equalTo(photo.snp.right)
            make.bottom.equalTo(photo.snp.bottom)
        }
        
        purchaseButton.setTitle("Buy premium for edit this image", for: .normal)
        purchaseButton.configuration = .filled()
        view.addSubview(purchaseButton)
        purchaseButton.snp.makeConstraints { make in
            make.top.equalTo(photo.snp.bottom).offset(30)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(photo.snp.width)
            make.height.equalTo(view.frame.size.height / 12)
        }
        purchaseButton.addTarget(self, action: #selector(toAppPurchase), for: .touchUpInside)
    }
    
    @objc func toAppPurchase() {
        let vc = InAppVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
