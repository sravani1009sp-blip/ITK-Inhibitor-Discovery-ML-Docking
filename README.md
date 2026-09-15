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


## Dataset and Feature Engineering

### Training Dataset

Known ITK inhibitor compounds were obtained from the **ChEMBL database** and used to develop the machine learning models.

Molecular structures were represented using SMILES notation.

### Molecular Descriptors

Eight physicochemical molecular descriptors were calculated from the SMILES structures using **RDKit**:

| Descriptor | Description |
|---|---|
| MolWt | Molecular Weight |
| LogP | Lipophilicity |
| HDonors | Hydrogen Bond Donors |
| HAcceptors | Hydrogen Bond Acceptors |
| TPSA | Topological Polar Surface Area |
| RotatableBonds | Number of Rotatable Bonds |
| RingCount | Number of Rings |
| HeavyAtomCount | Number of Heavy Atoms |

### ADME Features

Two additional properties were obtained using **SwissADME**:

- GI Absorption
- BBB Permeability

Therefore, the final machine learning feature set contained **10 features**:

**8 RDKit molecular descriptors + 2 ADME properties**

### Data Preparation

The dataset was divided into:

- **80% training data**
- **20% testing data**

Numerical features were standardized using **StandardScaler** before machine learning model development.

Categorical ADME properties were encoded into numerical values.


---

## Machine Learning Model Development

Four supervised machine learning classification algorithms were implemented to classify compounds as **active or inactive against ITK**.

### Models Used

| Model | Purpose |
|---|---|
| Logistic Regression | Baseline linear classification model |
| K-Nearest Neighbors (KNN) | Distance-based classification |
| Support Vector Classifier (SVC) | Hyperplane-based classification |
| XGBoost | Ensemble tree-based classification |

All models were trained using the same training dataset and evaluated on the held-out test dataset.

### Model Evaluation

Model performance was evaluated using:

- Accuracy
- Precision
- Recall
- F1-score
- Confusion Matrix

### Model Performance

| Model | Test Accuracy |
|---|---:|
| Logistic Regression | 65.57% |
| SVC | **69.40%** |
| KNN | 64.48% |
| XGBoost | 62.30% |

Among the four models, the **Support Vector Classifier (SVC)** achieved the highest test accuracy of approximately **69.4%**.

The SVC model also showed a recall of **0.90 for the active class**, indicating that it identified a high proportion of compounds classified as active in the test dataset.

### SVC Classification Results

| Class | Precision | Recall | F1-score |
|---|---:|---:|---:|
| Inactive | 0.77 | 0.42 | 0.55 |
| Active | 0.67 | 0.90 | 0.77 |

**Overall Accuracy: 69.4%**

The SVC model was therefore selected for the subsequent virtual screening step.


---


## Virtual Screening

The trained SVC model was used to screen a larger natural-product compound dataset for potential ITK inhibitors.

### Screening Dataset

The screening dataset contained **17,016 compounds** with compound identifiers and canonical SMILES.

The dataset was processed to retain the required molecular information and remove duplicate SMILES.

### Data Cleaning

The screening dataset was checked for:

- Missing values
- Duplicate compound identifiers
- Duplicate SMILES

No missing values or duplicate compound identifiers were detected.

A total of **4,176 duplicate SMILES** were identified and removed, resulting in **12,840 unique compounds**.

### Lipinski Filtering

The unique compounds were filtered using **Lipinski's Rule of Five**.

After filtering:

**5,506 compounds** satisfied the Lipinski criteria.

### SwissADME Properties

SwissADME data were incorporated for the filtered compounds to obtain:

- GI absorption
- BBB permeability

The results showed:

- **4,902 compounds** with high GI absorption
- **604 compounds** with low GI absorption
- **376 compounds** predicted to be BBB permeant
- **5,130 compounds** predicted not to be BBB permeant

### Molecular Descriptors

The same **8 molecular descriptors** used during model development were calculated for the screening compounds:

- Molecular Weight (MolWt)
- LogP
- Hydrogen Bond Donors (HDonors)
- Hydrogen Bond Acceptors (HAcceptors)
- Topological Polar Surface Area (TPSA)
- Rotatable Bonds
- Ring Count
- Heavy Atom Count

The descriptors were scaled using the same `StandardScaler` fitted during model training.

### SVC-Based Prediction

The trained **SVC model** was applied to the screening compounds.

The model generated:

- `Predicted_Activity`
- `SVC_Score`

The compounds were ranked according to their **SVC score**, with higher scores representing compounds positioned more strongly toward the predicted active class by the model.

The **top-ranked compounds** were selected for further processing and molecular docking.


---


## Top 50 Candidate Selection

