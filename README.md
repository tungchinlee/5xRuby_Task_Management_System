## 版本
- ruby: 2.7.0
- rails: 6.1.4

## 部署至heroku

- 登入

```bash
    heroku login
```

- 準備

```bash
    heroku create tms-5xruby
```

- 新增remote heroku節點

```bash
    git remote add heroku https://git.heroku.com/tms-5xruby.git
```

- 部署

```bash
    git push heroku main

    #migration有變動時
    heroku run rails db:migrate
```