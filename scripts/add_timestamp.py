import json
import time
import sys

# Function to add timestamp to a JSON object
def add_timestamp(json_obj):
    json_obj['timestamp'] = int(time.time() * 1000)  # Current time in milliseconds
    return json_obj

# Check if the correct number of command-line arguments are provided
if len(sys.argv) != 3:
    print("Usage: python add_timestamp.py input_file output_file")
    sys.exit(1)

input_file = sys.argv[1]
output_file = sys.argv[2]

try:
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        for line in infile:
            try:
                json_obj = json.loads(line)
                json_obj = add_timestamp(json_obj)
                json.dump(json_obj, outfile)
                outfile.write('\n')  # Add a newline after each JSON object
            except json.JSONDecodeError as e:
                print(f"Error decoding JSON: {e}")
except FileNotFoundError:
    print(f"File not found: {input_file}")
    sys.exit(1)

print(f"Timestamps added and written to {output_file}")