After SVC prediction, the screened compounds were ranked according to their SVC scores.

The **top 50 compounds** with the highest SVC scores were selected for further structural processing and molecular docking.

The selected compounds retained the following information:

- Compound Identifier
- SMILES
- Molecular descriptors
- Lipinski status
- GI absorption
- BBB permeability
- Predicted activity
- SVC score

The top 50 compounds were saved as:

`Top50_ML_Predicted_Compounds.csv`

---

## 3D Structure Generation

RDKit was used to generate 3D structures for the selected top 50 compounds.

The workflow included:

1. Reading the SMILES of the selected compounds.
2. Converting SMILES into molecular structures.
3. Adding hydrogen atoms.
4. Generating 3D coordinates.
5. Optimizing the molecular geometry using the UFF force field.
6. Saving the resulting structures in **SDF format**.

All **50 compounds were successfully converted** without any failures.

The generated structures were stored in:

`Top50_SDF/`

---

## Reference Ligand Preparation

A reference ligand was prepared separately using RDKit.

The reference ligand was:

- Converted from SMILES to a molecular structure
- Hydrogen atoms added
- 3D coordinates generated
- Geometry optimized using UFF
- Saved as an SDF file

The resulting file was saved as:

`Reference_Ligand.sdf`

This reference ligand was used for comparison during the molecular docking analysis.

---

## Top 10 Training Compounds

The top 10 compounds from the training dataset were also prepared for structural analysis.

The compounds were:

1. Loaded from the training dataset.
2. Converted from SMILES into molecular structures.
3. Hydrogen atoms were added.
4. 3D coordinates were generated.
5. Molecular geometry was optimized using UFF.
6. Structures were saved in SDF format.

All **10 training compounds were successfully processed**.

The generated structures were stored in:

`Top10_Training_SDF/`


---


## PDBQT Conversion

The generated SDF structures were converted into **PDBQT format** for molecular docking.

PDBQT files contain the molecular structure information required by AutoDock Vina, including atom types and partial charges.

The conversion workflow was:

1. Read the generated SDF files.
2. Convert the structures into PDB format.
3. Prepare the ligand structures for docking.
4. Convert the prepared structures into PDBQT format.
5. Store the resulting PDBQT files in the docking input directory.

The prepared ligand files were then used for molecular docking against the ITK protein.

---

## Molecular Docking

Molecular docking was performed to evaluate the predicted binding of the selected compounds against **Interleukin-2-inducible T-cell kinase (ITK)**.

**Target protein:** ITK  
**PDB ID:** 4HCT  
**Docking software:** AutoDock Vina

The selected machine-learning-predicted compounds were prepared in PDBQT format and docked against the ITK binding site.

The docking workflow consisted of:

1. Preparing the ITK receptor structure.
2. Preparing the reference ligand.
3. Preparing the selected training compounds.
4. Preparing the ML-predicted compounds.
5. Defining the docking search region.
6. Performing molecular docking using AutoDock Vina.
7. Recording the predicted binding scores.
8. Comparing the docking scores of the screened compounds with the reference ligand and training compounds.

The docking results were used to identify compounds with favourable predicted binding to ITK.


---


## Molecular Docking Results

The docking protocol was first evaluated using the reference ligand against ITK (PDB ID: 4HCT).

### Reference Ligand

The reference ligand showed a docking score of:

**−11.87 kcal/mol**

This value was used as a benchmark for comparison with the selected training compounds and ML-predicted natural products.

### Training Compounds

The selected experimentally reported ITK-active training compounds were docked against ITK to provide a comparison range for the screened natural products.

The docking scores of the training compounds ranged from approximately:

**−8.10 to −8.75 kcal/mol**

The training compounds were used as reference compounds when evaluating the docking performance of the ML-selected candidates.

### Top 50 Natural Products

The 50 compounds selected using the SVC decision score were subsequently docked against ITK.

For each compound, multiple binding poses were generated using AutoDock Vina, and the pose with the lowest predicted binding energy was selected for analysis.

The docking scores of the screened compounds were compared with:

- Reference ligand
- Selected training compounds
- Other ML-ranked natural products

More negative docking scores represent stronger predicted binding affinity within the docking scoring framework.

### Docking Analysis

The best docking poses were visualized using **UCSF Chimera** to examine ligand orientation and interactions within the ITK binding site.

The combined machine learning and molecular docking workflow was used to prioritize natural products showing favourable computational binding characteristics.

> **Important:** Molecular docking scores are computational predictions and do not experimentally confirm ITK inhibition or biological activity.


---


## Key Findings

The integrated machine learning and molecular docking workflow was used to prioritize potential ITK inhibitors from a natural-product library.

