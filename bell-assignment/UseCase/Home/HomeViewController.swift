//
//  HomeViewController.swift
//  bell-assignment
//
//  Created by Nithaparan Francis on 2022-12-02.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
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
        
        self.viewModel.didFetchCar = { [weak self] in
            self?.tableView.reloadData()
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as! CarTableViewCell
        cell.car = viewModel.cars[indexPath.row]
        return cell
    }
    
    
    
    
}

