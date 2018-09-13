//
//  SchoolDetailCell.swift
//  19900926-Vishnupriya-NYCSchools
//
//  Created by Vishnupriya on 9/12/18.
//  Copyright © 2018 Sonar. All rights reserved.
//

import UIKit

class SchoolDetailCell: UITableViewCell {

 
    @IBOutlet weak var lblReading: UILabel!
    @IBOutlet weak var lblMath: UILabel!
    @IBOutlet weak var lblWriting: UILabel!

    var detail :SchoolDetail? {
        didSet {
            if let write = detail?.satWritingAvgScore {
                lblWriting.text = write

            }
            if let read = detail?.satCriticalReadingAvgScore {
                lblReading.text = read

            }
            if let math = detail?.satMathAvgScore {
                lblMath.text = math
            }
        }
    }
}
