//
//  StudentInformationViewModel.swift
//  OnTheMap
//
//  Created by Jess Le on 3/29/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation

class StudentInformationViewModel {

    var delegate: StudentInformationDelegate?

    var students = [StudentInformation]() {
        didSet {
            if students.isEmpty {
                delegate?.displayError()
            }
            delegate?.reloadTableView()
        }
    }

    func getStudentData() {
        UdacityClient.getStudentsLocationByOrder(for: "-updatedAt") { (students, error) in
            if let _ = error {
                self.students = []
            } else {
                self.students = students
            }
        }
    }
}
