import os
import shutil
import time
from factory.handling.running_exception import RunningException as Rexc

from factory.base_context import BaseContext as Bctx
from factory.handling.base_logging import BaseLogging as Log

from settings.cli_impl import Cli
from settings.environment_data_provider import EnvSettings as Conf
from factory.utils.TextColorUtil import TextColor as Color


allure_results_dir = "allure-results"


def main():
    args = Cli.parse_external_args()
    Cli.set_arguments(args)
    try:
        cleanup_reports()
        run_robot_command()
    except:
        return 1


def run_robot_command():
    env_selected = Bctx.flag_environment.get()
    environment_features = f"feature_domains{os.sep}{env_selected}"
    Log.info(f"Running Robot Framework tests in {env_selected}...")
    tag = Cli.parse_robot_tag()
    print(f"robot_features{os.sep}{environment_features}{os.sep}{tag}.robot")
    result = os.system(
        f"python -m robot --outputdir .{os.sep}robot_features{os.sep}robot-results --timestampoutputs robot_features{os.sep}{environment_features}{os.sep}{tag}.robot"
    )
    if result == 1:
        raise BaseException


def cleanup_reports():
    path_robot_results = f".{os.sep}robot_features{os.sep}robot-results"
    deletion_message = " directory deleted successfully!"
    try:
        if os.path.exists(path_robot_results):
            shutil.rmtree(path_robot_results)
            print(Color.green(path_robot_results + deletion_message))
        time.sleep(2)
    except FileNotFoundError as fnfe:
        Rexc.raise_exception_error("Directory not found: ", fnfe)


class RobotRunner:
    if __name__ == "__main__":
        main()
