import os
# import pip

# pip.main(["install", "numpy"])
# pip.main(["install", "matplotlib"])

folders = ["solvers", "arrays", "encoding"]
for folder in folders:
    files = os.listdir(f"./{folder}")

    for file_name in files:
        if not (".f95" in file_name):
            continue

        output_file_name = file_name.replace(".f95", "")
        os.system(f"cd {folder} && f2py -c \
            --opt='-O3 -ftree-vectorize -march=native -fno-range-check \
                -floop-nest-optimize -fPIC -pipe' \
            {file_name} -m {output_file_name}")
        # -lgomp -ffast-math -fopenmp  -DF2PY_REPORT_ATEXIT (interesting flags)
