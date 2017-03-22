//
//  String.swift
//  PopularNames
//
//  Created by Caio Cezar Lopes dos Santos on 3/19/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit

extension String {
    var dateFromISO8601: Date? {
        return Date.iso8601Formatter.date(from: self)
    }
    
    var date: Date? {
        return Date.defaultFormatter.date(from: self)
    }
}
