//
//  CameraManager.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/07/15.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import AVFoundation

struct CameraManager {

    private init() {}

    private var session: AVCaptureSession!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!

    mutating func setup(delegate: AVCaptureVideoDataOutputSampleBufferDelegate) {
        guard let device = AVCaptureDevice.default(for: .video) else {
            return
        }
        device.activeVideoMinFrameDuration = CMTimeMake(value: 1, timescale: 30)

        do {
            // 入力設定
            let input = try AVCaptureDeviceInput(device: device)
            // 出力設定
            let output: AVCaptureVideoDataOutput = AVCaptureVideoDataOutput()
            // 出力設定: カラーチャンネル
            output.videoSettings = [kCVPixelBufferPixelFormatTypeKey : kCVPixelFormatType_32BGRA] as [String : Any]
            output.setSampleBufferDelegate(delegate, queue: DispatchQueue(label: "videoQueue"))
            // 出力設定: キューがブロックされているときに新しいフレームが来たら削除
            output.alwaysDiscardsLateVideoFrames = true

            // セッションの作成
            self.session = AVCaptureSession()
            // 解像度を設定
            self.session.sessionPreset = .medium

            // セッションに追加.
            if self.session.canAddInput(input) && self.session.canAddOutput(output) {
                self.session.addInput(input)
                self.session.addOutput(output)
            }
        } catch { error
            print(error.localizedDescription)
        }
    }

    mutating func startPreview() -> AVCaptureVideoPreviewLayer {
        // 画像を表示するレイヤーを生成
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        // カメラ入力の縦横比を維持したまま、レイヤーいっぱいに表示
        self.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        // 縦向きで固定
        self.videoPreviewLayer.connection?.videoOrientation = .portrait

        return self.videoPreviewLayer
    }

    mutating func start() {
        session.startRunning()
    }

    mutating func stop() {
        session.stopRunning()
        session = nil
    }
}
