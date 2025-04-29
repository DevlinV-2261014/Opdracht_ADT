import sys
import os
import pandas as pd

def main():
    if len(sys.argv) != 3:
        print("Usage: python csv_to_xml_json.py <input_csv_file> <output_file_name>")
        sys.exit(1)

    input_csv_file = sys.argv[1]
    output_file_name = sys.argv[2]
    if not os.path.isfile(input_csv_file):
        print(f"Error: The file {input_csv_file} does not exist.")
        sys.exit(1)
    if not input_csv_file.endswith('.csv'):
        print(f"Error: The file {input_csv_file} is not a CSV file.")
        sys.exit(1)
    
    # Read the CSV file
    df = pd.read_csv(input_csv_file)
    # Convert to XML
    xml_file_name = f"{output_file_name}.xml"
    df.to_xml(xml_file_name, index=False)
    print(f"XML file created: {xml_file_name}")
    # Convert to JSON
    json_file_name = f"{output_file_name}.json"
    df.to_json(json_file_name, orient='records', lines=True)
    print(f"JSON file created: {json_file_name}")

if __name__ == "__main__":
    main()