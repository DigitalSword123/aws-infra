provider "aws" {
  region     = "ap-south-1"
}

resource "aws_sns_topic" "aws_updates" {
  name = "sns-topic-1"
}

resource "aws_sqs_queue" "s3_updates_queue" {
  name = "user-updates-queue"
}

# resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
#   topic_arn = aws_sns_topic.aws_updates.arn
#   protocol  = "sqs"
#   endpoint  = aws_sqs_queue.s3_updates_queue.arn
# }

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.aws_updates.arn
  protocol  = "email"
  endpoint  = "ranaamiya70@gmail.com"
}

resource "aws_s3_bucket_notification" "s3eventnotification"{
  bucket="sqs-sns-test-aws"
  topic{
    id="put-request-in-s3"
    topic_arn=aws_sns_topic.aws_updates.arn
    events=["s3:ObjectCreated:*"]
    filter_prefix="test/"
    filter_suffix=".xml"
  }
}