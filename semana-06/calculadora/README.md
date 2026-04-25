# 📱 Calculadora Clon de Samsung S25 Ultra

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android" />
  <img src="https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white" alt="Windows" />
</div>

<br>

Una calculadora moderna, rápida y multiplataforma desarrollada en **Flutter**, diseñada meticulosamente para replicar la experiencia e interfaz de usuario (**One UI 6**) nativa de los dispositivos **Samsung Galaxy S25 Ultra**.

---

## ✨ Características Principales

- 🌑 **Dark Mode Nativo**: Diseño _edge-to-edge_ con un fondo negro puro (`#000000`) para aprovechar al máximo las pantallas OLED.
- 🟢 **Paleta de Colores One UI**: Botones circulares precisos en gris oscuro con los clásicos acentos en **verde vibrante** para operadores matemáticos y botón de igual (`=`).
- 🕒 **Modal de Historial Interactivo**: Incorpora el icónico botón de reloj (Historial) en la barra de herramientas que despliega una elegante lámina inferior (_Bottom Sheet_) con todo el registro de operaciones. ¡Totalmente editable al toque!
- 🎨 **Fondo Personalizable**: Soporte integrado para fondos de pantalla detrás de la interfaz (como imágenes de anime) con un sutil filtro oscuro para mantener la legibilidad de la calculadora.
- 📐 **Diseño Responsivo**: Limitado estratégicamente a 400px de ancho para mantener su aspecto de _smartphone_ vertical sin importar si se ejecuta en Windows, Web o Mac.

---

## 🛠️ Tecnologías Utilizadas

- **[Flutter](https://flutter.dev/)**: Framework principal para el renderizado de la UI multiplataforma.
- **Dart**: Lenguaje de programación enfocado en cliente para aplicaciones rápidas.
- **StatefulWidget**: Manejo reactivo del estado de la calculadora sin librerías de terceros, manteniendo el proyecto ultraligero.

---

## 🚀 Instalación y Uso

Asegúrate de tener instalado el SDK de [Flutter](https://docs.flutter.dev/get-started/install) en tu máquina.

1. **Clona el repositorio** o navega hasta el directorio del proyecto:
   ```bash
   cd semana-06/calculadora
   ```
2. **Obtén las dependencias** (aunque es puramente Flutter nativo):
   ```bash
   flutter pub get
   ```
3. **Ejecuta la aplicación**:
   ```bash
   flutter run
   ```

> [!TIP]
> **Modificación del Fondo:** Puedes cambiar tu fondo reemplazando el archivo `anime.jpg` ubicado en la carpeta `assets/images/`.

---

## 📂 Estructura del Proyecto

```text
📦 calculadora
 ┣ 📂 assets
 ┃ ┗ 📂 images           <-- Imágenes de fondo personalizadas
 ┣ 📂 lib
 ┃ ┣ 📂 screens
 ┃ ┃ ┗ 📜 calculator_screen.dart   <-- Lógica principal y UI de la calculadora
 ┃ ┗ 📜 main.dart                  <-- Punto de entrada y configuración de One UI Theme
 ┣ 📜 pubspec.yaml                 <-- Configuración de dependencias y assets
 ┗ 📜 README.md                    <-- Este archivo
```

---

<div align="center">
  <b>Desarrollado con ❤️ usando Flutter</b>
</div>
