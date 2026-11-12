---
marp: true
theme: default
paginate: true
header: '<span>gingaf: Headless and Multiplatform Execution of ITU-SBTVD NCL Applications — ACM MM 2026</span><span>Alan Guedes</span>'
style: |
  @import url('https://cdn.jsdelivr.net/gh/alanlivio/marp-utils@v0.1/marp-utils.css');
---

<!--
_paginate: false
_header: ""
_class: cols-3-1 vcenter
-->

- # gingaf: Headless and Multiplatform Execution of ITU-SBTVD NCL Applications

  **Alan L. V. Guedes**
  Computer Science, University of Reading, UK

  *ACM International Conference on Multimedia (MM '26)*
  Rio de Janeiro, BR

  **Paper Website (slides, code, demo)**:
  https://alanlivio.github.io/paper-mm26-gingaf/

- ![h:300 grayscale](assets/uor.svg)

  ![h:300](assets/qrcode.svg)

---

# Agenda

- **Context & Problem Definition**
- **Proposed Solution**
- **gingaf Features & Demo**
- **Final Remarks**

---

<!-- _class: invert -->
<!-- _paginate: skip -->

# Context & Problem Definition

---

<!-- _class: grid-2x2 -->

# Context: Ginga is a TV software (>60M TV set-top boxes in South America)

- ![h:215](assets/Picture1.png)

- ![h:215](assets/Picture2.jpg)

- ![h:215](assets/Picture3.png)

- ![h:215](assets/Picture4.jpg)

---

# Context: Ginga is an academic-led effort

![w:700 center](assets/image-4.png)

---

<!-- _class: cols-3-1 vcenter -->

# Context: Ginga plays NCL documents

## Example video.ncl

- ```xml
  <media id="video"  src="butterfly.mp4">
      <area id="a1" begin="2s" end="4s"/>
  </media>
  <media id="green_bg">
      <property name="background" value="green"/>
      <property name="bounds" value="0%,80%,20%,20%"/>
  </media>
  <media id="red_bg">
      <property name="background" value="red"/>
      <property name="bounds" value="80%,80%,20%,20%"/>
      <property name="explicitDur" value="2s"/>
  </media>
  ...
  ```

- ![h:210](assets/app_clock2.png)

  ![h:210](assets/app_clock4.png)

---

<!-- _class: cols-3-1 vcenter -->

# Context: Ginga plays NCL documents

## Example video.ncl

- ```xml
  ...
  <port id="init" component="video"/>
  <link id="l1">
      <bind role="onBegin" component="video" interface="a1"/>
      <bind role="start" component="green_bg"/>
  </link>
  <link id="l2">
      <bind role="onEnd" component="video" interface="a1"/>
      <bind role="stop" component="green_bg"/>
      <bind role="start" component="red_bg"/>
  </link>
  ```

- ![h:210](assets/app_clock2.png)

  ![h:210](assets/app_clock4.png)

---

# Context: Other TV systems also have XML-based languages

![w:700 center](assets/image-3.png)

---

# Problem definition: Complexity

![w:700 center](assets/image-2.png)

---

<!-- _class: cols-2 vcenter -->

# Problem definition: no "zero-install"

Compare Mozilla (https://developer.mozilla.org/) with Ginga-VM (2010)

- ![w:500](assets/image.png)

- ![w:500](assets/image-1.png)

---

<!-- _class: invert -->
<!-- _paginate: skip -->

# Proposed Solution

---

# Proposed Solution: portable multimedia engine

<div class="cols-3 spread vcenter">

- **PUC-Rio (Java AWT)**
  **PUC-Rio (C++, FFmpeg)**
  **PUC-Rio (C++, GStreamer)**

- <span style="font-size: 30px; font-weight: 800; color: #0969da;">gingaf (ours)</span>
  <span style="font-size: 18px; font-weight: 700; color: #0969da;">Ginga-NCL + Ginga-HTML5</span>

- **PUC-Rio (Netscape)**
  **UFSCar (WebNCL)**
  **Sidia NuGinga (NodeJS)**

</div>

<div class="banner">

![](assets/dart.svg) **Dart** ![](assets/flutter.svg) **Flutter**

</div>

<div class="cols-3 spread vcenter">

- **Native**
  ![h:95](assets/setupbox.png) ![h:95](assets/pc.png)

-

- **Browser**
  ![h:75](assets/browsers.png)

</div>

---

<!-- _class: cols-3 center -->

# Proposed Solution: portable multimedia engine

- ![w:500](assets/app_clock4.png)
  (a) Windows

- ![w:200](assets/android.png)
  (b) Android

- ![w:300](assets/web.png)
  (c) Web Browser

---

<!-- _class: cols-2 center -->

# Proposed Solution: Architecture

- **Previous ginga Implementations**

  ![](assets/coupled.png)

  <span style="font-weight: 700; color: #f85149;">No virtual clock & coupled UI-logic</span>

- **`gingaf` Architecture**

  ![](assets/arch.png)

  <span style="font-weight: 700; color: #3fb950;">Virtual clock & decoupled UI-logic</span>

---

# Proposed Solution: Virtual clock

It allows advancing simulated playback time arbitrarily without waiting for real-world elapsed seconds.

![w:600 center](assets/gifs/00syncProp.ncl.gif)

---

<!-- _class: invert -->
<!-- _paginate: skip -->

# Final Remarks

---

<!-- _class: cols-2 -->

# Demos: Playground

- ![w:900](assets/image-5.png)

- ![w:900](assets/playground.gif)

---

# Demos: Playground Debug

![center w:900](assets/playground-debug.gif)

---

<!-- _class: grid-2x2 -->

# Contributions

- **1. Multiplatform Graphics Engine**
  Single Dart/Flutter multiplatform code

- **2. Decoupled UI**
  In-memory NCL state machine isolated from UI rendering

- **3. Virtual Clock**
  Time progression via `tick()` and allow debug

- **4. Open-Source**
  https://github.com/ginga-org-br/gingaf

---

<!--
_paginate: false
_class: cols-1-3
-->

# Thank You!

- **Find more about Ginga** at https://ginga.org.br

  **Contact**: `a.guedes@reading.ac.uk`

- ![](assets/image-5.png)
