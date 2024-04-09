//
//  ViewController.swift
//  BitCoin
//
//  Created by ReetDhillon on 2024-04-08.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var conversionRate: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        pickerView.delegate = self
    }
}

//MARK: PickerViewDelegates
extension ViewController : UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyLabel.text = coinManager.currencyArray[row]
        coinManager.exchangeRate(to: currencyLabel.text ?? "")
    }
}

//MARK: PickerViewDataSource
extension ViewController : UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

//MARK: Coin Manager Delegated
extension ViewController: CoinManagerDelegate{
    func didUpdateCurrencyConversionRate(_ coinManager: CoinManager, coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.conversionRate.text = coinModel.currencyRateString
        }
    }
    
    func didFailWithError(error: Error) {
        print("Error is\(error)")
    }
}

