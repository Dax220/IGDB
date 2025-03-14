//
//  CachedAsyncImage.swift
//  IGDB
//
//  Created by Maxim Tischenko on 13.03.2025.
//

import SwiftUI

struct CachedAsyncImageCachePolicy {
    static var maxSizeOnDisk = 100 * 1024 * 1024
}

struct CachedAsyncImage<Content: View, Placeholder: View>: View {
    
    @State private var image: UIImage?
    @ViewBuilder private var placeholder: Placeholder
    private let url: URL
    private let content: (Image) -> Content
    private let cache = URLCache.shared
    
    init(url: URL, content: @escaping (Image) -> Content, @ViewBuilder placeholder: () -> Placeholder) {
        self.url = url
        self.content = content
        self.placeholder = placeholder()
    }
    
    var body: some View {
        VStack {
            if let image = image {
                content(Image(uiImage: image))
            } else {
                placeholder
                    .onAppear() {
                        loadImage()
                    }
            }
        }
    }
    
    private func loadImage() {
        
        let request = URLRequest(url: url)
        
        if let cachedResponse = cache.cachedResponse(for: request),
           let cachedImage = UIImage(data: cachedResponse.data) {
            self.image = cachedImage
            return
        }
        
        if let cachedImage = loadFromDisk() {
            self.image = cachedImage
            return
        }
        
        Task {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let downloadedImage = UIImage(data: data) else { return }
            image = downloadedImage
            cacheData(request: request, response: response, data: data)
        }
    }
    
    private func cacheData(request: URLRequest, response: URLResponse, data: Data) {
        let cachedData = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedData, for: request)
        saveToDisk(data: data)
        cleanDiskCacheIfNeeded(maxSizeBytes: CachedAsyncImageCachePolicy.maxSizeOnDisk)
    }
    
    private func saveToDisk(data: Data) {
        Task.detached(priority: .low) {
            let fileURL = await getFileURL()
            try? data.write(to: fileURL)
        }
    }
    
    private func loadFromDisk() -> UIImage? {
        let fileURL = getFileURL()
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: data)
    }
    
    private func getFileURL() -> URL {
        let filename = url.lastPathComponent
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return directory.appendingPathComponent(filename)
    }
    
    private func cleanDiskCacheIfNeeded(maxSizeBytes: Int) {
        Task.detached(priority: .low) {
            let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
            let fileManager = FileManager.default
            
            do {
                let files = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: [.contentModificationDateKey, .fileSizeKey], options: .skipsHiddenFiles)
                
                var totalSize = 0
                var fileInfos: [(url: URL, size: Int, date: Date)] = []
                
                for file in files {
                    let attributes = try file.resourceValues(forKeys: [.contentModificationDateKey, .fileSizeKey])
                    if let size = attributes.fileSize, let date = attributes.contentModificationDate {
                        totalSize += size
                        fileInfos.append((file, size, date))
                    }
                }
                
                print("total size: \(totalSize / 1048576) MB")
                if totalSize > maxSizeBytes {
                    let sortedFiles = fileInfos.sorted { $0.date < $1.date }
                    
                    var sizeToFree = Int(Double(maxSizeBytes) * 0.3)
                    for file in sortedFiles {
                        try fileManager.removeItem(at: file.url)
                        sizeToFree -= file.size
                        if sizeToFree <= 0 { break }
                    }
                }
            } catch {
                print("Cache cleaning error: \(error)")
            }
        }
    }
}
