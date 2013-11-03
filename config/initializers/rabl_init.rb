require 'rabl'
Rabl.configure do |config|
  # 设置include_json_root为false的话，可以使返回的JSON数据少一层结构，方便客户端的调用。
  # 可以设置这个值为true，然后请求API来看看区别。
  config.include_json_root = false
  # config.include_child_root = true
end