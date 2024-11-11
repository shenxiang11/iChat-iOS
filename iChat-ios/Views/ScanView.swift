//
//  ScanView.swift
//  iChat-ios
//
//  Created by 香饽饽zizizi on 2024/11/9.
//

import SwiftUI
import AVKit
import Ichatgl

#if os(iOS)
/// Camera Permission Enum
enum Permission: String {
    case idle = "Not Determined"
    case approved = "Access Granted"
    case denied = "Access Denied"
}

struct ScanView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @State private var isScanning: Bool = false
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var session: AVCaptureSession = .init()
    @State private var cameraPermission: Permission = .idle
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    @State private var confirmLoginViewShow = false

    @State private var deviceUuid = ""

    @StateObject private var qrDelegate = QRScannerDelegate()

    var body: some View {
        GeometryReader { geo in
            ZStack {
                CameraView(frameSize: .init(width: geo.size.width, height: geo.size.height), session: $session, orientation: .constant(.portrait))
                    .onAppear(perform: checkCameraPermission)
                    .onDisappear {
                        session.stopRunning()
                    }
                    .alert(errorMessage, isPresented: $showError) {
                        /// Showing Setting's Button, if permission is denied
                        if cameraPermission == .denied {
                            Button("Settings") {
                                let settingsString = UIApplication.openSettingsURLString
                                if let settingsURL = URL(string: settingsString) {
                                    /// Opening App's Setting, Using openURL SwiftUI API
                                    openURL(settingsURL)
                                }
                            }

                            /// Along with Cancel Button
                            Button("Cancel", role: .cancel) {
                            }
                        }
                    }
                    .onChange(of: qrDelegate.scannedCode) {
                        if let code = qrDelegate.scannedCode {
                            deviceUuid = code
                            Network.shared.apollo.perform(mutation: ScannedQRCodeMutation(deviceUuid: code)) { result in
                                switch result {
                                case .success(let graphqlResult):
                                    if case true = graphqlResult.data?.scanned {
                                        confirmLoginViewShow = true
                                    }
                                case .failure(let error):
                                    print("Confirm scanned failed: \(error)")
                                }
                            }
                        }
                    }

                Color.clear
                    .frame(width: 300, height: 300)
                    .overlay {
                        ForEach(0...4, id: \.self) { index in
                            let rotation = Double(index) * 90

                            RoundedRectangle(cornerRadius: 2, style: .circular)
                                /// Trimming to get Scanner like Edges
                                .trim(from: 0.61, to: 0.64)
                                .stroke(Color.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                .rotationEffect(.init(degrees: rotation))
                        }
                    }
                    .overlay {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(height: 2.5)
                            .shadow(color: .black.opacity(0.8), radius: 8, x: 0, y: isScanning ? 15 : -15)
                            .offset(y: isScanning ? 150 : -150)
                    }
            }
        }
        .ignoresSafeArea()
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward.circle.fill")
                }

            }
        }
        .fullScreenCover(isPresented: $confirmLoginViewShow) {
            ConfirmScanLoginView(show: $confirmLoginViewShow, deviceUuid: $deviceUuid)
        }
    }

    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermission = .approved
                if session.inputs.isEmpty {
                    /// New Setup
                    setupCamera()
                } else {
                    /// Already Existing One
                    reactivateCamera()
                }
            case .notDetermined:
                /// Requesting Camera Access
                if await AVCaptureDevice.requestAccess(for: .video) {
                    /// Permission Granted
                    cameraPermission = .approved
                    setupCamera()
                } else {
                    /// Permission Denied
                    cameraPermission = .denied
                    /// Presenting Error Message
                    presentError("Please Provide Access to Camera for scanning codes")
                }
            case .denied, .restricted:
                cameraPermission = .denied
                presentError("Please Provide Access to Camera for scanning codes")
            default: break
            }
        }
    }

    /// Setting Up Camera
    func setupCamera() {
        do {
            /// Finding Back Camera
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else {
                presentError("UNKNOWN DEVICE ERROR")
                return
            }

            /// Camera Input
            let input = try AVCaptureDeviceInput(device: device)
            /// For Extra Saftey
            /// Checking Whether input & output can be added to the session
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else {
                presentError("UNKNOWN INPUT/OUTPUT ERROR")
                return
            }

            /// Adding Input & ouptut to Camera Session
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            /// Setting Ouput config to read QR Codes
            qrOutput.metadataObjectTypes = [.qr]
            /// Adding Delegate to Retreive the Fetched QR Code From Camera
            qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
            session.commitConfiguration()
            /// Note Session must be started on Background thread
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            activateScannerAnimation()
        } catch {
            presentError(error.localizedDescription)
        }
    }

    func reactivateCamera() {
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
    }

    /// Activating Scanner Animation Method
    func activateScannerAnimation() {
        /// Adding Delay for Each Reversal
        withAnimation(.easeInOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)) {
            isScanning = true
        }
    }

    /// De-Activating Scanner Animation Method
    func deActivateScannerAnimation() {
        /// Adding Delay for Each Reversal
        withAnimation(.easeInOut(duration: 0.85)) {
            isScanning = false
        }
    }

    /// Presenting Error
    func presentError(_ message: String) {
        errorMessage = message
        showError.toggle()
    }
}

#Preview {
    ScanView()
}

#endif
