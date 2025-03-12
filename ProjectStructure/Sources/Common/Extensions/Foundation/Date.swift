//
//  Date.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation

enum DateState: Equatable {
    case yesterday, today, tomorrow, daysAgo(Int), indays(Int)
    
    var lowercaseString: String {
        switch self {
        case .yesterday:
            return "yesterday"
        case .today:
            return "today"
        case .tomorrow:
            return "tomorrow"
        case .daysAgo(let day):
            return "\(-day) days ago"
        case .indays(let day):
            return "in \(day) days"
        }
    }
}

extension Date {
    func safeISO8601Format() -> String {
        if #available(iOS 15.0, *) {
            return self.ISO8601Format()
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
            return formatter.string(from: self)
        }
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(
            from: Calendar.current.dateComponents(
                [.year, .month],
                from: Calendar.current.startOfDay(for: self)
            )
        ) ?? Date()
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth()) ?? Date()
    }
    
    func startOfMonth(with index: Int) -> Date {
        return Calendar.current.date(
            from: Calendar.current.dateComponents(
                [.year, .month],
                from: Calendar.current.date(byAdding: .month, value: index, to: Date()) ?? Date()
            )
        ) ?? Date()
    }
    
    func endOfMonth(with index: Int) -> Date {
        return Calendar.current.date(
            byAdding: DateComponents(month: 1, day: -1),
            to: self.startOfMonth(with: index)
        ) ?? Date()
    }
    
    func dayNumberOfWeek() -> Int {
        return Calendar.current.dateComponents([.weekday], from: self).weekday ?? 0
    }
    
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        dateformat.calendar = Calendar(identifier: .iso8601)
        dateformat.locale = Locale(identifier: "en_US")
        return dateformat.string(from: self)
    }
    
    func formattedDateStringNoLocale(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self)
    }
    
    func toUTCDateString(format: DateTimeFormatType) -> String {
        let formater = DateFormatter()
        formater.timeZone = TimeZone(abbreviation: "UTC")
        formater.dateFormat = format.rawValue
        return formater.string(from: self)
    }
    
    func toServerTime() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = DateTimeFormatType.time.rawValue
        dateformat.calendar = Calendar(identifier: .iso8601)
        dateformat.locale = Locale(identifier: "en_US")
        return "\(dateformat.string(from: self)).000Z"
    }
    
    func toServerDate() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = DateTimeFormatType.default.rawValue
        dateformat.calendar = Calendar(identifier: .iso8601)
        dateformat.locale = Locale(identifier: "en_US")
        return dateformat.string(from: self)
    }
    
    func toDateWithOrdinalSuffix(isIncludeDay: Bool = true) -> String {
        // Day
        let calendar = Calendar.current
        let anchorComponents = calendar.dateComponents([.day, .month, .year], from: self)
        guard let date = anchorComponents.day else { return "" }
        
        // Formater
        let monthAndYearFormate = DateFormatter()
        monthAndYearFormate.dateFormat = DateTimeFormatType.monthAndYear.rawValue
        let monthAndYear = monthAndYearFormate.string(from: self)
        
        let dayFormate = DateFormatter()
        dayFormate.dateFormat = DateTimeFormatType.weekdayNameStandaloneShort.rawValue
        
        var dateStr = "\(date)"
        switch dateStr {
        case "1", "21", "31":
            dateStr.append("st")
        case "2", "22":
            dateStr.append("nd")
        case "3", "23":
            dateStr.append("rd")
        default:
            dateStr.append("th")
        }
        if isIncludeDay {
            let day = dayFormate.string(from: self)
            return "\(day) \(dateStr) \(monthAndYear)"
        } else {
            return "\(dateStr) \(monthAndYear)"
        }
        
    }
    
    func toLocalDateStr(_ format: String) -> String {
        // Create a DateFormatter
        let dateFormatter = DateFormatter()
        
        // Set the desired date format
        dateFormatter.dateFormat = format
        
        // Set the time zone to the current system time zone
        dateFormatter.timeZone = TimeZone.current
        
        // Convert the Date object to a string in the local time zone
        let localDateString = dateFormatter.string(from: self)
        return localDateString
    }
}

