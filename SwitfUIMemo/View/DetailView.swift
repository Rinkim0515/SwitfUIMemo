//
//  DetailView.swift
//  SwitfUIMemo
//
//  Created by KimRin on 10/10/24.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var memo: Memo
    
    
    @EnvironmentObject var store: MemoStore
    @State private var showComposer = false
    @State private var showDeleteAlert = false
    @State private var showBottomBar = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(memo.content)
                            .padding()
                        Spacer(minLength: 0)
                    }
                    
                    Text(memo.insertDate,style: .date)
                        .padding()
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
        
        .sheet(isPresented: $showComposer) {
            ComposeView(memo: memo)
        }
        
        .navigationTitle("메모 보기")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {showBottomBar = false}
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                }
                .foregroundStyle(.red)
                .alert("삭제확인", isPresented: $showDeleteAlert) {
                    Button(role: .destructive) {
                        store.delete(memo: memo)
                        dismiss()
                    } label: {
                        Text("삭제")
                    }
                } message: {
                    Text("메모를 삭제할까요?")
                }
                
                Button {
                    showComposer = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
    }
    
        
}

#Preview {
    
    NavigationView {
        DetailView(memo: Memo(content: "Hello"))
            .environmentObject(MemoStore())
    }
    
}
