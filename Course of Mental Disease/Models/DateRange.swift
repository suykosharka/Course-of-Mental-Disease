//
//  DateRange.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 19.04.2025.
//

import Foundation

enum DateRangeType: String, Identifiable, CaseIterable {
    case today = "Сегодня"
    case yesterday = "Вчера"
    case twoWeeks = "Последние 14 дней"
    case customRange = "Выбрать период"

    var id: Self { self }

    func getDateRange(startDate: Date = Date(), endDate: Date = Date()) -> (Date, Date) {
        switch self {
        case .today:
            return (Date(), Date())
        case .yesterday:
            let yesterday = Date(timeIntervalSinceNow: -86400)
            return (yesterday, yesterday)
        case .twoWeeks:
            return (Date(timeIntervalSinceNow: -1209600), Date())
        case .customRange:
            return (startDate, endDate)
        }
    }
}
