#!/usr/bin/env python

import os
import argparse
import ssg.build_hardening
import ssg.environment

def parse_args():
    p = argparse.ArgumentParser()
    p.add_argument(
        "--build-config-yaml", required=True,
        help="YAML file with information about the build configuration. "
        "e.g.: ~/scap-security-guide/build/build_config.yml"
    )
    p.add_argument(
        "--product-yaml", required=True,
        help="YAML file with information about the product we are building. "
        "e.g.: ~/scap-security-guide/rhel7/product.yml"
    )
    p.add_argument(
        "--check-files", required=True,
        help="Input directory with pre-existing (templated & macro-ized) "
        "check content"
    )
    p.add_argument(
        "--output", required=True,
        help="Output directory to build the hardening content into"
    )
    args = p.parse_args()
    return args

def main():
    args = parse_args()

    # Create the output directory if it doesn't yet exist.
    if not os.path.exists(args.output):
        os.makedirs(args.output)

    env_yaml = ssg.environment.open_environment(
        args.build_config_yaml, args.product_yaml)

    ssg.build_hardening.cis(env_yaml, args.product_yaml, args.check_files, args.output)
    ssg.build_hardening.stig(env_yaml, args.product_yaml, args.check_files, args.output)

if __name__ == "__main__":
    main()
