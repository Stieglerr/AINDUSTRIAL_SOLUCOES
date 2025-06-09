⚡ Aplicativo A Industrial Soluções
Projeto Flutter desenvolvido para profissionais da área elétrica, como eletricistas e técnicos, oferecendo calculadoras e ferramentas essenciais com base nas normas NBR 5410 e NBR 17094.
O objetivo é otimizar o dimensionamento e a análise de circuitos e componentes elétricos, mesmo offline.

🔧 Funcionalidades
🔌 Cálculo da bitola mínima de fios com base na corrente elétrica

💡 Estimativa de consumo elétrico (R$)

🔁 Conversão entre potência real (W) e potência aparente (VA) com fator de potência

📏 Dimensionamento de eletrodutos conforme limites da NBR 5410

⚙️ Cálculo de corrente elétrica para motores monofásicos e trifásicos

🔒 Dimensionamento de contatoras e relés térmicos

📊 Gerenciamento de orçamentos com armazenamento local (SQLite)

📚 Acesso rápido a informações técnicas e referências normativas

🗺️ Integração com Google Maps para visualização de localizações técnicas e suporte à geolocalização

🛠️ Tecnologias Utilizadas

💙 Flutter (SDK multiplataforma)

🎯 Dart (linguagem principal)

🗃️ SQLite (sqflite e sqflite_common_ffi)

⚙️ Shared Preferences (configurações locais)

📳 Vibration (feedback tátil)

🔣 flutter_math_fork (renderização LaTeX de fórmulas)

🌐 url_launcher (acesso a links externos)

🗺️ Google Maps API (serviços de mapa e geolocalização)

▶️ Como Executar o Projeto

1. Pré-requisitos

Flutter instalado (versão 3.10 ou superior recomendada)

Emulador Android/iOS ou dispositivo físico configurado

2. Clonar o Repositório

git clone https://github.com/Stieglerr/A_Industrial_APP_Flutter

cd A_Industrial_APP_Flutter

3. Instalar Dependências

flutter pub get

4. Executar o App

Em emulador ou dispositivo físico:

flutter run

Para rodar no Desktop (Windows, Linux, macOS):

Adicione no main.dart:


import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(MyApp());
}
5. Configurar a API do Google Maps

Este projeto utiliza o Google Maps, portanto é necessário adicionar sua chave de API:

Android

No arquivo android/app/src/main/AndroidManifest.xml, adicione dentro da tag <application>:

<meta-data
  android:name="com.google.android.geo.API_KEY"
  android:value="SUA_CHAVE_DE_API_AQUI"/>
  
iOS

No arquivo ios/Runner/AppDelegate.swift, adicione:

GMSServices.provideAPIKey("SUA_CHAVE_DE_API_AQUI")

Certifique-se de ativar o serviço do Google Maps na Google Cloud Console.

📐 Fórmulas Utilizadas

Corrente (A) = Potência (W) / Tensão (V)

Potência Aparente (VA) = Potência Real (W) / Fator de Potência

Corrente Trifásica (A) = (CV × 735.5) / (√3 × V × FP × Rendimento)

Dimensionamento de eletrodutos conforme cabos e limites da NBR 5410

💾 Armazenamento Local com SQLite

O módulo de orçamentos:

Funciona offline

Persiste dados entre sessões

Permite consultar, editar e excluir orçamentos anteriores

📄 Licença

Este projeto é livre para fins acadêmicos e educacionais.

Dúvidas? Entre em contato:

GitHub - Stieglerr

👨‍💻 Autor

Desenvolvido por: Lucas Stiegler

📱 Download do APK
👉 Clique aqui para baixar o apk: https://drive.google.com/drive/folders/1Ui6NOKqbbID_dlFGGwYWb923DuYE5wb6?usp=sharing
