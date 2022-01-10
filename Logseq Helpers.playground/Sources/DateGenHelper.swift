import Foundation

extension Date {
    var firstWeekday: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
}

public struct DateGenHelper {
    public static func weekly(className: String) -> String  {
        var startDateComponents = DateComponents()
        startDateComponents.year = 2022
        startDateComponents.month = 01
        startDateComponents.day = 10
        startDateComponents.timeZone = TimeZone(abbreviation: "PST")

        var recessWeekDateComponents = DateComponents()
        recessWeekDateComponents.year = 2022
        recessWeekDateComponents.month = 03
        recessWeekDateComponents.day = 14
        recessWeekDateComponents.timeZone = TimeZone(abbreviation: "PST")

        let userCal = Calendar(identifier: .gregorian)
        let startDate = userCal.date(from: startDateComponents)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"

        var outputStr = ""
        for i in 0...14 {
            let recessWeekDate = userCal.date(from: recessWeekDateComponents)!
            
            if let dateToAppend = userCal.date(byAdding: .weekOfYear, value: i, to: startDate) {
                if (dateToAppend >= recessWeekDate) {
                    let newDateToAppend = userCal.date(byAdding: .weekOfYear, value: i + 1, to: startDate)!
                    let dateFormatted = dateFormatter.string(from: newDateToAppend)
                    let stringToAppend = "- \(dateFormatted) \(className)_W\(i+1) #Sp2022-w\(i+1)\n"
                    outputStr.append(stringToAppend)
                } else {
                    let dateFormatted = dateFormatter.string(from: dateToAppend)
                    let stringToAppend = "- \(dateFormatted) \(className)_W\(i+1) #Sp2022-w\(i+1)\n"
                    outputStr.append(stringToAppend)
                }
            }
        }
        
        return outputStr
    }
    
    public static func daily() -> String {
        let firstDayOfWeek = Date().firstWeekday!
        let userCal = Calendar(identifier: .gregorian)
        
        let dayDateFormatter = DateFormatter()
        dayDateFormatter.dateFormat = "EEEE"
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMMM"
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        let dayFormatter = NumberFormatter()
        dayFormatter.numberStyle = .ordinal
        
        var outputStr = ""
        for i in 0...6 {
            let dayToParse = userCal.date(byAdding: .day, value: i, to: firstDayOfWeek)!
            
            let dayString = dayDateFormatter.string(from: dayToParse)
            let monthString = monthFormatter.string(from: dayToParse)
            let yearString = yearFormatter.string(from: dayToParse)
            let day = dayFormatter.string(from: userCal.component(.day, from: dayToParse) as NSNumber)!

            outputStr.append("- \(dayString) - [[\(monthString) \(day), \(yearString)]]\n")
        }
        
        return outputStr
    }
    
}
