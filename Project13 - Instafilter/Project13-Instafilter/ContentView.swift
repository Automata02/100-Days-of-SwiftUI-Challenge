//
//  ContentView.swift
//  Project13-Instafilter
//
//  Created by roberts.kursitis on 05/12/2022.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.0
    @State private var showingImagePicker = false
    var isSavable: Bool {
        image != nil ? false : true
    }
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var hasRadius = false
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                VStack {
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity) { _ in applyProcessing() }
                    }
                    if hasRadius {
                        HStack {
                            Text("Radius")
                            Slider(value: $filterRadius, in: 0...200)
                                .onChange(of: filterRadius) { _ in applyProcessing() }
                        }
                    }
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change filter") {
                        showingFilterSheet = true
                    }
                    Spacer()
                    
                    Button("Save", action: save)
                        .disabled(isSavable)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .onChange(of: currentFilter) { _ in
                if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                    hasRadius = true
                } else {
                    hasRadius = false
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Group {
                    Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                    Button("Edges") { setFilter(CIFilter.edges()) }
                    Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                    Button("Bloom") { setFilter(CIFilter.bloom()) }
                    Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                    Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                }
                Group {
                    Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                    Button("Vignette") { setFilter(CIFilter.vignette()) }
                    Button("Bokeh Blur") { setFilter(CIFilter.bokehBlur()) }
                    Button("XRay") { setFilter(CIFilter.xRay()) }
                    Button("Spot Light") { setFilter(CIFilter.spotLight()) }
                    Button("Cancel", role: .cancel) { }
                }
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success")
        }
        
        imageSaver.errorHandler = {
            print($0.localizedDescription)
        }
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
