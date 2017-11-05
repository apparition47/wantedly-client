//
//  PhotosFeaturedViewController.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

class PhotosFeaturedViewController: UICollectionViewController {
    var configurator = PhotosFeaturedConfiguratorImplementation()
    var presenter: PhotosFeaturedPresenter!
    let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(photosFeaturedViewController: self)
        presenter.viewDidLoad()
        
        // We can inform the feedback generator that it will likely receive events soon,
        // which basically 'wakes up' the device's taptic engine for a few seconds,
        // preparing it for use without any latency. You can call this function as many
        // times as you want. Good tims to call this is when a gesture begins and right
        // after a haptic signal is played.
        notificationFeedbackGenerator.prepare()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    // MARK: - IBAction
    
    @IBAction func orderButtonPressed(_ sender: Any) {
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfPhotos
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
    
    // MARK: - UIScrollViewDelegate
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollToNearestVisibleCollectionViewCell()
        }
        
        // if at end
        let offsetX = scrollView.contentOffset.x
        let contentWidth = scrollView.contentSize.width
        if offsetX > contentWidth - scrollView.frame.size.width {
            presenter.didScrollViewToEnd()
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollToNearestVisibleCollectionViewCell()
    }
    
    // MARK: private
    
    private func scrollToNearestVisibleCollectionViewCell() {
        guard let collectionView = collectionView else {
            return
        }
        
        let visibleCenterPositionOfScrollView = Float(collectionView.contentOffset.x + (collectionView.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<collectionView.visibleCells.count {
            let cell = collectionView.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            
            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = collectionView.indexPath(for: cell)!.row
                presenter.didSnap(to: closestCellIndex)
            }
        }
        if closestCellIndex != -1 {
            self.collectionView!.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

// MARK: - PhotosFeaturedView

extension PhotosFeaturedViewController: PhotosFeaturedView {
    func refreshPhotosView() {
        presenter.didSnap(to: 0)
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func displayPhotosRetrievalError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
        
        notificationFeedbackGenerator.notificationOccurred(.error)
    }
    
    func updateBackground(hexColour: String) {
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut], animations: {
            self.collectionView?.backgroundColor = UIColor(hex: hexColour)
        })
    }
}
