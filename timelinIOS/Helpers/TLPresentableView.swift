import SwiftUI
import UIKit

struct TLPresentableView: UIViewControllerRepresentable {
    
    let previewUI: UIViewController!
    
    init(_ preview: @escaping () -> UIViewController) {
        self.previewUI = preview()
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return previewUI
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
