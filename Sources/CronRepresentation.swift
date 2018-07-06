//
//  CronRepresentation.swift
//  SwiftCron
//
//  Created by Keegan Rush on 2016/05/06.
//  Copyright © 2016 Rush42. All rights reserved.
//

import Foundation

enum CronField: Int {
	case minute, hour, day, month, weekday
	private static let fieldCheckers: Array<FieldCheckerInterface> = [MinutesField(), HoursField(), DayOfMonthField(), MonthField(), DayOfWeekField()]

	func getFieldChecker() -> FieldCheckerInterface {
		return CronField.fieldCheckers[rawValue]
	}
}

public struct CronRepresentation {
	static let NumberOfComponentsInValidString = 5
	public static let DefaultValue = "*"
	static let StepIdentifier = "/"
	static let ListIdentifier = ","
    static let RangeIdentifier = "-"

	var weekday: String
	var month: String
	var day: String
	var hour: String
	var minute: String

	var biggestField: CronField? {
		let defaultValue = CronRepresentation.DefaultValue

        if weekday != defaultValue { return CronField.weekday }
		if month != defaultValue { return CronField.month }
		if day != defaultValue { return CronField.day }
		if hour != defaultValue { return CronField.hour }
		if minute != defaultValue { return CronField.minute }
		return nil
	}

	// MARK: Issue 3: Get rid of. Should rather be using the enum
	subscript(index: Int) -> String {
		return cronParts[index]
	}

	init(minute: String = CronRepresentation.DefaultValue, hour: String = CronRepresentation.DefaultValue, day: String = CronRepresentation.DefaultValue, month: String = CronRepresentation.DefaultValue, weekday: String = CronRepresentation.DefaultValue) {
		self.minute = minute
		self.hour = hour
		self.day = day
		self.month = month
		self.weekday = weekday

		cronParts = [minute, hour, day, month, weekday]
		cronString = "\(minute) \(hour) \(day) \(month) \(weekday)"
	}

	init?(cronString: String) {
		let parts = cronString.components(separatedBy: " ")
		guard parts.count == CronRepresentation.NumberOfComponentsInValidString else {
			return nil
		}

		self.init(minute: parts[0], hour: parts[1], day: parts[2], month: parts[3], weekday: parts[4])
	}

	// MARK: Issue 3: pass in enum. Get value out of enum and check if it matches the default value?
	static func isDefault(_ field: String) -> Bool {
		return field == CronRepresentation.DefaultValue
	}

	public var cronString: String

	public var cronParts: Array<String>
}
