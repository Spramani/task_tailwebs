//
//  TableViewCell.swift
//  task_Tailwebs
//
//  Created by Shubham Ramani on 15/03/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(date:String,day:String,cellData:data){
        dateLabel.text = date
        dayLabel.text = day
        timeLabel.text = cellData.time
        totalTimeLabel.text = cellData.totalTime
        amountLabel.text = cellData.amount
    }
    
}