### Main Findings

- **Target:** Interleukin-2-Inducible T-cell Kinase (ITK)
- **Target structure:** PDB ID **4HCT**
- **Training dataset:** 929 ITK-related compounds from ChEMBL
- **Molecular descriptors:** 8 RDKit descriptors
- **Additional features:** GI absorption and BBB permeability
- **Total ML features:** 10
- **Machine learning models:** Logistic Regression, KNN, SVC, and XGBoost
- **Best-performing model:** SVC
- **SVC test accuracy:** **69.4%**
- **Initial natural-product screening dataset:** 17,016 compounds
- **Unique compounds after duplicate removal:** 12,840
- **Compounds after Lipinski filtering:** 5,506
- **Predicted active compounds:** 2,717
- **Predicted inactive compounds:** 2,789
- **Compounds selected for docking:** Top 50
- **Docking software:** AutoDock Vina with UCSF Chimera
- **ITK structure used for docking:** 4HCT
- **Reference ligand docking score:** **−11.87 kcal/mol**

The workflow demonstrates how machine learning can be used to reduce a large natural-product library to a smaller set of candidates for structure-based evaluation.

### Overall Workflow Outcome

**17,016 natural products**

→ **12,840 unique compounds**

→ **5,506 Lipinski-filtered compounds**

→ **2,717 SVC-predicted active compounds**

→ **Top 50 ranked by SVC decision score**

→ **Molecular docking against ITK**

This computational workflow provides a systematic approach for prioritizing potential ITK inhibitors for further investigation.

> **Note:** The results presented in this repository are computational predictions. Experimental studies are required to confirm ITK inhibitory activity, binding affinity, selectivity, and biological effects.



---


## Tools & Technologies

| Category | Tools |
|---|---|
| Programming | Python |
| Data analysis | Pandas, NumPy |
| Machine learning | Scikit-learn, XGBoost |
| Molecular descriptors | RDKit |
| Chemical database | ChEMBL |
| ADME analysis | SwissADME |
| Protein structure | RCSB Protein Data Bank |
| Protein visualization | UCSF Chimera, PyMOL |
| Molecular docking | AutoDock Vina |
| 3D structure generation | RDKit |

---

---

## Repository Structure

```text
ITK-Inhibitor-Discovery-ML-Docking/
│
├── ITK-project.ipynb
│
├── data/
│   ├── training/
│   └── screening/
│
├── screening/
│   ├── Top50_ML_Predicted_Compounds.csv
│   └── Top50_SDF/
│
├── docking/
│   ├── receptor/
│   ├── ref_ligand/
│   ├── trained/
│   └── coconut_screening/
│
├── results/
│   ├── machine_learning/
│   └── docking/
│
├── report/
│   └── Report.docx
│
└── README.md



---



## Limitations and Future Work

### Limitations

- The machine learning models were developed using a limited set of molecular descriptors and ADME-related features.
- The SVC model achieved an accuracy of **69.4%**, indicating that the predictions should be interpreted as computational prioritization rather than definitive activity predictions.
- Molecular docking scores are computational estimates and do not experimentally confirm binding affinity or inhibitory activity.
- Docking results depend on the selected protein structure, docking parameters, and scoring function.
- The predicted compounds require experimental validation to confirm their activity against ITK.

### Future Work

Future studies could focus on:

- Experimental validation of the prioritized compounds.
- Biochemical assays to confirm ITK inhibitory activity.
- Molecular dynamics simulations to further investigate protein–ligand stability.
- Evaluation of compound selectivity against related kinases.
- Exploring additional molecular descriptors and molecular fingerprints.
- Testing additional machine learning and deep learning approaches.
- Further optimization of promising natural-product candidates.


---

## Conclusion

This project presents an integrated computational workflow for the identification of potential ITK inhibitors from natural products.

A ChEMBL-based dataset of known ITK compounds was used to develop and compare four machine learning classification models. Among the evaluated models, the **Support Vector Classifier (SVC)** achieved the highest test accuracy of **69.4%** and was selected for virtual screening.

The trained SVC model was applied to a natural-product screening dataset, followed by molecular filtering, ranking, and selection of the top 50 compounds. These candidates were subsequently prepared for molecular docking against the ITK crystal structure (**PDB ID: 4HCT**).

The docking analysis provided a structural assessment of the ML-prioritized compounds and enabled comparison with the reference ligand and selected training compounds.

Overall, the study demonstrates the use of **machine learning, molecular descriptors, ADME properties, virtual screening, and molecular docking** as complementary computational approaches for prioritizing potential ITK inhibitors.

The identified compounds represent computationally prioritized candidates that require further experimental investigation and validation.
