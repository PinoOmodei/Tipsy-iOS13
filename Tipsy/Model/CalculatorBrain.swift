//
//  CalculatorBrain.swift
//  Tipsy
//
//  Created by Pino Omodei on 06/03/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    var bill : Float?
    var pct : Float = 0.0
    var split : Float = 2.0
    var quote : Float?
    
    mutating func calculateQuote () {
        if let safeBill = bill {
            let tip = safeBill * (pct)
            quote = (safeBill + tip) / split
        }
    }
    
    func getQuote() -> String {
        return(String(format: "%.2f", quote ?? 0.0))
    }
    
    func getCalcDescription() -> String {
        return(String(format: "Split between %.0f people, with %.0f%% of tip", split, pct * 100))
    }
}
