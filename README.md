# TransferGo Currency Converter App

**This app was developed as a home task assignment from TransferGo.** It is a currency converter that uses the TransferGo API to fetch FX rates. Users can select sending (`FROM`) and receiving (`TO`) currencies, input an amount, and get real-time conversions. The app enforces sending limits per currency and provides a smooth user experience with focus handling, debounced input, and swapping functionality.


---

## Features

- **Supported currencies:**  
  - Poland (PLN)  
  - Germany (EUR)  
  - Great Britain (GBP)  
  - Ukraine (UAH)

- **Sending limits:**  
  - PLN: 20,000  
  - EUR: 5,000  
  - GBP: 1,000  
  - UAH: 50,000

- **API Integration:**  
  - Uses TransferGo API endpoint: `GET https://my.transfergo.com/api/fx-rates`  
  - Parameters: `from`, `to`, `amount`  

- **Functionality:**  
  - Select `FROM` and `TO` currencies  
  - Input sending amount and see converted amount  
  - Swap `FROM` and `TO` currencies with a button  
  - Update either input field and recalculate conversion  
  - Shows the conversion rate in the middle  
  - Debounced input to avoid excessive API calls  
  - Real-time fetching of FX rates via API
  - Search functionality for currencies   

- **UI & Design:**  
  - Designed to match Figma mock-up as closely as possible  
  - Displays flags for each currency  
  - Limit alerts when sending amount exceeds the allowed maximum  


- **Tests:**  
  - Unit tests for ViewModel and NetworkManager using mocks  
  - Covers fetching, limits, swapping, and filtering logic  

---

## Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone git@github.com:vladdikhtia/TransferGo-Test.git

2. **Open the project in Xcode**

3. **Run the app:**
   - Select a simulator or a connected device
   - Build and run (`Cmd+R`)


