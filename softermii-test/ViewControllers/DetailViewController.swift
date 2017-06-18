//
//  DetailViewController.swift
//  softermii-test
//
//  Created by Sergey Mozgovoy on 17/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit
import SDWebImage
class DetailViewController: UIViewController, UIGestureRecognizerDelegate {
    var mediaURL:URL?
    var lastScale = CGFloat()
    
    @IBOutlet weak var mediaImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    private func prepareView (){
        let pgr = UIPinchGestureRecognizer(target: self, action: #selector(self.handlePinchGesture))
        pgr.delegate = self
        mediaImageView?.addGestureRecognizer(pgr)
        mediaImageView?.isUserInteractionEnabled = true
        self.mediaImageView.sd_setImage(with: mediaURL!, placeholderImage: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        if gestureRecognizer.state == .began {
            lastScale = gestureRecognizer.scale
        }
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let currentScale: CGFloat = (gestureRecognizer.view!.layer.value(forKeyPath: "transform.scale")) as! CGFloat

            let kMaxScale: CGFloat = 2.0
            let kMinScale: CGFloat = 1.0
            
            var newScale: CGFloat = 1 - (lastScale - gestureRecognizer.scale)
            
            newScale = min(newScale, kMaxScale / currentScale)
            newScale = max(newScale, kMinScale / currentScale)
            let transform: CGAffineTransform = gestureRecognizer.view!.transform.scaledBy(x: newScale, y: newScale)
            gestureRecognizer.view!.transform = transform
            lastScale = gestureRecognizer.scale
        }
    }
    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
        
        let image = mediaImageView.image
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
}
