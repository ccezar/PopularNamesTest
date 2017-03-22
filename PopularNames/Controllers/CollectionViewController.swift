//
//  CollectionViewController.swift
//  PopularNames
//
//  Created by Caio Cezar Lopes dos Santos on 3/20/17.
//  Copyright © 2017 Caio Tests. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties
    private var persons: [Person] = []
    private var viewedIDs: [String] = []

    // MARK: Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        loadPersons()
    }
    
    func loadPersons() {
        guard let path = openFile(file: "99", type: "json") else { return loadException(reason: "Unable To Load") }
        guard let jsonData = NSData(contentsOfFile: path) else { return loadException(reason: "Unable To Transform") }
        
        var allEntries = [[String:Any]]()
        allEntries = try! JSONSerialization.jsonObject(with: jsonData as Data, options: []) as! [[String: Any]]
        
        for item in allEntries {
            if let id = item["id"] as? String, viewedIDs.contains(id) == false {
                persons.append(Person(element: item))
                viewedIDs.append(id)
            }
        }
    }
    
    private func openFile(file: String, type: String) -> String? {
        return Bundle.main.path(forResource: file, ofType: type) ?? nil
    }
    
    private func loadException(reason: String) {
        NSException(name: NSExceptionName(rawValue: "WithoutLibsViewController Error"), reason: reason, userInfo: nil).raise()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            self.collectionView.isHidden = true
            self.collectionView.reloadData()
        }) { (context) in
            self.collectionView.isHidden = false
        }
    }

    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persons.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PersonCollectionViewCell
        cell.person = persons[indexPath.item]
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: getCollectionWidth() / CGFloat(getNumberOfColumns()), height: 400)
    }
    
    private func getCollectionWidth() -> CGFloat {
        return UIScreen.main.bounds.width - (isPortrait() ? 30 : 40)
    }
    
    private func getNumberOfColumns() -> Int {
        return isPortrait() ? 2 : 3
    }
    
    private func isPortrait() -> Bool {
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown:
            return true
        case .landscapeLeft, .landscapeRight:
            return false
        default:
            return false
        }
    }
    
}
