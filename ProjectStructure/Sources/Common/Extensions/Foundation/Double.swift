//
//  Double.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation

extension Double {
    func toInt() -> Int {
        return Int(self)
    }
    
    func toString() -> String {
        return String(format: "%.1f", self)
    }
    
    func toStringWithoutDecimalZero() -> String {
        return String(format: "%.0f", self)
    }
    
    func toStringRounded(numberDecimal: Int) -> String {
        return String(format: "%.\(numberDecimal)f", self)
    }
    
    func toStringCleanDecimalZero() -> String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }

    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16
        return String(formatter.string(from: number) ?? "")
    }
    
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func toStringWithDecimalEqual(numberDecimal: Int) -> String {
        var formattedValue = String(format: "%.\(numberDecimal)f", self)
        while formattedValue.last == "0" {
            formattedValue.removeLast()
        }
        
        if formattedValue.last == "." {
            formattedValue.removeLast()
        }
        return formattedValue
    }

    func toStringHoursAndMinutes(format: String = "%02d") -> String {
        return Double.convertHourAndMinute(time: self)
    }
}

extension Double {
    static func convertHourAndMinute(time: Double) -> String {
        let hour = Int(time)
        var decpart = time - Double(hour)
        let min = 1.0 / 60.0
        decpart = min * Double((decpart / min).rounded())
        var minute = String(Int(decpart * 60))

        if minute.count < 2 {
            minute = "0" + minute
        }

        return "\(hour)hrs \(minute)min"
    }
}
