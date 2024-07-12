//
//  ImageFeedCollectionViewController.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import UIKit

private let reuseIdentifier = "Cell"

class ImageFeedCollectionViewController: UICollectionViewController {
    private let viewModel: ImageFeedViewModel
    
    init(viewModel: ImageFeedViewModel) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout() // TODO: Make init from nib without flow layout
        layout.minimumLineSpacing = 40 // Space between rows
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ImageFeedCollectionViewCell.self, forCellWithReuseIdentifier: ImageFeedCollectionViewCell.reuseIdentifier)
        
        fetchPhotos()
        //TODO: Remove
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
    }
}

// MARK: - API calls
private extension ImageFeedCollectionViewController {
    func fetchPhotos() {
        Task {
            do {
                try await viewModel.fetchImages()
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print("Error fetching photos: \(error)")
            }
        }
    }
}

// MARK: - Collection View setup
extension ImageFeedCollectionViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfImages()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageFeedCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageFeedCollectionViewCell
        let photo = viewModel.getImage(at: indexPath)
        cell.configure(with: photo)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getNumberOfImages() - 2 {
            fetchPhotos()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.getImage(at: indexPath)
            let detailVC = PhotoDetailViewController(photo: photo)
            navigationController?.pushViewController(detailVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width - 40
//        let imgHeight = calculateImageHeight(sourceImage: viewModel.getImage(at: indexPath), scaledToWidth: width)
//        return CGSize(width: width,height: imgHeight)
        
        let photo = viewModel.getImage(at: indexPath)
        let width = (collectionView.bounds.width - 40) / 2
        let aspectRatio = CGFloat(photo.width) / CGFloat(photo.height)
        let height = width / aspectRatio
        return CGSize(width: width, height: height)
    }
    
    // TODO: Think about turn on/off shadow on scroll
//    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        toggleCellShadows(enabled: false)
//    }
//    
//    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
////        toggleCellShadows(enabled: true)
//    }
//    
//    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
////        if !decelerate {
//            toggleCellShadows(enabled: true)
////        }
//    }
//    
//    private func toggleCellShadows(enabled: Bool) {
//        for cell in collectionView.visibleCells as! [ImageFeedCollectionViewCell] {
//            cell.layer.shadowOpacity = enabled ? 0.25 : 0.0
//        }
//    }
}
