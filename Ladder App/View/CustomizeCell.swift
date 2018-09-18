//
//  CustomizeCell.swift
//  Ladder App
//
//  Created by Andrew Istoc on 18/09/2018.
//  Copyright © 2018 Andrew Istoc. All rights reserved.
//

import Foundation
import UIKit

class CustomizeCell: UITableViewCell {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    let bgColor = UIColor(cgColor: #colorLiteral(red: 0.1507248515, green: 0.5513415491, blue: 0.8203208981, alpha: 0.8062392979))
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        self.selectedBackgroundView?.backgroundColor = bgColor
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.selectedBackgroundView?.backgroundColor = bgColor
    }
}
