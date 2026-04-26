import Flutter
import UIKit
import Vision

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let auraChannel = FlutterMethodChannel(name: "com.nunu.auraapp/engine",
                                              binaryMessenger: controller.binaryMessenger)
    
    // Menerima panggilan dari Flutter (Data Source)
    auraChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      
      if call.method == "calculateAura" {
          guard let args = call.arguments as? [String: Any],
                let imagePaths = args["imagePaths"] as? [String] else {
              result(FlutterError(code: "INVALID_ARGUMENTS", message: "imagePaths is required", details: nil))
              return
          }
          
          self.processAuraScores(imagePaths: imagePaths, result: result)
      } else {
          result(FlutterMethodNotImplemented)
      }
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // Memproses semua gambar secara Background (agar UI Flutter tidak freeze)
  private func processAuraScores(imagePaths: [String], result: @escaping FlutterResult) {
      DispatchQueue.global(qos: .userInitiated).async {
          var resultsArray: [[String: Any]] = []
          
          for path in imagePaths {
              let score = self.calculateScoreForImage(at: path)
              resultsArray.append([
                  "imagePath": path,
                  "score": score
              ])
          }
          
          // Mengembalikan hasil kalkulasi ke Flutter lewat Main Thread
          DispatchQueue.main.async {
              result(resultsArray)
          }
      }
  }
  
  // Inti Mesin Kecerdasan Buatan (Apple Vision + Swift Native Math)
  private func calculateScoreForImage(at path: String) -> Double {
      var finalScore = 0.0
      
      // Inisialisasi Detektor Landmark Wajah Apple Vision
      let request = VNDetectFaceLandmarksRequest { (request, error) in
          guard let results = request.results as? [VNFaceObservation],
                let face = results.first, // Hanya memproses wajah orang pertama/terbesar di foto
                let landmarks = face.landmarks else {
              return
          }
          
          /* 
            Matematika Golden Ratio (Phi = 1.618)
            Mengukur lebar bibir dibandingkan dengan lebar hidung. 
            Semakin rasio mendekati 1.618, skor Aura semakin mendekati 100%.
          */
          if let nose = landmarks.nose, let outerLips = landmarks.outerLips {
              
              let faceBoundingBox = face.boundingBox
              let faceWidth = faceBoundingBox.width
              
              // 1. Ekstrak Lebar Hidung (Titik x Maks - x Min)
              let nosePoints = nose.normalizedPoints
              if let nLeft = nosePoints.min(by: { $0.x < $1.x }), let nRight = nosePoints.max(by: { $0.x < $1.x }) {
                  let noseWidth = abs(Double(nRight.x) - Double(nLeft.x)) * Double(faceWidth)
                  
                  // 2. Ekstrak Lebar Bibir (Titik x Maks - x Min)
                  let lipPoints = outerLips.normalizedPoints
                  if let lLeft = lipPoints.min(by: { $0.x < $1.x }), let lRight = lipPoints.max(by: { $0.x < $1.x }) {
                      let lipWidth = abs(Double(lRight.x) - Double(lLeft.x)) * Double(faceWidth)
                      
                      // 3. Kalkulasi Geometri Euclidean Rasio
                      if noseWidth > 0 {
                          let ratio = lipWidth / noseWidth
                          let goldenRatio = 1.618
                          
                          // Selisih antara wajah user dengan rasio kecantikan mutlak
                          let difference = abs(ratio - goldenRatio)
                          
                          // Rumus pengali: semakin kecil selisih, skor mendekati 100
                          var score = 100.0 - (difference * 25.0) 
                          
                          // Normalisasi skor (Skor max 99.9, Skor Min 50.0 biar aman)
                          if score > 99.9 { score = 99.9 }
                          if score < 50.0 { score = Double.random(in: 50.0...65.0) } 
                          
                          // Membulatkan skor ke 1 angka di belakang koma (misal 98.4)
                          finalScore = (score * 10).rounded() / 10
                      }
                  }
              }
          }
      }
      
      // Workaround for Simulator on Apple Silicon throwing "Could not create inference context"
      #if targetEnvironment(simulator)
      request.usesCPUOnly = true
      #endif
      
      // Membersihkan prefix file:// jika ada, agar path valid untuk UIImage
      let cleanPath = path.replacingOccurrences(of: "file://", with: "")
      
      // Membaca gambar menggunakan UIImage untuk menghindari error FileProvider 
      // dan memastikan format didukung oleh Vision
      guard let image = UIImage(contentsOfFile: cleanPath), let cgImage = image.cgImage else {
          print("Failed to read image from path: \(cleanPath)")
          return 0.0
      }
      
      let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
      do {
          try handler.perform([request])
      } catch {
          print("Vision request failed: \(error)")
      }
      
      // Jika wajah tidak terdeteksi (foto pemandangan/kosong), return 0.0
      return finalScore
  }
}
