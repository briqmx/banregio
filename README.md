# banregio

## config
```
config = {
  url: ,
  account:,
  customer:,
  basic_auth: {
    user:,
    password:
  },
  p12: {
    cert_base64:,
    password:
  }
}
```

¿Comó generar `cert_base64`?

1.- certificate_txt = File.new(path, "w")

2.-certificate_txt.puts(Base64.encode64(File.read(certificate_p12_path)))

3.- certificate_txt.close

4.- Abrir archivo copiar y pegar en la variable `cert_base64`

## Inicializar api

```
api = Banregio::ApiClient.from_config(config)
```

## Movimientos

```
date = Date.new(2023, 01, 01)
api.movements(initial_date: date, final_date: date)
```

## Balance
```
api.balance
```