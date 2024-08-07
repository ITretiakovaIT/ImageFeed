//
//  CustomFlowLayout.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import UIKit

protocol CustomFlowLayoutDelegate: AnyObject {
  func collectionView(_ collectionView: UICollectionView, aspectRatioForImageAtIndexPath indexPath: IndexPath) -> CGFloat
}

class CustomFlowLayout: UICollectionViewFlowLayout {
    weak var delegate: CustomFlowLayoutDelegate?
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 8
    
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }

        var yOffset: [CGFloat] = cache.isEmpty ? .init(repeating: 0, count: numberOfColumns) : yOffsetFromCache()
        
        let startIndex = cache.isEmpty ? 0 : cache.count
        
        for item in startIndex..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let imageAspectRatio = delegate?.collectionView(collectionView, aspectRatioForImageAtIndexPath: indexPath) ?? 180
            let height = columnWidth / imageAspectRatio + (cellPadding * 2)
            
            // Find the shortest column
            var shortestColumn = 0
            var shortestHeight = yOffset[0]
            
            for column in 1..<numberOfColumns {
                if yOffset[column] < shortestHeight {
                    shortestHeight = yOffset[column]
                    shortestColumn = column
                }
            }
            
            let frame = CGRect(x: xOffset[shortestColumn], y: yOffset[shortestColumn], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[shortestColumn] = yOffset[shortestColumn] + height
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    private func yOffsetFromCache() -> [CGFloat] {
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        for attributes in cache {
            let column = Int(attributes.frame.minX / (contentWidth / CGFloat(numberOfColumns)))
            yOffset[column] = max(yOffset[column], attributes.frame.maxY)
        }
        return yOffset
    }
}
