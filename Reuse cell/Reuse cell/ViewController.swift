//
//  ViewController.swift
//  Reuse cell
//
//  Created by AnhTT on 8/11/20.
//  Copyright © 2020 AnhTT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listHero: [HeroStats] = []
    var image2 =  UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadApi()
        // Do any additional setup after loading the view.
    }
    func loadApi() {
        DataService.sharing.getData { (data) in
            self.listHero = data
            self.tableView.reloadData()
        }
    }

    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 350
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listHero.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = listHero[indexPath.row].name
        cell.imageName.tag = indexPath.row
            let images = listHero[indexPath.row].img
            let defauLink = "https://api.opendota.com"
            let updateLink = defauLink + images
            cell.imageName?.downloaded(from: updateLink)
            cell.imageName?.clipsToBounds = true
            cell.imageName?.layer.cornerRadius = (cell.imageView?.frame.height)! / 2
            cell.imageName?.contentMode = .scaleAspectFill
        return cell
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

