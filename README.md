# sample_sendgrid

## command

copy `maillist.yml.sample` to `maillist.yml`. And replace example.com addresses to available email addresses.

```sh
cp maillist.yml.sample maillist.yml
```

### Legacy Transactional Template with SMTP
 ```sh
bin/rails runner ./scripts/smtp.rb 
```


## メモ

- X-SMTPAPI では Dynamic Transactional Templates をサポートしていない (2019-2-23)
  - The X-SMTPAPI does not support Dynamic Transactional Templates. For sending Dynamic Transactional Templates you need to use v3 Mail Send.
  - https://sendgrid.com/docs/for-developers/sending-email/how-to-use-a-transactional-template-with-smtp-or-v2/
  
