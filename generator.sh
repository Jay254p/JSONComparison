#!/bin/bash

# Initialize variables for the output XLSX file
output_file="en-US.xlsx"
echo -e "id\tutt\tannot_utt" > "$output_file"

# Loop through each JSONL file
for filename in *.jsonl; do
    if [ "$filename" != "en-US.jsonl" ]; then
        # Extract id, utt, and annot_utt using jq
        id=$(jq -r '.id' "$filename")
        utt=$(jq -r '.utt' "$filename")
        annot_utt=$(jq -r '.annot_utt' "$filename")

        # Append the data to the XLSX file
        echo -e "$id\t$utt\t$annot_utt" >> "$output_file"
    fi
done

echo "XLSX file created: $output_file"
