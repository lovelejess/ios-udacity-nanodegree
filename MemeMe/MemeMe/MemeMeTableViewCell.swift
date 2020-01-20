//
//  MemeMeTableViewCell.swift
//  MemeMe
//
//  Created by Jess Le on 1/19/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit

class MemeMeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var bottomText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        initializeStyles()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initializeStyles()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeStyles()
    }
    
    func initializeStyles() {
        self.memeImage?.contentMode = .scaleAspectFit
    }

}
