//
//  HelperModel.swift
//  TrumpetAlert
//
//  Created by reza wanted on 9/19/1400 AP.
//

import Foundation
import SwiftyJSON


extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}


typealias UnixTime = Int
extension UnixTime {
    private func formatType(form: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = form
        return dateFormatter
    }
    var dateFull: Date {
        return Date(timeIntervalSince1970: Double(self)/1000)
    }
    var toHour: String {
        return formatType(form: "HH:mm").string(from: dateFull)
    }
    var toDay: String {
        return formatType(form: "yyyy/MM/dd HH:mm").string(from: dateFull)
    }
}



public func saveJSON(json: JSON, key:String){
  if let jsonString = json.rawString() {
     UserDefaults.standard.setValue(jsonString, forKey: key)
  }
}

public func getJSON(_ key: String)-> JSON? {
   var p = ""
   if let result = UserDefaults.standard.string(forKey: key) {
       p = result
   }
   if p != "" {
       if let json = p.data(using: String.Encoding.utf8, allowLossyConversion: false) {
           do {
               return try JSON(data: json)
           } catch {
               return nil
           }
       } else {
           return nil
       }
   } else {
       return nil
   }
}
