//
//  MemeMeTableViewController.swift
//  MemeMe
//
//  Created by Jess Le on 1/19/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit

class MemeMeTableViewController: UITableViewController {

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    private let reuseIdentifier = "MemeMeCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.register(MemeMeTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.tableView.rowHeight = 200
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meme = memes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeMeTableViewCell", for: indexPath) as! MemeMeTableViewCell
        cell.memeImage?.image = meme.memedImage
        cell.topText?.text = meme.topText + " " + meme.bottomText
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = MemeMeDetailsViewController()
        viewController.memeImageView.image = memes[indexPath.row].memedImage
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
