//
//  DateTimeFormatType.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 18/11/24.
//

import Foundation

enum DateTimeFormatType: String {
    case `default` = "YYYY-MM-dd"
    case publicationText = "hh:mma, dd MMM YYYY"
    case medium = "dd MMM YYYY"
    case shortenMedium = "d MMM YYYY"
    case hourAndMinute = "hh:mma"
    case time = "HH:mm:ss"
    case fullDate = "EEE dd MMM"
    case fullDateWithFullMonthFormat = "EEE dd MMMM"
    case fullDateAndYear = "EEE dd MMM YYYY"
    case weekDayDate = "E dd/MM/yyyy"
    case fullDateTime = "dd MMM YYYY hh:mm a"
    case fullDateTime24hWithSlash = "dd/MM/YYYY HH:mm"
    case fullDateTime24h = "dd MMM YYYY HH:mm"
    case date = "dd MMMM YYYY"
    case leaveTime = "HH:mm"
    case shortenLeaveTime = "H:mm"
    case hourAmPm = "hh:mm a"
    case normalDate = "dd/MM/YYYY"
    case normalTime = "h:mm a"
    case timeZ = "HH:mm:ssZ"
    case timeGlobal = "HH:mm:ss.SSSZ"
    case timeISO = "yyyy-MM-dd'T'HH:mm:ssZ"
    case dateTimeISOWithFractionalSeconds = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case dateTimePattern = "dd MMM yyyy - h:mm a"
    case dateTimeISOWithoutFractionalSeconds = "yyyy-MM-dd'T'HH:mm:ss"
    case fullDateAndYear2 = "E, dd MMM YYYY"
    case ativityDate = "dd-MM-yyyy"
    case weekdayNameStandaloneShort = "EEE"
    case dayOnly = "dd"
    case dateAndTime = "YYYY-MM-dd,HH:mm"
    case dateAndTimeNew = "dd-MM-YYYY HH:mm"
    case dateAndMonth = "dd MMM"
    case dateMonth = "dd-MMM"
    case dateAndTimeWithSeparator = "dd MMM YYYY | hh:mm a"
    case dateTimeSlashWithSeparator = "YYYY/MM/dd | hh:mm a"
    case monthAndYear = "MMM yyyy"
}
