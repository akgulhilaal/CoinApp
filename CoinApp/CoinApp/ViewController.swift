//
//  ViewController.swift
//  CoinApp
//
//  Created by Hilal Akgül on 17.03.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterButton: UIButton!
    
    var coinList = [CoinElement](){
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    let coinRequest = CoinRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinRequest.getCoins{ result in
            switch result {
            case .success(let coinList):
                self.coinList = coinList
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        collectionView.backgroundColor = nil
        filterButton.showsMenuAsPrimaryAction = true
        filterButton.menu = UIMenu(children: [
            
            UIAction(title: "Price") { action in
                self.coinList.sort{ $0.price < $1.price }
                self.collectionView.reloadData()                    },
            
            UIAction(title: "MarketCap") { action in
                self.coinList.sort{ $0.marketCap < $1.marketCap }
                self.collectionView.reloadData()
                
            },
            UIAction(title: "24h Volume") { action in
                self.coinList.sort{ $0.the24HVolume < $1.the24HVolume }
                self.collectionView.reloadData()
                
            },
            UIAction(title: "Change") { action in
                self.coinList.sort{ $0.change < $1.change }
                self.collectionView.reloadData()
                
            },
            UIAction(title: "ListedAt") { action in
                self.coinList.sort{ $0.listedAt < $1.listedAt }
                self.collectionView.reloadData()
                
            },
        ])
        
        
        collectionView.register(UINib(nibName: "CoinListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CoinCell")
    }
    
    
    @IBAction func filterCoins(_ sender: Any) {
        self.coinList.sort{ $0.price < $1.price }
        self.collectionView.reloadData()
    }
    
}
extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coinList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCell", for: indexPath) as! CoinListCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .white
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.masksToBounds = true
        cell.configure(model: coinList[indexPath.row])
        
        if cell.changeLabel.text?.first == "-"{
            cell.changeLabel.textColor = .red
        }
        else{
            cell.changeLabel.textColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CoinDetailViewController.coinDetails = coinList[indexPath.row]
        self.performSegue(withIdentifier: "coinDetail", sender: self)
    }
    
    
}
