//
//  BookMark.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/31.
//

import Foundation

struct BookMark: Identifiable {
    let id = UUID()
    let bookMarkName: String
    let bookMarkAddress: (Double, Double)
    let bookMarkImage: String
    let bookMarkPurpose: String
}

let bookMarkList: [BookMark] = [
    BookMark(bookMarkName: "집", bookMarkAddress: (37.61651567349778, 127.07319238859908), bookMarkImage: "Home", bookMarkPurpose: "출퇴근"),
    BookMark(bookMarkName: "회사", bookMarkAddress: (37.52533442680478, 126.89604683044774), bookMarkImage: "WorkPlace", bookMarkPurpose: "출퇴근"),
    BookMark(bookMarkName: "거래처1", bookMarkAddress: (37.50281431321005, 127.22848337934188), bookMarkImage: "partner1", bookMarkPurpose: "출장"),
    BookMark(bookMarkName: "거래처2", bookMarkAddress: (37.61651567349778, 127.07319238859908), bookMarkImage: "partner2", bookMarkPurpose: "출장"),
    BookMark(bookMarkName: "거래처3", bookMarkAddress: (37.61651567349778, 127.07319238859908), bookMarkImage: "partner3", bookMarkPurpose: "출장")
]

