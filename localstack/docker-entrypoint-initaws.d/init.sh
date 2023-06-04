#!/bin/bash

echo "Create SQS queue laravel.queue"
aws sqs create-queue --queue-name laravelqueue --endpoint-url http://localhost:4566

echo "All resources initialized! 🚀"

aws sqs send-message --endpoint-url=http://localhost:4566 --queue-url http://localhost:4566/000000000000/laravelqueue --region us-east-1 --message-body 'Test Message!'