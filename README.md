Aplicativo A Industrial Soluções

Este projeto Flutter foi desenvolvido para profissionais da área elétrica, como eletricistas e técnicos.
O aplicativo oferece diversas calculadoras e ferramentas baseadas nas normas NBR 5410 e NBR
17094, otimizando o dimensionamento e análise de circuitos e componentes elétricos.

Funcionalidades

 Cálculo da bitola mínima de fios com base na corrente elétrica
 Estimativa de consumo elétrico em R$
 Conversão entre potência real (W) e potência aparente (VA) considerando o fator de potência
 Dimensionamento de eletrodutos segundo limites de ocupação normativos
 Cálculo de corrente elétrica para motores monofásicos e trifásicos
 Dimensionamento de contatoras e relés térmicos
 Gerenciamento de orçamentos com armazenamento local em SQLite
 Acesso rápido a informações técnicas com referências normativas

Tecnologias Utilizadas

 Flutter (SDK de desenvolvimento multiplataforma)
 Dart (linguagem de programação)
 SQLite (armazenamento local com os pacotes sqflite e sqflite_common_ffi)
 Shared Preferences (armazenamento de configurações e dados simples)
 Vibration (feedback tátil)
 flutter_math_fork (renderização de fórmulas em LaTeX)
 url_launcher (abertura de links externos)

Como Executar o Projeto

1. Pré-requisitos
 Ter o Flutter instalado (versão 3.10 ou superior recomendada)
 Ter um emulador Android, iOS ou dispositivo físico configurado
2. Clonar o repositório
git clone https://github.com/Stieglerr/A_Industrial_APP_Flutter
cd A_Industrial_APP_Flutter
3. Instalar dependências
flutter pub get
4. Rodar o aplicativo
 Em dispositivo físico ou emulador Android/iOS:
 flutter run
 Para rodar em desktop (Windows, Linux ou macOS):
 Adicione o seguinte no main.dart antes de rodar o app:
 import 'package:sqflite_common_ffi/sqflite_ffi.dart';
 void main() {
 sqfliteFfiInit();
 databaseFactory = databaseFactoryFfi;
 runApp(MyApp());
 }

Detalhes Técnicos

Fórmulas Utilizadas
 Corrente (A) = Potência (W) / Tensão (V)
 Potência Aparente (VA) = Potência Real (W) / Fator de Potência
 Corrente Motor Trifásico = (CV × 735.5) / (raiz(3) × V × FP × rendimento)
 Eletrodutos são dimensionados considerando número de cabos e limites da NBR 5410

Armazenamento Local com SQLite

O módulo de orçamentos salva os dados diretamente no dispositivo usando SQLite. Isso permite:
 Funcionar offline
 Persistir dados entre sessões
 Consultar e editar orçamentos anteriores

Licença

Este projeto é de uso livre para fins acadêmicos e educacionais.
Em caso de dúvidas, entre em contato pelo GitHub: https://github.com/Stieglerr

Autor
Desenvolvido por Lucas Stiegler
https://github.com/Stieglerr

DOWNLOAD APK

https://drive.google.com/drive/folders/1Ui6NOKqbbID_dlFGGwYWb923DuYE5wb6?usp=sharing
