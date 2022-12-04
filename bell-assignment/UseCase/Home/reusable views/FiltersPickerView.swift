//
//  FiltersPickerView.swift
//  bell-assignment
//
//  Created by Nithaparan Francis on 2022-12-03.
//

import Foundation
import UIKit



final class FiltersPickerView: UIView {
    @IBOutlet weak var pickerView: UIPickerView!
    
    var data: [String] = []
    
    var didItemSelected: ((_ item: String?) -> Void)?
    
    let nibName = "FiltersPickerView"
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
    
        override func prepareForInterfaceBuilder() {
            super.prepareForInterfaceBuilder()
            commonInit()
        }
        
        func commonInit() {
            guard let view = loadViewFromNib() else { return }
            view.frame = self.bounds
            self.addSubview(view)
            pickerView.delegate = self
            pickerView.dataSource = self
        }
    
    override func draw(_ rect: CGRect) {
        
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
        
        func loadViewFromNib() -> UIView? {
            let bundle = Bundle(for: ProsConsView.self)
            let nib = UINib(nibName: nibName, bundle: bundle)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        self.removeFromSuperview()
        self.didItemSelected?(self.data[self.pickerView.selectedRow(inComponent: 0)])
    }
    
    
    @IBAction func clearButtonclicked(_ sender: Any) {
        self.removeFromSuperview()
        self.didItemSelected?(nil)
    }
}

extension FiltersPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.data[row]
    }
    
}
