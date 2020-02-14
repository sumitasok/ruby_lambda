install_sam:
	brew tap aws/tap
	brew install aws-sam-cli

aws_create_bucket:
	aws s3 mb s3://cartislambdacoderubyexifparser

sam_package_app:
	sam package --template-file template.yaml --output-template-file packaged-template.yaml --s3-bucket cartislambdacoderubyexifparser

sam_deploy:
	sam deploy --template-file packaged-template.yaml --stack-name rubyExifParser --capabilities CAPABILITY_IAM --region ap-south-1

sam_package_and_deploy: sam_package_app sam_deploy