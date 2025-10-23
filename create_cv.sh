
#!/usr/bin/env bash
# ===============================================
# Script: create_moderncv_project.sh
# Purpose: Create a professional LaTeX CV project (XeLaTeX + moderncv)
# Author: Ginko
# ===============================================

set -euo pipefail

PROJECT_NAME="cv_project_moderncv"

echo ">>> Creating XeLaTeX CV project: $PROJECT_NAME"

# ─── Create folder structure ─────────────────────────────────────────────
mkdir -p "$PROJECT_NAME"/{contents,figures}

cd "$PROJECT_NAME"

# ─── Create main.tex ─────────────────────────────────────────────────────
cat <<'EOF' > main.tex
% =======================
% main.tex — Ginko's CV (moderncv)
% =======================
\documentclass[11pt,a4paper,sans]{moderncv}

% Style & color theme
\moderncvstyle{classic} % options: classic, casual, banking, oldstyle, fancy
\moderncvcolor{blue}    % options: blue, orange, green, red, purple, grey, black

% Load shared preamble
\input{preamble.tex}

% Personal info
\name{Ginko}{Nguyen}
\title{Embedded Systems Engineer}
\email{ginko@example.com}
\phone[mobile]{+84-XXX-XXX-XXX}
\social[github]{ginko-dev}
\photo[64pt][0.4pt]{figures/avatar.jpg}

\begin{document}
\makecvtitle

\input{contents/education.tex}
\input{contents/experience.tex}
\input{contents/skills.tex}
\input{contents/projects.tex}

\end{document}
EOF

# ─── Create preamble.tex ─────────────────────────────────────────────────
cat <<'EOF' > preamble.tex
% =======================
% preamble.tex — XeLaTeX setup
% =======================
\usepackage{fontspec}
\usepackage{xunicode}
\usepackage{xltxtra}
\usepackage{graphicx}
\usepackage{hyperref}
\usepackage{enumitem}

% Fonts (customize freely)
\setmainfont{Fira Sans}
\setsansfont{Fira Sans}
\setmonofont{Fira Mono}

% Document setup
\hypersetup{
    colorlinks=true,
    urlcolor=blue,
    linkcolor=black
}
EOF

# ─── Create content files ────────────────────────────────────────────────
cat <<'EOF' > contents/education.tex
\section{Education}
\cventry{2020--2024}{Bachelor of Telecommunications Engineering}{Hanoi University of Science and Technology}{Hanoi}{}{Thesis: \emph{Embedded Fall Detection System using ESP32 and 4G-GPS Module.}}
EOF

cat <<'EOF' > contents/experience.tex
\section{Experience}
\cventry{2023--Present}{Embedded Systems Developer}{Freelance / Research}{Remote}{}{
\begin{itemize}[leftmargin=*]
  \item Designed modular ESP-IDF components for communication (UART/I2C/PWM).
  \item Developed fall detection algorithm integrated with MPU6050 and EC800K module.
  \item Focus on efficient, reusable architecture and real-time performance.
\end{itemize}}
EOF

cat <<'EOF' > contents/skills.tex
\section{Skills}
\cvitem{Programming}{C, Python, Bash, CMake}
\cvitem{Embedded}{ESP-IDF, STM32 HAL, FreeRTOS}
\cvitem{Tools}{Neovim, tmux, Git, Linux, KiCad}
\cvitem{Soft Skills}{Systematic thinking, efficiency-driven, detail-oriented}
EOF

cat <<'EOF' > contents/projects.tex
\section{Projects}
\cvitem{Fall Detection System}{An IoT-based safety system using ESP32, MPU6050, and EC800K module to detect falls and send alerts with GPS data.}
\cvitem{CLI Workflow Toolkit}{Built a customized CLI workflow with Vim, tmux, and shell scripting for maximal control and speed.}
EOF

# ─── Create .latexmkrc (build config) ────────────────────────────────────
cat <<'EOF' > .latexmkrc
# ===============================
# Latexmk config (XeLaTeX + Biber)
# ===============================
$pdflatex = 'xelatex -shell-escape -interaction=nonstopmode -synctex=1 %O %S';
$biber = 'biber %O %B';
$pdf_previewer = 'zathura %S';
$recorder = 1;
$cleanup_includes_cusdep_generated = 1;
@generated_exts = qw(aux bbl bcf blg fdb_latexmk fls log out run.xml toc lof lot lol synctex.gz);
$pdf_mode = 1;
$force_mode = 1;
$pvc_view_file_via_temporary = 0;
EOF

# ─── Summary ─────────────────────────────────────────────────────────────
echo ">>> CV project created successfully!"
echo "Project structure:"
tree -a -I '.*swp' .
echo ""
echo "To build: cd $PROJECT_NAME && latexmk -xelatex main.tex"
