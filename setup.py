import sys
import argparse
import json
import platform
import os
from collections import OrderedDict

__SETUP_VERSION__ = "1.2.6"


class Template:
    def __init__(self) -> None:
        self._home_path = os.path.expanduser("~")
        self._current_path = os.path.abspath(os.path.dirname(__file__))
        self._download_path = ""
        self._install_path = ""

    def set_download_path(self, path):
        self._download_path = path

    def set_install_path(self, path):
        self._install_path = path

    def get_template(self):
        return {
            "home_path": self._home_path,
            "current_path": self._current_path,
            "download_path": self._download_path,
            "install_path": self._install_path
        }


class Parser:
    def __init__(self) -> None:
        self._parser = argparse.ArgumentParser()
        self._install_enable = None
        self._build_enable = None
        self._install_folder = ""
        self._build_folder = ""
        self._init_parser()

    def _init_parser(self):
        self._parser.add_argument(
            '--install_enable', type=bool, default=True, help='install enable')
        self._parser.add_argument(
            '--build_enable', type=bool, default=True, help='build enable')
        self._parser.add_argument(
            '--install_folder', type=str, default="third_party", help='install folder')
        self._parser.add_argument(
            '--build_folder', type=str, default="install", help='build folder')

    def start(self):
        params = vars(self._parser.parse_args())
        self._install_enable = params.get("install_enable")
        self._build_enable = params.get("build_enable")
        self._install_folder = params.get("install_folder")
        self._build_folder = params.get("build_folder")

    def get_install_enable(self):
        return self._install_enable

    def get_build_enable(self):
        return self._build_enable

    def get_install_folder(self):
        return self._install_folder

    def get_build_folder(self):
        return self._build_folder


class Script:
    def __init__(self) -> None:
        self._before = []
        self._after = []

    def set_before(self, script: list):
        self._before = script

    def set_after(self, script: list):
        self._after = script

    def get_before(self):
        return self._before

    def get_after(self):
        return self._after


class Repository:
    def __init__(self) -> None:
        self._current_path = os.path.abspath(os.path.dirname(__file__))
        self._addr = ""
        self._name = ""
        self._branch = ""
        self._commit = ""
        self._before_script = ""
        self._options = ""
        self._install_path = ""

    def get_addr(self):
        return self._addr

    def get_name(self):
        return self._name

    def get_branch(self):
        return self._branch

    def get_commit(self):
        return self._commit

    def get_before_script(self):
        return self._before_script

    def get_options(self):
        return self._options

    def get_install_path(self):
        return self._install_path

    def set_addr(self, addr) -> None:
        self._addr = addr
        return None

    def set_name(self, name) -> None:
        self._name = name
        return None

    def set_branch(self, branch) -> None:
        self._branch = branch
        return None

    def set_commit(self, commit) -> None:
        self._commit = commit
        return None

    def set_before_script(self, before_script) -> None:
        self._before_script = before_script
        return None

    def set_options(self, options) -> None:
        self._options = options
        return None

    def is_git_repository(self) -> bool:
        return self._addr.endswith(".git")

    def set_install_path(self, install_path) -> None:
        if install_path.startswith("/"):
            self._install_path = install_path
        elif install_path.startswith("~"):
            self._install_path = os.path.expanduser(install_path)
        else:
            self._install_path = os.path.join(self._current_path, install_path)
        return None


