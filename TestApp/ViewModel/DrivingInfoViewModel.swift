//
//  DrivingInfoViewModel.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/30.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class DrivingInfoViewModel: ObservableObject {
    
    @AppStorage("carReg") var carReg: String = ""
    @Published var drivingInfos: [DrivingInfo] = []
    @Published var allDrivingInfos: [DrivingInfo] = []
    @Published var recentRef: String = ""
    @Published var isSaved: Bool = false
    @Published var ownerName: String = ""
    
    func getOwnerName(carNum: String) async {
        let documents = Firestore.firestore().collection("Users").document(carNum)
        await documents.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                
                // 필드 값 불러오기
                if let fieldValue = data?["ownerName"] as? String {
                    self.ownerName = fieldValue
                }
            } else {
                print("Document does not exist")
            }
        }
        
    }
    
    func saveStartDrivingInfo(id: String, drivingInfo: DrivingInfo) async {
        let documents = Firestore.firestore().collection("Users").document(carReg).collection("DrivingInfo")
        await documents.document(id)
            .setData(drivingInfo.dictionary) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Success")
                }
            }
    }
    
    func updateRecentDrivingInfo(_ updatedField:[String:Any]) async {
        let documents = Firestore.firestore().collection("Users").document(carReg).collection("DrivingInfo").document(recentRef)
        await documents.setData(updatedField, merge: true) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success")
            }
        }
    }
    
    func updateDrivingInfo(_ drivingInfo: DrivingInfo, _ updatedField:[String:Any]) async {
        let documents = Firestore.firestore().collection("Users").document(carReg).collection("DrivingInfo").document(drivingInfo.id)
        await documents.setData(updatedField, merge: true) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success")
                self.isSaved = true
            }
        }
    }
    
    //전체데이터 받아오겠다고 한 거
    func updateDrivingInfoData() {
        let documentRef = Firestore.firestore().collection("Users").document(carReg).collection("DrivingInfo")
        
        documentRef.addSnapshotListener { (snapshot, error) in
            if let error = error {
                print("Error fetching driving info: \(error.localizedDescription)")
                return
            }
            guard let documents = snapshot?.documents else {
                print("스냅샷 Nil")
                return
            }
            self.allDrivingInfos = []
            
            documents.forEach { content in
                do {
                    var drivingInfo = try Firestore.Decoder().decode(DrivingInfo.self, from: content.data())
                    self.allDrivingInfos.append(drivingInfo)
                    
                } catch {
                    print("저장 실패")
                }
            }
        }
    }
    
    //운행내역에서 사용되는 년도별 월별 fetch함수
    func fetchDrivingInfos(targetYear: String, targetMonth: String) async {
        let documentRef = Firestore.firestore().collection("Users").document(carReg).collection("DrivingInfo")
        
        documentRef.addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("스냅샷 Nil")
                return
            }
            
            self.drivingInfos = []
            documents.forEach { content in
                do {
                    var drivingInfo = try Firestore.Decoder().decode(DrivingInfo.self, from: content.data())
                    
                    // 여기서 date를 분리하여 년도와 월을 추출
                    let dateComponents = drivingInfo.date.split(separator: ".")
                    if dateComponents.count >= 2 {
                        let year = String(dateComponents[0])
                        if let monthInt = Int(dateComponents[1]) { // Int로 변환
                            let month = String(monthInt) // 다시 String으로 변환
                            
                            // 년도와 월이 일치하는지 확인
                            if year == targetYear && month == targetMonth {
                                self.drivingInfos.append(drivingInfo)
                            }
                        }
                    }
                    
                } catch {
                    print("저장 실패")
                }
            }
        }
    }
}
