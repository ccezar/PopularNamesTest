//
//  Person.swift
//  PopularNames
//
//  Created by Caio Cezar Lopes dos Santos on 3/19/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit

public class Person: NSObject {
    private(set) var id: String?
    private(set) var name: String?
    private(set) var photo: String?
    private(set) var birthday: Date?
    private(set) var bio: String?
    
    init(element: [String: Any]) {
        self.id = element["id"] as? String ?? nil
        self.name = element["name"] as? String ?? nil
        self.photo = element["image"] as? String ?? nil
        self.bio = element["bio"] as? String ?? nil
        
        if let birthday = element["birthday"] as? String {
            self.birthday = birthday.dateFromISO8601
        }
    }
    
    public func birthdayFormatted() -> String? {
        guard let _ = birthday else { return nil }
        return birthday!.defaultFormat
    }
}