class Pipeline:
    def __init__(self) -> None:
        self._parser = Parser()
        self._repos = OrderedDict()
        self._scripts = Script()
        self._template = Template()
        self._current_path = os.path.abspath(os.path.dirname(__file__))
        self._download_path = ""
        self._install_path = ""
        self._packages_path = ""
        self._pkg_config_path = ""
        self._system = platform.uname().system

    def init(self):
        self._load_params()
        self._loading_packages()
        self._before_script()
        return None

    def download(self):
        for _, repo in self._repos.items():
            print("#################             ####################")
            print("#################   download: {}".format(repo.get_name()))
            print("#################             ####################")
            self._clone_git_repository(repo=repo)
            self._download_compress_files(repo=repo)

    def build(self):
        for name, repo in self._repos.items():
            if not repo.is_git_repository():
                continue
            print("#################             ####################")
            print("#################   build: {}".format(repo.get_name()))
            print("#################             ####################")
            repo_path = os.path.join(self._download_path, name)
            os.chdir(repo_path)
            cmd = "export PKG_CONFIG_PATH={0}/lib/pkgconfig:{0}/shared/pkgconfig:{1} && mkdir -p build && cd build && cmake .. {2}".format(
                self._install_path, self._pkg_config_path, repo.get_options())
            self._command(cmd=cmd)
            os.chdir("build")
            cmd = "make install -j4"
            self._command(cmd=cmd)

    def exit(self):
        self._after_script()

    def _clone_git_repository(self, repo: Repository):
        cmd = ""
        download_path = os.path.join(self._download_path, repo.get_name())
        if os.path.exists(download_path):
            return
        if not repo.is_git_repository():
            return
        self._command("mkdir -p {}".format(download_path))
        if "" == repo.get_branch() and "" == repo.get_commit():
            cmd = "git clone --depth 1 {} {}".format(
                repo.get_addr(),
                download_path)
        elif repo.get_branch():
            cmd = "git clone --depth 1 --single-branch --branch {} {} {}".format(
                repo.get_branch(),
                repo.get_addr(),
                download_path)
        elif repo.get_commit():
            cmd = "git clone {0} {1} && cd {1} && git checkout {2}".format(
                repo.get_addr(), download_path, repo.get_commit())
        self._command(cmd=cmd)

    def _download_compress_files(self, repo: Repository):
        if not repo.get_addr():
            return
        if repo.is_git_repository():
            return
        cmd = ""
        download_path = os.path.join(self._download_path, repo.get_name())
        file_extension = os.path.splitext(repo.get_addr())[1]
        target_file_name = "{}{}".format(repo.get_name(), file_extension)
        target_file_path = os.path.join(self._download_path, target_file_name)
        if os.path.exists(target_file_path):
            print("  文件 {} 已存在".format(target_file_path))
            return

        print("#### download compress file: {}".format(repo.get_addr()))

        # download
        cmd = "wget -O {0} {1}".format(target_file_path, repo.get_addr())
        self._command(cmd=cmd)

        # unpack
        temp_path = os.path.join(self._download_path, ".zip_temp")
        self._command("mkdir -p {}".format(temp_path))
        if target_file_path.endswith(".zip") or target_file_path.endswith(".vsix"):
            cmd = "unzip -d {} {}".format(temp_path, target_file_path)
        elif target_file_path.endswith(".tar.gz"):
            cmd = "tar -C {} -zxvf {}".format(temp_path, target_file_path)
        elif target_file_path.endswith(".tar"):
            cmd = "tar -C {} -xvf {}".format(temp_path, target_file_path)
        else:
            print("   !!!!!!  Exception")
            sys.exit(9)
        self._command(cmd=cmd)

        # move
        for file_name in os.listdir(temp_path):
            file_path = os.path.join(temp_path, file_name)
            if os.path.isdir(file_path) and repo.get_install_path():
                # 修改文件夹名
                cmd = "mv {} {}".format(
                    file_path, os.path.join(temp_path, repo.get_name()))
                self._command(cmd=cmd)
                # 移动
                cmd = "mkdir -p {}".format(os.path.join(
                    self._current_path, repo.get_install_path()))
                self._command(cmd=cmd)
                cmd = "mv {} {}".format(os.path.join(temp_path, repo.get_name()), os.path.join(
                    self._current_path, repo.get_install_path()))
                self._command(cmd=cmd)
                break

        self._remove_files(temp_path)

    def _command(self, cmd):
        if "" != cmd:
            print("---   @@@@@@@ cmd: {}".format(cmd))
            os.system(cmd)

    def _remove_files(self, path: str):
        for file_name in os.listdir(path):
            file_path = os.path.join(path, file_name)
            if os.path.isfile(file_path):
                os.remove(file_path)

    def _load_params(self):
        self._parser.start()
        self._download_path = os.path.join(
            self._current_path, str(self._parser.get_install_folder()))
        self._install_path = os.path.join(
            self._current_path, str(self._parser.get_build_folder()))
        self._packages_path = os.path.join(self._current_path, "packages.json")
        if not os.path.exists(self._packages_path):
            print("packages.json文件不存在: {}".format(self._packages_path))
            sys.exit(9)
        self._command("mkdir -p {}".format(self._download_path))
        self._command("mkdir -p {}".format(self._install_path))
        self._template.set_download_path(self._download_path)
        self._template.set_install_path(self._install_path)

        if os.getenv("PKG_CONFIG_PATH"):
            self._pkg_config_path = "{}".format(os.getenv("PKG_CONFIG_PATH"))
        else:
            self._pkg_config_path = ""

    def _loading_packages(self):
        with open(self._packages_path) as file:
            data = json.load(file, object_pairs_hook=OrderedDict)
        for config_name, config_repo in data["dependencies"].items():
            self._append_repository(
                name=config_name,
                addr=self._parse_addr(config_repo.get("addr")),
                branch=config_repo.get("branch", ""),
                commit=config_repo.get("commit", ""),
                before_script=config_repo.get("before_script", ""),
                install_path=config_repo.get("install_path", ""),
                options=config_repo.get("cmake_optione", "")
            )
        self._scripts.set_before(data["scripts"].get("before", []))
        self._scripts.set_after(data["scripts"].get("after", []))

    def _before_script(self):
        for script in self._scripts.get_before():
            self._command(script.format(**self._template.get_template()))

    def _after_script(self):
        for script in self._scripts.get_after():
            self._command(script)

    def _append_repository(self, **kwargs):
        repo = Repository()
        for key, value in kwargs.items():
            if "addr" == key:
                repo.set_addr(addr=value.format(
                    **self._template.get_template()))
            elif "name" == key:
                repo.set_name(name=value.format(
                    **self._template.get_template()))
            elif "install_path" == key:
                repo.set_install_path(install_path=value.format(
                    **self._template.get_template()))
            elif "branch" == key:
                repo.set_branch(branch=value.format(
                    **self._template.get_template()))
            elif "commit" == key:
                repo.set_commit(commit=value.format(
                    **self._template.get_template()))
            elif "before_script" == key:
                repo.set_before_script(before_script=value.format(
                    **self._template.get_template()))
            elif "options" == key:
                options = ""
                for option in value:
                    options += " " + \
                        option.format(**self._template.get_template())
                repo.set_options(options=options)
            else:
                print("Exception")
                exit(0)
        self._repos[repo.get_name()] = repo

    def _parse_addr(self, addr) -> str:
        if isinstance(addr, str):
            return addr
        elif isinstance(addr, dict):
            print("addr is dict: {}".format(addr))
            if "Linux" == self._system and "linux" in addr:
                print("addr: {}".format(addr["linux"]))
                return addr["linux"]
            elif "Darwin" == self._system and "mac" in addr:
                print("addr: {}".format(addr["mac"]))
                return addr["mac"]
        print("packages.json addr Exception")
        sys.exit(9)


def main():
    print("setup version: {}".format(__SETUP_VERSION__))
    pipe_line = Pipeline()
    pipe_line.init()
    pipe_line.download()
    pipe_line.build()
    pipe_line.exit()


if __name__ == "__main__":
    main()
