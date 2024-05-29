import UIKit
import FirebaseStorage

class ImageUploadService {
    static let shared = ImageUploadService()

    private let storage = Storage.storage()

    func uploadImage(_ image: UIImage, completion: @escaping (URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(nil)
            return
        }

        let imageName = UUID().uuidString
        let storageRef = storage.reference().child("images/\(imageName).jpg")

        storageRef.putData(imageData, metadata: nil) { metadata, error in
            guard error == nil else {
                completion(nil)
                return
            }

            storageRef.downloadURL { url, error in
                completion(url)
            }
        }
    }
}
