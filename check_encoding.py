import os

def check_po_file(filepath):
    print(f"Checking: {filepath}")
    try:
        with open(filepath, 'rb') as f:
            raw_data = f.read()
            
        bom = raw_data.startswith(b'\xef\xbb\xbf')
        print(f"  Byte Order Mark (BOM) exists: {bom}")
        
        # Attempt strict UTF-8 decode
        decoded_text = raw_data.decode('utf-8')
        print("  Strict UTF-8 decode: Success")
        
        lines = decoded_text.splitlines()
        msgid_counts = 0
        for line in lines:
            if line.startswith('msgid'):
                print(f"  Raw decoded line: {line}")
                msgid_counts += 1
                if msgid_counts >= 3:
                    break
    except UnicodeDecodeError as e:
        print(f"  Strict UTF-8 decode: Failed ({e})")
    except Exception as e:
        print(f"  An error occurred: {e}")
    print("-" * 20)

files_to_check = [
    'translations/en/LC_MESSAGES/messages.po',
    'translations/et/LC_MESSAGES/messages.po'
]

for file_path in files_to_check:
    if os.path.exists(file_path):
        check_po_file(file_path)
    else:
        print(f"File not found: {file_path}")
