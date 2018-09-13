//
//  HeaderView.swift
//  19900926-Vishnupriya-NYCSchools
//
//  Created by Vishnupriya on 9/12/18.
//  Copyright © 2018 Sonar. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate {
    
    func headerView(_ header: HeaderView?, didExpand expand: Bool, school: String?)

}

class HeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnArrow: UIButton!
    var isExpanded = false
    var delegate : HeaderViewDelegate?
    var title :String? {
        didSet {
            if let titl = title {
                lblTitle.text = titl
            }
        }
    }
    
    @IBAction func didTapHeader(_ sender: UIButton) {
         btnArrow.isSelected = !btnArrow.isSelected
            isExpanded = !isExpanded
        if let del = delegate , let tit = title {
            del.headerView(self, didExpand: btnArrow.isSelected, school: tit)
        }
    }
    
}
