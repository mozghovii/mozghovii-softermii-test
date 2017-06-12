//
//  MediaCollectionController.swift
//  softermii-test
//
//  Created by Sergey Mozgovoy on 17/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit

class MediaCollectionController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let numberOfCellsPerRow: CGFloat = 3
    var currentUser:User?
    var mediaArray = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.congifureCollectionView()
        self.getDataFromAPI()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Methods

    private func getDataFromAPI() {
        APIManager.sharedInstance .getUserInfo(success: { (user) in
            self.currentUser = user
            self.collectionView.reloadData()
        }, failure: {
            
        })
        APIManager.sharedInstance.getSelfMediaRecent(parameters: nil, success: { (array) in
            self.mediaArray = array
            self.collectionView.reloadData()
        }) {
            
        }
    }
    
    fileprivate  func congifureCollectionView() {
        self.collectionView.register(UINib.init(nibName: Globals.CellIdentifiers.HeaderReusableView, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Globals.CellIdentifiers.HeaderReusableView)
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (view.frame.width - max(0, numberOfCellsPerRow - 1)*horizontalSpacing)/numberOfCellsPerRow
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension MediaCollectionController:UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mediaArray.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MediaCell = collectionView.dequeueReusableCell(withReuseIdentifier: Globals.CellIdentifiers.MediaCell, for: indexPath) as! MediaCell
        cell.configureCellWithModel(model: mediaArray[indexPath.row] as! MediaModel)
        return cell
        
    }
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView : UICollectionReusableView? = nil
        
        // Create header
        if (kind == UICollectionElementKindSectionHeader) {
            // Create Header
            let headerView: HeaderReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Globals.CellIdentifiers.HeaderReusableView, for: indexPath as IndexPath) as! HeaderReusableView
            if currentUser != nil {
                headerView.fillWithData(data: self.currentUser!)
            }
            
            reusableView = headerView
        }
        return reusableView!
    }
}

// MARK: - UICollectionViewDelegate

extension MediaCollectionController:UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mediaModel = mediaArray[indexPath.row] as! MediaModel
        let mainStoryboard: UIStoryboard = UIStoryboard(name: Globals.StoryboardsName.main, bundle: nil)
        let detailController = mainStoryboard.instantiateViewController(withIdentifier: Globals.GeneralConstants.detailViewController) as! DetailViewController
        detailController.mediaURL = mediaModel.standardResolutionURL
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}
