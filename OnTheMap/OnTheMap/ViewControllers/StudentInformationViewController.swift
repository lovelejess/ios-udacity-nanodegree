//
//  StudentInformationViewController.swift
//  OnTheMap
//
//  Created by Jess Le on 3/15/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit

class StudentInformationViewController: UIViewController {
    let cellReuseIdentifier = "StudentInfoCell"

    @IBAction func onLogoutButtonPressed(_ sender: Any) {
        coordinator?.navigate(to: .logout)
    }
    
    @IBAction func onAddPinButtonPressed(_ sender: Any) {
        coordinator?.navigate(to: .addPin)
    }
    
    @IBAction func onRefreshButtonPressed(_ sender: Any) {
        viewModel?.getStudentData()
    }
    
    @IBOutlet weak var tableView: UITableView!

    var viewModel: StudentInformationViewModel?
    var coordinator: StudentInformationCoordinator?
    weak var delegate: StudentInformationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel?.getStudentData()
    }
}

extension StudentInformationViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let students = viewModel?.students else { return 0 }
        return students.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let students = viewModel?.students else { return UITableViewCell() }
        let cell =  tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier)!

        let student = students[(indexPath as NSIndexPath).row]

        cell.textLabel?.text = student.firstName + " " + student.lastName
        cell.detailTextLabel?.text = student.mediaURL

        return cell
    }
}

extension StudentInformationViewController: StudentInformationDelegate {
    func reloadTableView() {
        self.tableView.reloadData()
    }
}

class StudentInformationViewModel {
    
    var delegate: StudentInformationDelegate?

    var students = [Student]() {
        didSet {
            delegate?.reloadTableView()
        }
    }

    func getStudentData() {
        UdacityClient.getStudentsLocationByOrder(for: "-updatedAt") { (students, error) in
            self.students = students
        }
    }
}

protocol StudentInformationDelegate: class {
    func reloadTableView()
}
