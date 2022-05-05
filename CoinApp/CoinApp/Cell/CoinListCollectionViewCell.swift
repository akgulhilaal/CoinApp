//
//  CoinListCollectionViewCell.swift
//  CoinApp
//
//  Created by Hilal Akgül on 17.03.2022.
//

import UIKit

class CoinListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configure(model : CoinElement){
        let newUrl = model.iconUrl.replacingOccurrences(of: "svg", with: "png")
        let url = URL(string: (newUrl))
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    self.coinImage.image = UIImage(data: imageData)
                }
        coinName.text = model.name
        symbolLabel.text = model.symbol
        changeLabel.text = "\(model.change)%"
        priceLabel.text = String(format: "$%.2f", Double(model.price)!)

    }

}
