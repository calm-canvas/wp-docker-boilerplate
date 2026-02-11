import os
import sys

def get_env_vars(env_file_path):
    """
    Reads the .env file and returns a dictionary of THEME_* variables.
    """
    env_vars = {}
    if not os.path.exists(env_file_path):
        print(f"Error: {env_file_path} not found.")
        sys.exit(1)

    try:
        with open(env_file_path, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith('#'):
                    continue
                if '=' in line:
                    key, value = line.split('=', 1)
                    # Remove quotes if present
                    value = value.strip('"').strip("'")
                    if key.startswith('THEME_'):
                        env_vars[key] = value
    except Exception as e:
        print(f"Error reading .env file: {e}")
        sys.exit(1)
    
    return env_vars

def generate_theme_info():
    # The script is in /bin/python, so project_root is two levels up.
    project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
    env_file = os.path.join(project_root, '.env')
    tpl_file = os.path.join(project_root, 'bin', 'python', 'tpl', 'style.tpl')
    output_file = os.path.join(project_root, 'theme-name', 'style.css')

    # 1. Read .env variables
    env_vars = get_env_vars(env_file)
    
    # Check if THEME_NAME is at least present
    if 'THEME_NAME' not in env_vars:
        print("Error: THEME_NAME not found in .env file.")
        sys.exit(1)

    # 2. Read template
    if not os.path.exists(tpl_file):
        print(f"Error: Template file {tpl_file} not found.")
        sys.exit(1)

    with open(tpl_file, 'r', encoding='utf-8') as f:
        tpl_content = f.read()

    # 3. Replace placeholders
    # Placeholder format in tpl: THEME_NAME, THEME_URI, etc.
    # Sort keys by length descending to avoid partial matches (e.g. THEME_AUTHOR replacing part of THEME_AUTHOR_URI)
    new_content = tpl_content
    for key in sorted(env_vars.keys(), key=len, reverse=True):
        value = env_vars[key]
        new_content = new_content.replace(key, value)

    # 4. Write to output file
    try:
        os.makedirs(os.path.dirname(output_file), exist_ok=True)
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Successfully generated {output_file}")
    except Exception as e:
        print(f"Error writing to output file: {e}")
        sys.exit(1)

if __name__ == "__main__":
    generate_theme_info()
