//
//  ForecastDetailsVC.swift
//  Forecastr
//
//  Created by Evan Butler on 5/28/21.
//

import UIKit

class ForecastListVC: UIViewController {

    let tableView = UITableView()
    var forecastDays: [ForecastDay] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }

    init(forecastDays: [ForecastDay]) {
        super.init(nibName: nil, bundle: nil)
        self.forecastDays = forecastDays
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "3 Day Forecast"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureTableView() {
        view.addSubview(tableView)

        tableView.frame = view.bounds
        tableView.rowHeight = 120

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(DayCell.self, forCellReuseIdentifier: DayCell.reuseID)
    }

}

extension ForecastListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastDays.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DayCell.reuseID) as! DayCell
        let forecastDay = forecastDays[indexPath.row]
        cell.set(forecastDay: forecastDay)

        return cell
    }


}
