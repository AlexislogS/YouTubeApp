//
//  Date+.swift
//  YouTubeApp
//
//  Created by Alex Yatsenko on 30.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import Foundation

extension Date {
    func toString(format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
}
