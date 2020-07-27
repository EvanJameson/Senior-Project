/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that clips an image to a circle and adds a stroke and shadow.
*/

//from SwiftUI tutorial

import SwiftUI

struct CircleImage: View {
    var image: Image
    var wh: CGFloat

    var body: some View {
        image
            .resizable()
            .frame(width: wh, height: wh)
            .clipShape(Circle())
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("CPSLO"), wh: 50)
    }
}
