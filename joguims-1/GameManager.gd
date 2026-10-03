extends Node

var paginas := 0
const TOTAL_PAGINAS := 7
var pecas := 0
const TOTAL_PECAS := 5

func coletar_pagina():
	paginas += 1

	print("Páginas:", paginas, "/", TOTAL_PAGINAS)

	if paginas >= TOTAL_PAGINAS:
		print("Todas as páginas coletadas!")
