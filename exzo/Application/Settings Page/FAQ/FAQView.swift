//
//  FAQView.swift
//  exzo
//
//  Created by Difa N Pratama on 21/01/22.
//

import SwiftUI

struct Task: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let subtask: Subtask
}

struct Subtask: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let height: Float
}

struct SubtaskCell: View {
    let task: Subtask

    var body: some View {
        VStack {
            HStack {
                Rectangle().frame(width: 2, height: CGFloat(task.height), alignment: .center).padding(.leading, 9)
                Text(task.title)
                    .scaledFont(name: "Avenir", size: 15)
                    .padding(.trailing, 5)
            }
            .frame( height: CGFloat(task.height * 1.5))
        }
        
    }
}

struct TaskCell: View {
    @State private var isExpanded: Bool = false
    
    let task: Task
    
    var body: some View {
        content
            .padding(.leading)
            .frame(maxWidth: .infinity)
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 5) {
            header
            if isExpanded {
                SubtaskCell(task: task.subtask)
                .padding(.leading)
            }
            Divider()
        }
    }
    
    private var header: some View {
        HStack {
            Text(task.title)
            Spacer()
            Image(systemName: "chevron.down")
                .foregroundColor(Color.primary.opacity(0.2))
            Spacer()
                .frame(width:20)
        }
        .contentShape(Rectangle())
        .padding(.vertical, 4)
        .onTapGesture {
            withAnimation { isExpanded.toggle() }
        }
    }
}

// swiftlint:disable all
struct FAQView: View {
    private let tasks: [Task] = [
        Task(title: "Apakah Exzo akan menjual data pribadi pengguna ?",
             subtask: Subtask(title: "Tidak, kami tidak akan menjual ataupun mengakses data personal yang pengguna masukan.", height: 50)),
        Task(title: "Apakah Exzo dapat membaca jurnal pengguna?", subtask: Subtask(title: "Selain dari sistem, kami tidak dapat melihat dan memiliki akses untuk melakukannya.", height: 40)),
        Task(
            title: "Apakah Exzo dapat membantu mengatur Eksim yang saya punya ?",
            subtask:
                Subtask(title: "Kami adalah aplikasi yang dapat membantumu untuk melacak kegiatan sehari-hari dan membantumu untuk melihat pola kambuh eksim yang dimiliki. Tapi semua kegiatan dan keputusan yang kamu lakukan adalah hal utama untuk mengatur eksim.", height: 100)
            
        ),
        Task(title: "Apakah analisis yang didapat 100% akurat?", subtask: Subtask(title: "Ini tidak 100% akurat, akan tetapi tergantung dari seberapa detail, sering, dan benarnya dari Jurnal yang kamu masukan.", height: 50)),
        Task(title: "Apakah saya dapat memindahkan semua jurnal saya ke dawai lain ?", subtask: Subtask(title: "Untuk saat ini Exzo hanya dapat menyimpan data secara internal di dawai masing-masing. Tetapi kami sedang mengembangkan agar Exzo dapat lebih mudah akses.", height: 80)),
        Task(title: "Apa Exzo bekerja sama dengan Ahli yang berakreditasi?", subtask: Subtask(title: "Saat ini kami memiliki dermatologis yang ikut serta membantu membangun. Akan tetapi kami tentunya akan bekerja sama dengan insitusi eksim lokal yang ada di Indonesia. ", height: 80))
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                Text("Pertanyaan yang Sering Ditanyakan (F.A.Q)")
                    .fontWeight(.bold)
                    .scaledFont(name: "Avenir", size: 22)
                ForEach(tasks) { task in
                    TaskCell(task: task)
                        .animation(.default)
                }
                
            }
            .navigationTitle("FAQ")
        }
            
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}
