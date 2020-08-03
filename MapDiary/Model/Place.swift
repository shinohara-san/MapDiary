//
//  Place.swift
//  MapDiary
//
//  Created by Yuki Shinohara on 2020/08/03.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Foundation
import RealmSwift

class Place: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var lat = 0
    @objc dynamic var lon = 0
    @objc dynamic var diary = ""
    @objc dynamic var date = ""
    
    override static func primaryKey() -> String? {
      return "id"
    }
}
