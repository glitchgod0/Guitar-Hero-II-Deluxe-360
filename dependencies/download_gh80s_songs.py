# enable_keys.py
from pathlib import Path
import shutil
import os
try:
    import git
    print("module 'git' is installed. Downloading GHIIDX songs repo & enabling GH80SDX songs for Xenia, this will take a while...")
except ModuleNotFoundError:
    print("module 'git' is not installed. Install it via '/dependencies/install_gitpython.bat' or 'pip install gitpython'")
    sys.exit(1)
    
# get the current working directory
cwd = Path().absolute()

# clone/pull gh2dx songs
gh2dx_songs_source_path = cwd.joinpath("gh80sdx-360-songs")

if gh2dx_songs_source_path.exists():
    # folder exists, pull the repository
    repo = git.Repo(gh2dx_songs_source_path)
    origin = repo.remotes.origin
    origin.pull()
else:
    # folder does not exist, clone the repository
    repo = git.Repo.clone_from("https://github.com/hmxmilohax/gh2dx-360-songs.git", gh2dx_songs_source_path, branch="gh80sdx")

gh2dx_songs_source_folder = cwd.joinpath("gh80sdx-360-songs/GH80SDX/songs")
gh2dx_config_source_folder = cwd.joinpath("gh80sdx-360-songs/GH80SDX/config")
gh2dx_customs_folder = cwd.joinpath("content/415607E7/00000002/GH80SDX/songs")
gh2dx_custom_config_folder = cwd.joinpath("content/415607E7/00000002/GH80SDX/config")
files = os.listdir(gh2dx_songs_source_path)

# Check if the destination folder exists
if os.path.exists(gh2dx_customs_folder):
    # If it exists, remove it
    shutil.rmtree(gh2dx_customs_folder)

# Copy the source folder to the destination
shutil.copytree(gh2dx_songs_source_folder, gh2dx_customs_folder, ignore_dangling_symlinks=False)

# Check if the destination folder exists
if os.path.exists(gh2dx_custom_config_folder):
    # If it exists, remove it
    shutil.rmtree(gh2dx_custom_config_folder)

# Copy the source folder to the destination
shutil.copytree(gh2dx_config_source_folder, gh2dx_custom_config_folder, ignore_dangling_symlinks=False)

# Delete all .vgs files
for path in gh2dx_customs_folder.glob('**/*.vgs'):
    os.remove(path)

print(f"Successfully downloaded GH80SDX songs repo. Please rebuild in order to see them added in-game.")