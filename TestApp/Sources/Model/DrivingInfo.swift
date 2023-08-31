//
//  DrivingInfo.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

import Foundation

struct DrivingInfo: Identifiable, Codable {
    let id: String
    let date: String
    var purpose: String
    let totalDistance: Int
    let startAddress: String
    let startTime: String
    let endAddress: String
    let endTime: String
    let fuelFee: Int
    let tollFee: Int
    let depreciation: Int
    var dictionary: [String:Any] {
        return ["id": id,
                "date": date,
                "purpose": purpose,
                "totalDistance": totalDistance,
                "startAddress": startAddress,
                "startTime": startTime,
                "endAddress": endAddress,
                "endTime": endTime,
                "tollFee": tollFee,
                "fuelFee": fuelFee,
                "depreciation": depreciation]
    }
    func calculateTime(_ date: Date) -> String {
        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_KR")
        format.dateFormat = "hh:mm"
        return format.string(from: date)
    }
}
