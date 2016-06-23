ource /etc/profile.d/rvm.sh

下载nginx 
apt-get install nginx

启动nginx
 $sudo /etc/init.d/nginx start

service nginx start

unix:///var/rails-app/my_blog/shared/sockets/puma.sock;

停止puma
bundle exec pumactl -F config/puma.rb stop
