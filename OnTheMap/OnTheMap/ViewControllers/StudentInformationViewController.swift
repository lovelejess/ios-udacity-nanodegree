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

    @IBOutlet weak var tableView: UITableView!

    var viewModel: StudentInformationViewModel?
    var coordinator: StudentInformationCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
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

        cell.textLabel?.text = student
        cell.detailTextLabel?.text = student

        return cell
    }
}

class StudentInformationViewModel {

    var students: [String] = ["Student"]
}

