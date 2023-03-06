//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var calculatorBrain = CalculatorBrain()

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    
/* da stackoverflow: come chiudere la tastiera
 override func viewDidLoad() {
        super.viewDidLoad()
              
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }

    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //close the keyboard of billTextField
        billTextField.endEditing(true)

    }
 */
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        // take the bill input
        calculatorBrain.bill = Float(billTextField.text!) ?? 0.0
        
        // take the selected % of tip
        if (zeroPctButton.isSelected) {
            calculatorBrain.pct = 0.0
        } else if (tenPctButton.isSelected) {
            calculatorBrain.pct = 0.1
        } else if (twentyPctButton.isSelected) {
            calculatorBrain.pct = 0.2
        } else {
            calculatorBrain.pct = 0.0
        }
 
        // take the number of split
        calculatorBrain.split = Float(splitNumberLabel.text!) ?? 2.0
        
        // calculate the quote!
        calculatorBrain.calculateQuote()
        
        // show (modal) the results
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToResult") {
            let destination = segue.destination as! ResultsViewController
            destination.total = calculatorBrain.getQuote()
            destination.settings = calculatorBrain.getCalcDescription()
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

