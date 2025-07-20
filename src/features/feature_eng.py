import pandas as pd
import numpy as np
from pathlib import Path

def feature_eng():
    data_path = Path("data/processed/cleaned_data.parquet")

    df = pd.read_parquet(data_path)

    # Convert target variable
    df['readmitted'] = df['readmitted'].apply(lambda x: 1 if x in ['<30', '>30'] else 0)

    # One-hot encode each group separately
    med_sp = pd.get_dummies(df['medical_specialty'], prefix='medical_specialty', drop_first=True, dtype='int')
    race = pd.get_dummies(df['race'], prefix='race', drop_first=True, dtype='int')
    gen = pd.get_dummies(df['gender'], prefix='gender', drop_first=True, dtype='int')
    age = pd.get_dummies(df['age'], prefix='age', drop_first=True, dtype='int')
    dummy_diag = pd.get_dummies(df[['diag-goup_1', 'diag-goup_2', 'diag-goup_3']], drop_first=True, dtype='int')
    dia_med = pd.get_dummies(df['diabetesMed'], prefix='diabetesMed', drop_first=True, dtype='int')

    med_cols = [
        'metformin', 'repaglinide', 'nateglinide', 'chlorpropamide',
        'glimepiride', 'acetohexamide', 'glipizide', 'glyburide', 'tolbutamide',
        'pioglitazone', 'rosiglitazone', 'acarbose', 'miglitol', 'troglitazone',
        'tolazamide', 'examide', 'citoglipton', 'insulin',
        'glyburide-metformin', 'glipizide-metformin', 'glimepiride-pioglitazone'
    ]
    med_charged = pd.get_dummies(df[med_cols], drop_first=True, dtype='int')

    # Drop original columns
    df = df.drop(
        columns=[
            'encounter_id', 'patient_nbr', 'weight', 'payer_code', 'race', 'gender', 'age',
            'admission_type_id', 'discharge_disposition_id', 'admission_source_id', 'num_lab_procedures',
            'num_procedures', 'medical_specialty', 'diag_1', 'diag_2', 'diag_3',
            'metformin-rosiglitazone', 'metformin-pioglitazone', 'max_glu_serum',
            'A1Cresult', 'change', 'diag-goup_1', 'diag-goup_2', 'diag-goup_3',
            *med_cols, 'diabetesMed'
        ],
        errors='ignore'
    )

    # Concatenate all features
    df = pd.concat([df, med_sp, race, gen, age, dummy_diag, dia_med, med_charged], axis=1)

    # Save to processed folder
    df.to_parquet(Path("../data/processed/feature_data.parquet"), index=False)

if __name__ == "__main__":
    print("Running feature engineering...")
    feature_eng()
