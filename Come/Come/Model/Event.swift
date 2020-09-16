//
//  Event.swift
//  Come
//
//  Created by Eduardo Souza on 14/09/20.
//  Copyright © 2020 Eduardo Tarallo Souza. All rights reserved.
//

import Foundation

struct Event: Codable {
    var date: String = ""
    var description: String = ""
    var image: String = ""
    var longitude: String = ""
    var latitude: String = ""
    var price: Double = 0.0
    var title: String = ""
    var id: String = ""

    init() {}

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let idEvent = try? container.decode(String.self, forKey: .id) {
            self.id = idEvent
        }

        if let eventTitle = try? container.decode(String.self, forKey: .title) {
            self.title = eventTitle
        }

        if let eventDate = try? container.decode(Double.self, forKey: .date) {
            self.date = getDateFromTimeStamp(timeStamp: eventDate)
        }

        if let eventDesc = try? container.decode(String.self, forKey: .description) {
            self.description = eventDesc
        }

        if let eventImage = try? container.decode(String.self, forKey: .image) {
            self.image = eventImage
        }

        if let lat = try? container.decode(String.self, forKey: .latitude) {
            self.latitude = lat
        } else if let lat = try? container.decode(Double.self, forKey: .latitude) {
            self.latitude = "\(lat)"
        }

        if let long = try? container.decode(String.self, forKey: .longitude) {
            self.longitude = long
        } else if let long = try? container.decode(Double.self, forKey: .longitude) {
            self.longitude = "\(long)"
        }

        if let eventPrice = try? container.decode(Double.self, forKey: .price) {
            self.price = eventPrice
        }

    }

    func getDateFromTimeStamp(timeStamp : Double) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM/YY  HH:mm"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }

}
