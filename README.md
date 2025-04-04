# WAFER: Wavelet Analyzer of g-Forces for Expected Residual Lifetime Evaluation.

This repository provides the full implementation of the **WAFER system**, a wavelet-based predictive maintenance framework for Remaining Useful Life (RUL) estimation and catastrophic failure detection in vehicle suspension systems. The code and data included here were used to generate the results presented in our study.

---

## 📌 Overview

WAFER is an empirical framework for real-time processing of vibration signals acquired from vehicles operating in diverse urban conditions. Using advanced **wavelet transforms**, **energy decomposition**, and **multi-resolution analysis (MRA)**, WAFER allows:

- Accurate RUL estimation of suspension systems
- Real-time prediction of catastrophic failures
- Adaptation to varying road textures and driving patterns

The analysis covers multiple urban segments (Rome and San Diego), showcasing the robustness and generalizability of the method.

---

## 📂 Repository Structure

```
📁 data/
   ├── xyz_2.csv
   ├── xyz_3.csv
   ├── Data_1.csv

📁 results/
   ├── denoiser_xyz_2.eps
   ├── denoiser_xyz_2bis.eps
   ├── denoiser_xyz_3.eps
   ├── denoiser_xyz_3bis.eps
   ├── MRA_xyz_2.eps
   ├── MRA_xyz_2bis.eps
   ├── MRA_xyz_3.eps
   ├── MRA_xyz_3bis.eps
   ├── TABLEU_xyz_2.eps
   ├── TABLEU_xyz_2bis.eps
   ├── TABLEU_xyz_3.eps
   └── TABLEU_xyz_3bis.eps

📁 scripts/
   ├── vibration_1.R
   ├── vibration_2.R
   ├── prog_car.R
   └── graph_paper_car_suspension.R

📄 README.md
```

---

## 📈 Description of Scripts

### `vibration_1.R`

- Performs wavelet denoising using threshold scaling on **TS--c** signal (San Diego).
- Applies MRA and reconstructs filtered signal components.
- Computes energy decomposition via `wavShrink`.
- Includes a simplified test on random data to validate functionality.

### `vibration_2.R`

- Focused signal processing pipeline on two datasets (`xyz_2`, `xyz_3`).
- Produces stacked plots and performs MODWT-based multi-resolution analysis.
- Calculates energy metrics (mean, sum, variance) from D1 component.
- Computes confidence intervals for wavelet variance.
- Implements accelerated estimation path for catastrophic detection.

### `prog_car.R`

- Loads and parses signal data from `Data_1.csv`.
- Applies MODWT using the `wavelets` package.
- Visualizes signal decomposition over multiple levels.
- Demonstrates the effect of suppressing specific wavelet components (e.g., `W1`, `W4`) on signal reconstruction.

### `graph_paper_car_suspension.R`

- Generates all the figures (.eps) used in the paper.
- Performs denoising across various thresholds and segments.
- Visualizes MRA of Rome and San Diego signals.
- Applies `wavMODWT` for advanced decomposition and energy analysis.
- Intended for reproducible academic plotting.

---

## 📊 Methodology Summary

The WAFER pipeline consists of the following steps:

### 1. **Signal Acquisition**
- Data sampled at 15–20 Hz.
- Four trip segments: Rome (TS--a, TS--b) and San Diego (TS--c, TS--d).
- Signals represent vertical vehicle acceleration.

### 2. **Signal Preprocessing**
- Thresholding to remove insignificant G-forces:
  - Rome: 3.15025
  - San Diego: 0.15025

### 3. **Multi-Resolution Analysis (MRA)**
- Extracts relevant frequency components (e.g., D1).
- Applied using MODWT and `la8` wavelet filter.

### 4. **Energy Decomposition**
- Computed via `wavMODWT`, `wavMRD`, and `wavVar`.
- Energy in D1 level is a key degradation indicator.

### 5. **RUL Estimation**
- Predictive model (Equation X in paper) estimates remaining lifespan.
- Synthesizes real-time and historical energy trends.

### 6. **Catastrophic Failure Detection**
- Accelerated MRA + energy check against critical threshold (ℑ).
- Real-time alerts if failure risk is detected.

---

## 🛠️ Requirements

The following R packages are required:

```r
install.packages(c("forecast", "wavelets", "WaveletComp", "waveslim", "fBasics"))

# Optional: for deprecated or local packages
# install.packages("path/to/splus2R_1.3-4.tar.gz", repos = NULL, type = "source")
# install.packages("path/to/ifultools_2.0-26.tar.gz", repos = NULL, type = "source")
# install.packages("path/to/wmtsa_2.0-3.tar.gz", repos = NULL, type = "source")
```

> Some packages like `fpp` and `wmtsa` are archived; the user may need to install from local `.tar.gz` files provided in this repository or CRAN archives.

---

## ▶️ How to Run

1. Place the `.csv` files inside the `data/` folder.
2. Open the desired R script inside `scripts/`.
3. Run the script in RStudio or from R terminal.
4. Plots and logs will be saved or displayed based on the script logic.

---

## 📁 Data

- `xyz_2.csv`, `xyz_3.csv`: Time series of vertical accelerations from Rome and San Diego.
- `Data_1.csv`: Raw dataset for MRA experimentation.

Each file contains univariate signals sampled at 15–20 Hz.

---

## 📌 Reproducibility

All figures and analyses shown in the paper are reproducible using this repository. To verify:

- Run `graph_paper_car_suspension.R` to generate `.eps` plots.
- Cross-check numerical results via `vibration_1.R` and `vibration_2.R`.

---

## 📄 License

This project is released under the MIT License.

---

## 📬 Contact

For questions or academic inquiries, contact:

**Author**: [Luca Biazzo]  
**Affiliation**: [University of Brescia]  
**Email**: [luca.biazzo@unibs.it]

---

> _“Through advanced monitoring and diagnostic technologies, WAFER transforms the traditional maintenance paradigm into a predictive and proactive strategy.”_