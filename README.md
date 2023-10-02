# JSONComparison

## Introduction comparing JSONL files and creating a output file with common fields
This repository contains a Python script for comparing JSONL (JSON Lines) files and generating Excel reports summarizing the differences, the data used in this project is directly from the [MASSIVE dataset]([URL](https://github.com/alexa/massive). This tool is particularly useful for analyzing multilingual data where you have a "pivot" JSONL file and want to compare it against multiple other JSONL files to identify matching data.

## Getting Started

Follow these steps to set up and use the JSONL File Comparison Tool:

### Prerequisites

1. Make sure you have Python 3.x installed on your system.


2. Download test files and store in the same directory as the project. [MASSIVE dataset]([URL](https://github.com/alexa/massive). 

3. Install the required Python libraries by running the following command:

   ```bash
   pip install jsonlines openpyxl

4. clone the repository
   ```bash
   git clone https://github.com/Jay254p/JSONComparison.git
     
### Usage 
1. Navigate to the project directory
  '''bash
  cd JSONComparison

2. Run the script file using the command:
   '''bash
   ./generator.sh
   
3. Follow the prompts to select the pivot file and specify which JSONL files to compare.
4. The script will process the comparisons and create Excel files in the "output" directory.


### Error Logging
If any errors occur during execution, they will be stored in the "error.log" file, this file will be created automatically.



