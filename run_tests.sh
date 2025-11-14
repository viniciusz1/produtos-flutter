#!/bin/bash

echo "====================================="
echo "Executando Testes Automatizados"
echo "====================================="
echo ""

echo "1. Testando Modelos..."
flutter test test/models/

echo ""
echo "2. Testando Telas..."
flutter test test/screens/

echo ""
echo "3. Testando Aplicação Principal..."
flutter test test/main_test.dart

echo ""
echo "4. Testando Widget Principal..."
flutter test test/widget_test.dart

echo ""
echo "5. Executando Testes de Integração..."
flutter test test/integration/

echo ""
echo "====================================="
echo "Executando TODOS os testes..."
echo "====================================="
flutter test

echo ""
echo "====================================="
echo "Testes Concluídos!"
echo "====================================="

