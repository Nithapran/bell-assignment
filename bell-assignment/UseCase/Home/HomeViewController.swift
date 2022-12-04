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
    
    var viewModel: HomeViewModel = HomeViewModel(repository: CarDataRepository(remoteDataSource: CarRemoteService(), localDataSource: CarLocalService()))

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        Task.init {
            await self.viewModel.getAllCars()
        }
        
    }
    
    private func setUpView() {
        let navBarTitleView = UILabel()
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "GillSans-UltraBold", size: 20) ]
        let myAttrString = NSAttributedString(string: "Guidomia", attributes: myAttribute as [NSAttributedString.Key : Any])
        navBarTitleView.attributedText = myAttrString
        
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        menuButton.contentMode = .center
        let menuImage = UIImage(named: "humburgerButton")?.withRenderingMode(.alwaysTemplate)
        
        menuButton.setImage(menuImage, for: .normal)
        menuButton.tintColor = .white
        let rightBarButton = UIBarButtonItem(customView: menuButton)
        setUpNavigationBar(isHidden: false, titleView: navBarTitleView, rightBarButton: rightBarButton)
        setUpTableViewView()
        self.viewModel.didFetchCar = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setUpTableViewView() {
        self.tableView.rowHeight = UITableView.automaticDimension;
        self.tableView.estimatedRowHeight = 87.0
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "CarTableViewCell", bundle: nil), forCellReuseIdentifier: "CarTableViewCell")
        tableView.register(UINib(nibName: "TopAdTableViewCell", bundle: nil), forCellReuseIdentifier: "TopAdTableViewCell")
        tableView.register(UINib(nibName: "CarFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "CarFilterTableViewCell")
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
            return self.viewModel.presentableCars.count
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "CarFilterTableViewCell", for: indexPath) as! CarFilterTableViewCell
            cell.selectedMake = viewModel.selectedMake
            cell.selectedModel = viewModel.selectedModel
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as! CarTableViewCell
            
            if indexPath == selectedCell {
                cell.isExpanded = true
            } else {
                cell.isExpanded = false
            }
            cell.car = viewModel.presentableCars[indexPath.row]
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
            return UITableView.automaticDimension
        case 2:
            return UITableView.automaticDimension
        default:
            return 0
        }
        
    }
}

extension HomeViewController: CarFilterTableViewCellDelegate {
    func didMakeButtonClicked() {
        let picker = FiltersPickerView(frame: self.view.frame)
        picker.didItemSelected = { [weak self] (make) in
            self?.viewModel.didSelectMake(make: make)
            self?.tableView.reloadData()
        }

        picker.data = self.viewModel.getMakes()
        self.view.addSubview(picker)
    }
    
    func didModelButtonClicked() {
        let picker = FiltersPickerView(frame: self.view.frame)
        picker.didItemSelected = { [weak self] (model) in
            self?.viewModel.didSelectModel(model: model)
            self?.tableView.reloadData()
        }

        picker.data = self.viewModel.getModels()
        self.view.addSubview(picker)
    }
    
    
}


