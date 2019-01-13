//
//  SettingsViewController.swift
//  Tipper
//
//  Created by Caitlyn Chau on 12/28/18.
//  Copyright © 2018 Caitlyn Chau. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    @IBOutlet weak var Amount1Field: UITextField!
    @IBOutlet weak var Amount2Field: UITextField!
    @IBOutlet weak var Amount3Field: UITextField!
    @IBOutlet weak var settingsTipControl: UISegmentedControl!
    @IBOutlet weak var peopleSwitch: UISwitch!
    var switchOn = false //default switch value
    //var tipIndex: Int = 0 //default tip index
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    //MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onTapSettings(_ sender: Any) {
        view.endEditing(true)
    }

    
    @IBAction func updateAmount1(_ sender: UITextField) {
        let tip1 = Int(Amount1Field.text!) ?? 0
        defaults.set(tip1, forKey: "amount1")
        defaults.set(true, forKey: "hasChanged")
        defaults.synchronize()
        settingsTipControl.setTitle(String(defaults.integer(forKey: "amount1")) + "%", forSegmentAt: 0)
    }
    
    @IBAction func updateAmount2(_ sender: UITextField) {
        let tip2 = Int(Amount2Field.text!) ?? 0
        defaults.set(tip2, forKey: "amount2")
        defaults.set(true, forKey: "hasChanged")
        defaults.synchronize()
        settingsTipControl.setTitle(String(defaults.integer(forKey: "amount2")) + "%", forSegmentAt: 1)
    }
    
    @IBAction func updateAmount3(_ sender: UITextField) {
        let tip3 = Int(Amount3Field.text!) ?? 0
        defaults.set(tip3, forKey: "amount3")
        defaults.set(true, forKey: "hasChanged")
        defaults.synchronize()
        settingsTipControl.setTitle(String(defaults.integer(forKey: "amount3")) + "%", forSegmentAt: 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        
        Amount1Field.text = String(defaults.integer(forKey: "amount1"))
        Amount2Field.text = String(defaults.integer(forKey: "amount2"))
        Amount3Field.text = String(defaults.integer(forKey: "amount3"))
        settingsTipControl.setTitle(String(defaults.integer(forKey: "amount1")) + "%", forSegmentAt: 0)
        settingsTipControl.setTitle(String(defaults.integer(forKey: "amount2")) + "%", forSegmentAt: 1)
        settingsTipControl.setTitle(String(defaults.integer(forKey: "amount3")) + "%", forSegmentAt: 2)
        
        switchOn = defaults.bool(forKey: "isOn")
        peopleSwitch.setOn(switchOn, animated: switchOn)
    
        let intValue = defaults.integer(forKey: "tipIndex")
        settingsTipControl.selectedSegmentIndex = intValue
    }
    
    @IBAction func defaultValueControl(_ sender: UISegmentedControl) {
        let tipIndex = settingsTipControl.selectedSegmentIndex
        defaults.set(tipIndex, forKey: "tipIndex")
        defaults.set(true, forKey: "defaultChanged")
        defaults.synchronize()
    }
    
    @IBAction func `switch`(_ sender: UISwitch) {
        switchOn = sender.isOn
        defaults.set(switchOn, forKey: "isOn")
        defaults.synchronize()
    }
}
