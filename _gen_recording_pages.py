import shutil
# Read the recordings yml file
import yaml

def main():
    recording_list = None
    with open("./recordings/lecture-recordings.yml", "r") as infile:
        try:
            recording_list = yaml.safe_load(infile)
        except yaml.YAMLError as exc:
            print(exc)
            return
    # And loop over each entry, creating a .html file for each one
    # The format should be: recordings/recording-w{00}s{00}-{0}
    for cur_recording in recording_list:
        week = cur_recording['week']
        section = cur_recording['section']
        

if __name__ == "__main__":
    main()

# src_fpath = "./_index-template.html"
# target_fpath = "./docs/index.html"
# shutil.copyfile(src_fpath, target_fpath)
# print(f"Password-protection index copied to {target_fpath}")
