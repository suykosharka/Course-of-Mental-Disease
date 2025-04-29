//
//  Extensions.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 09.11.2023.
//

import Foundation
import SwiftUI

extension Encodable {
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}

import SwiftUI

extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}

extension String {
    func formattedDateString() -> String {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd"
            inputFormatter.locale = Locale(identifier: "en_US_POSIX")

            guard let date = inputFormatter.date(from: self) else { return self }

            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd.MM.yyyy"
            return outputFormatter.string(from: date)
        }
    }
