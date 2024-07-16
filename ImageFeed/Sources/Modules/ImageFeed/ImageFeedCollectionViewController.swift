//
//  ImageFeedCollectionViewController.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import UIKit
import Kingfisher

class ImageFeedCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let viewModel: ImageFeedViewModel
    
    // MARK: - Initialization
    
    init(viewModel: ImageFeedViewModel) {
        self.viewModel = viewModel
        let layout = CustomFlowLayout()
        super.init(collectionViewLayout: layout)
        layout.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCell()
        setupCollectionView()
        
        fetchImages()
    }
}

// MARK: - Setup View
private extension ImageFeedCollectionViewController {
    func setupCell() {
        collectionView.register(UINib(nibName: "ImageFeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ImageFeedCollectionViewCell.reuseIdentifier)
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .white
        
        collectionView.contentInset.left = 8
        collectionView.contentInset.right = 8
        
        collectionView.prefetchDataSource = self
    }
}

// MARK: - API calls
private extension ImageFeedCollectionViewController {
    func fetchImages() {
        Task {
            do {
                let images = try await viewModel.fetchImages()
                
                DispatchQueue.main.async {
                    self.updateCollectionView(with: images)
                }
            } catch {
                Logger.errorDebugLog(error.localizedDescription, category: .Network)
            }
        }
    }
}

// MARK: - Helpers
private extension ImageFeedCollectionViewController {
    func updateCollectionView(with newImages: [Image]) {
        let startIndex = viewModel.getNumberOfImages() - newImages.count
        let indexPaths = (startIndex..<viewModel.getNumberOfImages()).map { IndexPath(item: $0, section: 0) }
        
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: indexPaths)
        }, completion: nil)
    }
}

// MARK: - Collection View delegate, dataSource
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
        let image = viewModel.getImage(at: indexPath)
        
        let viewModel = DetailImageViewModel(fullSizeImageURL: image.src.large, backgroundImageURL: image.src.medium)
        let detailImageVC = DetailImageViewController(viewModel: viewModel)
        
        detailImageVC.modalPresentationStyle = .overFullScreen
        detailImageVC.modalTransitionStyle = .coverVertical
        
        present(detailImageVC, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ImageFeedCollectionViewCell else { return }
        
        cell.imageView.kf.cancelDownloadTask()
    }
}

// MARK: - UICollectionViewDataSourcePrefetching
extension ImageFeedCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let urls = indexPaths.compactMap { URL(string: viewModel.getImage(at: $0).src.medium) }
        
        ImagePrefetcher(urls: urls).start()
    }
}

// MARK: - CustomFlowLayoutDelegate
extension ImageFeedCollectionViewController: CustomFlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, aspectRatioForImageAtIndexPath indexPath:IndexPath) -> CGFloat {
        return viewModel.getAspectRatioForImage(at: indexPath)
    }
}
