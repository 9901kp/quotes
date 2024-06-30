//
//  ViewController.swift
//  quotes
//
//  Created by Мухаммед Каипов on 17/6/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var quotes: [String] = []
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: quoteTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: quoteTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        view.addSubview(activityIndicator)
        fetchData()
    }
    
    @objc
    func refreshData(){
        quotes.removeAll()
        fetchData()
        tableView.refreshControl?.endRefreshing()
    }

    func fetchData(){
        var quoteCount = 20
        var fetchedQuotes = 0
        
        while quoteCount > 0{
            let url = URL(string: "https://api.kanye.rest")!
            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error!: \(error.localizedDescription)")
                }
                guard let data = data else { return }
                
                do{
                    let decode = try JSONDecoder().decode(Kanye.self,from: data)
                    DispatchQueue.main.async{
                        self.quotes.append(decode.quote)
                        fetchedQuotes += 1
                        
                        if fetchedQuotes == 10{
                            self.activityIndicator.stopAnimating()
                            self.tableView.reloadData()
                        }
                    }
                }catch let error{
                    print(error)
                }
            }
            dataTask.resume()
            quoteCount -= 1
        }
    }
}



extension ViewController: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: quoteTableViewCell.identifier, for: indexPath) as! quoteTableViewCell
        cell.textLbl.text = quotes[indexPath.row]
        return cell
    }
    
    
}

struct Kanye: Codable{
    var quote: String
}
