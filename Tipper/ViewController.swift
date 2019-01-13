//
//  ViewController.swift
//  Tipper
//
//  Created by Albert Chau on 12/24/18.
//  Copyright © 2018 Caitlyn Chau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet var segmentedAmounts: UIView!
    @IBOutlet weak var IntNumPeopleLabel: UILabel!
    @IBOutlet weak var pricePerPersonLabel: UILabel!
    @IBOutlet weak var peopleView: UIView!
    
    
    var tipPercentages: [Double] = [0.1, 0.15, 0.2]
    var numPeople = 1
    var numPeopleChanged = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Tip Calculator"
        billField.becomeFirstResponder()
    }

    @IBAction func onTap(_ sender: Any) {
       view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        pricePerPersonLabel.text = String(format: "$%.2f", total)
        
        if numPeopleChanged == true {
            let pricePerPerson = total / Double(numPeople)
            pricePerPersonLabel.text = String(format: "$%.2f", pricePerPerson)
        }
        
        let defaults = UserDefaults.standard
        defaults.set(billField.text, forKey: "bill")
        defaults.set(tipLabel.text, forKey: "tip")
        defaults.set(totalLabel.text, forKey: "total")
        defaults.set(pricePerPersonLabel.text, forKey: "ppp")
    }
    
    @IBAction func NumPeopleStepper(_ sender: UIStepper) {
        //let defaults = UserDefaults.standard
        let people = sender.value
        IntNumPeopleLabel.text = String(Int(people))
        numPeopleChanged = true
        if numPeopleChanged == true {
            numPeople = Int(people)
            self.calculateTip(self)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        let defaults = UserDefaults.standard
        
        //change text of tip values
        let boolValue = defaults.bool(forKey: "hasChanged")
        if boolValue == true {
            let amount1 = Double(defaults.integer(forKey: "amount1")) * 0.01
            let amount2 = Double(defaults.integer(forKey: "amount2")) * 0.01
            let amount3 = Double(defaults.integer(forKey: "amount3")) * 0.01
            tipPercentages = [amount1, amount2, amount3]
            tipControl.setTitle(String(defaults.integer(forKey: "amount1")) + "%", forSegmentAt: 0)
            tipControl.setTitle(String(defaults.integer(forKey: "amount2")) + "%", forSegmentAt: 1)
            tipControl.setTitle(String(defaults.integer(forKey: "amount3")) + "%", forSegmentAt: 2)
        }
    
        //change default tip value
        let defaultChanged = defaults.bool(forKey: "defaultChanged")
        if defaultChanged {
            let intValue = defaults.integer(forKey: "tipIndex")
            tipControl.selectedSegmentIndex = intValue
            defaults.set(false, forKey: "defaultChanged")
        }
        self.calculateTip(self)
        
        //show Number of People view
        let switchOn = defaults.bool(forKey: "isOn")
        if (switchOn == true){
            peopleView.isHidden = false
            defaults.set(true, forKey: "isOn")
        }else{
            peopleView.isHidden = true
            defaults.set(false, forKey: "isOn")
        }
    }
    
}


