# BIST-100 Index Prediction

A machine learning project that predicts the BIST-100 (Borsa Istanbul 100) stock market index using multiple models: Polynomial Regression, Long Short-Term Memory (LSTM) networks, and Gated Recurrent Units (GRU).

## Project Overview

This project implements and compares three different approaches to predict the BIST-100 index one day and 15 days ahead:

- **Polynomial Regression**: Linear model with polynomial features for baseline comparison
- **LSTM Models**: Deep learning approach using Long Short-Term Memory networks
- **GRU Models**: Gated recurrent unit networks for sequence prediction

## Dataset

The project uses multiple financial indicators as features:

- BIST-100 historical prices
- S&P 500 Index
- Nikkei 225 Index
- DAX Index
- EEM ETF
- Brent Oil prices
- US Dollar Index
- USD/TRY exchange rate
- VIX (Volatility Index)
- Gold (XAU/USD) prices
- Turkey CDS (Credit Default Swaps)
- Turkey Bond Yields
- Turkey PMI
- Turkey GDP Growth
- Turkey Inflation Rate
- Turkey M2 Money Supply
- Turkey Policy Rate
- Turkey Unemployment Rate
- Federal Reserve Rate

## Project Structure

```
├── README.md                          # Project documentation
├── requirements.txt                   # Python dependencies
├── LICENSE                            # MIT License
├── .gitignore                         # Git ignore file
│
├── notebooks/                         # Jupyter notebooks for model training and prediction
│   ├── polyreg1day.ipynb              # Polynomial Regression 1-day ahead
│   ├── polyreg15day.ipynb             # Polynomial Regression 15-day ahead
│   ├── lstm1day.ipynb                 # LSTM 1-day ahead
│   ├── lstm15day.ipynb                # LSTM 15-day ahead
│   ├── gru1day.ipynb                  # GRU 1-day ahead
│   └── gru15day.ipynb                 # GRU 15-day ahead
│
├── data/                              # Data directory
│   ├── raw/                           # Raw financial data
│   │   ├── BIST100Data.csv
│   │   ├── sp500.mat
│   │   ├── Brent Oil.csv
│   │   ├── DAX Price.csv
│   │   ├── EEM ETF.csv
│   │   ├── Nikkei225 Price.csv
│   │   ├── US Dollar Index.csv
│   │   ├── usdtry.csv
│   │   ├── VIX Price.csv
│   │   ├── XAU to USD Price.csv
│   │   ├── Turkey CDS 2 Year.csv
│   │   ├── Turkey CDS 10 Year.csv
│   │   ├── Turkey 2 Year Bond Yield Historical Data.csv
│   │   ├── tr10by.csv
│   │   ├── fed_rate.xlsx
│   │   ├── turkeypmi.xlsx
│   │   ├── turkey_gdp_growth.xlsx
│   │   ├── turkey_inflation_year.xlsx
│   │   ├── turkey_M2.xlsx
│   │   ├── turkey_policy_rate_.xlsx
│   │   └── turkey_unemployment.xlsx
│   ├── processed/                     # Processed/cleaned data
│   │   ├── Xtable.csv                 # Final feature table for models
│   │   └── Xtable_raw.csv             # Raw preprocessed output
│   └── preprocessing/                 # Data preprocessing scripts
│       └── data_preprocess.m          # MATLAB preprocessing script
│
└── docs/                              # Project documentation
    ├── DOCS.md                        # Documentation guide
    ├── Report.pdf                     # Detailed project report
    ├── Presentation.pdf               # Project presentation slides
    ├── Presentation.pptx              # Project presentation (editable)
    └── presentation_link.txt          # Link to online resources
```

## Installation

### Requirements
- Python 3.8 or higher
- Jupyter Notebook or JupyterLab

### Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/BIST100-prediction.git
cd BIST100-prediction
```

2. Create a virtual environment (optional but recommended):
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

## Usage

1. Start Jupyter:
```bash
jupyter notebook
```

2. Open any of the prediction notebooks from the `notebooks/` folder:
   - `notebooks/polyreg1day.ipynb` - For 1-day ahead polynomial regression predictions
   - `notebooks/lstm1day.ipynb` - For 1-day ahead LSTM predictions
   - `notebooks/gru1day.ipynb` - For 1-day ahead GRU predictions
   - `notebooks/polyreg15day.ipynb` - For 15-day ahead polynomial regression predictions
   - `notebooks/lstm15day.ipynb` - For 15-day ahead LSTM predictions
   - `notebooks/gru15day.ipynb` - For 15-day ahead GRU predictions

3. Run the cells to:
   - Load and preprocess the data
   - Train the models
   - Generate predictions
   - Visualize results

## Model Descriptions

### Polynomial Regression
A simple baseline model that fits polynomial features to historical data. Used for 1-day and 15-day ahead predictions using walk-forward validation.

### LSTM (Long Short-Term Memory)
A type of recurrent neural network that can learn long-term dependencies in time series data. Includes layers with dropout for regularization and batch normalization for improved training.

### GRU (Gated Recurrent Unit)
A simpler variant of LSTM with a gating mechanism. It requires fewer parameters while maintaining comparable performance on sequence prediction tasks.

## Results

The models are evaluated using common regression metrics:
- Mean Squared Error (MSE)
- Root Mean Squared Error (RMSE)
- Mean Absolute Error (MAE)
- Mean Absolute Percentage Error (MAPE)
- R² Score

See `docs/Report.pdf` for detailed results and analysis. For a quick overview, check `docs/Presentation.pdf`.

## Data Preprocessing

The raw financial data is organized in `data/raw/` and preprocessed using the MATLAB script `data/preprocessing/data_preprocess.m` which:
- Aligns multiple time series to common dates
- Handles missing values
- Normalizes features
- Creates the feature matrix (`data/processed/Xtable.csv`)

All model notebooks automatically load `data/processed/Xtable.csv` for training and prediction.

## Notes

- The models use walk-forward validation to simulate real-world deployment
- All notebooks are self-contained and can be run independently
- Predictions are made using the previous 20 days of data (window size)

## Future Improvements

- Implement ensemble methods combining multiple models
- Add more financial indicators
- Optimize hyperparameters using neural architecture search
- Deploy as a web application
- Add real-time prediction capabilities

## References

- LSTM for time series: Hochreiter & Schmidhuber (1997)
- GRU networks: Cho et al. (2014)
- Walk-forward validation: Prechelt (1994)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

Burak

## Disclaimer

This project is for educational and research purposes only. Stock market predictions have inherent risks, and past performance does not guarantee future results. Do not use these predictions for actual financial decisions without consulting with a financial advisor.
