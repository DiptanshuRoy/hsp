import pandas as pd
from pathlib import Path
import numpy as np

def load_and_clean_data():
    raw_path = Path("data/raw/diabetic_data.csv")
    processed_path = Path("data/processed/cleaned_data.parquet")

    # Load raw data
    df = pd.read_csv(raw_path)

    # Cleaning steps (fillna, drop columns, etc.)
   # Convert diag_1 to numeric, coerce errors to NaN
    df['diag_1'] = pd.to_numeric(df['diag_1'], errors='coerce')

# Fill missing values with the median
    df['diag_1'] = df['diag_1'].fillna(df['diag_1'].median())
    df['diag_1'] = pd.to_numeric(df['diag_1'], errors='coerce')

# Convert diag_2 to numeric, coerce errors to NaN
    df['diag_2'] = pd.to_numeric(df['diag_2'], errors='coerce')

# Fill missing values with the median
    df['diag_2'] = df['diag_2'].fillna(df['diag_2'].median())
    df['diag_3'] = pd.to_numeric(df['diag_3'], errors='coerce')

# Fill missing values with the median
    df['diag_3'] = df['diag_3'].fillna(df['diag_3'].median())

    #added some useful columns
    def map_icd9(code):
        try:
            code = float(code)
            if 390 <= code <= 459 or code == 785:
                return 'Circulatory'
            elif 460 <= code <= 519 or code == 786:
                return 'Respiratory'
            elif 520 <= code <= 579 or code == 787:
                return 'Digestive'
            elif 250 <= code < 251:
                return 'Diabetes'
            elif 800 <= code <= 999:
                return 'Injury'
            elif 710 <= code <= 739:
                return 'Musculoskeletal'
            elif 580 <= code <= 629 or code == 788:
                return 'Genitourinary'
            else:
                return 'Other'
        except:
            return 'Unknown'
    df['diag-group_1'] = df['diag_1'].apply(map_icd9)
    df['diag-group_2'] = df['diag_2'].apply(map_icd9)
    df['diag-group_3'] = df['diag_3'].apply(map_icd9)
    #now handelling categorical variables
    df['race'].replace('?',np.nan,inplace=True)
    df.race.fillna(df.race.mode()[0], inplace=True)

    df['medical_specialty'].replace('?',np.nan,inplace=True)
    df.medical_specialty.fillna(df.medical_specialty.mode()[0], inplace=True)
    #there are some columns that are not useful for the model
    df = df.drop(columns=['payer_code','weight','max_glu_serum','A1Cresult'])
    
    # Save cleaned data
    df.to_parquet(processed_path, index=False)

if __name__ == "__main__":
    load_and_clean_data()
