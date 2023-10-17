//
//  InAppVC.swift
//  AJourneyThroughTime
//
//  Created by Cenker Soyak on 17.10.2023.
//

import UIKit
import SnapKit
import RevenueCat

class InAppVC: UIViewController {
    
    let purchaseButton = UIButton()
    let restoreButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        setUp()
    }
    func createUI(){
        view.backgroundColor = .white
        
        let priceLabel = UILabel()
        priceLabel.text = "Per Month Price 19.99$"
        priceLabel.textAlignment = .center
        priceLabel.textColor = .black
        priceLabel.font = .boldSystemFont(ofSize: 20)
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
        }
        purchaseButton.setTitle("Purchase", for: .normal)
        purchaseButton.configuration = .plain()
        purchaseButton.backgroundColor = .systemBlue
        purchaseButton.layer.cornerRadius = 10
        purchaseButton.tintColor = .white
        purchaseButton.layer.borderColor = UIColor.black.cgColor
        purchaseButton.layer.borderWidth = 0.5
        purchaseButton.isHidden = true
        view.addSubview(purchaseButton)
        purchaseButton.addTarget(self, action: #selector(purchaseButtonClicked), for: .touchUpInside)
        purchaseButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(priceLabel.snp.bottom).offset(80)
        }
        restoreButton.addTarget(self, action: #selector(restoreButtonClicked), for: .touchUpInside)
        restoreButton.setTitle("Restore", for: .normal)
        restoreButton.configuration = .plain()
        restoreButton.backgroundColor = .systemBlue
        restoreButton.layer.cornerRadius = 10
        restoreButton.tintColor = .white
        restoreButton.layer.borderColor = UIColor.black.cgColor
        restoreButton.layer.borderWidth = 0.5
        restoreButton.isHidden = true
        restoreButton.addTarget(self, action: #selector(restoreButtonClicked), for: .touchUpInside)
        view.addSubview(restoreButton)
        restoreButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(purchaseButton.snp.bottom).offset(30)
            make.width.equalTo(purchaseButton.snp.width)
        }
    }
    func fetchPackages(completion: @escaping (Package) -> Void){
        Purchases.shared.getOfferings { offerings, error in
            guard let offerings = offerings, error == nil else {
                return
            }
            guard let package = offerings.all.first?.value.availablePackages.first else {
                return
            }
            completion(package)
        }
    }
    func purchase(package: Package){
        Purchases.shared.purchase(package: package) { transaction, info, error, userCancelled in
            guard let transaction = transaction, let info = info, error == nil, !userCancelled else {
                return
            }
        }
    }
    
    func restorePurchases(){
        Purchases.shared.restorePurchases { info, error in
            guard let info = info, error == nil else { return }
        }
    }
    func setUp(){
        Purchases.shared.getCustomerInfo { info, error in
            guard let info = info, error == nil else { return }
            if
                info.entitlements.all[""]?.isActive == true {
            } else {
                DispatchQueue.main.async {
                    self.purchaseButton.isHidden = false
                    self.restoreButton.isHidden = false
                }
            }
        }
    }
    @objc func purchaseButtonClicked(){
        fetchPackages { [weak self] package in
            self?.purchase(package: package)
        }
    }
    @objc func restoreButtonClicked(){
        restorePurchases()
    }
}
