# Authentication

Authentication is done through the `Authorization` request header. The value should be in the format `Token abcdefg` where `abcdefg` is replaced with your API Key.

```shell
## Request Header
curl "http://guestmanager.com/api/pubic/v1"
  -H "Authorization: Token meowmeowmeow"
```

## API Keys
API Keys are created in the company dashboard under the Config menu. API keys are authorized for either `read`, `write`, or both.
