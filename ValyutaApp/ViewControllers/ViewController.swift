//
//  ViewController.swift
//  ValyutaApp
//
//  Created by Veysal on 17.10.22.
//

import UIKit
import SnapKit
import DropDown

class ViewController: UIViewController {
    let url = URL(string: "https://api.exchangerate.host/latest")
    var selectedCurrency = "AZN"
    let menu : DropDown = {
        let menu = DropDown()
        menu.dataSource = [
        "EURO to AZN",
        "EURO to TRY",
        "EURO to RUB",
        "EURO to USD",
        "EURO to GGP",
        "EURO to JOD"
        ]
        return menu
    }()

    private var ratesViewModel: CurrancyRatesViewModel!
    private var currancyViewModel: CurrancyViewModel!
    private lazy var buttonCalculate : UIButton = {
        let button = UIButton()
        self.view.addSubview(button)
        button.backgroundColor = .blue
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(onTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var textCurrancy : UILabel = {
        let label = UILabel()
        self.view.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.text = "select currency name"
        label.textColor = .blue
        return label
    }()
    private lazy var dateLabel : UILabel = {
        let label = UILabel()
        self.view.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 32, weight: .light)
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    private lazy var textPrice : UILabel = {
        let label = UILabel()
        self.view.addSubview(label)
        label.text = "0"
        label.textAlignment = .right
        return label
    }()
    private lazy var priceTextField : UITextField = {
        let label = UITextField()
        self.view.addSubview(label)
        label.text = "1"
        label.textAlignment = .left
        label.borderStyle = .roundedRect
        return label
    }()
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOtherData()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapCurrancyLabel))
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        textCurrancy.isUserInteractionEnabled = true
        textCurrancy.addGestureRecognizer(gestureRecognizer)
    }
    @objc func onTapped() {
        
        getData(text: selectedCurrency)
        if let text = priceTextField.text {
            textCurrancy.text = "\(text) EURO"
        }
       
    }
    
    @objc func onTapCurrancyLabel() {
        menu.show()
        print("Okkkk")
        textPrice.text = "..."

    }
    
    func getOtherData() {
        CurrancyWebService().downloadData(url: url!) { currancy, _ in
            if let currancy = currancy {
                self.currancyViewModel = CurrancyViewModel(currancy: currancy)
                DispatchQueue.main.async {
                self.dateLabel.text = "Date : \(self.currancyViewModel.date)"
                }
            }
        }
    }
    
    func getData(text : String) {
    
        CurrancyWebService().downloadData(url: url!) { _, currancyRate in
            if let currancyRate = currancyRate {
                self.ratesViewModel = CurrancyRatesViewModel(ratesList: currancyRate)
                DispatchQueue.main.async {
                    self.textPrice.text = "\(Double(self.priceTextField.text!)! * self.ratesViewModel.getPrice(value: text)) \(self.selectedCurrency)"
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        menu.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        menu.anchorView = textCurrancy
        menu.selectionAction = {index, title in
            self.textCurrancy.text = title
            switch index {
            case 0:
                self.selectedCurrency = "AZN"
            case 1:
                self.selectedCurrency = "TRY"
            case 2:
                self.selectedCurrency = "RUB"
            case 3:
                self.selectedCurrency = "USD"
            case 4:
                self.selectedCurrency = "GGP"
            case 5:
                self.selectedCurrency = "JOD"
            default:
                self.selectedCurrency = "AZN"
            }
        }
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        priceTextField.snp.makeConstraints { make in
            make.top.equalTo(self.textCurrancy.safeAreaLayoutGuide.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(32)
            make.width.equalTo(view.bounds.width/2)
        }
        textCurrancy.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(32)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(view.bounds.height/2-8)
            make.right.equalTo(self.textPrice.safeAreaLayoutGuide.snp.left).offset(8)
            make.width.equalTo(view.bounds.width/2)
        }
        textPrice.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(view.bounds.width/2)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(view.bounds.height/2-8)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-32)
            make.width.equalTo(view.bounds.width/2)
        }
        
        buttonCalculate.snp.makeConstraints { make in
            make.top.equalTo(self.priceTextField.safeAreaLayoutGuide.snp.bottom).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(32)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-32)
            make.height.equalTo(32)
        }
    }

  

}

