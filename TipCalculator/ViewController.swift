//
//  ViewController.swift
//  TipCalculator
//
//  Created by Alexandre Barde on 21/04/2023.
//

import UIKit

class ViewController: UIViewController {

    // "Bill total" input
    @IBOutlet weak var inputTotalBill: UITextField!
    
    // "Service" input
    @IBOutlet weak var inputServicePercentage: UITextField!
    
    // "Split (Nb Persons)" input
    @IBOutlet weak var inputNbPersons: UITextField!
    
    
    @IBOutlet weak var calculatedTip: UILabel!
    
    @IBOutlet weak var totalBill: UILabel!
    
    @IBOutlet weak var perPersonBill: UILabel!
    
    // Global variables
    var nbPersonsG = 1
    var billG = 0.0
    var percentService = 15.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.addDoneButtonOnKeyboard()
    }
 
    @IBAction func setPercentService(_ sender: Any) {
        let prctService = inputServicePercentage.text!
        if !(prctService.isEmpty) {
            self.percentService = Double(prctService)!
            self.calcul()
            
            inputServicePercentage.text = "\(prctService) %"
        }
    }
    
    @IBAction func setNbPersons(_ sender: Any) {
        let nbPersons = inputNbPersons.text!
        if !(nbPersons.isEmpty) {
            self.nbPersonsG = Int(nbPersons)!
            if self.nbPersonsG > 1 {
                inputNbPersons.text = "\(self.nbPersonsG) persons"
            } else {
                inputNbPersons.text = "\(self.nbPersonsG) person"
            }
            self.calcul()
        }
    }

    func calcul() {
        if !(self.billG == 0.0) || !(self.billG == 0) {
            print("% \(self.percentService)")
            print("% 100 : \(self.percentService / 100)")
            print("bill : \(self.billG)")
            let tip = self.billG * Double(self.percentService / 100)
            print(tip)
            let totalBillCal = tip + self.billG
            let totalSplitted = round((totalBillCal / Double(self.nbPersonsG) * 100)) / 100.0
            
            calculatedTip.text = "\(tip) $"
            totalBill.text = "\(totalBillCal) $"
            perPersonBill.text = "\(totalSplitted) $"
        }
    }
    
    @IBAction func setBillTotal(_ sender: Any) {
       let bill = inputTotalBill.text!
        
       if bill.isEmpty {
           calculatedTip.text = "0,00$"
       }
        
        self.billG = Double(inputTotalBill.text!)!
        self.calcul()
        
        // Add dollar symbol
        let currentBill = inputTotalBill.text!
        inputTotalBill.text = currentBill + " $"
        
    }
    
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        inputTotalBill.inputAccessoryView = doneToolbar
        inputNbPersons.inputAccessoryView = doneToolbar
        inputServicePercentage.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        inputTotalBill.resignFirstResponder()
        inputNbPersons.resignFirstResponder()
        inputServicePercentage.resignFirstResponder()
    }
    
    
}

