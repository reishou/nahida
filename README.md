```
Clone repo
```

```
cp .env.example .env
```

```
cp app/sites/default.conf app/sites/your-web.conf
```

```
docker-compose up -d
```

S3 config in `config/filesystems.php`

```php
[
    's3' => [
        'driver' => 's3',
        'key' => env('AWS_ACCESS_KEY_ID', 'test'),
        'secret' => env('AWS_SECRET_ACCESS_KEY', 'test'),
        'region' => env('AWS_DEFAULT_REGION', 'us-west-2'),
        'bucket' => env('AWS_BUCKET', 'laravel'),
        'endpoint' => env('AWS_S3_ENDPOINT', 'http://laravel.localhost:4566'),
        'bucket_endpoint' => false,
        'use_path_style_endpoint' => true,
    ]
];
```