//
//  CameraView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/11/9.
//

#if os(iOS)
import SwiftUI
import AVKit

/// Camera View Using AVCaptureVideoPreviewLayer
struct CameraView: UIViewRepresentable {
    var frameSize: CGSize
    /// Camera Session
    @Binding var session: AVCaptureSession
    @Binding var orientation: UIDeviceOrientation
    
    func makeUIView(context: Context) -> UIView {
        /// Defining Camera Frame Size
        let view = UIViewType(frame: CGRect(origin: .zero, size: frameSize))
        view.backgroundColor = .clear

        let cameraLayer = AVCaptureVideoPreviewLayer(session: session)
        cameraLayer.frame = .init(origin: .zero, size: frameSize)
        cameraLayer.videoGravity = .resizeAspectFill
        cameraLayer.masksToBounds = true
        view.layer.addSublayer(cameraLayer)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        /// Video Orientation to adapt for iPad Orientation
        if let layer = uiView.layer.sublayers?.first(where: { layer in
            layer is AVCaptureVideoPreviewLayer
        }) as? AVCaptureVideoPreviewLayer {
            switch orientation {
            case .portrait: layer.setAffineTransform(.init(rotationAngle: 0))
            case .landscapeLeft: layer.setAffineTransform(.init(rotationAngle: -.pi / 2))
            case .landscapeRight: layer.setAffineTransform(.init(rotationAngle: .pi / 2))
            case .portraitUpsideDown: layer.setAffineTransform(.init(rotationAngle: .pi))
            default: break
            }
        }
    }
}

class QRScannerDelegate: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published var scannedCode: String?
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metaObject = metadataObjects.first {
            guard let readableObject = metaObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let Code = readableObject.stringValue else { return }
            scannedCode = Code
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}
#endif
