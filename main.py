import jsonlines
from openpyxl import Workbook
import sys


#Open and read the jsonl
def read_jsonl(file_path):
    data = []
    with jsonlines.open(file_path, "r") as reader:
        for item in reader:
            data.append(item)
    return data

#Compare
def compare_jsonl_files(file1, file2):
    data1 = read_jsonl(file1)
    data2 = read_jsonl(file2)

    matching_data = []

    data2_dict = {item["id"]: item for item in data2}

    for item1 in data1:
        id_1 = item1["id"]
        if id_1 in data2_dict:
            matching_data.append({
                "id": id_1,
                "pivot_utt": data2_dict[id_1]["utt"],
                "pivot_annot_utt": data2_dict[id_1]["annot_utt"],
                "compared_utt": item1["utt"],
                "compared_annot_utt": item1["annot_utt"]
            })

    return matching_data

def write_to_excel(data, output_file):
    wb = Workbook()
    ws = wb.active

    headers = ["id", "pivot_utt", "pivot_annot_utt", "compared_utt", "compared_annot_utt"]
    ws.append(headers)

    for item in data:
        ws.append([item["id"], item["pivot_utt"], item["pivot_annot_utt"], item["compared_utt"], item["compared_annot_utt"]])

    wb.save(output_file)

if __name__ == "__main__":
    file1 = sys.argv[1]
    file2 = sys.argv[2]
    output_file = sys.argv[3]

    matching_data = compare_jsonl_files(file1, file2)
    if matching_data:
        write_to_excel(matching_data, output_file)
