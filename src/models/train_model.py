import pandas as pd
from sklearn.model_selection import train_test_split
from xgboost import XGBClassifier
import joblib
from pathlib import Path

def train_model():
    data_path = Path("D:/hospital/hospital_readmission_ml/data/processed/feature_data.parquet")
    df = pd.read_parquet(data_path)

   

    x_train, x_test, y_train, y_test = train_test_split(df.drop('readmission', axis=1), df['readmission'], test_size=0.2, random_state=42)
    x_train.columns = [col.replace('[', '_').replace(']', '_').replace('<', '_') for col in x_train.columns]
    x_test.columns = [col.replace('[', '_').replace(']', '_').replace('<', '_') for col in x_test.columns]
    model = XGBClassifier(subsample=1.0, n_estimators=200, max_depth=5, learning_rate=0.1, gamma=0.1, colsample_bytree=0.6)
    model.fit(x_train, y_train)

    # Save model
    joblib.dump(model, './models/xgb_model.pkl')
    print("✅ Model trained and saved!")

if __name__ == "__main__":
    train_model()
