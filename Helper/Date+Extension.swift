//
//  Date+Extension.swift
//  task_Tailwebs
//
//  Created by Shubham Ramani on 15/03/24.
//

import Foundation

extension Date {
    
    func short_weekday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        let month = dateFormatter.string(from: self)
        return month.capitalized
    }

    func month() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let month = dateFormatter.string(from: self)
        return month.capitalized
    }

    func month_numeric() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.string(from: self)
        return month.capitalized
    }

    func year() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let month = dateFormatter.string(from: self)
        return month.capitalized
    }

    func day() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let month = dateFormatter.string(from: self)
        return month.capitalized
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }

    
    func getDateString() -> String{
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df.string(from: self)
    }
    
   
}

extension String{
    func stringToDate()->Date{
        let date_formatter = DateFormatter()
        date_formatter.dateFormat = "dd/MM/yyyy"
        return date_formatter.date(from: self) ?? Date()
    }
}
