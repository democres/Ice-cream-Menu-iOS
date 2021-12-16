//
//  ViewController.swift
//  GorillaTest
//
//  Created by David Figueroa on 1/11/21.
//

import UIKit
import Alamofire

class CreateProductViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepDescriptionLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var viewModel = CreateProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for subview in view.subviews {
            subview.alpha = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.getData { [weak self] success in
            guard self == `self` else { return }
            if success {
                DispatchQueue.main.async {
                    self?.bindData()
                    self?.refreshViews()
                }
            }
        }
    }
    
    private func refreshViews() {
        UIView.animate(withDuration: 2) {
            for subview in self.view.subviews {
                subview.alpha = 1
            }
        }
    }
    
    private func bindData() {
        titleLabel.text = viewModel.title
        
        guard let firstProduct = viewModel.flavors.first else { return }
        
        productName.text = firstProduct.name
        productPrice.text = "$\(firstProduct.price)"
        
        AF.request(firstProduct.imageUrl, method: .get).response{ response in
            switch response.result {
            case .success(let responseData):
                self.mainImage.image = UIImage(data: responseData!, scale:1)
            case .failure(let error):
                print("error--->",error)
            }
        }
    }
}

