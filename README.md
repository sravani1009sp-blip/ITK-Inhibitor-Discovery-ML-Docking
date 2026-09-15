# ITK Inhibitor Discovery Using Machine Learning and Molecular Docking

Machine learning-based virtual screening and molecular docking workflow for identifying potential Interleukin-2-Inducible T-cell Kinase (ITK) inhibitors from natural products.

## Project Overview

Interleukin-2-Inducible T-cell Kinase (ITK) is a Tec family tyrosine kinase involved in T-cell receptor signaling and immune regulation. Its role in T-cell activation makes it a potential therapeutic target for inflammatory, autoimmune, and T-cell-related diseases.

This project integrates **machine learning-based virtual screening** with **structure-based molecular docking** to identify potential ITK inhibitors from natural product databases.

Known ITK inhibitors were collected from the **ChEMBL database** and used to develop classification models. Molecular descriptors were calculated using **RDKit**, while gastrointestinal (GI) absorption and blood-brain barrier (BBB) permeability were obtained using **SwissADME**.

Four machine learning classifiers were developed and compared:

- Logistic Regression
- K-Nearest Neighbors (KNN)
- Support Vector Classifier (SVC)
- XGBoost

The **Support Vector Classifier (SVC)** showed the best overall performance and was subsequently used for virtual screening of natural products from the **COCONUT database**.

The highest-ranked compounds were selected for molecular docking against the ITK crystal structure (**PDB ID: 4HCT**) using **UCSF Chimera with the AutoDock Vina docking engine**.

## Research Workflow

**1. ChEMBL Dataset Collection**

Known ITK inhibitors were collected from ChEMBL.

↓

**2. Dataset Preparation**

Compounds were classified as active or inactive based on IC50 values.

↓

**3. Molecular Descriptor Calculation**

8 physicochemical descriptors were calculated using RDKit.

↓

**4. ADME Property Prediction**

GI absorption and BBB permeability were obtained using SwissADME.

↓

**5. Feature Integration**

8 molecular descriptors + 2 ADME properties = **10 features**

↓

**6. Machine Learning**

Logistic Regression • KNN • SVC • XGBoost

↓

**7. Model Selection**

SVC showed the best overall performance.

↓

**8. COCONUT Virtual Screening**

Natural product compounds were processed and screened using the trained SVC model.

↓

**9. Confidence Ranking**

SVC decision scores were used to rank predicted compounds.

↓

**10. Top 50 Selection**

The 50 highest-ranked compounds were selected.

↓

**11. 3D Structure Generation**

RDKit was used to generate 3D structures for the selected compounds.

↓

**12. Molecular Docking**

Top predicted compounds were docked against ITK (PDB: 4HCT).

↓

**13. Docking Analysis**

Docking scores were compared with the reference ligand and selected training compounds.


---
