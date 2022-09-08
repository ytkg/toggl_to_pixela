# toggl_to_pixela
Togglの時間をPixelaに記録するスクリプト

## デモ
![Pixelaのグラフ](https://pixe.la/v1/users/takagi/graphs/task-durations)
https://pixe.la/v1/users/takagi/graphs/task-durations.html

## 使い方
### ローカルの場合
#### 環境変数の設定
```bash
cp .env.sample .env
vim .env
```

#### 実行
```bash
bundle install
bundle exec ruby app.rb
```
### GitHub Actionsの場合
#### 環境変数の設定
[Settings] -> [Secrets]に以下を登録
- TOGGL_API_TOKEN: Togglのtoken
- TOGGL_WORKSPACE_ID: Togglのworkspace id
- PIXELA_USERNAME: Pixelaのusername
- PIXELA_TOKEN: Pixelaのtoken
