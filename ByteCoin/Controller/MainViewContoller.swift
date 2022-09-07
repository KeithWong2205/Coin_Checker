//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class MainViewContoller: UIViewController {

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        // Do any additional setup after loading the view.
    }


}

//MARK: -

extension MainViewContoller: UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    
}

//MARK: -

extension MainViewContoller: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        return coinManager.getCoinPrice(for: selectedCurrency)
    }
}

//MARK: -

extension MainViewContoller: CoinManagerDelegate{
    func didFetchSuccess(_ coinManager: CoinManager, rate: RateModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format: "%.2f", rate.exchangeRate)
            self.currencyLabel.text = rate.quoteCurrency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
