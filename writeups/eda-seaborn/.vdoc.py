# type: ignore
# flake8: noqa
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: load-seaborn-dataset
import seaborn as sns
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
import glob
import os

def read_txt(txt_fpath, verbose=False):
  """
  Helper function for taking filepaths (fpaths) and reading then into Python as strings
  """
  if verbose:
    print(f"Reading {txt_fpath}")
  # Ensure it returns None if the file could not be read
  txt_contents = None
  with open(txt_fpath, 'r', encoding='utf-8') as infile:
    txt_contents = infile.read()
  
  return {
    'filename': filename,
    'text': txt_contents
  }

corpus_paths = [
  "./fiction-corpus/",
  "./textbook-corpus/",
]
# This will eventually hold one *dictionary* for each
# text in our corpus, with keys called `filename` and `text`
corpus_docs = []
for cur_path in corpus_paths:
  print(f"Scanning corpus: {cur_path}")
  # Create wildcard string like "./fiction-corpus/*.txt" to give to glob
  glob_str = os.path.join(cur_path, "*.txt")
  # Use the glob library to get a list of all *.txt files in the directory, as filepaths
  fpaths = glob.glob(glob_str)
  # Read each file into a string (so that this line produces a *list* of strings)
  doc_contents = [read_txt(fpath, verbose=True) for fpath in fpaths]
  # And *extend* corpus_docs to contain these newly-loaded strings
  corpus_docs.extend(docs)

# To check that the loop ran successfully, we print
# out the *filenames* of each document that was loaded
doc_fnames = [doc['filename'] for doc in corpus_docs]
print("Loaded files:")
print("\n".join(doc_fnames))
#
#
#
#
#
