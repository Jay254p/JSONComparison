#!/bin/bash

log_file="error.log"
script_dir="$(dirname "$0")"
main_script="main.py"
output_dir="${script_dir}/output"
mkdir "${output_dir}"
json_files=(
            "af-ZA.jsonl"
            "am-ET.jsonl"
            "ar-SA.jsonl"
            "az-AZ.jsonl"
            "bn-BD.jsonl"
            "ca-ES.jsonl"
            "cy-GB.jsonl"
            "da-DK.jsonl"
            "de-DE.jsonl"
            "el-GR.jsonl"
            "en-US.jsonl"
            "es-ES.jsonl"
            "fa-IR.jsonl"
            "fi-FI.jsonl"
            "fr-FR.jsonl"
            "he-IL.jsonl"
            "hi-IN.jsonl"
            "hu-HU.jsonl"
            "hy-AM.jsonl"
            "id-ID.jsonl"
            "is-IS.jsonl"
            "it-IT.jsonl"
            "ja-JP.jsonl"
            "jv-ID.jsonl"
            "ka-GE.jsonl"
            "km-KH.jsonl"
            "kn-IN.jsonl"
            "ko-KR.jsonl"
            "lv-LV.jsonl"
            "ml-IN.jsonl"
            "mn-MN.jsonl"
            "ms-MY.jsonl"
            "my-MM.jsonl"
            "nb-NO.jsonl"
            "nl-NL.jsonl"
            "pl-PL.jsonl"
            "pt-PT.jsonl"
            "ro-RO.jsonl"
            "ru-RU.jsonl"
            "sl-SL.jsonl"
            "sq-AL.jsonl"
            "sv-SE.jsonl"
            "sw-KE.jsonl"
            "ta-IN.jsonl"
            "te-IN.jsonl"
            "th-TH.jsonl"
            "tl-PH.jsonl"
            "tr-TR.jsonl"
            "ur-PK.jsonl"
            "vi-VN.jsonl"
            "zh-CN.jsonl"
            "zh-TW.jsonl"
          )

pivot_files=(
            "af-ZA.jsonl"
            "am-ET.jsonl"
            "ar-SA.jsonl"
            "az-AZ.jsonl"
            "bn-BD.jsonl"
            "ca-ES.jsonl"
            "cy-GB.jsonl"
            "da-DK.jsonl"
            "de-DE.jsonl"
            "el-GR.jsonl"
            "en-US.jsonl"
            "es-ES.jsonl"
            "fa-IR.jsonl"
            "fi-FI.jsonl"
            "fr-FR.jsonl"
            "he-IL.jsonl"
            "hi-IN.jsonl"
            "hu-HU.jsonl"
            "hy-AM.jsonl"
            "id-ID.jsonl"
            "is-IS.jsonl"
            "it-IT.jsonl"
            "ja-JP.jsonl"
            "jv-ID.jsonl"
            "ka-GE.jsonl"
            "km-KH.jsonl"
            "kn-IN.jsonl"
            "ko-KR.jsonl"
            "lv-LV.jsonl"
            "ml-IN.jsonl"
            "mn-MN.jsonl"
            "ms-MY.jsonl"
            "my-MM.jsonl"
            "nb-NO.jsonl"
            "nl-NL.jsonl"
            "pl-PL.jsonl"
            "pt-PT.jsonl"
            "ro-RO.jsonl"
            "ru-RU.jsonl"
            "sl-SL.jsonl"
            "sq-AL.jsonl"
            "sv-SE.jsonl"
            "sw-KE.jsonl"
            "ta-IN.jsonl"
            "te-IN.jsonl"
            "th-TH.jsonl"
            "tl-PH.jsonl"
            "tr-TR.jsonl"
            "ur-PK.jsonl"
            "vi-VN.jsonl"
            "zh-CN.jsonl"
            "zh-TW.jsonl"
          )

echo "Select a pivot file:"
for ((i=0; i<${#pivot_files[@]}; i++)); do
  echo "$i. ${pivot_files[i]}"
done

read -p "Enter the pivot file number: " pivot_option

if [[ $pivot_option -ge 0 && $pivot_option -lt ${#pivot_files[@]} ]]; then
  pivot_file="${pivot_files[pivot_option]}"
  pivot_locale=$(basename "$pivot_file" .jsonl | cut -d'-' -f1)

  echo "Select JSON files to compare (separate with spaces, or enter 'all' for all files):"
  for ((i=0; i<${#json_files[@]}; i++)); do
    echo "$i. ${json_files[i]}"
  done

  read -p "Enter the JSON file numbers (e.g., 0 1 2) or 'all': " json_option

  selected_json_files=()
  if [[ $json_option == "all" ]]; then
    selected_json_files=("${json_files[@]}")
  else
    IFS=" " read -ra json_indices <<< "$json_option"
    for index in "${json_indices[@]}"; do
      if [[ $index -ge 0 && $index -lt ${#json_files[@]} ]]; then
        selected_json_files+=("${json_files[index]}")
      else
        echo "Invalid JSON file option: $index"
        exit 1
      fi
    done
  fi

  echo "Selected JSON files:"
  for selected_json_file in "${selected_json_files[@]}"; do
    echo "- $selected_json_file"
  done

  for json_file in "${selected_json_files[@]}"; do
    locale=$(basename "$json_file" .jsonl | cut -d'-' -f1)

    output_file="${output_dir}/${pivot_locale}-${locale}.xlsx"

    echo "Please wait... Comparing ${pivot_file} and ${json_file} and creating ${pivot_locale}-${locale}.xlsx file..."
    echo "-------------------------------------------------------------------------"
    echo "File created successfully at location ${output_dir}. Processig next..."
    echo "-------------------------------------------------------------------------"

    if ! python "$main_script" "$json_file" "$pivot_file" "$output_file" 2>> "$log_file"; then
      echo "Error running script for $json_file. See $log_file for details."
    fi
  done
else
  echo "Invalid pivot file option."
fi

echo "Process complete. Press enter to exit..."
read enter


