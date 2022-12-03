//
//  HomeViewController.swift
//  bell-assignment
//
//  Created by Nithaparan Francis on 2022-12-02.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedCell: IndexPath = IndexPath(row: 0, section: 2)
    
    var viewModel: HomeViewModel = HomeViewModel(service: CarServiceImplementation())

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        self.viewModel.getAllCars()
    }
    
    private func setUpView() {
        self.tableView.rowHeight = UITableView.automaticDimension;
        self.tableView.estimatedRowHeight = 87.0
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "CarTableViewCell", bundle: nil), forCellReuseIdentifier: "CarTableViewCell")
        tableView.register(UINib(nibName: "TopAdTableViewCell", bundle: nil), forCellReuseIdentifier: "TopAdTableViewCell")
        
        self.viewModel.didFetchCar = { [weak self] in
            self?.tableView.reloadData()
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return self.viewModel.cars.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopAdTableViewCell", for: indexPath) as! TopAdTableViewCell
            return cell
        case 1:
            return UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as! CarTableViewCell
            if indexPath == selectedCell {
                cell.bottomViewHightContraint.priority = .defaultLow
            } else {
                
                cell.bottomViewHightContraint.constant = 0
                cell.bottomViewHightContraint.priority = .required
            }
            cell.car = viewModel.cars[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedCell != indexPath && indexPath.section == 2 {
            selectedCell = indexPath
            self.tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 196
        case 1:
            return 0
        case 2:
            return UITableView.automaticDimension
        default:
            return 0
        }
        
    }
    
}

