//
//  FlowLayout.swift
//  FriendFace
//
//  Created by Igor Florentino on 28/05/24.
//

import SwiftUI

struct FlowLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
	
	var items: Data
	//itens que serão usados para construir o flowLayout. esses itens precisam estar dentro de uma coleção que implementa o RandomAccessCollection para poderem ser usados dentro de um ForEach e cada item dentro da coleçao precisa ser hashable
	var spacing: CGFloat = 4
	//qual o espaçamento deve ser dado entre cada um dos itens. esse numero precisa ser do tipo CGFloat pois representa valores de UI
	var content: (Data.Element) -> Content
	//a closure que deve ser passar na construçao da estrutura. essa closura pega um elemento dentro da coleçao e transforma num Content, um tipo de dado que implementa o protocolo View
	
	@State private var totalHeight: CGFloat = .zero
	//variavel usada para armazenar a altura total da view
	
	var body: some View {
		GeometryReader { geometry in
			// geometry é uma instancia do tipo GeometryProxy que nos da acesso as dimensoes do conteiner pai
			self.generateContent(in: geometry)
			//funçao usada para gerar as views para cada um dos elementos dentro da coleçao data
		}
		//gera o conteudo dentro de uma view GeometryReader para que tenhamos acesso as dimensoes do conteiner pai
		.frame(height: totalHeight)
		//setamos o frame do geometryReader para totalHeight para que o conteiner pai use essa dimensão como referencia na hora de renderiza-lo
	}
	
	private func generateContent(in geometry: GeometryProxy) -> some View {
		// a funçao usada para gerar as views, por isso o retorno deve do tipo some View
		var width = CGFloat.zero
		var height = CGFloat.zero
		
		return ZStack(alignment: .topLeading) {
			// cria cada view dentro de um Zstack para termos liberdade de posicionar cada item manualmente na stck
			ForEach(items, id: \.self) { item in
				//interege em loop para todos os itens da coleçao
				self.content(item)
				//cria uma view para cada item de acordo com o que será passado na closure quando FlowLayout for chamado
					.padding([.horizontal, .vertical], self.spacing)
				//da um espaçamento horizonal e vertical para cada item de acordo com valor definido na propriedade spacing
					.alignmentGuide(.leading, computeValue: { dimension in
						//alinha a view do item verticalmente dentro do container Zstack.
						//dimension é uma variavel que contem as dimensoes da view em questao
						//leading significa que estamos usando o lado superior esquerdo do item como referencia
						if (abs(width - dimension.width) > geometry.size.width) {
							// verifica se temos largura disponivel
							// with representa quanto de largura ja foi consumida pelos itens
							// dimension.with representa a largura do item atual
							// geometry.size.with representa qual o valor total horizontal disponivel por linha
							// o valor dentro de abs() representa quanto seria consumido horizontalmente caso insejamos o item na linha atual
							width = 0
							height -= dimension.height
							// se a lagura do item em conjunto com o que ja foi consumido é maior do que o tamanho disponivel devemos pular uma linha do tamanho da altura do item e resetar a largura consumida.
						}
						//caso nao seguimos com a logica padrao de inserir o item na linha atual
						let result = width
						// enviamos o valor do que ja foi consumido para ser usado para posicionar o item
						if item == self.items.last {
							width = 0
							//Ao redefinir width para 0 no último item, garantimos que futuras iterações do layout não comecem com um valor acumulado que pode causar desalinhamento dos itens
							//Para manter a consistência, é uma prática comum redefinir variáveis de controle ao final de um processo iterativo.
						} else {
							width -= dimension.width
							//caso contrario o valor consumido de largura é adicionado com o valor da largura do item para ser usado pelo proximo item
						}
						return result
					})
					.alignmentGuide(.top, computeValue: { _ in
						//define um guia de alinhamento vertical para cada item, especificando onde o topo (top) do item deve ser posicionado.
						//indica que não estamos usando o parâmetro fornecido pelo alignmentGuide porque a posição vertical não depende das dimensões do item atual, mas sim da posição acumulada (height).
						//o valor consumido verticalmente esta sendo calculado no modificador aligmnentGuida anterior, aqui precisamos apenas enviar o valor para posicionar o item
						let result = height
						// enviamos o valor do que ja foi consumido para ser usado para posicionar o item
						if item == self.items.last {
							height = 0
							//Isto é similar ao que fazemos com a largura (width), garantindo que futuras iterações do layout comecem com um valor inicial limpo.
						}
						return result
					})
			}
		}
		.background(viewHeightReader($totalHeight))
		//viewHeightReader é chamado, que adiciona um GeometryReader invisível (Color.clear) atrás do conteúdo.
	}
	
	private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
		GeometryReader { geometry in
			//O GeometryReader dentro de viewHeightReader mede a altura total do conteúdo.
			DispatchQueue.main.async {
				binding.wrappedValue = geometry.size.height
				//A atualização de totalHeight desencadeia uma nova renderização do FlowLayout com a altura correta.
			}
			return Color.clear
			//Usar uma view invisível (Color.clear) dentro de .background() assegura que a medição não afete a aparência do layout.
		}
	}
}

#Preview {
	FlowLayout(items: ["Swift", "Combine", "SwiftUI", "Xcode", "iOS", "macOS", "watchOS", "tvOS", "CoreData", "CloudKit"]) { tag in
		Text(tag)
			.padding(.all, 5)
			.background(Color.green)
			.cornerRadius(5)
	}
}
