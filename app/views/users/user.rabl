object @user

# Declare the properties to include
attributes :bio, :location, :score
# alias 'avatar_url' to avatarURL. 为什么这么处理，因为Objective-C和Java都是驼峰式命名方式，这样做一个转换，客户端在获取json数据的时候就会
# 得到驼峰式的key值，如果API描述已经在wiki上了，那么客户端只需要将这些key值直接从wiki上拷过来就可以作为变量名了。然后因为变量名和key
# 值相同，客户端在解析json数据的时候，key就可以直接从变量名上拷。总的来说：这样能减少很多错误的概率。
attributes :avatar_url => :avatarURL 
attributes :allow_browse => :allowBrowse 
attributes :identify_token => :identifyToken