import boto3
import sys
import re

def parse_s3_url(s3_url):
    match = re.match(r's3://([^/]+)/(.+)', s3_url)
    if match:
        return match.group(1), match.group(2)
    else:
        raise ValueError(f"Invalid S3 URL: {s3_url}")

def download_from_s3(s3_url, target_path):
    bucket_name, key = parse_s3_url(s3_url)
    s3 = boto3.resource('s3')
    bucket = s3.Bucket(bucket_name)
    target_file_path = f"{target_path}/{key.split('/')[-1]}"
    bucket.download_file(key, target_file_path)
    print(f"Downloaded '{key}' from S3 bucket '{bucket_name}' to '{target_file_path}'")

if __name__ == '__main__':
    args = sys.argv
    if len(args) != 3:
        print("Usage: python script.py s3://bucket/key target_path")
        sys.exit(1)

    s3_url = args[1]
    target_path = args[2]

    download_from_s3(s3_url, target_path)