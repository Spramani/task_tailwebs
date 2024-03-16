//
//  CalenderDateCVC.swift
//  task_Tailwebs
//
//  Created by Shubham Ramani on 15/03/24.
//

import UIKit

class CalenderDateCVC: UICollectionViewCell {

    @IBOutlet weak var lbl_date: UILabel!{
        didSet{
            lbl_date.layer.cornerRadius = lbl_date.layer.bounds.height/2
            lbl_date.layer.masksToBounds = true

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
