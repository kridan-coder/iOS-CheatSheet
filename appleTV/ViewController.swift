//
//  ViewController.swift
//  day10tvOS
//
//  Created by KriDan on 12.05.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataSet()
    }

    var dataSet: QuotesResponse!
    
    func loadDataSet(){
        ApiClient().getQuotes(){ response in
            self.dataSet = response
            self.dataSet.data!.append(contentsOf: response.data!)
            self.dataSet.data!.append(contentsOf: response.data!)
            self.dataSet.data!.append(contentsOf: response.data!)
            self.dataSet.data!.append(contentsOf: response.data!)
            self.initCollectionView()
            self.indicator.stopAnimating()
        }
    }
    
    func initCollectionView(){
        
        //collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        

        
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSet.data?.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.setUpData(data: dataSet.data![indexPath.item])
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(gesture:)))
        tap.allowedPressTypes = [NSNumber(value: UIPress.PressType.select.rawValue)]
        cell.addGestureRecognizer(tap)
        return cell
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let prev = context.previouslyFocusedView as? CollectionViewCell {
            UIView.animate(withDuration: 0.1) {
                prev.image.frame.size = CGSize(width: 325, height: 325)
            }
        }
        if let next = context.nextFocusedView as? CollectionViewCell {
            UIView.animate(withDuration: 0.1) {
                next.image.frame.size = CGSize(width: 600, height: 600)
            }
        }
    }
    
    
    
    @objc func tapped(gesture: UITapGestureRecognizer){
        if let cell = gesture.view as? CollectionViewCell {
            print(cell.label.text)
            let vc = self.storyboard!.instantiateViewController(identifier: "screen2")
            self.navigationController!.pushViewController(vc, animated: true)
            print("dasdadkajkdjadkandaskndjandkajdnjasd")
        }
        
    }
    
}
