//
//  CurrenciesListCellTableViewCell.swift
//  iOS Giovane Barreira
//
//  Created by Giovane Barreira on 10/4/20.
//

import UIKit

class CurrenciesListCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTitleLbl: UILabel!
    @IBOutlet weak var cellSubtitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
