# require 'httparty'
require 'json'
require 'exifr/jpeg'
require 'aws-sdk-s3'

def lambda_handler(event:, context:)
  puts("called")
  # path_to_file = './data/7134.jpg'
  
  # Sample pure Lambda function

  # Parameters
  # ----------
  # event: Hash, required
  #     API Gateway Lambda Proxy Input Format
  #     Event doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-input-format

  # context: object, required
  #     Lambda Context runtime methods and attributes
  #     Context doc: https://docs.aws.amazon.com/lambda/latest/dg/ruby-context.html

  # Returns
  # ------
  # API Gateway Lambda Proxy Output Format: dict
  #     'statusCode' and 'body' are required
  #     # api-gateway-simple-proxy-for-lambda-output-format
  #     Return doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html

  # begin
  #   response = HTTParty.get('http://checkip.amazonaws.com/')
  # rescue HTTParty::Error => error
  #   puts error.inspect
  #   raise error
  # end

  # first_record = event["Records"].first
  # bucket_name = first_record["s3"]["bucket"]["name"]
  # file_name = first_record["s3"]["object"]["key"]
  bucket_name = 'cartis-dev-1'
  file_name = 'cartis/clients/14/projects/28/surveys/60/datasets/438/7130.jpg'
  

  client = Aws::S3::Client.new(region: 'ap-south-1')
  # s3 = Aws::S3::Resource.new(client: client)
  # object = s3.bucket(bucket_name).object(file_name)

  # client = Aws::S3::Client.new(
  #   region: ENV['REGION'],
  #   access_key_id: ENV['ACCESS_KEY'],
  #   secret_access_key: ENV['SECRET_ACCESS_KEY']
  #   )

  local_path = '/tmp/' +File.basename(file_name)

  File.open(local_path, 'wb') do |file|
    reap = client.get_object({ bucket: bucket_name, key: file_name}, target: file)
  end

  exif = EXIFR::JPEG.new(local_path)

  {
    statusCode: 200,
    body: {
      message: "Hello World!",
      # location: response.body
      latitide: exif.gps.latitude,
      exif: exif.to_hash.merge(exif.gps.to_h)
    }.to_json
  }
end

lambda_handler(event: {}, context: {})
