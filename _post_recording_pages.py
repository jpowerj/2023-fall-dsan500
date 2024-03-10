# Read the recordings yml file
import yaml

rec_html_template = """<!DOCTYPE html>
<html>
<head>
    <title>DSAN 5000: Redirecting to Video...</title>
    <meta http-equiv="refresh" content="0; url=!rec_url!">
</head>
<body>
    <p>
        Redirecting to DSAN 5000 lecture recording video...
    </p>
</body>
</html>"""

def write_html(html_str, fpath):
    with open(fpath, 'w', encoding='utf-8') as outfile:
        outfile.write(html_str)

def main():
    recording_list = None
    with open("./recordings/lecture-recordings.yml", "r") as infile:
        try:
            recording_list = yaml.safe_load(infile)
        except yaml.YAMLError as exc:
            print(exc)
            return
    # And loop over each entry, creating a .html file for each one
    # Format should just be:
    # recordings/recording-w{00}s{00}-{0}.html
    # For now just -{0-9}
    for cur_recording in recording_list:
        week = cur_recording['week']
        week_str = str(week).zfill(2)
        section = cur_recording['section']
        url = cur_recording['url']
        cur_html = rec_html_template.replace("!rec_url!", url)
        for part_num in range(1, 10):
            cur_fpath = f"./recordings/recording-w{week_str}s{section}-{part_num}.html"
            write_html(cur_html, cur_fpath)
        

if __name__ == "__main__":
    main()

# src_fpath = "./_index-template.html"
# target_fpath = "./docs/index.html"
# shutil.copyfile(src_fpath, target_fpath)
# print(f"Password-protection index copied to {target_fpath}")
