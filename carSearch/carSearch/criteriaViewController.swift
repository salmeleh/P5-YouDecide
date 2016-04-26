//
//  criteriaViewController.swift
//  carSearch
//
//  Created by Stu Almeleh on 4/25/16.
//  Copyright © 2016 Stu Almeleh. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class criteriaViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var pricePickerView: UIPickerView!
    @IBOutlet weak var performancePickerView: UIPickerView!
    @IBOutlet weak var fuelEfficiencyPickerView: UIPickerView!
    
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var performanceSlider: UISlider!
    @IBOutlet weak var fuelEfficiencySlider: UISlider!
    
    //picker view choices
    var priceChoices = [10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000, 90000, 100000]
    var performanceChoices = [7, 8, 9, 10, 11, 12, 13, 14]
    var fuelEfficiencyChoices = [10, 15, 20, 25, 30, 35, 40, 45]
    
    //set default selections & importances
    var priceSelection = 50000, performanceSelection = 10, fuelEfficiencySelection = 20
    var priceImportance = 5, performanceImportance = 5, fuelEfficiencyImportance = 5
    
    override func viewDidLoad() {
        pickerViewSetup()
        sliderValueDidChange()
        
    }
    
    
    
    //UIPickerViewDelegate Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        let tag = pickerView.tag
        
        if tag == 1 {
            return priceChoices.count
        }
        else if tag == 2 {
            return performanceChoices.count
        }
        else if tag == 3 {
            return fuelEfficiencyChoices.count
        }
        
        return 1
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let tag = pickerView.tag
        
        if tag == 1 {
            return String(priceChoices[row])
        }
        else if tag == 2 {
            return String(performanceChoices[row])
        }
        else if tag == 3 {
            return String(fuelEfficiencyChoices[row])
        }
        
        return ""
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let tag = pickerView.tag
        
        if tag == 1 {
            priceSelection =  priceChoices[row]
        }
        else if tag == 2 {
            performanceSelection = performanceChoices[row]
        }
        else if tag == 3 {
            fuelEfficiencySelection = fuelEfficiencyChoices[row]
        }
        
    }
    
    
    
    @IBAction func sliderValueDidChange(sender: AnyObject) {
        let tag = sender.tag
        
        if tag == 1 {
            priceImportance = Int(priceSlider.value)
            print(priceImportance)
        }
        else if tag == 2 {
            performanceImportance = Int(performanceSlider.value)
            print(performanceImportance)
        }
        else if tag == 3 {
            fuelEfficiencyImportance = Int(performanceSlider.value)
            print(fuelEfficiencyImportance)
        }

        
    }

    
    
    
    
    
    
    
    
    
    
    func pickerViewSetup() {
        
        pricePickerView.delegate = self
        performancePickerView.delegate = self
        fuelEfficiencyPickerView.delegate = self
        
        pricePickerView.tag = 1
        performancePickerView.tag = 2
        fuelEfficiencyPickerView.tag = 3
        
        pricePickerView.selectRow(priceChoices.count / 2 - 1, inComponent: 0, animated: true)
        performancePickerView.selectRow(performanceChoices.count / 2, inComponent: 0, animated: true)
        fuelEfficiencyPickerView.selectRow(fuelEfficiencyChoices.count / 2, inComponent: 0, animated: true)
        
        
    }
    
    
    
    
    
}

    
    
    

