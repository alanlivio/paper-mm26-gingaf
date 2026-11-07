---
title: "gingaf: Headless and Multiplatform Execution of ITU-SBTVD NCL Applications"
hide:
  - navigation
description: "gingaf: Headless and Multiplatform Execution of ITU-SBTVD NCL Applications. ACM MM 2026."
---

<header class="academic-header" markdown="1">
<h1 class="academic-title">gingaf: Headless and Multiplatform Execution of ITU-SBTVD NCL Applications</h1>
<div class="academic-authors">
<div class="academic-author">
<div class="author-name"><a href="https://alanlivio.github.io">Alan Guedes</a></div>
<div class="author-inst">University of Reading</div>
</div>
</div>
<div class="academic-conference">ACM MM 2026</div>
<div class="academic-links" markdown="span">
<a class="academic-link-btn" href="https://dl.acm.org/doi/10.1145/3767308.3834744">
:simple-doi: <span>DOI</span>
</a>
<a class="academic-link-btn" href="assets/pdfs/main.pdf">
:lucide-download: <span>Pre-print</span>
</a>
<a class="academic-link-btn" href="slides/">
:lucide-presentation: <span>Slides</span>
</a>
<a class="academic-link-btn" href="https://github.com/ginga-org-br/gingaf/releases/tag/v0.1.0">
:simple-github: <span>Code Repo</span>
</a>
<a class="academic-link-btn" href="https://github.com/alanlivio/paper-mm26-gingaf">
:simple-github: <span>Paper Repo</span>
</a>
</div>
</header>

<div class="abstract-container" markdown="1">
<div class="abstract-inner" markdown="1">

## Abstract

The Nested Context Language (NCL) is a core component of the ITU-T and SBTVD television standards. It is legally mandated and installed on 100% of certified Digital TV sets and set-top boxes across Brazil and several Latin American countries. This massive deployment impacts over 60 million people. However, the ecosystem of NCL development tools is limited. In this context, we present <span style="font-variant: small-caps;">gingaf</span>, an open-source implementation of an NCL player built in Flutter. It supports a headless execution engine that schedules NCL events in-memory without requiring any UI and provides a foundation for NCL developer tooling. We also proposed a UI component that achieves multiplatform visual rendering of NCL documents on Windows, mobile, and Web from a single codebase.

</div>
</div>

## Architecture

<span style="font-variant: small-caps;">gingaf</span> is built around two main components (Figure below): the NCL Logic as a self-contained execution engine that manages the NCL event state machine with no knowledge of any display context; and NCL UI as a Flutter widget that drives the engine and maps its output to native platform widgets.

![gingaf Architecture](assets/image.png)

## Example: Multiplatform Execution

The following NCL code (`video.ncl`) demonstrates a simple video presentation with two synchronized background images that appear sequentially. This illustrates the capabilities of NCL for multiplatform environments.

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

## Multi-platform Demos

<table>
  <tbody>
    <tr>
      <td align="center" width="50%">
        <img src="assets/gifs/windows.gif" /><br />
        Windows
      </td>
      <td align="center" width="50%">
        <img src="assets/gifs/android.gif" /><br />
        Android
      </td>
    </tr>
    <tr>
      <td align="center" width="50%">
        <img src="assets/gifs/chrome.gif" /><br />
        Chrome
      </td>
      <td align="center" width="50%">
        <img src="assets/gifs/cli.gif" /><br />
        CLI (headless execution)
      </td>
    </tr>
  </tbody>
</table>

## Execution Instructions

To run the <span style="font-variant: small-caps;">gingaf</span> (either the presentation layer with GUI or the headless execution engine for testing), execute the following commands:

```bash
git clone -b v0.1.0 https://github.com/ginga-org-br/gingaf
cd gingaf/ncldoc
make deps
dart lib/main.dart ../ginga/examples/video.ncl
cd ../ginga
make deps # See SETUP.md for environment configuration
flutter run -d <chrome,windows,emulator-XXXX> --dart-define="APP=examples/video.ncl"
```

## Citation

```bibtex
@inproceedings{gingaf2026,
    author    = {Guedes, Alan},
    title     = {gingaf: Headless and Multiplatform Execution of ITU-SBTVD NCL Applications},
    booktitle = {Proceedings of the 34th ACM International Conference on Multimedia},
    location  = {Rio de Janeiro, Brazil},
    year      = {2026},
    doi       = {10.1145/3767308.3834744},
    url       = {https://dl.acm.org/doi/10.1145/3767308.3834744},
    series    = {MM '26}
}
```

<footer class="academic-footer md-typeset">
<p>Built with <a href="https://zensical.org" rel="nofollow">Zensical</a> based on <a href="https://research-template.roman.technology" rel="nofollow">Roman Hauksson-Neill's project page template</a></p>
</footer>
