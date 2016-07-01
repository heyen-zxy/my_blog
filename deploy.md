# nginx + puma + mina 自动化部署
主要参考 [https://segmentfault.com/a/1190000002918225](https://segmentfault.com/a/1190000002918225)
#### puma
 在gemfile中加入 ` gem 'puma' `
  
 执行 ` bundle isntall `
 
 在config下手动创建一个puma.rb文件
  
 	
 	#ruby

	#!/usr/bin/env puma

	#rails的运行环境
	environment 'production'
	threads 2, 64 #最大线程数和最小线程数
	workers 4 #一般设置2-4

	#项目名
	app_name = "blog"
	#项目路径
	application_path = "/var/rails-app/#{app_name}"
	#这里一定要配置为项目路径下地current
	directory "#{application_path}/current"

	#下面都是 puma的配置项 puma需要的文件夹在mina配置文件 task setup配置里面创建
	pidfile "#{application_path}/shared/tmp/pids/puma.pid"
	state_path "#{application_path}/shared/tmp/sockets/puma.state"
	stdout_redirect "#{application_path}/shared/log/puma.stdout.log", "#{application_path}/shared/log/	puma.stderr.log"
	bind "unix://#{application_path}/shared/tmp/sockets/#{app_name}.sock" #这个需要配置到nginx中
	activate_control_app "unix://#{application_path}/shared/tmp/sockets/pumactl.sock"

	#后台运行
	daemonize true
	on_restart do
  	puts 'On restart...'
	end
	preload_app! 
 
#### mina
在gemfile中加入 ` gem 'mina' `
  
 执行 ` bundle isntall `
 
 ` mina init` 会在config下生成 deploy.rb
 
 	require 'mina/bundler'
	require 'mina/rails'
	require 'mina/git'
	require 'mina/rvm' #服务器上使用的是rvm

	#服务器地址,是使用ssh的方式登录服务器 
	set :domain, 'root@112.124.46.102' #在服务器~/.ssh/authorized_keys 里面写入你的id_rsa.pub就不用密码登录
	#服务器中项目部署位置
	set :deploy_to, '/var/rails-app/blog'
	#git代码仓库
	set :repository, 'https://github.com/heyen-zxy/my_blog.git'
	#git分支
	set :branch, 'master'
	#配置rvm位置
	set :rvm_path, '/usr/local/rvm/bin/rvm'
	
	# This task is the environment that is loaded for most commands, such as
	# `mina deploy` or `mina rake`.
	task :environment do
  	# If you're using rbenv, use this to load the rbenv environment.
  	# Be sure to commit your .ruby-version or .rbenv-version to your repository.
  	# invoke :'rbenv:load'
	# For those using RVM, use this to load an RVM version@gemset.
  		invoke :'rvm:use[ruby-2.1.3]' #设置rvm ruby版本
	end

	# 中括号里的文件 会出现在服务器项目附录的shared文件夹中，这里加入了secrets.yml，环境密钥无需跟开发计算机一样
	set :shared_paths, ['config/database.yml', 'log', 'config/secrets.yml']

	# 这个块里面的代码表示运行 mina setup时运行的命令
	task :setup => :environment do

  		# 在服务器项目目录的shared中创建log文件夹
  		queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  		queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  		# 在服务器项目目录的shared中创建config文件夹 下同
  		queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  		queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  		queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  		queue! %[touch "#{deploy_to}/#{shared_path}/config/secrets.yml"]

  		# puma.rb 配置puma必须得文件夹及文件
  		queue! %[mkdir -p "#{deploy_to}/shared/tmp/pids"]
  		queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/pids"]

  		queue! %[mkdir -p "#{deploy_to}/shared/tmp/sockets"]
  		queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/sockets"]

  		queue! %[touch "#{deploy_to}/shared/config/puma.rb"]
  		queue  %[echo "-----> Be sure to edit 'shared/config/puma.rb'."]

  		# tmp/sockets/puma.state
  		queue! %[touch "#{deploy_to}/shared/tmp/sockets/puma.state"]
  		queue  %[echo "-----> Be sure to edit 'shared/tmp/sockets/puma.state'."]

  		# log/puma.stdout.log
  		queue! %[touch "#{deploy_to}/shared/log/puma.stdout.log"]
  		queue  %[echo "-----> Be sure to edit 'shared/log/puma.stdout.log'."]

  		# log/puma.stdout.log
  		queue! %[touch "#{deploy_to}/shared/log/puma.stderr.log"]
  		queue  %[echo "-----> Be sure to edit 'shared/log/puma.stderr.log'."]

  		queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml'."]
	end

	#这个代码块表示运行 mina deploy时执行的命令
	desc "Deploys the current version to the server."
	task :deploy => :environment do
  		to :before_hook do
  		end
  		deploy do
    		#重新拉git服务器上的最新版本，即使没有改变
    		invoke :'git:clone'
    		#重新设定shared_path位置
    		invoke :'deploy:link_shared_paths'
    		invoke :'bundle:install'
    		invoke :'rails:db_migrate' #首次执行可能会报错 需要我们手动先创建数据库 db:create
    		invoke :'rails:assets_precompile'
    		invoke :'deploy:cleanup'

    		to :launch do
      			queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      			# queue "chown -R www-data #{deploy_to}"
      			queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt" 
      			queue "pumactl -F  #{deploy_to}/#{current_path}/config/puma.rb  restart" #touch好像没有效果 所以直接使用的命令重启， 重启命令参考：
    		end
  		end
	end
	
puma 重启命令参考[http://ruby-journal.com/digesting-pumactl](http://ruby-journal.com/digesting-pumactl)

执行 ` mina setup `会在服务器生成对应的项目路径

* current -当前版本目录也就是项目目录
* last_version -版本号
* releases/ -过去的版本
* scm/
* shared/ 先前shared_path所设定另外拉出来的文件都在这里
* tmp/


#### nginx
在` /etc/nginx/sites-enabled/ `创建文件 blog文件，sites-enabled下的文件会默认加载到nginx.conf中

	upstream deploy_blog {
	         server   unix:///var/rails-app/blog/shared/tmp/sockets/blog.sock; #这个是在puma.rb 中产生的
	        }
	
	server {
	    listen 80;
	    server_name 112.124.46.102;
	    client_max_body_size 3m;
	
	    # Tell Nginx and Passenger where your app's 'public' directory is
	    root /var/rails-app/blog/current/public;
	    location / {
	        expires      max;
	        add_header     Cache-Control public;
	
	        proxy_redirect   off;
	        proxy_set_header  Host        $http_host;
	        proxy_set_header  X-Forwarded-For  $proxy_add_x_forwarded_for;
	
	        proxy_pass     http://deploy_blog; #此处指定对应的upstream
	  }
	}
  