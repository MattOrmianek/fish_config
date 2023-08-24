#!/usr/bin/env python3
import os
import subprocess

def activate_virtualenv(venv_path):
    activate_script = f'source "{venv_path}/bin/activate.fish"'
    subprocess.run([activate_script], shell = True, stdout = subprocess.DEVNULL, stderr = subprocess.DEVNULL)

def deactivate_virtualenv_and_restore_one_before():
    if venv_path:
        activate_virtualenv(venv_path)
    else:
        subprocess.run(["deactivate"], shell = True, stdout = subprocess.DEVNULL, stderr = subprocess.DEVNULL)

venv_path = os.getenv('VIRTUAL_ENV')
if venv_path:
    print(f"Wirtualne środowisko aktywne w: {venv_path}")
else:
    print("Brak aktywnego wirtualnego środowiska")

path_with_venv_for_sz = "/Users/mateuszormianek/functions/venv_for_sz"

try:
    activate_virtualenv(path_with_venv_for_sz)
except:
    print("Error 1: can't activate virtualenv for sz")

try:
    import sys
    import token
    import tokenize
    import itertools
    import argparse
    from tabulate import tabulate
except:
    print("Error 2: can't import modules")
    exit(-1)

try:
    TOKEN_WHITELIST = [token.OP, token.NAME, token.NUMBER, token.STRING]

    parser = argparse.ArgumentParser(description="Analyze Python files.")
    parser.add_argument("path", nargs="?", default=".", help="Path to analyze (default: current directory).")
    parser.add_argument("--without", metavar="<path>", help="Path to exclude from analysis.")
    args = parser.parse_args()

    if args.without:
        print(f"Analyzing path: {args.path}, excluding: {args.without}")
    else:
        print(f"Analyzing path: {args.path}")

    headers = ["Name", "Lines"]
    table = []
    for path, subdirs, files in os.walk(args.path):
        if args.without and args.without in path:
            continue
        for name in files:
            if not name.endswith(".py"):
                continue
            filepath = os.path.join(path, name)
            with tokenize.open(filepath) as file_:
                try:
                    tokens = [t for t in tokenize.generate_tokens(file_.readline) if t.type in TOKEN_WHITELIST]
                    token_count, line_count = len(tokens), len(set([t.start[0] for t in tokens]))
                    table.append([filepath, line_count])
                except:
                    pass

    print(tabulate([headers] + sorted(table, key=lambda x: -x[1]), headers="firstrow", floatfmt=".1f")+"\n")

    for dir_name, group in itertools.groupby(sorted([(x[0].rsplit("/", 1)[0], x[1]) for x in table]), key=lambda x: x[0]):
        print(f"{dir_name:30s} : {sum([x[1] for x in group]):6d}")

    print(f"\ntotal line count: {sum([x[1] for x in table])}")
except:
    print("Error 3: can't complete main function")
    exit(-1)
try:
    deactivate_virtualenv_and_restore_one_before()
except:
    print("Error 4: can't deactivate virtualenv or activate one before")
    exit(-1)
