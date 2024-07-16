//
//  ImageFeedCollectionViewController.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import UIKit

class ImageFeedCollectionViewController: UICollectionViewController {
    private let viewModel: ImageFeedViewModel
    
    init(viewModel: ImageFeedViewModel) {
        self.viewModel = viewModel
        let layout = CustomFlowLayout()
        super.init(collectionViewLayout: layout)
        layout.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCell()
        setupCollectionView()
        
        fetchImages()
    }
}

// MARK: - Helpers
private extension ImageFeedCollectionViewController {
    func setupCell() {
        collectionView.register(UINib(nibName: "ImageFeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ImageFeedCollectionViewCell.reuseIdentifier)
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .white
        
        collectionView.contentInset.left = 8
        collectionView.contentInset.right = 8
    }
}

// MARK: - API calls
private extension ImageFeedCollectionViewController {
    func fetchImages() {
        Task {
            do {
                try await viewModel.fetchImages()
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                Logger.errorDebugLog(error.localizedDescription, category: .Network)
            }
        }
    }
}

// MARK: - Collection View setup
extension ImageFeedCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfImages()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageFeedCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageFeedCollectionViewCell
        let image = viewModel.getImage(at: indexPath)
        cell.configure(with: image)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getNumberOfImages() - 4 {
            fetchImages()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let photo = viewModel.getImage(at: indexPath)
//        let detailVC = PhotoDetailViewController(photo: photo)
//        present(detailVC, animated: true)
        
        let image = viewModel.getImage(at: indexPath)
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageFeedCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageFeedCollectionViewCell
//        let img = cell.imageView.image
        
        let viewModel = DetailImageViewModel(fullSizeImageURL: image.src.original, backgroundImageURL: image.src.large)
        let detailImageVC = DetailImageViewController(nibName: "DetailImageViewController", bundle: nil)
        detailImageVC.viewModel = viewModel
        
        detailImageVC.modalPresentationStyle = .overFullScreen
        detailImageVC.modalTransitionStyle = .coverVertical
        
        present(detailImageVC, animated: true)
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

extension ImageFeedCollectionViewController: CustomFlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, aspectRatioForImageAtIndexPath indexPath:IndexPath) -> CGFloat {
        let photo = viewModel.getImage(at: indexPath)
        let aspectRatio = CGFloat(photo.width) / CGFloat(photo.height)
        return aspectRatio
    }
}
