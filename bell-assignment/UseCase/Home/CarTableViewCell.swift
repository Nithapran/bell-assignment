//
//  CarTableViewCell.swift
//  bell-assignment
//
//  Created by Nithaparan Francis on 2022-12-02.
//

import UIKit

class CarTableViewCell: UITableViewCell {


    @IBOutlet weak var topViewBottomContraint: NSLayoutConstraint!
    @IBOutlet weak var carRatingStackView: UIStackView!
    @IBOutlet weak var carConsStackView: UIStackView!
    @IBOutlet weak var carProsStackView: UIStackView!
    @IBOutlet weak var carPriceLabel: UILabel!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    
    var car: Car? {
        didSet {
            setUpView(car: car)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpView(car: Car?) {
        self.carNameLabel.text = car?.model
        self.carPriceLabel.text = car?.getPriceInKFormat()
        self.carImageView.image = UIImage(named: car?.image ?? "")
        carRatingStackView.subviews.forEach { (view) in view.removeFromSuperview() } // remove stackview caches
        
        // append stars as UIImageView to stackView according to the rating
        for _ in 1...(car?.rating ?? 0) {
            let star = UIImageView(image: UIImage(systemName: "star.fill"))
            self.carRatingStackView.addArrangedSubview(star)
        }
    }
    
}
