---
marp: true
theme: default
paginate: true
header: 'gingaf: Headless & Multiplatform NCL Execution — ACM MM 2026'
---

<style>
.grayscale {
  filter: grayscale(100%);
}
</style>

<!--
_paginate: false
_header: ""
-->

<div style="display: grid; grid-template-columns: 3fr 1fr; align-items: center;">

<div>

# gingaf: Headless and Multiplatform Execution of ITU-SBTVD NCL Applications

**Alan L. V. Guedes**
Computer Science, University of Reading, UK

*ACM International Conference on Multimedia (MM '26)*
Rio de Janeiro, Brazil

**Paper Website (slides, code, demo)**:
https://alanlivio.github.io/paper-mm26-gingaf/

</div>

<div style="display: flex; flex-direction: column; justify-content: center;">

<img src="assets/uor.svg" height="300" class="grayscale" />

<img src="assets/qrcode.svg" height="300" />

</div>

</div>

---

# Agenda

- **Context**
- **Proposed Solution**
- **Results**
- **Final Remarks**

---

# Context

**Nested Context Language (NCL)**
- Core standard of ITU-T H.761 and SBTVD ABNT 15606-2.
- Legally mandated on 100% of certified Digital TV receivers in Latin America (>60M viewers).

**Strategic Reach & The Tooling Gap**
- Deployed in national public programs (e.g., Brazil4D) and TV 3.0 standards.
- Despite high reach, developer tooling and accessible testing environments remain severely restricted.
---

# Context

<div style="display: grid; grid-template-columns: 3fr 2fr">

<div>

**P1: Lack of Accessible Development Environments**
- Legacy Ginga players require dedicated Linux installations and heavy media frameworks (SDL, GStreamer, FFmpeg).
- Web execution was previously impossible due to native desktop library dependencies.

**P2: Lack of Debugging & Inspection Features**
- Tight coupling between presentation UI and document state machine.
- Inability to pause execution, advance time deterministically, or inspect intermediate states in memory.

</div>

<div>

</div>

</div>

---

# Key Architectural Insight: Decoupling

<div style="display: grid; grid-template-columns: 3fr 2fr">

<div>

**Legacy Architecture Limitations**
- Bidirectional coupling between NCL logic and UI rendering.
- State machines could not execute without active display contexts and native audio/video decoders.

**gingaf Solution**
- Standalone, headless Dart package (`ncl_doc`).
- Isolated UI presentation within Flutter widget layer (`ncl_app`).
- Communication is strictly unidirectional from the UI layer to the headless engine (`tick()`).

</div>

<div>

<img src="assets/coupled.png" />

<img src="assets/arch.png" />

</div>

</div>

---

# Architectural Overview & NCL DOM

<div style="display: grid; grid-template-columns: 3fr 2fr">

<div>

**Headless NCL Logic (`ncl_doc`)**
- In-memory event state machine managing media nodes, areas, and links.
- Independent of rendering backends, operating systems, and display drivers.

**NCL DOM Hierarchy**
- Element $\rightarrow$ Node $\rightarrow$ Media, Composition, Context, Switch, NCLua.

**Multiplatform Presentation (`ncl_app`)**
- Flutter widget driving visual media, layout, and rendering.
- Single codebase targeting Windows, Linux, macOS, iOS, Android, and Web.

</div>

<div>

<img src="assets/elem_tree.png" />

</div>

</div>

---

# Headless Execution & Deterministic Testing

**Virtual Clock Mechanism**
- Allows advancing simulated playback time arbitrarily without waiting for real-world elapsed seconds.

**Fast-Forward State Inspection**
- Execute thousands of ticks per second for rapid integration testing and automated regression suites.

**Time-Travel Debugging**
- Step forward and backward through NCL events to pinpoint race conditions or invalid link triggers.

---

# Multiplatform Visual Presentation

**Unified Cross-Platform Engine**
- Single codebase runs natively across desktop (Windows), mobile (Android), and browser (Web).
- Video/audio playback hooked directly to headless state machine.

<div style="display: flex; gap: 16px; justify-content: center; align-items: flex-end; margin-top: 15px;">
  <div style="text-align: center;">
    <img src="assets/app_clock4.png" height="230" style="border-radius: 4px; box-shadow: 0 2px 8px rgba(0,0,0,0.15);" />
    <p style="font-size: 14px; margin-top: 6px; color: #555;">(a) Windows</p>
  </div>
  <div style="text-align: center;">
    <img src="assets/android.png" height="230" style="border-radius: 4px; box-shadow: 0 2px 8px rgba(0,0,0,0.15);" />
    <p style="font-size: 14px; margin-top: 6px; color: #555;">(b) Android</p>
  </div>
  <div style="text-align: center;">
    <img src="assets/web.png" height="230" style="border-radius: 4px; box-shadow: 0 2px 8px rgba(0,0,0,0.15);" />
    <p style="font-size: 14px; margin-top: 6px; color: #555;">(c) Web Browser</p>
  </div>
</div>

---

# Example Execution: video.ncl

```xml
<ncl>
  <body>
    <port id="init" component="video"/>
    <media id="video" src="https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4">
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
    <link id="l1">
      <bind role="onBegin" component="video" interface="a1"/>
      <bind role="start" component="green_bg"/>
    </link>
    <link id="l2">
      <bind role="onEnd" component="video" interface="a1"/>
      <bind role="stop" component="green_bg"/>
      <bind role="start" component="red_bg"/>
    </link>
  </body>
</ncl>
```

---

# Example Execution: video.ncl

<div style="display: grid; grid-template-columns: 3fr 2fr">

<div>

**Temporal Synchronization Scenario**
- Main video plays from `0s` to `7s`.
- Area anchor `a1` spans from `2s` to `4s`.
- Link `l1`: When `a1` begins (`2s`), green background starts.
- Link `l2`: When `a1` ends (`4s`), green stops and red starts for `2s`.

**Deterministic Consistency**
- All targets display identical synchronized state at `t=2s`, `t=4s`, and `t=6s`.

</div>

<div>

<img src="assets/web.png" />

</div>

</div>

---

# Final Remarks

- Headless execution engine enabling in-memory unit testing and deterministic debugging.
- Cross-platform presentation across mobile, desktop, and web from a single codebase.
- Reproducible artifacts, interactive demos, and source code available openly.

---

<!--
_paginate: false
_header: ""
-->

# Thank You!

<div style="display: grid; grid-template-columns: 3fr 2fr">

<div>

### Questions & Discussion

- **Repository**: https://github.com/ginga-org-br/gingaf
- **Contact**: `a.guedes@reading.ac.uk`

</div>

<div>

<img src="assets/portal1.png" />

</div>

</div>
