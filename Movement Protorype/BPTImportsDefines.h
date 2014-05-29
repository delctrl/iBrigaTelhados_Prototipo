//
//  BPTImportsDefines.h
//  Movement Protorype
//
//  Created by LEON SALGUEIRO VALIENGO BERNI on 29/05/14.
//  Copyright (c) 2014 LEON SALGUEIRO VALIENGO BERNI. All rights reserved.
//

/** @ref begins **/
#define HEIGHT_TILE 70 /** @note Altura da tile na tela **/
#define WIDTH_TILE 140 /** @note Largura da tile na tela **/
#define CHAR_SIZE_RATE 1.5 /** @note Escala do personagem em relação às tiles **/
#define SCALE 0.6 /** @note wtf **/
#define CHAR_DIFF_X 10 /** @note Diferença de posição do personagem no eixo X, quando em comparação com o local da tile **/
#define CHAR_DIFF_Y 10 /** @note Diferença de posição do personagem no eixo Y, quando em comparação com o local da tile **/
#define MAP_H 5 /** @note Quantidade de tiles no eixo Y, considerar leitura de arquivo **/
#define MAP_W 5 /** @note Quantidade de tiles no eixo X, considerar leitura de arquivo **/
/** @ref ends **/

#import <Foundation/Foundation.h>

@interface BPTImportsDefines : NSObject

@property CGSize cgsTileSize;

@end

/** 
 Padronização do Código:
 
 O código será escrito inteiramente em inglês, com comentários em português.
 Nomes de classes seguirão o formato: BPTName.
 Nomes de variáveis começarão com a abreviação do nome da classe. Ex.: Character * charName; Tile * tileName; UIButton * btnName.
 Tentar utilizar ao máximo arrays, ao invés de criar vários objetos como propriedades.
 
 Comentários seguirão o seguinte padrão:
 
 @b---------    Branch mãe.
 @version---    Versão do código, com breve comentário das mudanças.
 @date------    Data da última - grande - mudança.
 @author----    Autor da última - grande - mudança.
 
 @test------    Referência do que deve ser incluido nos testes automatizados.
 @details---    Explicações detalhadas de um método ou parte do código.
 @note------    Notas breves, sobre uma parte do código.
 @bug-------    Bug que ainda falta ser trabalhado.
 @skip------    Parte do código não utilizada, que pode ser útil futuramente, ou parte do código comentada, por qualquer outro motivo.
 @overload--    Se foi feito algum overload e sua descrição.
 
 @ref-------    Parte do código que deve ser refatorada.
 **/