// MARK: - Date static methods
extension DateFormatter {
    static var unitedStatesDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
    
    static func unitedStatesDateFormatter(dateFormat: String) -> DateFormatter {
        let formatter = Self.unitedStatesDateFormatter
        formatter.dateFormat = dateFormat
        return formatter
    }
    
    static func differenceStartEndTime(startTime: String, endTime: String, format: DateTimeFormatType) -> Double {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let startTimeDate = dateFormatter.date(from: startTime),
              let endTimeDate = dateFormatter.date(from: endTime) else {
            return 0
        }
        
        if startTimeDate > endTimeDate {
            let calendar = Calendar.current
            if let nextDayEndTime = calendar.date(byAdding: .day, value: 1, to: endTimeDate) {
                let timeDifference = nextDayEndTime.timeIntervalSince(startTimeDate) / 3600.0
                return timeDifference
            }
        } else {
            let timeDifference = endTimeDate.timeIntervalSince(startTimeDate) / 3600.0
            return timeDifference
        }
        return 0
    }
    
}

extension Date {
    enum WeekDay: Int {
        case sunday = 1
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        
        var weekDayDisplay: String {
            switch self {
            case .sunday:
                return "Sunday"
            case .monday:
                return "Monday"
            case .tuesday:
                return "Tuesday"
            case .wednesday:
                return "Wednesday"
            case .thursday:
                return "Thursday"
            case .friday:
                return "Friday"
            case .saturday:
                return "Saturday"
            }
        }
    }
    
    func getWeekDay() -> WeekDay {
        let calendar = Calendar.current
        let weekDay = calendar.component(Calendar.Component.weekday, from: self)
        return WeekDay(rawValue: weekDay)!
    }
    
    func toStringInUnitedStates(toFormat dateFormat: String) -> String {
        let formatter = DateFormatter.unitedStatesDateFormatter
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
}

extension Date {
    static func compareDateString(firstCompareDate: String,
                                  secondCompareDate: String,
                                  format: DateTimeFormatType,
                                  isSameDate: Bool = false) -> Bool {
        let timeFormatter = DateFormatter.unitedStatesDateFormatter(dateFormat: format.rawValue)
        guard let startTime = timeFormatter.date(from: firstCompareDate), let finishTime = timeFormatter.date(from: secondCompareDate) else {
            return false
        }
        if isSameDate {
            return startTime >= finishTime
        }
        return startTime > finishTime
    }
    
    static func processTimeOvernight(firstCompareDate: String,
                                     secondCompareDate: String,
                                     isOvernightShift: Bool) -> (Bool, String) {
        let isTimeAfter = Date.compareDateString(firstCompareDate: firstCompareDate,
                                                 secondCompareDate: secondCompareDate,
                                                 format: .hourAmPm)
        var overnightShiftLabel = ""
        var isStartTimeMoreThan = true
        
        if isTimeAfter {
            isStartTimeMoreThan = false
            overnightShiftLabel = isOvernightShift ? "(+2)" : "(+1)"
        } else if isOvernightShift {
            isStartTimeMoreThan = false
            overnightShiftLabel = ""
        }
        return (isStartTimeMoreThan, overnightShiftLabel)
    }
}

extension Date {
    static func combine(date: Date, time: Date) -> Date? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day, .month, .year], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
        
        var newComponents = DateComponents()
        newComponents.timeZone = .current
        newComponents.day = dateComponents.day
        newComponents.month = dateComponents.month
        newComponents.year = dateComponents.year
        newComponents.hour = timeComponents.hour
        newComponents.minute = timeComponents.minute
        newComponents.second = timeComponents.second
        
        return calendar.date(from: newComponents)
    }
    
    func addingMinutes(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self) ?? self
    }
}
