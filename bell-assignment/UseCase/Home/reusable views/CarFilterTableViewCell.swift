//
//  CarFilterTableViewCell.swift
//  bell-assignment
//
//  Created by Nithaparan Francis on 2022-12-03.
//

import UIKit

protocol CarFilterTableViewCellDelegate: AnyObject {
    func didMakeButtonClicked() -> Void
    func didModelButtonClicked() -> Void
}

class CarFilterTableViewCell: UITableViewCell {

    weak var delegate: CarFilterTableViewCellDelegate?
    
    var selectedMake: String? {
        didSet {
            self.carMakeLabel.text = selectedMake != nil ? selectedMake : "Any make"
        }
    }
    
    var selectedModel: String? {
        didSet {
            self.carModelLabel.text = selectedModel != nil ? selectedModel : "Any model"
        }
    }
  
    
    @IBOutlet weak var carMakeLabel: UILabel!
    
    @IBOutlet weak var carModelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func makeButtonClicked(_ sender: Any) {
        self.delegate?.didMakeButtonClicked()
    }
    
    @IBAction func modelButtonclicked(_ sender: Any) {
        self.delegate?.didModelButtonClicked()
    }
}
