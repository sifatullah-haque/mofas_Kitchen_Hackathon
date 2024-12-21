# Smart Ingredients Manager

An ingredients manager built with Flutter. You can add items (e.g., *Salt*, *Pepper*) along with their quantities, and update existing quantities if they already exist. Items are stored locally using **SharedPreferences**, and you can view or edit them at any time.

## Table of Contents
- [Features](#features)
- [Screens Overview](#screens-overview)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Usage](#usage)
- [SharedPreferences Logic](#sharedpreferences-logic)
- [Roadmap (Optional)](#roadmap-optional)
- [License (Optional)](#license-optional)

---

## Features

1. **Add Items (Addingradiants)**
   - Users can select a category (e.g., *Spices, Herbs & Seasonings*).
   - Choose a specific item (e.g., *Salt*).
   - Enter a quantity.
   - If the item already exists, its quantity is incremented.

2. **View Items (Viewingradiants)**
   - Displays a list of all stored items in **SharedPreferences**.
   - If no items are found, shows a friendly message.

3. **Local Persistence**
   - Uses `SharedPreferences` so data persists across app restarts.

4. **Dynamic UI**
   - Dropdowns for category and item appear only when needed.
   - Responsive design with `flutter_screenutil`.

---

## Screens Overview

### 1. Add Ingredients
- **Item Category** Dropdown: *Fruits, Vegetables, Spices, etc.*
- **Item Selection** Dropdown: *Salt, Pepper, Milk, etc.*
- **Quantity Field**: Enter the numeric amount.
- **Add Button**:  
  - If the item already exists, the existing quantity is increased.  
  - Otherwise, it creates a new entry in SharedPreferences.

### 2. View Ingredients
- Uses a `FutureBuilder` to load items from SharedPreferences.
- Displays items in a `ListView`.
- Shows a message if no items are found.

---


- **`addingradiants.dart`**: Allows adding/updating items and their quantities.  
- **`viewingradiants.dart`**: Lists all items retrieved from `SharedPreferences`.

---

## Installation

1. **Clone the Repository**  
   ```bash
   https://github.com/sifatullah-haque/mofas_Kitchen_Hackathon

## Download the APP
https://drive.google.com/drive/folders/16dRrkw1ghwgGCZCPrTiREp6N_TDnEqOj?usp=sharing


- All Rights Reserved By Team Alpha
