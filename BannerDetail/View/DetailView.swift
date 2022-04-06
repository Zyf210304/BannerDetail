//
//  DetailView.swift
//  BannerDetail
//
//  Created by 张亚飞 on 2022/4/6.
//

import SwiftUI

struct DetailView: View {
    
    var movie: Movie
    @Binding var showDetailView: Bool
    @Binding var detailMovie: Movie?
    @Binding var currentCardSize: CGSize
    
    var animation: Namespace.ID
    
    @State var showDetailContent: Bool = false
    
    @State var offset: CGFloat = 0
    
    var body: some View {
       
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack {
                
                Image(movie.artwork)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: currentCardSize.width, height: currentCardSize.height)
                    .cornerRadius(15)
                    .matchedGeometryEffect(id: movie.id, in: animation)
                
                VStack(spacing: 15) {

                    Text(movie.movieTitle)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 25)

                    Text(sampleText)
                        .multilineTextAlignment(.leading)
                    
                    Button {
                        
                    } label: {
                         
                        Text("Book Ticket")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background{
                                
                                RoundedRectangle(cornerRadius: 10,style: .continuous)
                                    .fill(.blue)
                            }
                    }
                    .padding(.top, 20)

                }
                .opacity(showDetailContent ? 1 : 0)
                .offset(y: showDetailContent ? 0 : 200)
                
            }
            .padding()
            .modifier(OffsetModifier(offset: $offset))
        }
        .coordinateSpace(name: "SCROLL")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
                
        }
        .onAppear {

            withAnimation(.easeInOut) {

                showDetailContent = true
            }
        }
        .onChange(of: offset) { newValue in
            
            if newValue > 120 {
                
                withAnimation(.easeInOut) {
                    
                    showDetailContent = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    withAnimation(.easeInOut) {
                        
                        showDetailView = false
                    }
                }
                
            }
        }
//        .onTapGesture {
//
//            showDetailView = false
//        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
