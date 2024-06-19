<div id="main-content" class="container">
<div class="content">
<div xmlns:v="http://rdf.data-vocabulary.org/#" id="crumbs">
<span typeof="v:Breadcrumb">
<a rel="v:url" property="v:title" class="crumbs-home" href="https://serveradmin.ru/">Home</a>
</span> <span class="delimiter">»</span> <span typeof="v:Breadcrumb">
<a rel="v:url" property="v:title" href="https://serveradmin.ru/category/linux/">Linux</a>
</span> <span class="delimiter">»</span> <span typeof="v:Breadcrumb">
<a rel="v:url" property="v:title" href="https://serveradmin.ru/category/linux/centos/">CentOS</a>
</span> <span class="delimiter">»</span> <span class="current">Rsync настройка бэкапа на CentOS / Debian / Ubuntu</span>
</div>
<article class="post-listing post-984 post type-post status-publish format-standard has-post-thumbnail  category-centos category-debian category-linux tag-backup tag-centos tag-debian tag-rsync tag-ubuntu" id="the-post">
<div class="post-inner">
<h1 class="name post-title entry-title">
<span itemprop="name">Rsync настройка бэкапа на CentOS / Debian / Ubuntu</span>
</h1>
<p class="post-meta">
<span class="post-meta-author">
<i class="fa fa-user">
</i>
<a href="https://serveradmin.ru/author/zerox/" title="">Zerox </a>
</span>
<span class="tie-date">
<i class="fa fa-clock-o">
</i>Обновлено: 16.11.2020</span>	
<span class="post-cats">
<i class="fa fa-folder">
</i>
<a href="https://serveradmin.ru/category/linux/centos/" rel="category tag">CentOS</a>, <a href="https://serveradmin.ru/category/linux/debian/" rel="category tag">Debian</a>, <a href="https://serveradmin.ru/category/linux/" rel="category tag">Linux</a>
</span>
<span class="post-comments">
<i class="fa fa-comments">
</i>
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comments">142 комментария</a>
</span>
<span class="post-views">
<i class="fa fa-eye">
</i>150,841 Просмотры</span> </p>
<div class="clear">
</div>
<div class="entry">
<p>Существует много способов организации backup на CentOS/Debian/Ubuntu серверах - бесплатные утилиты, самописные скрипты с использованием tar, система бэкапа bacula и много другое. Все это в той или иной мере я использовал или использую в своей работе. Сегодня я хочу с вами поделиться своим методом организации простого, удобного и быстрого способа настройки инкрементного backup с использованием популярной утилиты <strong>rsync</strong> на серверах под управлением CentOS/Debian/Ubuntu. Способ одинаково работает на этих системах, небольшие отличия только в самой установке rsync, о чем я отдельно упомяну для каждой системы.</p>
<div class="mot" style="background: rgb(230, 115, 112) !important; outline: rgb(255, 0, 0) solid !important;">
<div class="mot-inner-block">
Научитесь обеспечивать безопасность в непрерывном процессе разработки и продакшена на онлайн курсе <strong>"Внедрение и работа в DevSecOps."</strong> в OTUS. Курс не для новичков, для успешного поступления пройдите <a href="https://serveradmin.ru/devsecops-txt" rel="noopener">вступительный тест</a>.
</div>
</div>
<p>
<span id="more-984">
</span>
</p>
<div class="lwptoc lwptoc-light lwptoc-notInherit" data-smooth-scroll="0" data-lwptoc-initialized="1">
<div class="lwptoc_i">    <div class="lwptoc_header">
<b class="lwptoc_title">Содержание</b>            </div>
<div class="lwptoc_items lwptoc_items-visible">
<div class="lwptoc_itemWrap">
<div class="lwptoc_item">    <a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#Ustanovka_rsync_na_CentOS_8">
<span class="lwptoc_item_label">Установка rsync на CentOS 8</span>
</a>
</div>
<div class="lwptoc_item">    <a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#Ustanovka_rsync_na_CentOS_7">
<span class="lwptoc_item_label">Установка rsync на CentOS 7</span>
</a>
</div>
<div class="lwptoc_item">    <a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#Ustanovka_rsync_na_DebianUbuntu">
<span class="lwptoc_item_label">Установка rsync на Debian/Ubuntu</span>
</a>
</div>
<div class="lwptoc_item">    <a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#Nastrojka_rsync">
<span class="lwptoc_item_label">Настройка rsync</span>
</a>
</div>
<div class="lwptoc_item">    <a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#Kopirovanie_rsync_cerez_ssh">
<span class="lwptoc_item_label">Копирование rsync через ssh</span>
</a>
</div>
<div class="lwptoc_item">    <a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#Nastrojka_isklucenij">
<span class="lwptoc_item_label">Настройка исключений</span>
</a>
</div>
<div class="lwptoc_item">    <a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#Rotacia_logov_rsync">
<span class="lwptoc_item_label">Ротация логов rsync</span>
</a>
</div>
<div class="lwptoc_item">    <a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#Primer_bekapa_windows_servera_s_pomosu_rsync">
<span class="lwptoc_item_label">Пример бэкапа windows сервера с помощью rsync</span>
</a>
<div class="lwptoc_itemWrap">
<div class="lwptoc_item">    <a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#Pomogla_stata_Podpisyvajsa_na_telegram_kanal_avtora">
<span class="lwptoc_item_label">Помогла статья? Подписывайся на telegram канал автора</span>
</a>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<h2>
<span id="Ustanovka_rsync_na_CentOS_8">
<span style="color: #000000;">Установка rsync на CentOS 8</span>
</span>
</h2>
<p>Чаще всего rsync уже присутствует в базовой версии centos 8, но скорее всего без версии, работающей в качестве службы. Так что устанавливаем обоих:</p>
<pre># dnf install rsync rsync-daemon</pre>
<p>
<a href="https://serveradmin.ru/wp-content/uploads/2020/11/rsync-install-configure-01.png" target="_blank" rel="noopener noreferrer">
<img decoding="async" class="aligncenter wp-image-12976 size-full" src="https://serveradmin.ru/wp-content/uploads/2020/11/rsync-install-configure-01.png" alt="" width="1034" height="361" data-wp-pid="12976" data-pin-nopin="nopin" srcset="https://serveradmin.ru/wp-content/uploads/2020/11/rsync-install-configure-01.png 1034w, https://serveradmin.ru/wp-content/uploads/2020/11/rsync-install-configure-01-300x105.png 300w, https://serveradmin.ru/wp-content/uploads/2020/11/rsync-install-configure-01-1024x358.png 1024w, https://serveradmin.ru/wp-content/uploads/2020/11/rsync-install-configure-01-768x268.png 768w" sizes="(max-width: 1034px) 100vw, 1034px">
</a>
</p>
<p>Если у вас еще нет настроенной системы, то используйте мои статьи по <a href="https://serveradmin.ru/ustanovka-centos-8/" target="_blank" rel="noopener noreferrer">установке</a> и <a href="https://serveradmin.ru/centos-nastroyka-servera/" target="_blank" rel="noopener noreferrer">настройке centos 8</a>. Запускаем rsyncd и добавляем в автозагрузку.</p>
<pre># systemctl enable --now rsyncd
Created symlink /etc/systemd/system/multi-user.target.wants/rsyncd.service → /usr/lib/systemd/system/rsyncd.service.</pre>
<p>Проверяем автозагрузку:</p>
<pre># systemctl list-unit-files --type service | grep rsyncd
rsyncd.service enabled</pre>
<p>Проверяем, слушает ли служба сетевой порт.</p>
<pre># netstat -tulpn | grep rsync
tcp        0      0 0.0.0.0:873             0.0.0.0:*               LISTEN      40814/rsync         
tcp6       0      0 :::873                  :::*                    LISTEN      40814/rsync         
</pre>
<p>Все в порядке, можно приступать к настройке rsync. Если вам не нужен ipv6, то можете его <a href="https://serveradmin.ru/disable-ipv6/#Rsync" target="_blank" rel="noopener noreferrer">отключить</a>.</p>
<h2>
<span id="Ustanovka_rsync_na_CentOS_7">
<span style="color: #000000;">Установка rsync на CentOS 7</span>
</span>
</h2>
<p>Ставим rsync:</p>
<pre># yum install rsync</pre>
<p>Добавляем в автозагрузку:</p>
<pre>#&nbsp;systemctl enable rsyncd
ln -s '/usr/lib/systemd/system/rsyncd.service' '/etc/systemd/system/multi-user.target.wants/rsyncd.service'</pre>
<p>Проверяем автозагрузку:</p>
<pre># systemctl list-unit-files --type service | grep rsyncd
rsyncd.service enabled</pre>
<p>Запускаем rsync:</p>
<pre># systemctl start rsyncd</pre>
<p>Проверяем, как запустился:</p>
<pre># netstat -tulpn | grep rsync
tcp &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp;0 0.0.0.0:873 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0.0.0.0:* &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; LISTEN &nbsp; &nbsp; &nbsp;2782/rsync</pre>
<p>Все в порядке, можно приступать к настройке rsync.</p>
<h2>
<span id="Ustanovka_rsync_na_DebianUbuntu">
<span style="color: #000000;">Установка rsync на Debian/Ubuntu</span>
</span>
</h2>
<div class="ca-ca ca-ca-center ca-ca-9">
<div class="" data-ai-debug1="9">
<!-- Yandex.RTB R-A-184428-6 -->
<div id="yandex_rtb_R-A-184428-6">
</div>
<script>window.yaContextCb.push(()=>{
Ya.Context.AdvManager.render({
renderTo: 'yandex_rtb_R-A-184428-6',
blockId: 'R-A-184428-6'
})
})</script>
</div>
<div class="" style="visibility: hidden; display: none; background: rgb(230, 115, 112) !important; outline: rgb(255, 0, 0) solid !important;" data-ai-tracking="WzAsMywi0JHQsNC90L3QtdGAIDEgYWRibG9jayIsImxpbnV4IiwwXQ==" data-ai-debug1="9 <= 3">
<a href="https://serveradmin.ru/otus-linux-picture" target="_blank" rel="noopener">
<img class="aligncenter" src="https://serveradmin.ru/wp-content/uploads/2022/07/1.png" alt="" width="725" height="88">
</a>
</div>
</div>
<p>Устанавливаем rsync:</p>
<pre># apt install rsync</pre>
<p>Правим&nbsp;конфиг:</p>
<pre># mcedit /etc/default/rsync</pre>
<p>Находим строку <strong>RSYNC_ENABLE=false</strong>
<em>&nbsp;</em>и меняем на <strong>true</strong>:</p>
<pre>RSYNC_ENABLE=true</pre>
<p>Создаем пустой файл конфигурации <em>/etc/rsyncd.conf</em>, он нужен для запуска службы. Позже мы его заполним настройками.</p>
<pre># touch /etc/rsyncd.conf</pre>
<p>Запускаем rsync:</p>
<pre># systemctl enable --now rsync
Synchronizing state of rsync.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable rsync</pre>
<p>Проверяем, что работает:</p>
<pre># netstat -tulnp | grep rsync
tcp        0      0 0.0.0.0:873             0.0.0.0:*               LISTEN      2232/rsync          
tcp6       0      0 :::873                  :::*                    LISTEN      2232/rsync          
</pre>
<p>Все в порядке, можно приступать к настройке rsync.</p>
<h2>
<span id="Nastrojka_rsync">
<span style="color: #000000;">Настройка rsync</span>
</span>
</h2>
<p>Теперь приступаем к настройке. Логика наших бэкапов будет следующая.&nbsp;При первом запуске мы делаем полный бэкап интересующей нас информации в папку <strong>current</strong>. Потом раз в сутки мы сверяем имеющийся архив с источником и делаем его вновь актуальным, перезаписывая все изменившиеся файлы, но при этом не удаляем их, а складываем в папку <strong>increment</strong>, где каждый день создается папка с именем в виде даты, в которую складываются все измененные файлы за текущий день. Таким образом, у нас всегда будет полный архив, актуальный на момент последней синхронизации, плюс набор папок за каждый день с изменившимися в этот день файлами. Сколько дней хранить, можно выбрать по необходимости.</p>
<p>Получается у нас такая картинка:</p>
<p>
<a href="https://serveradmin.ru/wp-content/uploads/2015/05/rsync.jpg">
<img decoding="async" loading="lazy" class="aligncenter size-full wp-image-991" src="https://serveradmin.ru/wp-content/uploads/2015/05/rsync.jpg" alt="rsync" width="315" height="277" srcset="https://serveradmin.ru/wp-content/uploads/2015/05/rsync.jpg 315w, https://serveradmin.ru/wp-content/uploads/2015/05/rsync-300x264.jpg 300w" sizes="(max-width: 315px) 100vw, 315px">
</a>
</p>
<p>При этом подключение и работа rsync будет проходить по своему отдельному порту <strong>tcp 873</strong>. Не забудьте <a href="https://serveradmin.ru/nastroyka-iptables-v-centos-7/" target="_blank" rel="noopener noreferrer">настроить iptables</a> и открыть этот порт. Приступаем к реализации. В первую очередь настраиваем rsync на серверах источниках информации, с которых мы будем забирать данные для backup.</p>
<p>Создаем файл конфигурации rsync:</p>
<pre># mcedit /etc/rsyncd.conf</pre>
<pre>pid file = /var/run/rsyncd.pid
log file = /var/log/rsyncd.log
transfer logging = true
munge symlinks = yes
# папка источник для бэкапа
[data]
path = /data
uid = root
read only = yes
list = yes
comment = Data backup Dir
auth users = backup
secrets file = /etc/rsyncd.scrt</pre>
<p>Создаем файл с учетными данными для подключения:</p>
<pre># mcedit /etc/rsyncd.scrt</pre>
<pre>backup:12345</pre>
<p>где <strong>backup</strong> - имя пользователя, <strong>12345</strong> - пароль.<br>
Делаем права на чтение только <strong>root</strong>, иначе rsync не запустится:</p>
<pre># chmod 0600 /etc/rsyncd.scrt</pre>
<p>После настройки перезапускаем rsync. На Centos:</p>
<pre># systemctl restart rsyncd</pre>
<p>На Debian/Ubuntu:</p>
<pre># systemctl restart rsync</pre>
<p>Теперь идем на сервер приемник, в котором будут храниться архивные копии с серверов источников. Там создаем скрипт инкрементного бэкапа c использованием rsync:</p>
<pre># mcedit /root/bin/backup-server1.sh</pre>
<pre>#!/bin/bash
date
# Папка, куда будем складывать архивы
syst_dir=/backup/
# Имя сервера, который архивируем
srv_name=server1
# Адрес сервера, который архивируем
srv_ip=10.10.1.55
# Пользователь rsync на сервере, который архивируем
srv_user=backup
# Ресурс на сервере для бэкапа
srv_dir=data
echo "Start backup ${srv_name}"
# Создаем папку для инкрементных бэкапов
mkdir -p ${syst_dir}${srv_name}/increment/
# Запускаем непосредственно бэкап с параметрами
/usr/bin/rsync -avz --progress --delete --password-file=/etc/rsyncd.scrt ${srv_user}@${srv_ip}::${srv_dir} ${syst_dir}${srv_name}/current/ --backup --backup-dir=${syst_dir}${srv_name}/increment/`date +%Y-%m-%d`/
# Чистим папки с инкрементными архивами старше 30-ти дней
/usr/bin/find ${syst_dir}${srv_name}/increment/ -maxdepth 1 -type d -mtime +30 -exec rm -rf {} \;
date
echo "Finish backup ${srv_name}"</pre>
<p>Делаем скрипт исполняемым:</p>
<pre># chmod 0744 /root/bin/backup-server1.sh</pre>
<p>Создаем файл с паролем для авторизации на сервере источнике:</p>
<pre># mcedit /etc/rsyncd.scrt</pre>
<pre>12345</pre>
<p>Делаем права на чтение только root, иначе rsync выдаст ошибку:<br>
<strong>ERROR: password file must not be other-accessible</strong>
<br>
Исправляем это:</p>
<pre># chmod 0600 /etc/rsyncd.scrt</pre>
<p>На этом все, теперь можно запускать скрипт и ожидать его выполнения. Если получите ошибку на клиенте:</p>
<pre>rsync: opendir "/." (in data) failed: Permission denied (13)</pre>
<p>и вот эту на сервере:</p>
<pre>SELinux is preventing rsync from getattr access on the file</pre>
<p>Проверьте настройки SELinux. Это он блокирует доступ к файлам. Нужно либо отключить selinux, либо настроить. В данном случае настройка простая:</p>
<pre># setsebool -P rsync_full_access on</pre>
<p>Осталось добавить скрипт в cron:</p>
<pre># mcedit /etc/crontab</pre>
<pre>30 23 * * * root /root/bin/backup-server1.sh</pre>
<p>Я обычно создаю несколько скриптов для каждого сервера отдельно. Потом объединяю их запуск в одном общем скрипте и уже его добавляю в cron. А потом по мере необходимости редактирую уже его, добавляю или удаляю сервера.</p>
<h2>
<span id="Kopirovanie_rsync_cerez_ssh">Копирование rsync через ssh</span>
</h2>
<p>Rsync может работать через ssh. Это избавляет от необходимости настраивать отдельно службу и авторизацию, но при этом будут использоваться системные учетные записи. У меня есть предположение, что производительность при подключении по ssh будет ниже, но я нигде не видел подтверждения этому.</p>
<p>Для того, чтобы скопировать файлы с помощью rsync по ssh нет необходимости запускать службу, настраивать конфиг, создавать файл с авторизацией. Можно просто запустить примерно такую команду на передачу файлов.</p>
<pre># /usr/bin/rsync -avz --progress --delete root@10.1.6.221:/data/mysql_dump /backup</pre>
<div class="box warning  ">
<div class="box-inner-block">
<i class="fa tie-shortcode-boxicon">
</i>
Будьте внимательны при использовании ключа&nbsp;--delete. Не перепутайте источник, откуда качаете файлы, с приемником, куда копируете. Если их перепутать и в качестве источника указать пустую папку, а в качестве приемника с файлами, файлы будут удалены моментально и без предупреждения.
</div>
</div>
<p>Если для подключения вы используете публичный ключ или нестандартный порт ssh, указать эти параметры можно следующим образом.</p>
<pre># /usr/bin/rsync -avz --progress --delete -e "ssh -p 1234 -i /root/.ssh/id_rsa.pub" root@10.1.6.221:/data/mysql_dump /backup</pre>
<h2>
<span id="Nastrojka_isklucenij">Настройка исключений</span>
</h2>
<p>Вы можете настроить исключение файлов или каталогов при копировании с помощью rsync. Делается это с помощью ключа --exclude или --exclude-from. Первый позволяет указать исключение непосредственно в команде на исполнение. Второй позволяет загружать список исключений из файла. Пример первого варианта:</p>
<pre># /usr/bin/rsync -avz --progress --delete <strong>--exclude='*.jpeg'</strong> root@10.1.6.221:/var/www/html /backup</pre>
<p>Вы скопируете директорию с сайтом, исключив из нее все картинки с расширением .jpeg. Таких исключений можно добавить сколько угодно в одной команде. Но удобнее их выносить в отдельный файл. Примерно так.</p>
<pre># /usr/bin/rsync -avz --progress --delete --exclude-from=exclude.lst root@10.1.6.221:/var/www/html /backup</pre>
<p>Содержимое файла <em>exclude.lst</em>.</p>
<pre>*/bitrix/managed_cache/MYSQL/*
*/bitrix/backup/*
*/bitrix/html_pages/site.ru/*
*/upload/resize_cache/*
*/bitrix/cache/*
*/log.txt
*/rating/logs/my_file.log</pre>
<p>Это пример исключений для bitrix сайта. Все эти команды и исключения можно комбинировать и использовать в скриптах на примере того, что я привел в самом начале.</p>
<h2>
<span id="Rotacia_logov_rsync">
<span style="color: #000000;">Ротация логов rsync</span>
</span>
</h2>
<p>Мы ранее указали в настройках службы rsyncd ведение лога в файл <em>/var/log/rsyncd.log</em>. Необходимо настроить ротацию этого лога, чтобы он не рос до бесконечности. На больших файловых серверах он очень быстро вырастет до сотен мегабайт и более.</p>
<p>Для этого создаем в папке&nbsp;<em>/etc/logrotate.d</em> файл с конфигурацией ротации:</p>
<pre># mcedit&nbsp;/etc/logrotate.d/rsyncd
/var/log/rsyncd.log {
size=500k
compress
rotate 4
missingok
notifempty
}</pre>
<p>С такими настройками ротация будет происходить каждый раз, когда файл лога превысит размер в 500 кб. Храниться будут 4 версии лог файла. Эти настройки вы можете сами поменять по своему усмотрению.</p>
<p>Когда используете ротацию по размеру файла, не забывайте проверять, что она у вас корректно работает. В разных дистрибутивах есть нюансы на этот счет. Я их отдельно рассматриваю в статье - <a href="https://serveradmin.ru/rotacziya-fajlov-po-razmeru-v-logrotate/" target="_blank" rel="noopener noreferrer">ротация файлов по размеру в logrotate</a>.</p>
<h2>
<span id="Primer_bekapa_windows_servera_s_pomosu_rsync">
<span style="color: #000000;">Пример бэкапа windows сервера с помощью rsync</span>
</span>
</h2>
<p>Еще один пример из моей практики. Допустим, у нас есть windows сервер с некоторой информацией, которую мы хотим так же бэкапить. Никаких проблем, это делается достаточно просто.</p>
<p>Создаем на windows сервере сетевую шару с информацией. Создаем пользователя и добавляем его в доступ к этой папке. Этого пользователя мы будем использовать для подключения виндовой шары к linux серверу.</p>
<p>Монтируем шару с информацией, которую будем бэкапить:</p>
<pre># mount -t cifs //192.168.0.16/docs /mnt/docs -o user=backup,password=12345,iocharset=utf8,codepage=cp866</pre>
<p>192.168.0.16 - адрес виндовой шары<br>
backup и 12345 - пользователь и пароль виндовой машины с доступом к шаре&nbsp;docs.</p>
<p>Все, теперь папку&nbsp;<em>/mnt/docs</em> можно использовать в качестве приемника в нашем скрипте бэкапа с rsync. Если папка примонтирована непосредственно к серверу с бэкапами, то нужно на нем самом настроить конфиг rsyncd на примере серверов источников, запустить на нем rsyncd и в скрипте в качестве ip адреса сервера указывать 127.0.0.1.</p>
<p>Я в таких случаях создаю несколько скриптов: на монтирование шары, бэкап и размонтирование, объединяю их в один и запускаю последовательно. В итоге получается, что подключаем диск, делаем бэкап и отключаем его.</p>
<p>Так же есть возможность установить на Windows Server rsync с помощью cygwin. Подобный функционал собран в готовом приложении - <a href="https://ru.wikipedia.org/wiki/CwRsync" target="_blank" rel="noopener noreferrer">
<strong>cwRsync server</strong>
</a>. Его настройка ничем принципиально не отличается от настройки linux версии. Нужно только внимательно следить за путями к директориям, примеры есть в конфигах.</p>
<div class="mot" style="background: rgb(230, 115, 112) !important; outline: rgb(255, 0, 0) solid !important;">
<div class="mot-inner-block">
Если у вас есть желание научиться строить и поддерживать высокодоступные и надежные системы, рекомендую познакомиться с <strong>онлайн-курсом «Administrator Linux. Professional»</strong> в OTUS. Вы научитесь делать профессиональный подбор конфигурации, управлять процессами, обеспечивать безопасность, выполнять развертывание, настройку и обслуживание сетей.
Проверьте себя на вступительном тесте и смотрите подробнее программи <a href="https://serveradmin.ru/slrekshfmtb" rel="noopener">ссылке</a>.
</div>
</div>
<h4 style="text-align: center;">
<span id="Pomogla_stata_Podpisyvajsa_na_telegram_kanal_avtora">Помогла статья? Подписывайся на <a href="https://serveradmin.ru/telegram-header" target="_blank" rel="noopener noreferrer">telegram канал</a> автора</span>
</h4>
Анонсы всех статей, плюс много другой полезной и интересной информации, которая не попадает на сайт.
<div class="dkpdf-button-container" style=" text-align:right ">
<a class="dkpdf-button" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/?pdf=984" target="_blank">
<span class="dkpdf-button-icon">
<i class="fa fa-file-pdf-o">
</i>
</span> Скачать pdf</a>
</div>
<!-- AI CONTENT END 1 -->
</div>
<!-- .entry /-->
<div class="clear">
</div>
</div>
<!-- .post-inner -->
<script type="application/ld+json">{"@context":"http:\/\/schema.org","@type":"NewsArticle","dateCreated":"2020-11-16T18:05:46+03:00","datePublished":"2020-11-16T18:05:46+03:00","dateModified":"2020-11-16T18:11:46+03:00","headline":"Rsync \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0430 \u0431\u044d\u043a\u0430\u043f\u0430 \u043d\u0430 CentOS \/ Debian \/ Ubuntu","name":"Rsync \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0430 \u0431\u044d\u043a\u0430\u043f\u0430 \u043d\u0430 CentOS \/ Debian \/ Ubuntu","keywords":"backup,centos,debian,rsync,ubuntu","url":"https:\/\/serveradmin.ru\/rsync-nastroyka-bekapa-na-centos-debian-ubuntu\/","description":"\u0421\u0443\u0449\u0435\u0441\u0442\u0432\u0443\u0435\u0442 \u043c\u043d\u043e\u0433\u043e \u0441\u043f\u043e\u0441\u043e\u0431\u043e\u0432 \u043e\u0440\u0433\u0430\u043d\u0438\u0437\u0430\u0446\u0438\u0438 backup \u043d\u0430 CentOS\/Debian\/Ubuntu \u0441\u0435\u0440\u0432\u0435\u0440\u0430\u0445 - \u0431\u0435\u0441\u043f\u043b\u0430\u0442\u043d\u044b\u0435 \u0443\u0442\u0438\u043b\u0438\u0442\u044b, \u0441\u0430\u043c\u043e\u043f\u0438\u0441\u043d\u044b\u0435 \u0441\u043a\u0440\u0438\u043f\u0442\u044b \u0441 \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u043d\u0438\u0435\u043c tar, \u0441\u0438\u0441\u0442\u0435\u043c\u0430 \u0431\u044d\u043a\u0430\u043f\u0430 bacula \u0438 \u043c\u043d\u043e\u0433\u043e \u0434\u0440\u0443\u0433\u043e\u0435. \u0412\u0441\u0435 \u044d\u0442\u043e \u0432 \u0442\u043e\u0439 \u0438\u043b\u0438 \u0438\u043d\u043e","copyrightYear":"2020","publisher":{"@id":"#Publisher","@type":"Organization","name":"Server Admin","logo":{"@type":"ImageObject","url":"https:\/\/serveradmin.ru\/wp-content\/uploads\/2022\/11\/logo-new1.png"},"sameAs":["https:\/\/www.youtube.com\/user\/zeroxzed\/","https:\/\/vk.com\/serv_adm"]},"sourceOrganization":{"@id":"#Publisher"},"copyrightHolder":{"@id":"#Publisher"},"mainEntityOfPage":{"@type":"WebPage","@id":"https:\/\/serveradmin.ru\/rsync-nastroyka-bekapa-na-centos-debian-ubuntu\/"},"author":{"@type":"Person","name":"Zerox","url":"https:\/\/serveradmin.ru\/author\/zerox\/"},"articleSection":"CentOS,Debian,Linux","articleBody":"\u0421\u0443\u0449\u0435\u0441\u0442\u0432\u0443\u0435\u0442 \u043c\u043d\u043e\u0433\u043e \u0441\u043f\u043e\u0441\u043e\u0431\u043e\u0432 \u043e\u0440\u0433\u0430\u043d\u0438\u0437\u0430\u0446\u0438\u0438 backup \u043d\u0430 CentOS\/Debian\/Ubuntu \u0441\u0435\u0440\u0432\u0435\u0440\u0430\u0445 - \u0431\u0435\u0441\u043f\u043b\u0430\u0442\u043d\u044b\u0435 \u0443\u0442\u0438\u043b\u0438\u0442\u044b, \u0441\u0430\u043c\u043e\u043f\u0438\u0441\u043d\u044b\u0435 \u0441\u043a\u0440\u0438\u043f\u0442\u044b \u0441 \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u043d\u0438\u0435\u043c tar, \u0441\u0438\u0441\u0442\u0435\u043c\u0430 \u0431\u044d\u043a\u0430\u043f\u0430 bacula \u0438 \u043c\u043d\u043e\u0433\u043e \u0434\u0440\u0443\u0433\u043e\u0435. \u0412\u0441\u0435 \u044d\u0442\u043e \u0432 \u0442\u043e\u0439 \u0438\u043b\u0438 \u0438\u043d\u043e\u0439 \u043c\u0435\u0440\u0435 \u044f \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u043b \u0438\u043b\u0438 \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u0443\u044e \u0432 \u0441\u0432\u043e\u0435\u0439 \u0440\u0430\u0431\u043e\u0442\u0435. \u0421\u0435\u0433\u043e\u0434\u043d\u044f \u044f \u0445\u043e\u0447\u0443 \u0441 \u0432\u0430\u043c\u0438 \u043f\u043e\u0434\u0435\u043b\u0438\u0442\u044c\u0441\u044f \u0441\u0432\u043e\u0438\u043c \u043c\u0435\u0442\u043e\u0434\u043e\u043c \u043e\u0440\u0433\u0430\u043d\u0438\u0437\u0430\u0446\u0438\u0438 \u043f\u0440\u043e\u0441\u0442\u043e\u0433\u043e, \u0443\u0434\u043e\u0431\u043d\u043e\u0433\u043e \u0438 \u0431\u044b\u0441\u0442\u0440\u043e\u0433\u043e \u0441\u043f\u043e\u0441\u043e\u0431\u0430 \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0438 \u0438\u043d\u043a\u0440\u0435\u043c\u0435\u043d\u0442\u043d\u043e\u0433\u043e backup \u0441 \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u043d\u0438\u0435\u043c \u043f\u043e\u043f\u0443\u043b\u044f\u0440\u043d\u043e\u0439 \u0443\u0442\u0438\u043b\u0438\u0442\u044b rsync \u043d\u0430 \u0441\u0435\u0440\u0432\u0435\u0440\u0430\u0445 \u043f\u043e\u0434 \u0443\u043f\u0440\u0430\u0432\u043b\u0435\u043d\u0438\u0435\u043c CentOS\/Debian\/Ubuntu. \u0421\u043f\u043e\u0441\u043e\u0431 \u043e\u0434\u0438\u043d\u0430\u043a\u043e\u0432\u043e \u0440\u0430\u0431\u043e\u0442\u0430\u0435\u0442 \u043d\u0430 \u044d\u0442\u0438\u0445 \u0441\u0438\u0441\u0442\u0435\u043c\u0430\u0445, \u043d\u0435\u0431\u043e\u043b\u044c\u0448\u0438\u0435 \u043e\u0442\u043b\u0438\u0447\u0438\u044f \u0442\u043e\u043b\u044c\u043a\u043e \u0432 \u0441\u0430\u043c\u043e\u0439 \u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0435 rsync, \u043e \u0447\u0435\u043c \u044f \u043e\u0442\u0434\u0435\u043b\u044c\u043d\u043e \u0443\u043f\u043e\u043c\u044f\u043d\u0443 \u0434\u043b\u044f \u043a\u0430\u0436\u0434\u043e\u0439 \u0441\u0438\u0441\u0442\u0435\u043c\u044b.\r\n\r\n\r\n\r\n\r\n\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430 rsync \u043d\u0430 CentOS 8\r\n\u0427\u0430\u0449\u0435 \u0432\u0441\u0435\u0433\u043e rsync \u0443\u0436\u0435 \u043f\u0440\u0438\u0441\u0443\u0442\u0441\u0442\u0432\u0443\u0435\u0442 \u0432 \u0431\u0430\u0437\u043e\u0432\u043e\u0439 \u0432\u0435\u0440\u0441\u0438\u0438 centos 8, \u043d\u043e \u0441\u043a\u043e\u0440\u0435\u0435 \u0432\u0441\u0435\u0433\u043e \u0431\u0435\u0437 \u0432\u0435\u0440\u0441\u0438\u0438, \u0440\u0430\u0431\u043e\u0442\u0430\u044e\u0449\u0435\u0439 \u0432 \u043a\u0430\u0447\u0435\u0441\u0442\u0432\u0435 \u0441\u043b\u0443\u0436\u0431\u044b. \u0422\u0430\u043a \u0447\u0442\u043e \u0443\u0441\u0442\u0430\u043d\u0430\u0432\u043b\u0438\u0432\u0430\u0435\u043c \u043e\u0431\u043e\u0438\u0445:\r\n# dnf install rsync rsync-daemon\r\n\r\n\r\n\u0415\u0441\u043b\u0438 \u0443 \u0432\u0430\u0441 \u0435\u0449\u0435 \u043d\u0435\u0442 \u043d\u0430\u0441\u0442\u0440\u043e\u0435\u043d\u043d\u043e\u0439 \u0441\u0438\u0441\u0442\u0435\u043c\u044b, \u0442\u043e \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u0443\u0439\u0442\u0435 \u043c\u043e\u0438 \u0441\u0442\u0430\u0442\u044c\u0438 \u043f\u043e \u0443\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0435 \u0438 \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0435 centos 8. \u0417\u0430\u043f\u0443\u0441\u043a\u0430\u0435\u043c rsyncd \u0438 \u0434\u043e\u0431\u0430\u0432\u043b\u044f\u0435\u043c \u0432 \u0430\u0432\u0442\u043e\u0437\u0430\u0433\u0440\u0443\u0437\u043a\u0443.\r\n# systemctl enable --now rsyncd\r\nCreated symlink \/etc\/systemd\/system\/multi-user.target.wants\/rsyncd.service \u2192 \/usr\/lib\/systemd\/system\/rsyncd.service.\r\n\u041f\u0440\u043e\u0432\u0435\u0440\u044f\u0435\u043c \u0430\u0432\u0442\u043e\u0437\u0430\u0433\u0440\u0443\u0437\u043a\u0443:\r\n# systemctl list-unit-files --type service | grep rsyncd\r\nrsyncd.service enabled\r\n\u041f\u0440\u043e\u0432\u0435\u0440\u044f\u0435\u043c, \u0441\u043b\u0443\u0448\u0430\u0435\u0442 \u043b\u0438 \u0441\u043b\u0443\u0436\u0431\u0430 \u0441\u0435\u0442\u0435\u0432\u043e\u0439 \u043f\u043e\u0440\u0442.\r\n# netstat -tulpn | grep rsync\r\ntcp        0      0 0.0.0.0:873             0.0.0.0:*               LISTEN      40814\/rsync         \r\ntcp6       0      0 :::873                  :::*                    LISTEN      40814\/rsync         \r\n\r\n\u0412\u0441\u0435 \u0432 \u043f\u043e\u0440\u044f\u0434\u043a\u0435, \u043c\u043e\u0436\u043d\u043e \u043f\u0440\u0438\u0441\u0442\u0443\u043f\u0430\u0442\u044c \u043a \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0435 rsync. \u0415\u0441\u043b\u0438 \u0432\u0430\u043c \u043d\u0435 \u043d\u0443\u0436\u0435\u043d ipv6, \u0442\u043e \u043c\u043e\u0436\u0435\u0442\u0435 \u0435\u0433\u043e \u043e\u0442\u043a\u043b\u044e\u0447\u0438\u0442\u044c.\r\n\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430 rsync \u043d\u0430 CentOS 7\r\n\u0421\u0442\u0430\u0432\u0438\u043c rsync:\r\n# yum install rsync\r\n\u0414\u043e\u0431\u0430\u0432\u043b\u044f\u0435\u043c \u0432 \u0430\u0432\u0442\u043e\u0437\u0430\u0433\u0440\u0443\u0437\u043a\u0443:\r\n#\u00a0systemctl enable rsyncd\r\n\r\nln -s '\/usr\/lib\/systemd\/system\/rsyncd.service' '\/etc\/systemd\/system\/multi-user.target.wants\/rsyncd.service'\r\n\u041f\u0440\u043e\u0432\u0435\u0440\u044f\u0435\u043c \u0430\u0432\u0442\u043e\u0437\u0430\u0433\u0440\u0443\u0437\u043a\u0443:\r\n# systemctl list-unit-files --type service | grep rsyncd\r\n\r\nrsyncd.service enabled\r\n\u0417\u0430\u043f\u0443\u0441\u043a\u0430\u0435\u043c rsync:\r\n# systemctl start rsyncd\r\n\u041f\u0440\u043e\u0432\u0435\u0440\u044f\u0435\u043c, \u043a\u0430\u043a \u0437\u0430\u043f\u0443\u0441\u0442\u0438\u043b\u0441\u044f:\r\n# netstat -tulpn | grep rsync\r\n\r\ntcp \u00a0 \u00a0 \u00a0 \u00a00 \u00a0 \u00a0 \u00a00 0.0.0.0:873 \u00a0 \u00a0 \u00a0 \u00a0 \u00a0 \u00a0 0.0.0.0:* \u00a0 \u00a0 \u00a0 \u00a0 \u00a0 \u00a0 \u00a0 LISTEN \u00a0 \u00a0 \u00a02782\/rsync\r\n\u0412\u0441\u0435 \u0432 \u043f\u043e\u0440\u044f\u0434\u043a\u0435, \u043c\u043e\u0436\u043d\u043e \u043f\u0440\u0438\u0441\u0442\u0443\u043f\u0430\u0442\u044c \u043a \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0435 rsync.\r\n\u0423\u0441\u0442\u0430\u043d\u043e\u0432\u043a\u0430 rsync \u043d\u0430 Debian\/Ubuntu\r\n\u0423\u0441\u0442\u0430\u043d\u0430\u0432\u043b\u0438\u0432\u0430\u0435\u043c rsync:\r\n# apt install rsync\r\n\u041f\u0440\u0430\u0432\u0438\u043c\u00a0\u043a\u043e\u043d\u0444\u0438\u0433:\r\n# mcedit \/etc\/default\/rsync\r\n\u041d\u0430\u0445\u043e\u0434\u0438\u043c \u0441\u0442\u0440\u043e\u043a\u0443 RSYNC_ENABLE=false\u00a0\u0438 \u043c\u0435\u043d\u044f\u0435\u043c \u043d\u0430 true:\r\nRSYNC_ENABLE=true\r\n\u0421\u043e\u0437\u0434\u0430\u0435\u043c \u043f\u0443\u0441\u0442\u043e\u0439 \u0444\u0430\u0439\u043b \u043a\u043e\u043d\u0444\u0438\u0433\u0443\u0440\u0430\u0446\u0438\u0438 \/etc\/rsyncd.conf, \u043e\u043d \u043d\u0443\u0436\u0435\u043d \u0434\u043b\u044f \u0437\u0430\u043f\u0443\u0441\u043a\u0430 \u0441\u043b\u0443\u0436\u0431\u044b. \u041f\u043e\u0437\u0436\u0435 \u043c\u044b \u0435\u0433\u043e \u0437\u0430\u043f\u043e\u043b\u043d\u0438\u043c \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0430\u043c\u0438.\r\n# touch \/etc\/rsyncd.conf\r\n\u0417\u0430\u043f\u0443\u0441\u043a\u0430\u0435\u043c rsync:\r\n# systemctl enable --now rsync\r\nSynchronizing state of rsync.service with SysV service script with \/lib\/systemd\/systemd-sysv-install.\r\nExecuting: \/lib\/systemd\/systemd-sysv-install enable rsync\r\n\u041f\u0440\u043e\u0432\u0435\u0440\u044f\u0435\u043c, \u0447\u0442\u043e \u0440\u0430\u0431\u043e\u0442\u0430\u0435\u0442:\r\n# netstat -tulnp | grep rsync\r\ntcp        0      0 0.0.0.0:873             0.0.0.0:*               LISTEN      2232\/rsync          \r\ntcp6       0      0 :::873                  :::*                    LISTEN      2232\/rsync          \r\n\r\n\u0412\u0441\u0435 \u0432 \u043f\u043e\u0440\u044f\u0434\u043a\u0435, \u043c\u043e\u0436\u043d\u043e \u043f\u0440\u0438\u0441\u0442\u0443\u043f\u0430\u0442\u044c \u043a \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0435 rsync.\r\n\u041d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0430 rsync\r\n\u0422\u0435\u043f\u0435\u0440\u044c \u043f\u0440\u0438\u0441\u0442\u0443\u043f\u0430\u0435\u043c \u043a \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0435. \u041b\u043e\u0433\u0438\u043a\u0430 \u043d\u0430\u0448\u0438\u0445 \u0431\u044d\u043a\u0430\u043f\u043e\u0432 \u0431\u0443\u0434\u0435\u0442 \u0441\u043b\u0435\u0434\u0443\u044e\u0449\u0430\u044f.\u00a0\u041f\u0440\u0438 \u043f\u0435\u0440\u0432\u043e\u043c \u0437\u0430\u043f\u0443\u0441\u043a\u0435 \u043c\u044b \u0434\u0435\u043b\u0430\u0435\u043c \u043f\u043e\u043b\u043d\u044b\u0439 \u0431\u044d\u043a\u0430\u043f \u0438\u043d\u0442\u0435\u0440\u0435\u0441\u0443\u044e\u0449\u0435\u0439 \u043d\u0430\u0441 \u0438\u043d\u0444\u043e\u0440\u043c\u0430\u0446\u0438\u0438 \u0432 \u043f\u0430\u043f\u043a\u0443 current. \u041f\u043e\u0442\u043e\u043c \u0440\u0430\u0437 \u0432 \u0441\u0443\u0442\u043a\u0438 \u043c\u044b \u0441\u0432\u0435\u0440\u044f\u0435\u043c \u0438\u043c\u0435\u044e\u0449\u0438\u0439\u0441\u044f \u0430\u0440\u0445\u0438\u0432 \u0441 \u0438\u0441\u0442\u043e\u0447\u043d\u0438\u043a\u043e\u043c \u0438 \u0434\u0435\u043b\u0430\u0435\u043c \u0435\u0433\u043e \u0432\u043d\u043e\u0432\u044c \u0430\u043a\u0442\u0443\u0430\u043b\u044c\u043d\u044b\u043c, \u043f\u0435\u0440\u0435\u0437\u0430\u043f\u0438\u0441\u044b\u0432\u0430\u044f \u0432\u0441\u0435 \u0438\u0437\u043c\u0435\u043d\u0438\u0432\u0448\u0438\u0435\u0441\u044f \u0444\u0430\u0439\u043b\u044b, \u043d\u043e \u043f\u0440\u0438 \u044d\u0442\u043e\u043c \u043d\u0435 \u0443\u0434\u0430\u043b\u044f\u0435\u043c \u0438\u0445, \u0430 \u0441\u043a\u043b\u0430\u0434\u044b\u0432\u0430\u0435\u043c \u0432 \u043f\u0430\u043f\u043a\u0443 increment, \u0433\u0434\u0435 \u043a\u0430\u0436\u0434\u044b\u0439 \u0434\u0435\u043d\u044c \u0441\u043e\u0437\u0434\u0430\u0435\u0442\u0441\u044f \u043f\u0430\u043f\u043a\u0430 \u0441 \u0438\u043c\u0435\u043d\u0435\u043c \u0432 \u0432\u0438\u0434\u0435 \u0434\u0430\u0442\u044b, \u0432 \u043a\u043e\u0442\u043e\u0440\u0443\u044e \u0441\u043a\u043b\u0430\u0434\u044b\u0432\u0430\u044e\u0442\u0441\u044f \u0432\u0441\u0435 \u0438\u0437\u043c\u0435\u043d\u0435\u043d\u043d\u044b\u0435 \u0444\u0430\u0439\u043b\u044b \u0437\u0430 \u0442\u0435\u043a\u0443\u0449\u0438\u0439 \u0434\u0435\u043d\u044c. \u0422\u0430\u043a\u0438\u043c \u043e\u0431\u0440\u0430\u0437\u043e\u043c, \u0443 \u043d\u0430\u0441 \u0432\u0441\u0435\u0433\u0434\u0430 \u0431\u0443\u0434\u0435\u0442 \u043f\u043e\u043b\u043d\u044b\u0439 \u0430\u0440\u0445\u0438\u0432, \u0430\u043a\u0442\u0443\u0430\u043b\u044c\u043d\u044b\u0439 \u043d\u0430 \u043c\u043e\u043c\u0435\u043d\u0442 \u043f\u043e\u0441\u043b\u0435\u0434\u043d\u0435\u0439 \u0441\u0438\u043d\u0445\u0440\u043e\u043d\u0438\u0437\u0430\u0446\u0438\u0438, \u043f\u043b\u044e\u0441 \u043d\u0430\u0431\u043e\u0440 \u043f\u0430\u043f\u043e\u043a \u0437\u0430 \u043a\u0430\u0436\u0434\u044b\u0439 \u0434\u0435\u043d\u044c \u0441 \u0438\u0437\u043c\u0435\u043d\u0438\u0432\u0448\u0438\u043c\u0438\u0441\u044f \u0432 \u044d\u0442\u043e\u0442 \u0434\u0435\u043d\u044c \u0444\u0430\u0439\u043b\u0430\u043c\u0438. \u0421\u043a\u043e\u043b\u044c\u043a\u043e \u0434\u043d\u0435\u0439 \u0445\u0440\u0430\u043d\u0438\u0442\u044c, \u043c\u043e\u0436\u043d\u043e \u0432\u044b\u0431\u0440\u0430\u0442\u044c \u043f\u043e \u043d\u0435\u043e\u0431\u0445\u043e\u0434\u0438\u043c\u043e\u0441\u0442\u0438.\r\n\r\n\u041f\u043e\u043b\u0443\u0447\u0430\u0435\u0442\u0441\u044f \u0443 \u043d\u0430\u0441 \u0442\u0430\u043a\u0430\u044f \u043a\u0430\u0440\u0442\u0438\u043d\u043a\u0430:\r\n\r\n\r\n\r\n\u041f\u0440\u0438 \u044d\u0442\u043e\u043c \u043f\u043e\u0434\u043a\u043b\u044e\u0447\u0435\u043d\u0438\u0435 \u0438 \u0440\u0430\u0431\u043e\u0442\u0430 rsync \u0431\u0443\u0434\u0435\u0442 \u043f\u0440\u043e\u0445\u043e\u0434\u0438\u0442\u044c \u043f\u043e \u0441\u0432\u043e\u0435\u043c\u0443 \u043e\u0442\u0434\u0435\u043b\u044c\u043d\u043e\u043c\u0443 \u043f\u043e\u0440\u0442\u0443 tcp 873. \u041d\u0435 \u0437\u0430\u0431\u0443\u0434\u044c\u0442\u0435 \u043d\u0430\u0441\u0442\u0440\u043e\u0438\u0442\u044c iptables \u0438 \u043e\u0442\u043a\u0440\u044b\u0442\u044c \u044d\u0442\u043e\u0442 \u043f\u043e\u0440\u0442. \u041f\u0440\u0438\u0441\u0442\u0443\u043f\u0430\u0435\u043c \u043a \u0440\u0435\u0430\u043b\u0438\u0437\u0430\u0446\u0438\u0438. \u0412 \u043f\u0435\u0440\u0432\u0443\u044e \u043e\u0447\u0435\u0440\u0435\u0434\u044c \u043d\u0430\u0441\u0442\u0440\u0430\u0438\u0432\u0430\u0435\u043c rsync \u043d\u0430 \u0441\u0435\u0440\u0432\u0435\u0440\u0430\u0445 \u0438\u0441\u0442\u043e\u0447\u043d\u0438\u043a\u0430\u0445 \u0438\u043d\u0444\u043e\u0440\u043c\u0430\u0446\u0438\u0438, \u0441 \u043a\u043e\u0442\u043e\u0440\u044b\u0445 \u043c\u044b \u0431\u0443\u0434\u0435\u043c \u0437\u0430\u0431\u0438\u0440\u0430\u0442\u044c \u0434\u0430\u043d\u043d\u044b\u0435 \u0434\u043b\u044f backup.\r\n\r\n\u0421\u043e\u0437\u0434\u0430\u0435\u043c \u0444\u0430\u0439\u043b \u043a\u043e\u043d\u0444\u0438\u0433\u0443\u0440\u0430\u0446\u0438\u0438 rsync:\r\n# mcedit \/etc\/rsyncd.conf\r\npid file = \/var\/run\/rsyncd.pid\r\nlog file = \/var\/log\/rsyncd.log\r\ntransfer logging = true\r\nmunge symlinks = yes\r\n\r\n# \u043f\u0430\u043f\u043a\u0430 \u0438\u0441\u0442\u043e\u0447\u043d\u0438\u043a \u0434\u043b\u044f \u0431\u044d\u043a\u0430\u043f\u0430\r\n[data]\r\npath = \/data\r\nuid = root\r\nread only = yes\r\nlist = yes\r\ncomment = Data backup Dir\r\nauth users = backup\r\nsecrets file = \/etc\/rsyncd.scrt\r\n\u0421\u043e\u0437\u0434\u0430\u0435\u043c \u0444\u0430\u0439\u043b \u0441 \u0443\u0447\u0435\u0442\u043d\u044b\u043c\u0438 \u0434\u0430\u043d\u043d\u044b\u043c\u0438 \u0434\u043b\u044f \u043f\u043e\u0434\u043a\u043b\u044e\u0447\u0435\u043d\u0438\u044f:\r\n# mcedit \/etc\/rsyncd.scrt\r\nbackup:12345\r\n\u0433\u0434\u0435 backup - \u0438\u043c\u044f \u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u0435\u043b\u044f, 12345 - \u043f\u0430\u0440\u043e\u043b\u044c.\r\n\u0414\u0435\u043b\u0430\u0435\u043c \u043f\u0440\u0430\u0432\u0430 \u043d\u0430 \u0447\u0442\u0435\u043d\u0438\u0435 \u0442\u043e\u043b\u044c\u043a\u043e root, \u0438\u043d\u0430\u0447\u0435 rsync \u043d\u0435 \u0437\u0430\u043f\u0443\u0441\u0442\u0438\u0442\u0441\u044f:\r\n# chmod 0600 \/etc\/rsyncd.scrt\r\n\u041f\u043e\u0441\u043b\u0435 \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0438 \u043f\u0435\u0440\u0435\u0437\u0430\u043f\u0443\u0441\u043a\u0430\u0435\u043c rsync. \u041d\u0430 Centos:\r\n# systemctl restart rsyncd\r\n\u041d\u0430 Debian\/Ubuntu:\r\n# systemctl restart rsync\r\n\u0422\u0435\u043f\u0435\u0440\u044c \u0438\u0434\u0435\u043c \u043d\u0430 \u0441\u0435\u0440\u0432\u0435\u0440 \u043f\u0440\u0438\u0435\u043c\u043d\u0438\u043a, \u0432 \u043a\u043e\u0442\u043e\u0440\u043e\u043c \u0431\u0443\u0434\u0443\u0442 \u0445\u0440\u0430\u043d\u0438\u0442\u044c\u0441\u044f \u0430\u0440\u0445\u0438\u0432\u043d\u044b\u0435 \u043a\u043e\u043f\u0438\u0438 \u0441 \u0441\u0435\u0440\u0432\u0435\u0440\u043e\u0432 \u0438\u0441\u0442\u043e\u0447\u043d\u0438\u043a\u043e\u0432. \u0422\u0430\u043c \u0441\u043e\u0437\u0434\u0430\u0435\u043c \u0441\u043a\u0440\u0438\u043f\u0442 \u0438\u043d\u043a\u0440\u0435\u043c\u0435\u043d\u0442\u043d\u043e\u0433\u043e \u0431\u044d\u043a\u0430\u043f\u0430 c \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u043d\u0438\u0435\u043c rsync:\r\n# mcedit \/root\/bin\/backup-server1.sh\r\n#!\/bin\/bash\r\ndate\r\n# \u041f\u0430\u043f\u043a\u0430, \u043a\u0443\u0434\u0430 \u0431\u0443\u0434\u0435\u043c \u0441\u043a\u043b\u0430\u0434\u044b\u0432\u0430\u0442\u044c \u0430\u0440\u0445\u0438\u0432\u044b\r\nsyst_dir=\/backup\/\r\n# \u0418\u043c\u044f \u0441\u0435\u0440\u0432\u0435\u0440\u0430, \u043a\u043e\u0442\u043e\u0440\u044b\u0439 \u0430\u0440\u0445\u0438\u0432\u0438\u0440\u0443\u0435\u043c\r\nsrv_name=server1\r\n# \u0410\u0434\u0440\u0435\u0441 \u0441\u0435\u0440\u0432\u0435\u0440\u0430, \u043a\u043e\u0442\u043e\u0440\u044b\u0439 \u0430\u0440\u0445\u0438\u0432\u0438\u0440\u0443\u0435\u043c\r\nsrv_ip=10.10.1.55\r\n# \u041f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u0435\u043b\u044c rsync \u043d\u0430 \u0441\u0435\u0440\u0432\u0435\u0440\u0435, \u043a\u043e\u0442\u043e\u0440\u044b\u0439 \u0430\u0440\u0445\u0438\u0432\u0438\u0440\u0443\u0435\u043c\r\nsrv_user=backup\r\n# \u0420\u0435\u0441\u0443\u0440\u0441 \u043d\u0430 \u0441\u0435\u0440\u0432\u0435\u0440\u0435 \u0434\u043b\u044f \u0431\u044d\u043a\u0430\u043f\u0430\r\nsrv_dir=data\r\necho \"Start backup ${srv_name}\"\r\n# \u0421\u043e\u0437\u0434\u0430\u0435\u043c \u043f\u0430\u043f\u043a\u0443 \u0434\u043b\u044f \u0438\u043d\u043a\u0440\u0435\u043c\u0435\u043d\u0442\u043d\u044b\u0445 \u0431\u044d\u043a\u0430\u043f\u043e\u0432\r\nmkdir -p ${syst_dir}${srv_name}\/increment\/\r\n# \u0417\u0430\u043f\u0443\u0441\u043a\u0430\u0435\u043c \u043d\u0435\u043f\u043e\u0441\u0440\u0435\u0434\u0441\u0442\u0432\u0435\u043d\u043d\u043e \u0431\u044d\u043a\u0430\u043f \u0441 \u043f\u0430\u0440\u0430\u043c\u0435\u0442\u0440\u0430\u043c\u0438\r\n\/usr\/bin\/rsync -avz --progress --delete --password-file=\/etc\/rsyncd.scrt ${srv_user}@${srv_ip}::${srv_dir} ${syst_dir}${srv_name}\/current\/ --backup --backup-dir=${syst_dir}${srv_name}\/increment\/`date +%Y-%m-%d`\/\r\n# \u0427\u0438\u0441\u0442\u0438\u043c \u043f\u0430\u043f\u043a\u0438 \u0441 \u0438\u043d\u043a\u0440\u0435\u043c\u0435\u043d\u0442\u043d\u044b\u043c\u0438 \u0430\u0440\u0445\u0438\u0432\u0430\u043c\u0438 \u0441\u0442\u0430\u0440\u0448\u0435 30-\u0442\u0438 \u0434\u043d\u0435\u0439\r\n\/usr\/bin\/find ${syst_dir}${srv_name}\/increment\/ -maxdepth 1 -type d -mtime +30 -exec rm -rf {} \\;\r\ndate\r\necho \"Finish backup ${srv_name}\"\r\n\u0414\u0435\u043b\u0430\u0435\u043c \u0441\u043a\u0440\u0438\u043f\u0442 \u0438\u0441\u043f\u043e\u043b\u043d\u044f\u0435\u043c\u044b\u043c:\r\n# chmod 0744 \/root\/bin\/backup-server1.sh\r\n\u0421\u043e\u0437\u0434\u0430\u0435\u043c \u0444\u0430\u0439\u043b \u0441 \u043f\u0430\u0440\u043e\u043b\u0435\u043c \u0434\u043b\u044f \u0430\u0432\u0442\u043e\u0440\u0438\u0437\u0430\u0446\u0438\u0438 \u043d\u0430 \u0441\u0435\u0440\u0432\u0435\u0440\u0435 \u0438\u0441\u0442\u043e\u0447\u043d\u0438\u043a\u0435:\r\n# mcedit \/etc\/rsyncd.scrt\r\n12345\r\n\u0414\u0435\u043b\u0430\u0435\u043c \u043f\u0440\u0430\u0432\u0430 \u043d\u0430 \u0447\u0442\u0435\u043d\u0438\u0435 \u0442\u043e\u043b\u044c\u043a\u043e root, \u0438\u043d\u0430\u0447\u0435 rsync \u0432\u044b\u0434\u0430\u0441\u0442 \u043e\u0448\u0438\u0431\u043a\u0443:\r\nERROR: password file must not be other-accessible\r\n\u0418\u0441\u043f\u0440\u0430\u0432\u043b\u044f\u0435\u043c \u044d\u0442\u043e:\r\n# chmod 0600 \/etc\/rsyncd.scrt\r\n\u041d\u0430 \u044d\u0442\u043e\u043c \u0432\u0441\u0435, \u0442\u0435\u043f\u0435\u0440\u044c \u043c\u043e\u0436\u043d\u043e \u0437\u0430\u043f\u0443\u0441\u043a\u0430\u0442\u044c \u0441\u043a\u0440\u0438\u043f\u0442 \u0438 \u043e\u0436\u0438\u0434\u0430\u0442\u044c \u0435\u0433\u043e \u0432\u044b\u043f\u043e\u043b\u043d\u0435\u043d\u0438\u044f. \u0415\u0441\u043b\u0438 \u043f\u043e\u043b\u0443\u0447\u0438\u0442\u0435 \u043e\u0448\u0438\u0431\u043a\u0443 \u043d\u0430 \u043a\u043b\u0438\u0435\u043d\u0442\u0435:\r\nrsync: opendir \"\/.\" (in data) failed: Permission denied (13)\r\n\u0438 \u0432\u043e\u0442 \u044d\u0442\u0443 \u043d\u0430 \u0441\u0435\u0440\u0432\u0435\u0440\u0435:\r\nSELinux is preventing rsync from getattr access on the file\r\n\u041f\u0440\u043e\u0432\u0435\u0440\u044c\u0442\u0435 \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0438 SELinux. \u042d\u0442\u043e \u043e\u043d \u0431\u043b\u043e\u043a\u0438\u0440\u0443\u0435\u0442 \u0434\u043e\u0441\u0442\u0443\u043f \u043a \u0444\u0430\u0439\u043b\u0430\u043c. \u041d\u0443\u0436\u043d\u043e \u043b\u0438\u0431\u043e \u043e\u0442\u043a\u043b\u044e\u0447\u0438\u0442\u044c selinux, \u043b\u0438\u0431\u043e \u043d\u0430\u0441\u0442\u0440\u043e\u0438\u0442\u044c. \u0412 \u0434\u0430\u043d\u043d\u043e\u043c \u0441\u043b\u0443\u0447\u0430\u0435 \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0430 \u043f\u0440\u043e\u0441\u0442\u0430\u044f:\r\n# setsebool -P rsync_full_access on\r\n\u041e\u0441\u0442\u0430\u043b\u043e\u0441\u044c \u0434\u043e\u0431\u0430\u0432\u0438\u0442\u044c \u0441\u043a\u0440\u0438\u043f\u0442 \u0432 cron:\r\n# mcedit \/etc\/crontab\r\n30 23 * * * root \/root\/bin\/backup-server1.sh\r\n\u042f \u043e\u0431\u044b\u0447\u043d\u043e \u0441\u043e\u0437\u0434\u0430\u044e \u043d\u0435\u0441\u043a\u043e\u043b\u044c\u043a\u043e \u0441\u043a\u0440\u0438\u043f\u0442\u043e\u0432 \u0434\u043b\u044f \u043a\u0430\u0436\u0434\u043e\u0433\u043e \u0441\u0435\u0440\u0432\u0435\u0440\u0430 \u043e\u0442\u0434\u0435\u043b\u044c\u043d\u043e. \u041f\u043e\u0442\u043e\u043c \u043e\u0431\u044a\u0435\u0434\u0438\u043d\u044f\u044e \u0438\u0445 \u0437\u0430\u043f\u0443\u0441\u043a \u0432 \u043e\u0434\u043d\u043e\u043c \u043e\u0431\u0449\u0435\u043c \u0441\u043a\u0440\u0438\u043f\u0442\u0435 \u0438 \u0443\u0436\u0435 \u0435\u0433\u043e \u0434\u043e\u0431\u0430\u0432\u043b\u044f\u044e \u0432 cron. \u0410 \u043f\u043e\u0442\u043e\u043c \u043f\u043e \u043c\u0435\u0440\u0435 \u043d\u0435\u043e\u0431\u0445\u043e\u0434\u0438\u043c\u043e\u0441\u0442\u0438 \u0440\u0435\u0434\u0430\u043a\u0442\u0438\u0440\u0443\u044e \u0443\u0436\u0435 \u0435\u0433\u043e, \u0434\u043e\u0431\u0430\u0432\u043b\u044f\u044e \u0438\u043b\u0438 \u0443\u0434\u0430\u043b\u044f\u044e \u0441\u0435\u0440\u0432\u0435\u0440\u0430.\r\n\u041a\u043e\u043f\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0435 rsync \u0447\u0435\u0440\u0435\u0437 ssh\r\nRsync \u043c\u043e\u0436\u0435\u0442 \u0440\u0430\u0431\u043e\u0442\u0430\u0442\u044c \u0447\u0435\u0440\u0435\u0437 ssh. \u042d\u0442\u043e \u0438\u0437\u0431\u0430\u0432\u043b\u044f\u0435\u0442 \u043e\u0442 \u043d\u0435\u043e\u0431\u0445\u043e\u0434\u0438\u043c\u043e\u0441\u0442\u0438 \u043d\u0430\u0441\u0442\u0440\u0430\u0438\u0432\u0430\u0442\u044c \u043e\u0442\u0434\u0435\u043b\u044c\u043d\u043e \u0441\u043b\u0443\u0436\u0431\u0443 \u0438 \u0430\u0432\u0442\u043e\u0440\u0438\u0437\u0430\u0446\u0438\u044e, \u043d\u043e \u043f\u0440\u0438 \u044d\u0442\u043e\u043c \u0431\u0443\u0434\u0443\u0442 \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u044c\u0441\u044f \u0441\u0438\u0441\u0442\u0435\u043c\u043d\u044b\u0435 \u0443\u0447\u0435\u0442\u043d\u044b\u0435 \u0437\u0430\u043f\u0438\u0441\u0438. \u0423 \u043c\u0435\u043d\u044f \u0435\u0441\u0442\u044c \u043f\u0440\u0435\u0434\u043f\u043e\u043b\u043e\u0436\u0435\u043d\u0438\u0435, \u0447\u0442\u043e \u043f\u0440\u043e\u0438\u0437\u0432\u043e\u0434\u0438\u0442\u0435\u043b\u044c\u043d\u043e\u0441\u0442\u044c \u043f\u0440\u0438 \u043f\u043e\u0434\u043a\u043b\u044e\u0447\u0435\u043d\u0438\u0438 \u043f\u043e ssh \u0431\u0443\u0434\u0435\u0442 \u043d\u0438\u0436\u0435, \u043d\u043e \u044f \u043d\u0438\u0433\u0434\u0435 \u043d\u0435 \u0432\u0438\u0434\u0435\u043b \u043f\u043e\u0434\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u0438\u044f \u044d\u0442\u043e\u043c\u0443.\r\n\r\n\u0414\u043b\u044f \u0442\u043e\u0433\u043e, \u0447\u0442\u043e\u0431\u044b \u0441\u043a\u043e\u043f\u0438\u0440\u043e\u0432\u0430\u0442\u044c \u0444\u0430\u0439\u043b\u044b \u0441 \u043f\u043e\u043c\u043e\u0449\u044c\u044e rsync \u043f\u043e ssh \u043d\u0435\u0442 \u043d\u0435\u043e\u0431\u0445\u043e\u0434\u0438\u043c\u043e\u0441\u0442\u0438 \u0437\u0430\u043f\u0443\u0441\u043a\u0430\u0442\u044c \u0441\u043b\u0443\u0436\u0431\u0443, \u043d\u0430\u0441\u0442\u0440\u0430\u0438\u0432\u0430\u0442\u044c \u043a\u043e\u043d\u0444\u0438\u0433, \u0441\u043e\u0437\u0434\u0430\u0432\u0430\u0442\u044c \u0444\u0430\u0439\u043b \u0441 \u0430\u0432\u0442\u043e\u0440\u0438\u0437\u0430\u0446\u0438\u0435\u0439. \u041c\u043e\u0436\u043d\u043e \u043f\u0440\u043e\u0441\u0442\u043e \u0437\u0430\u043f\u0443\u0441\u0442\u0438\u0442\u044c \u043f\u0440\u0438\u043c\u0435\u0440\u043d\u043e \u0442\u0430\u043a\u0443\u044e \u043a\u043e\u043c\u0430\u043d\u0434\u0443 \u043d\u0430 \u043f\u0435\u0440\u0435\u0434\u0430\u0447\u0443 \u0444\u0430\u0439\u043b\u043e\u0432.\r\n# \/usr\/bin\/rsync -avz --progress --delete root@10.1.6.221:\/data\/mysql_dump \/backup\r\n\r\n\r\n\u0415\u0441\u043b\u0438 \u0434\u043b\u044f \u043f\u043e\u0434\u043a\u043b\u044e\u0447\u0435\u043d\u0438\u044f \u0432\u044b \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u0443\u0435\u0442\u0435 \u043f\u0443\u0431\u043b\u0438\u0447\u043d\u044b\u0439 \u043a\u043b\u044e\u0447 \u0438\u043b\u0438 \u043d\u0435\u0441\u0442\u0430\u043d\u0434\u0430\u0440\u0442\u043d\u044b\u0439 \u043f\u043e\u0440\u0442 ssh, \u0443\u043a\u0430\u0437\u0430\u0442\u044c \u044d\u0442\u0438 \u043f\u0430\u0440\u0430\u043c\u0435\u0442\u0440\u044b \u043c\u043e\u0436\u043d\u043e \u0441\u043b\u0435\u0434\u0443\u044e\u0449\u0438\u043c \u043e\u0431\u0440\u0430\u0437\u043e\u043c.\r\n# \/usr\/bin\/rsync -avz --progress --delete -e \"ssh -p 1234 -i \/root\/.ssh\/id_rsa.pub\" root@10.1.6.221:\/data\/mysql_dump \/backup\r\n\u041d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0430 \u0438\u0441\u043a\u043b\u044e\u0447\u0435\u043d\u0438\u0439\r\n\u0412\u044b \u043c\u043e\u0436\u0435\u0442\u0435 \u043d\u0430\u0441\u0442\u0440\u043e\u0438\u0442\u044c \u0438\u0441\u043a\u043b\u044e\u0447\u0435\u043d\u0438\u0435 \u0444\u0430\u0439\u043b\u043e\u0432 \u0438\u043b\u0438 \u043a\u0430\u0442\u0430\u043b\u043e\u0433\u043e\u0432 \u043f\u0440\u0438 \u043a\u043e\u043f\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0438 \u0441 \u043f\u043e\u043c\u043e\u0449\u044c\u044e rsync. \u0414\u0435\u043b\u0430\u0435\u0442\u0441\u044f \u044d\u0442\u043e \u0441 \u043f\u043e\u043c\u043e\u0449\u044c\u044e \u043a\u043b\u044e\u0447\u0430 --exclude \u0438\u043b\u0438 --exclude-from. \u041f\u0435\u0440\u0432\u044b\u0439 \u043f\u043e\u0437\u0432\u043e\u043b\u044f\u0435\u0442 \u0443\u043a\u0430\u0437\u0430\u0442\u044c \u0438\u0441\u043a\u043b\u044e\u0447\u0435\u043d\u0438\u0435 \u043d\u0435\u043f\u043e\u0441\u0440\u0435\u0434\u0441\u0442\u0432\u0435\u043d\u043d\u043e \u0432 \u043a\u043e\u043c\u0430\u043d\u0434\u0435 \u043d\u0430 \u0438\u0441\u043f\u043e\u043b\u043d\u0435\u043d\u0438\u0435. \u0412\u0442\u043e\u0440\u043e\u0439 \u043f\u043e\u0437\u0432\u043e\u043b\u044f\u0435\u0442 \u0437\u0430\u0433\u0440\u0443\u0436\u0430\u0442\u044c \u0441\u043f\u0438\u0441\u043e\u043a \u0438\u0441\u043a\u043b\u044e\u0447\u0435\u043d\u0438\u0439 \u0438\u0437 \u0444\u0430\u0439\u043b\u0430. \u041f\u0440\u0438\u043c\u0435\u0440 \u043f\u0435\u0440\u0432\u043e\u0433\u043e \u0432\u0430\u0440\u0438\u0430\u043d\u0442\u0430:\r\n# \/usr\/bin\/rsync -avz --progress --delete --exclude='*.jpeg' root@10.1.6.221:\/var\/www\/html \/backup\r\n\u0412\u044b \u0441\u043a\u043e\u043f\u0438\u0440\u0443\u0435\u0442\u0435 \u0434\u0438\u0440\u0435\u043a\u0442\u043e\u0440\u0438\u044e \u0441 \u0441\u0430\u0439\u0442\u043e\u043c, \u0438\u0441\u043a\u043b\u044e\u0447\u0438\u0432 \u0438\u0437 \u043d\u0435\u0435 \u0432\u0441\u0435 \u043a\u0430\u0440\u0442\u0438\u043d\u043a\u0438 \u0441 \u0440\u0430\u0441\u0448\u0438\u0440\u0435\u043d\u0438\u0435\u043c .jpeg. \u0422\u0430\u043a\u0438\u0445 \u0438\u0441\u043a\u043b\u044e\u0447\u0435\u043d\u0438\u0439 \u043c\u043e\u0436\u043d\u043e \u0434\u043e\u0431\u0430\u0432\u0438\u0442\u044c \u0441\u043a\u043e\u043b\u044c\u043a\u043e \u0443\u0433\u043e\u0434\u043d\u043e \u0432 \u043e\u0434\u043d\u043e\u0439 \u043a\u043e\u043c\u0430\u043d\u0434\u0435. \u041d\u043e \u0443\u0434\u043e\u0431\u043d\u0435\u0435 \u0438\u0445 \u0432\u044b\u043d\u043e\u0441\u0438\u0442\u044c \u0432 \u043e\u0442\u0434\u0435\u043b\u044c\u043d\u044b\u0439 \u0444\u0430\u0439\u043b. \u041f\u0440\u0438\u043c\u0435\u0440\u043d\u043e \u0442\u0430\u043a.\r\n# \/usr\/bin\/rsync -avz --progress --delete --exclude-from=exclude.lst root@10.1.6.221:\/var\/www\/html \/backup\r\n\u0421\u043e\u0434\u0435\u0440\u0436\u0438\u043c\u043e\u0435 \u0444\u0430\u0439\u043b\u0430 exclude.lst.\r\n*\/bitrix\/managed_cache\/MYSQL\/*\r\n*\/bitrix\/backup\/*\r\n*\/bitrix\/html_pages\/site.ru\/*\r\n*\/upload\/resize_cache\/*\r\n*\/bitrix\/cache\/*\r\n*\/log.txt\r\n*\/rating\/logs\/my_file.log\r\n\u042d\u0442\u043e \u043f\u0440\u0438\u043c\u0435\u0440 \u0438\u0441\u043a\u043b\u044e\u0447\u0435\u043d\u0438\u0439 \u0434\u043b\u044f bitrix \u0441\u0430\u0439\u0442\u0430. \u0412\u0441\u0435 \u044d\u0442\u0438 \u043a\u043e\u043c\u0430\u043d\u0434\u044b \u0438 \u0438\u0441\u043a\u043b\u044e\u0447\u0435\u043d\u0438\u044f \u043c\u043e\u0436\u043d\u043e \u043a\u043e\u043c\u0431\u0438\u043d\u0438\u0440\u043e\u0432\u0430\u0442\u044c \u0438 \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u044c \u0432 \u0441\u043a\u0440\u0438\u043f\u0442\u0430\u0445 \u043d\u0430 \u043f\u0440\u0438\u043c\u0435\u0440\u0435 \u0442\u043e\u0433\u043e, \u0447\u0442\u043e \u044f \u043f\u0440\u0438\u0432\u0435\u043b \u0432 \u0441\u0430\u043c\u043e\u043c \u043d\u0430\u0447\u0430\u043b\u0435.\r\n\u0420\u043e\u0442\u0430\u0446\u0438\u044f \u043b\u043e\u0433\u043e\u0432 rsync\r\n\u041c\u044b \u0440\u0430\u043d\u0435\u0435 \u0443\u043a\u0430\u0437\u0430\u043b\u0438 \u0432 \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0430\u0445 \u0441\u043b\u0443\u0436\u0431\u044b rsyncd \u0432\u0435\u0434\u0435\u043d\u0438\u0435 \u043b\u043e\u0433\u0430 \u0432 \u0444\u0430\u0439\u043b \/var\/log\/rsyncd.log. \u041d\u0435\u043e\u0431\u0445\u043e\u0434\u0438\u043c\u043e \u043d\u0430\u0441\u0442\u0440\u043e\u0438\u0442\u044c \u0440\u043e\u0442\u0430\u0446\u0438\u044e \u044d\u0442\u043e\u0433\u043e \u043b\u043e\u0433\u0430, \u0447\u0442\u043e\u0431\u044b \u043e\u043d \u043d\u0435 \u0440\u043e\u0441 \u0434\u043e \u0431\u0435\u0441\u043a\u043e\u043d\u0435\u0447\u043d\u043e\u0441\u0442\u0438. \u041d\u0430 \u0431\u043e\u043b\u044c\u0448\u0438\u0445 \u0444\u0430\u0439\u043b\u043e\u0432\u044b\u0445 \u0441\u0435\u0440\u0432\u0435\u0440\u0430\u0445 \u043e\u043d \u043e\u0447\u0435\u043d\u044c \u0431\u044b\u0441\u0442\u0440\u043e \u0432\u044b\u0440\u0430\u0441\u0442\u0435\u0442 \u0434\u043e \u0441\u043e\u0442\u0435\u043d \u043c\u0435\u0433\u0430\u0431\u0430\u0439\u0442 \u0438 \u0431\u043e\u043b\u0435\u0435.\r\n\r\n\u0414\u043b\u044f \u044d\u0442\u043e\u0433\u043e \u0441\u043e\u0437\u0434\u0430\u0435\u043c \u0432 \u043f\u0430\u043f\u043a\u0435\u00a0\/etc\/logrotate.d \u0444\u0430\u0439\u043b \u0441 \u043a\u043e\u043d\u0444\u0438\u0433\u0443\u0440\u0430\u0446\u0438\u0435\u0439 \u0440\u043e\u0442\u0430\u0446\u0438\u0438:\r\n# mcedit\u00a0\/etc\/logrotate.d\/rsyncd\r\n\r\n\/var\/log\/rsyncd.log {\r\nsize=500k\r\ncompress\r\nrotate 4\r\nmissingok\r\nnotifempty\r\n}\r\n\u0421 \u0442\u0430\u043a\u0438\u043c\u0438 \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0430\u043c\u0438 \u0440\u043e\u0442\u0430\u0446\u0438\u044f \u0431\u0443\u0434\u0435\u0442 \u043f\u0440\u043e\u0438\u0441\u0445\u043e\u0434\u0438\u0442\u044c \u043a\u0430\u0436\u0434\u044b\u0439 \u0440\u0430\u0437, \u043a\u043e\u0433\u0434\u0430 \u0444\u0430\u0439\u043b \u043b\u043e\u0433\u0430 \u043f\u0440\u0435\u0432\u044b\u0441\u0438\u0442 \u0440\u0430\u0437\u043c\u0435\u0440 \u0432 500 \u043a\u0431. \u0425\u0440\u0430\u043d\u0438\u0442\u044c\u0441\u044f \u0431\u0443\u0434\u0443\u0442 4 \u0432\u0435\u0440\u0441\u0438\u0438 \u043b\u043e\u0433 \u0444\u0430\u0439\u043b\u0430. \u042d\u0442\u0438 \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0438 \u0432\u044b \u043c\u043e\u0436\u0435\u0442\u0435 \u0441\u0430\u043c\u0438 \u043f\u043e\u043c\u0435\u043d\u044f\u0442\u044c \u043f\u043e \u0441\u0432\u043e\u0435\u043c\u0443 \u0443\u0441\u043c\u043e\u0442\u0440\u0435\u043d\u0438\u044e.\r\n\r\n\u041a\u043e\u0433\u0434\u0430 \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u0443\u0435\u0442\u0435 \u0440\u043e\u0442\u0430\u0446\u0438\u044e \u043f\u043e \u0440\u0430\u0437\u043c\u0435\u0440\u0443 \u0444\u0430\u0439\u043b\u0430, \u043d\u0435 \u0437\u0430\u0431\u044b\u0432\u0430\u0439\u0442\u0435 \u043f\u0440\u043e\u0432\u0435\u0440\u044f\u0442\u044c, \u0447\u0442\u043e \u043e\u043d\u0430 \u0443 \u0432\u0430\u0441 \u043a\u043e\u0440\u0440\u0435\u043a\u0442\u043d\u043e \u0440\u0430\u0431\u043e\u0442\u0430\u0435\u0442. \u0412 \u0440\u0430\u0437\u043d\u044b\u0445 \u0434\u0438\u0441\u0442\u0440\u0438\u0431\u0443\u0442\u0438\u0432\u0430\u0445 \u0435\u0441\u0442\u044c \u043d\u044e\u0430\u043d\u0441\u044b \u043d\u0430 \u044d\u0442\u043e\u0442 \u0441\u0447\u0435\u0442. \u042f \u0438\u0445 \u043e\u0442\u0434\u0435\u043b\u044c\u043d\u043e \u0440\u0430\u0441\u0441\u043c\u0430\u0442\u0440\u0438\u0432\u0430\u044e \u0432 \u0441\u0442\u0430\u0442\u044c\u0435 - \u0440\u043e\u0442\u0430\u0446\u0438\u044f \u0444\u0430\u0439\u043b\u043e\u0432 \u043f\u043e \u0440\u0430\u0437\u043c\u0435\u0440\u0443 \u0432 logrotate.\r\n\u041f\u0440\u0438\u043c\u0435\u0440 \u0431\u044d\u043a\u0430\u043f\u0430 windows \u0441\u0435\u0440\u0432\u0435\u0440\u0430 \u0441 \u043f\u043e\u043c\u043e\u0449\u044c\u044e rsync\r\n\u0415\u0449\u0435 \u043e\u0434\u0438\u043d \u043f\u0440\u0438\u043c\u0435\u0440 \u0438\u0437 \u043c\u043e\u0435\u0439 \u043f\u0440\u0430\u043a\u0442\u0438\u043a\u0438. \u0414\u043e\u043f\u0443\u0441\u0442\u0438\u043c, \u0443 \u043d\u0430\u0441 \u0435\u0441\u0442\u044c windows \u0441\u0435\u0440\u0432\u0435\u0440 \u0441 \u043d\u0435\u043a\u043e\u0442\u043e\u0440\u043e\u0439 \u0438\u043d\u0444\u043e\u0440\u043c\u0430\u0446\u0438\u0435\u0439, \u043a\u043e\u0442\u043e\u0440\u0443\u044e \u043c\u044b \u0445\u043e\u0442\u0438\u043c \u0442\u0430\u043a \u0436\u0435 \u0431\u044d\u043a\u0430\u043f\u0438\u0442\u044c. \u041d\u0438\u043a\u0430\u043a\u0438\u0445 \u043f\u0440\u043e\u0431\u043b\u0435\u043c, \u044d\u0442\u043e \u0434\u0435\u043b\u0430\u0435\u0442\u0441\u044f \u0434\u043e\u0441\u0442\u0430\u0442\u043e\u0447\u043d\u043e \u043f\u0440\u043e\u0441\u0442\u043e.\r\n\r\n\u0421\u043e\u0437\u0434\u0430\u0435\u043c \u043d\u0430 windows \u0441\u0435\u0440\u0432\u0435\u0440\u0435 \u0441\u0435\u0442\u0435\u0432\u0443\u044e \u0448\u0430\u0440\u0443 \u0441 \u0438\u043d\u0444\u043e\u0440\u043c\u0430\u0446\u0438\u0435\u0439. \u0421\u043e\u0437\u0434\u0430\u0435\u043c \u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u0435\u043b\u044f \u0438 \u0434\u043e\u0431\u0430\u0432\u043b\u044f\u0435\u043c \u0435\u0433\u043e \u0432 \u0434\u043e\u0441\u0442\u0443\u043f \u043a \u044d\u0442\u043e\u0439 \u043f\u0430\u043f\u043a\u0435. \u042d\u0442\u043e\u0433\u043e \u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u0435\u043b\u044f \u043c\u044b \u0431\u0443\u0434\u0435\u043c \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u044c \u0434\u043b\u044f \u043f\u043e\u0434\u043a\u043b\u044e\u0447\u0435\u043d\u0438\u044f \u0432\u0438\u043d\u0434\u043e\u0432\u043e\u0439 \u0448\u0430\u0440\u044b \u043a linux \u0441\u0435\u0440\u0432\u0435\u0440\u0443.\r\n\r\n\u041c\u043e\u043d\u0442\u0438\u0440\u0443\u0435\u043c \u0448\u0430\u0440\u0443 \u0441 \u0438\u043d\u0444\u043e\u0440\u043c\u0430\u0446\u0438\u0435\u0439, \u043a\u043e\u0442\u043e\u0440\u0443\u044e \u0431\u0443\u0434\u0435\u043c \u0431\u044d\u043a\u0430\u043f\u0438\u0442\u044c:\r\n# mount -t cifs \/\/192.168.0.16\/docs \/mnt\/docs -o user=backup,password=12345,iocharset=utf8,codepage=cp866\r\n192.168.0.16 - \u0430\u0434\u0440\u0435\u0441 \u0432\u0438\u043d\u0434\u043e\u0432\u043e\u0439 \u0448\u0430\u0440\u044b\r\nbackup \u0438 12345 - \u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u0435\u043b\u044c \u0438 \u043f\u0430\u0440\u043e\u043b\u044c \u0432\u0438\u043d\u0434\u043e\u0432\u043e\u0439 \u043c\u0430\u0448\u0438\u043d\u044b \u0441 \u0434\u043e\u0441\u0442\u0443\u043f\u043e\u043c \u043a \u0448\u0430\u0440\u0435\u00a0docs.\r\n\r\n\u0412\u0441\u0435, \u0442\u0435\u043f\u0435\u0440\u044c \u043f\u0430\u043f\u043a\u0443\u00a0\/mnt\/docs \u043c\u043e\u0436\u043d\u043e \u0438\u0441\u043f\u043e\u043b\u044c\u0437\u043e\u0432\u0430\u0442\u044c \u0432 \u043a\u0430\u0447\u0435\u0441\u0442\u0432\u0435 \u043f\u0440\u0438\u0435\u043c\u043d\u0438\u043a\u0430 \u0432 \u043d\u0430\u0448\u0435\u043c \u0441\u043a\u0440\u0438\u043f\u0442\u0435 \u0431\u044d\u043a\u0430\u043f\u0430 \u0441 rsync. \u0415\u0441\u043b\u0438 \u043f\u0430\u043f\u043a\u0430 \u043f\u0440\u0438\u043c\u043e\u043d\u0442\u0438\u0440\u043e\u0432\u0430\u043d\u0430 \u043d\u0435\u043f\u043e\u0441\u0440\u0435\u0434\u0441\u0442\u0432\u0435\u043d\u043d\u043e \u043a \u0441\u0435\u0440\u0432\u0435\u0440\u0443 \u0441 \u0431\u044d\u043a\u0430\u043f\u0430\u043c\u0438, \u0442\u043e \u043d\u0443\u0436\u043d\u043e \u043d\u0430 \u043d\u0435\u043c \u0441\u0430\u043c\u043e\u043c \u043d\u0430\u0441\u0442\u0440\u043e\u0438\u0442\u044c \u043a\u043e\u043d\u0444\u0438\u0433 rsyncd \u043d\u0430 \u043f\u0440\u0438\u043c\u0435\u0440\u0435 \u0441\u0435\u0440\u0432\u0435\u0440\u043e\u0432 \u0438\u0441\u0442\u043e\u0447\u043d\u0438\u043a\u043e\u0432, \u0437\u0430\u043f\u0443\u0441\u0442\u0438\u0442\u044c \u043d\u0430 \u043d\u0435\u043c rsyncd \u0438 \u0432 \u0441\u043a\u0440\u0438\u043f\u0442\u0435 \u0432 \u043a\u0430\u0447\u0435\u0441\u0442\u0432\u0435 ip \u0430\u0434\u0440\u0435\u0441\u0430 \u0441\u0435\u0440\u0432\u0435\u0440\u0430 \u0443\u043a\u0430\u0437\u044b\u0432\u0430\u0442\u044c 127.0.0.1.\r\n\r\n\u042f \u0432 \u0442\u0430\u043a\u0438\u0445 \u0441\u043b\u0443\u0447\u0430\u044f\u0445 \u0441\u043e\u0437\u0434\u0430\u044e \u043d\u0435\u0441\u043a\u043e\u043b\u044c\u043a\u043e \u0441\u043a\u0440\u0438\u043f\u0442\u043e\u0432: \u043d\u0430 \u043c\u043e\u043d\u0442\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0435 \u0448\u0430\u0440\u044b, \u0431\u044d\u043a\u0430\u043f \u0438 \u0440\u0430\u0437\u043c\u043e\u043d\u0442\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0435, \u043e\u0431\u044a\u0435\u0434\u0438\u043d\u044f\u044e \u0438\u0445 \u0432 \u043e\u0434\u0438\u043d \u0438 \u0437\u0430\u043f\u0443\u0441\u043a\u0430\u044e \u043f\u043e\u0441\u043b\u0435\u0434\u043e\u0432\u0430\u0442\u0435\u043b\u044c\u043d\u043e. \u0412 \u0438\u0442\u043e\u0433\u0435 \u043f\u043e\u043b\u0443\u0447\u0430\u0435\u0442\u0441\u044f, \u0447\u0442\u043e \u043f\u043e\u0434\u043a\u043b\u044e\u0447\u0430\u0435\u043c \u0434\u0438\u0441\u043a, \u0434\u0435\u043b\u0430\u0435\u043c \u0431\u044d\u043a\u0430\u043f \u0438 \u043e\u0442\u043a\u043b\u044e\u0447\u0430\u0435\u043c \u0435\u0433\u043e.\r\n\r\n\u0422\u0430\u043a \u0436\u0435 \u0435\u0441\u0442\u044c \u0432\u043e\u0437\u043c\u043e\u0436\u043d\u043e\u0441\u0442\u044c \u0443\u0441\u0442\u0430\u043d\u043e\u0432\u0438\u0442\u044c \u043d\u0430 Windows Server rsync \u0441 \u043f\u043e\u043c\u043e\u0449\u044c\u044e cygwin. \u041f\u043e\u0434\u043e\u0431\u043d\u044b\u0439 \u0444\u0443\u043d\u043a\u0446\u0438\u043e\u043d\u0430\u043b \u0441\u043e\u0431\u0440\u0430\u043d \u0432 \u0433\u043e\u0442\u043e\u0432\u043e\u043c \u043f\u0440\u0438\u043b\u043e\u0436\u0435\u043d\u0438\u0438 - cwRsync server. \u0415\u0433\u043e \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0430 \u043d\u0438\u0447\u0435\u043c \u043f\u0440\u0438\u043d\u0446\u0438\u043f\u0438\u0430\u043b\u044c\u043d\u043e \u043d\u0435 \u043e\u0442\u043b\u0438\u0447\u0430\u0435\u0442\u0441\u044f \u043e\u0442 \u043d\u0430\u0441\u0442\u0440\u043e\u0439\u043a\u0438 linux \u0432\u0435\u0440\u0441\u0438\u0438. \u041d\u0443\u0436\u043d\u043e \u0442\u043e\u043b\u044c\u043a\u043e \u0432\u043d\u0438\u043c\u0430\u0442\u0435\u043b\u044c\u043d\u043e \u0441\u043b\u0435\u0434\u0438\u0442\u044c \u0437\u0430 \u043f\u0443\u0442\u044f\u043c\u0438 \u043a \u0434\u0438\u0440\u0435\u043a\u0442\u043e\u0440\u0438\u044f\u043c, \u043f\u0440\u0438\u043c\u0435\u0440\u044b \u0435\u0441\u0442\u044c \u0432 \u043a\u043e\u043d\u0444\u0438\u0433\u0430\u0445.\r\n\r\n","image":{"@type":"ImageObject","url":"https:\/\/serveradmin.ru\/wp-content\/uploads\/2015\/05\/logo-rsync-1.jpg","width":696,"height":330}}</script>
</article>
<!-- .post-listing -->
<p class="post-tag">Tags <a href="https://serveradmin.ru/tag/backup/" rel="tag">backup</a> <a href="https://serveradmin.ru/tag/centos/" rel="tag">centos</a> <a href="https://serveradmin.ru/tag/debian/" rel="tag">debian</a> <a href="https://serveradmin.ru/tag/rsync/" rel="tag">rsync</a> <a href="https://serveradmin.ru/tag/ubuntu/" rel="tag">ubuntu</a>
</p>
<div class="elan2 elan2-post">		
<div class="ca-ca ca-ca-default ca-ca-52">
<a href="https://serveradmin.ru/devsecops-pic" rel="noopener">
<img class="aligncenter" src="https://serveradmin.ru/wp-content/uploads/2023/01/devsecops_04.jpg" alt="" width="640" height="200">
</a>
</div>
</div>
<section id="author-box">
<div class="block-head">
<h3>Автор Zerox </h3>
<div class="stripe-line">
</div>
</div>
<div class="post-listing">
<div class="author-bio">
<div class="author-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-90 photo " height="90" width="90">	</div>
<!-- #author-avatar -->
<div class="author-description">
Владимир, системный администратор, автор сайта.
Люблю настраивать сервера, изучать что-то новое, делиться знаниями, писать интересные и полезные статьи.
Открыт к диалогу и сотрудничеству. Если вам интересно узнать обо мне побольше, то можете послушать интервью. Запись на моем канале - https://t.me/srv_admin/425 или на сайте в контактах.		</div>
<!-- #author-description -->
<div class="author-social flat-social">
																					</div>
<div class="clear">
</div>
</div>
</div>
</section>
<!-- #author-box -->
<div class="post-navigation">
<div class="post-previous">
<a href="https://serveradmin.ru/perenos-i-obnovlenie-onlyoffice/" rel="prev">
<span>Предыдущая</span> Перенос и обновление Onlyoffice</a>
</div>
<div class="post-next">
<a href="https://serveradmin.ru/nastrojka-ssl-tls-sertifikatov-lets-encrypt-v-postfix-i-dovecot/" rel="next">
<span>Следующая</span> Настройка SSL/TLS сертификатов Let's Encrypt в postfix и dovecot</a>
</div>
</div>
<!-- .post-navigation -->
<div id="comments">
<div id="comments-box">
<div class="block-head">
<h3 id="comments-title">142 комментария </h3>
<div class="stripe-line">
</div>
</div>
<div class="post-listing">
<ol class="commentlist">	<li id="comment-19981">
<div class="comment even thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Анна</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-19981">	03.08.2022 в 16:06</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Здравствуйте Владимир, огромное спасибо за ваш труд. Извините, возможно за глупый вопрос, в unix системах не слишком сильна.<br>
Подскажите пожалуйста, как корректно удалять папки в директории "increment", опираясь не на время их создания, а на количество?<br>
Допустим как вариант, что бы всегда 3-ри последних оставались. В том плане, что бы не попасть в ситуацию, когда копии перестанут делаться, в силу любых вероятно банальных причин, а скрипт продолжит по расписанию работать. Как итог директория "increment", через 30 дней, в данном случае, окажется пустой.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-19981" data-commentid="19981" data-postid="984" data-belowelement="comment-19981" data-respondelement="respond" data-replyto="Комментарий к записи Анна" aria-label="Комментарий к записи Анна">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-19630">
<div class="comment byuser comment-author-xancss odd alt thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">xancss</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-19630">	08.05.2022 в 15:37</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Добрый день!<br>
В # Ресурс на сервере для бэкапа srv_dir можно указать несколько папок, если да, то как это правильно сделать?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-19630" data-commentid="19630" data-postid="984" data-belowelement="comment-19630" data-respondelement="respond" data-replyto="Комментарий к записи xancss" aria-label="Комментарий к записи xancss">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-19635">
<div class="comment byuser comment-author-zerox bypostauthor even depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-19635">	08.05.2022 в 23:51</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Нужно bash скрипт сделать с циклом и в нём проходить по очереди по всем ресурсам. Примерно так:</p>
<pre>srv_dir=("1c" "documents" "scans" "1c-backup" "personal-32")
for i in "${srv_dir[@]}";
do
/usr/bin/rsync -avz --progress --delete --password-file=/etc/rsyncd.scrt ${srv_user}@${srv_ip}::${i} ${syst_dir}${srv_name}/current/ --backup --backup-dir=${syst_dir}${srv_name}/increment/`date +%Y-%m-%d`/
done</pre>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-19635" data-commentid="19635" data-postid="984" data-belowelement="comment-19635" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-19638">
<div class="comment odd alt depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Аноним</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-19638">	09.05.2022 в 13:27</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Спасибо, получилось!<br>
С праздником!</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-19638" data-commentid="19638" data-postid="984" data-belowelement="comment-19638" data-respondelement="respond" data-replyto="Комментарий к записи Аноним" aria-label="Комментарий к записи Аноним">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-20209">
<div class="comment even depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Ser</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-20209">	25.10.2022 в 10:32</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>а если эти каталоги имеют, например, пробела?<br>
srv_dir=("1 c" "doc u  m ents" "s c ans" "1c - backup" "pe rsonal-32")</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-20209" data-commentid="20209" data-postid="984" data-belowelement="comment-20209" data-respondelement="respond" data-replyto="Комментарий к записи Ser" aria-label="Комментарий к записи Ser">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-20210">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-4 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-20210">	25.10.2022 в 13:24</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Не знаю, что с этим делать, не проверял. В скрипте идёт перебор не каталогов, а ресурсов rsync на сервере, которые вы сами указываете. Просто не ставьте там пробелы, и всё.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-20210" data-commentid="20210" data-postid="984" data-belowelement="comment-20210" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-19070">
<div class="comment even thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Alex</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-19070">	31.01.2022 в 12:54</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Доброго дня, интересная статья, хочу применить на практике для бэкапа шлюза на Fedora.<br>
Вопрос. Корректно ли rsync запускать на работающем сервере?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-19070" data-commentid="19070" data-postid="984" data-belowelement="comment-19070" data-respondelement="respond" data-replyto="Комментарий к записи Alex" aria-label="Комментарий к записи Alex">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-19071">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-19071">	31.01.2022 в 13:20</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Да, никаких проблем не будет. Я всегда на работающих серверах запускаю.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-19071" data-commentid="19071" data-postid="984" data-belowelement="comment-19071" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-17284">
<div class="comment even thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Andrey</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-17284">	30.04.2021 в 18:31</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Привет! А не проще подключать по sshfs ресурс с сервера хранения и локально все на него бекапить rsync_ом? Подключать проще всего по ключу. Я лично так и делаю. меньше гимора, все настраиваешь на одном клиенте. Правда у меня на клиентах редко что меняется и нет проблемы сколько времени длится процесс. Но в случае если исходные данные быстро меняются этот вариант все равно не особо прокатит.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-17284" data-commentid="17284" data-postid="984" data-belowelement="comment-17284" data-respondelement="respond" data-replyto="Комментарий к записи Andrey" aria-label="Комментарий к записи Andrey">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-17285">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-17285">	30.04.2021 в 18:55</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>В целом, так можно делать. Это просто будет медленнее. В каких-то случаях разница незаметна, но если файлов десятки и сотни тысяч, то разницу видно. Через настройку rsync сервера и прямого доступа к нему, достигается максимальное быстродействие в синхронизации.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-17285" data-commentid="17285" data-postid="984" data-belowelement="comment-17285" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-17151">
<div class="comment even thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Антон</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-17151">	13.04.2021 в 16:51</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Добрый день. А автор еще читает? Вопрос следующий - есть проксмокс на котором крутятся виртуалки, некоторые надо бекапить на отдельный сервер, при выполнении скрипта, по логике настроенном на ip нужной виртуалки, ошибка рсинк, в принципе логично предположить в таком случае, что настроить рсинк надо на этой виртуалке, но, можно ли как то выборочные виртуалки с самого сервера с проксмокс копировать, не лазия в них? За ранее спасибо.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-17151" data-commentid="17151" data-postid="984" data-belowelement="comment-17151" data-respondelement="respond" data-replyto="Комментарий к записи Антон" aria-label="Комментарий к записи Антон">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-17157">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-17157">	13.04.2021 в 20:32</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Виртуалки не надо бэкапить rsync, либо хотя бы выключать их. Для proxmox есть хорошее решение для бэкапов - <a href="https://pbs.proxmox.com/" rel="nofollow ugc">https://pbs.proxmox.com/</a>
</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-17157" data-commentid="17157" data-postid="984" data-belowelement="comment-17157" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-17160">
<div class="comment even depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Антон</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-17160">	14.04.2021 в 13:07</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>В данном случае, как я понимаю, надо монтировать другой сервер на машину с виртуалками, за идею спасибо, но по ходу будем тыкаться в каждую нужную. Спасибо за статью, полезная, лайк однозначно!</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-17160" data-commentid="17160" data-postid="984" data-belowelement="comment-17160" data-respondelement="respond" data-replyto="Комментарий к записи Антон" aria-label="Комментарий к записи Антон">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-17165">
<div class="comment odd alt depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Антон</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-17165">	15.04.2021 в 17:43</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>@ERROR: auth failed on module data<br>
rsync error: error starting client-server protocol (code 5) at main.c(1675) [Receiver=3.1.3]<br>
Thu 15 Apr 17:16:48 MSK 2021<br>
Finish backup slack<br>
Проделываю все по инструкции, почему такое выскакивает? рсинк на обеех машинах работает, фаерволов нет....</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-17165" data-commentid="17165" data-postid="984" data-belowelement="comment-17165" data-respondelement="respond" data-replyto="Комментарий к записи Антон" aria-label="Комментарий к записи Антон">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-17166">
<div class="comment byuser comment-author-zerox bypostauthor even depth-4 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-17166">	15.04.2021 в 18:01</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Ошибка явно говорит, что проблемы с аутентификацией. Надо в эту сторону смотреть.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-17166" data-commentid="17166" data-postid="984" data-belowelement="comment-17166" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-16989">
<div class="comment odd alt thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Arhon</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16989">	22.03.2021 в 10:08</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Добрый день. Возможно кто подскажет, чем kexit делать бэкап mysql базы забикса,  rsync или mysqldump ? база весит около 20G</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16989" data-commentid="16989" data-postid="984" data-belowelement="comment-16989" data-respondelement="respond" data-replyto="Комментарий к записи Arhon" aria-label="Комментарий к записи Arhon">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-16990">
<div class="comment byuser comment-author-zerox bypostauthor even depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16990">	22.03.2021 в 10:27</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Rsync не подходит для бэкапа базы. Надо обязательно дамп сначала делать, а потом его переносить с помощью rsync. Либо использовать специализированные средства для бэкапа баз, например Percona XtraBackup - <a href="https://serveradmin.ru/polnyj-i-inkrementnyj-backup-mysql/" rel="nofollow ugc">https://serveradmin.ru/polnyj-i-inkrementnyj-backup-mysql/</a>
</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16990" data-commentid="16990" data-postid="984" data-belowelement="comment-16990" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-16764">
<div class="comment odd alt thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Александр</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16764">	27.02.2021 в 16:28</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>У меня при очистке инкрементных с параметром -mindepth 1 удаляет всю папку increment, если в ней находятся папки старше 30 дней. Работает так, как задумывалось (удаление инкрементных старше 30 дней), с параметрами -mindepth 1 -maxdepth 2.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16764" data-commentid="16764" data-postid="984" data-belowelement="comment-16764" data-respondelement="respond" data-replyto="Комментарий к записи Александр" aria-label="Комментарий к записи Александр">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-16624">
<div class="comment even thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Дмитрий</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16624">	16.02.2021 в 11:46</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Приветствую. Хочется поблагодарить за статьи, которые я уже неоднократно использовал.<br>
Сейчас столкнулся с проблемой: нужно настроить резервное копирование раз в месяц "полный бейкап", ежедневно инкрементный бейкап (только изменения и каждый день в отдельный архив). Пример: 1 число месяца в 1:00 полный архив, 2, 3, 4, итд инкрементные архивы (в следующем месяце опять полный и на основании его инкрементные).</p>
<p>Backup делается на перемонтированную папку с помощью rsync. Сейчас я делаю просто полный бейкап с помощью (пример: rsync -zvra /var/www/site /backup/) Но не могу найти как настроить согласно задачи :(</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16624" data-commentid="16624" data-postid="984" data-belowelement="comment-16624" data-respondelement="respond" data-replyto="Комментарий к записи Дмитрий" aria-label="Комментарий к записи Дмитрий">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-16629">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16629">	16.02.2021 в 13:12</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Это надо какой-то софт найти, где инкрементные бэкапы автоматизированы. Например, rdiff-backup или duplicity. Будет проще, чем реализовывать в rsync.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16629" data-commentid="16629" data-postid="984" data-belowelement="comment-16629" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-16594">
<div class="comment even thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Влад</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16594">	11.02.2021 в 20:40</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Я тоже хочу поблагодарить за статью. Добавил уже в закладки с 10-к страниц вашего сайта :) Я на линуксе всего недели 3, для меня все в новинку. У меня есть вопрос. Я заказал VPS centos 7, мне сделали первоначальную настройку. Он рабочий. Я проверил, на нем уже установлен rsync  version 3.1.2. Я боюсь что-нибудь настраивать, чтобы случайно не "сломать" vps, я ищу возможность сделать полный backup сервера с возможность восстановить его, в случае чего.</p>
<p>Уточните, пожалуйста, Rsync подходит для такой задачи? :)<br>
Я уже читал вашу статью про Veeam Agent for Linux (<a href="https://serveradmin.ru/backup-i-perenos-linux-servera/" rel="nofollow ugc">https://serveradmin.ru/backup-i-perenos-linux-servera/</a>) и не знаю точно, что мне поможет.<br>
Мне нужно скопировать весь сервер со всеми настройками, процессами и т.д. на свой ноутбук (Lubuntu), а если я что-то сломаю, вернуть все обратно на VPS.<br>
Хочется разобраться самостоятельно, без того, чтобы обратиться за помощью в тех поддержку, и они все настроили сами. Мне бы только научиться восстанавливать сломанную систему, а дальше обучение пойдет быстрее, надеюсь :)</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16594" data-commentid="16594" data-postid="984" data-belowelement="comment-16594" data-respondelement="respond" data-replyto="Комментарий к записи Влад" aria-label="Комментарий к записи Влад">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-16595">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16595">	11.02.2021 в 21:06</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Собственно, а чем Veeam Agent for Linux не устроил?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16595" data-commentid="16595" data-postid="984" data-belowelement="comment-16595" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-16596">
<div class="comment even depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Влад</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16596">	11.02.2021 в 21:46</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Veeam Agent for Linux оказалась первой статьей, с которой я начал поиск информации про бэкап. Прочитал про некоторые нюансы (из статьи про Veeam Agent) бесплатной версии и, может, засомневался + испугали некоторые непонятные для меня вещи, например (положить его куда-нибудь по smb или nfs..., KeyDisk). А потом часто стали попадаться статьи про rsync, да еще с подробной инструкцией. Вот и подумал, что нашел то, что искал :)<br>
Но, если Veeam Agent for Linux - более подходящий вариант для копирования и восстановления всей системы и загрузки на мой пк, тогда я еще больше поразбираюсь в этом направлении.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16596" data-commentid="16596" data-postid="984" data-belowelement="comment-16596" data-respondelement="respond" data-replyto="Комментарий к записи Влад" aria-label="Комментарий к записи Влад">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-15557">
<div class="comment odd alt thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">
<a href="https://lintop.blogspot.com/" rel="external nofollow ugc" class="url">zool</a>
</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-15557">	19.11.2020 в 08:05</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Инкремент в бэкап сервер по urbackup делается, а вот зеркалируется на резервный сервер по ночам такой строчкой:<br>
rsync -A -p -v -a -z -P /mnt/driveA/abc/ root@fileserver2:/mnt/md0/fileserver/abc/ --log-file=/var/log/rsync/rsync-abc.log</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-15557" data-commentid="15557" data-postid="984" data-belowelement="comment-15557" data-respondelement="respond" data-replyto="Комментарий к записи zool" aria-label="Комментарий к записи zool">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-15508">
<div class="comment even thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Сергей</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-15508">	16.11.2020 в 22:55</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Спасибо в очередной раз!!!!</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-15508" data-commentid="15508" data-postid="984" data-belowelement="comment-15508" data-respondelement="respond" data-replyto="Комментарий к записи Сергей" aria-label="Комментарий к записи Сергей">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-15324">
<div class="comment odd alt thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Дмитрий</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-15324">	04.11.2020 в 19:47</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Добрый день, подскажите как можно при помощи этого скрипта забэкапить сервер локально? Т.е архивы хранить локально</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-15324" data-commentid="15324" data-postid="984" data-belowelement="comment-15324" data-respondelement="respond" data-replyto="Комментарий к записи Дмитрий" aria-label="Комментарий к записи Дмитрий">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-15327">
<div class="comment byuser comment-author-zerox bypostauthor even depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-15327">	04.11.2020 в 19:52</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Примерно так:</p>
<pre>/usr/bin/rsync -av --delete /var/www/html /mnt/backup --backup --backup-dir=/mnt/increment/`date +%Y-%m-%d`/</pre>
<p>То есть просто в источнике (/var/www/html) и приемнике (/mnt/backup) указываете локальные папки.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-15327" data-commentid="15327" data-postid="984" data-belowelement="comment-15327" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-15330">
<div class="comment odd alt depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Дмитрий</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-15330">	04.11.2020 в 20:02</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Мне не нужен удаленный сервер, просто что бы он сам себя на себя бэкапил</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-15330" data-commentid="15330" data-postid="984" data-belowelement="comment-15330" data-respondelement="respond" data-replyto="Комментарий к записи Дмитрий" aria-label="Комментарий к записи Дмитрий">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-15331">
<div class="comment byuser comment-author-zerox bypostauthor even depth-4 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-15331">	04.11.2020 в 20:37</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Так я и показал, как он бэкапит в рамках одного сервера. Директории /var/www/html и /mnt/backup находятся на одном сервере.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-15331" data-commentid="15331" data-postid="984" data-belowelement="comment-15331" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-15332">
<div class="comment odd alt depth-5 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Дмитрий</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-15332">	04.11.2020 в 20:50</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Т. е  если  у меня папка для архива /backup</p>
<p>Для чего вторая папка /mnt/backup ?</p>
<p> вот моя строчка в конф</p>
<p>/usr/bin/rsync -av --delete /backup /mnt/backup --backup --backup-dir=/mnt/increment/`date +%Y-%m-%d`/</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-15332" data-commentid="15332" data-postid="984" data-belowelement="comment-15332" data-respondelement="respond" data-replyto="Комментарий к записи Дмитрий" aria-label="Комментарий к записи Дмитрий">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-15335">
<div class="comment byuser comment-author-zerox bypostauthor even depth-6 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-15335">	05.11.2020 в 09:29</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Я же не знаю, какая у вас папка. /mnt/backup это просто пример. Если у вас бэкапы лежат в /backup, то указывайте ее.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-15335" data-commentid="15335" data-postid="984" data-belowelement="comment-15335" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-14538">
<div class="comment odd alt thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Максим</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14538">	20.08.2020 в 13:38</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Добрый день!</p>
<p>Всё достаточно понятно, со всем можно разобраться. Но я вот столкнулся со следующей проблемой:<br>
Есть шара на винде, которую удачно копирую через rsync, но никак не получается сохранить доменные права на файлы.<br>
Была простая идея забрать их getfacl перед каждым бэкапом в отдельный файл, но если смотерть права на примонтированную через cifs шару, то он показывает только root:root, а не виндовые права. Подскажите, где я ошибаюсь?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14538" data-commentid="14538" data-postid="984" data-belowelement="comment-14538" data-respondelement="respond" data-replyto="Комментарий к записи Максим" aria-label="Комментарий к записи Максим">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-14539">
<div class="comment byuser comment-author-zerox bypostauthor even depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14539">	20.08.2020 в 13:58</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>А как вы виндовую шару копируете? Монтируете ее к линукс севреру? Он то ничего про доменных пользователей не знает, поэтому и права не сохраняются. Я не прорабатывал этот вопрос, но на скорую руку решал его просто. Сделал скрипт на powershell и права доступа с файлов собирал им в отдельный файл. При необходимости из него они накатывались обратно.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14539" data-commentid="14539" data-postid="984" data-belowelement="comment-14539" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-14542">
<div class="comment odd alt depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Максим</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14542">	20.08.2020 в 14:05</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Да, такая идея тоже была. Но не  хочется сам процесс раскладывать на 2 сервера. У этого есть свои причины.<br>
Я думал если завести через winbind тачку в домен, то права можно будет видеть. Т.е. в теории можно даже проще - если процесс копирования начинать со стороны винды - то там права то можно сохранить, но во первых теряются все прелести rsync, а во вторых выступать в качестве исполнителя команд будет винда, а меня это никак не устраивает в решении текущей задачи.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14542" data-commentid="14542" data-postid="984" data-belowelement="comment-14542" data-respondelement="respond" data-replyto="Комментарий к записи Максим" aria-label="Комментарий к записи Максим">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-14543">
<div class="comment even depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Максим</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14543">	20.08.2020 в 14:24</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>И сразу вторая проблема в голове, возможно встречались.</p>
<p>Если перенести всю помойку файловую на самбу, как будет корректно копировать? Тоже только виндой собирая ACL в файл?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14543" data-commentid="14543" data-postid="984" data-belowelement="comment-14543" data-respondelement="respond" data-replyto="Комментарий к записи Максим" aria-label="Комментарий к записи Максим">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-14544">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-4 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14544">	20.08.2020 в 14:45</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Если перенести файловый сервер на самбу, будет масса других проблем. Я не рекомендую. Там права вообще иногда слетают. Мне лично не нравится вариант файловой шары на linux с AD. Я за 10-ти летнюю практику много таких историй видел и настраивал и везде, где была возможность, файловые шары оставлял на винде.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14544" data-commentid="14544" data-postid="984" data-belowelement="comment-14544" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-14469">
<div class="comment even thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Сергей Вагнер</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14469">	17.08.2020 в 00:24</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Добрый день, сделал все по вашей инструкции (у меня centos8.2) - при запуске скрипта выдает ошибку:<br>
[root@backup scripts]# ./backup.sh<br>
Mon Aug 17 00:20:48 MSK 2020<br>
Start backup testpc<br>
ERROR: The remote path must start with a module name not a /</p>
<p>Не подскажите где взять это имя модуля и куда его прописать?</p>
<p>Собственно мой конфиг аналогичек как мануале:</p>
<p>#!/bin/bash<br>
date<br>
# Папка, куда будем складывать архивы<br>
syst_dir=/home/backup/<br>
# Имя сервера, который архивируем<br>
srv_name=testpc<br>
# Адрес сервера, который архивируем<br>
srv_ip=10.100.100.139<br>
# Пользователь rsync на сервере, который архивируем<br>
srv_user=backup<br>
# Ресурс на сервере для бэкапа<br>
srv_dir=/home/data/<br>
echo "Start backup ${srv_name}"<br>
# Создаем папку для инкрементных бэкапов<br>
mkdir -p ${syst_dir}${srv_name}/increment/<br>
# Запускаем непосредственно бэкап с параметрами<br>
/usr/bin/rsync -a --delete --password-file=/etc/rsyncd.scrt ${srv_user}@${srv_ip}::${srv_dir} ${syst_dir}${srv_name}/current/ --backup --backup-dir=${syst_dir}${srv_name}/increment/`date +%Y-%m-%d`/<br>
# Чистим папки с инкрементными архивами старше 30-ти дней<br>
/usr/bin/find ${syst_dir}${srv_name}/increment/ -maxdepth 1 -type d -mtime +30 -exec rm -rf {} \;<br>
date<br>
echo "Finish backup ${srv_name}"</p>
<p>Заранее большое спасибо за ответ.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14469" data-commentid="14469" data-postid="984" data-belowelement="comment-14469" data-respondelement="respond" data-replyto="Комментарий к записи Сергей Вагнер" aria-label="Комментарий к записи Сергей Вагнер">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-14473">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14473">	17.08.2020 в 10:27</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Так вы же не по статье делаете. В качестве источника для бэкапа должен быть указан ресурс на сервере, описанный в конфиге, а не путь. Вот мой пример:</p>
<p># Ресурс на сервере для бэкапа<br>
srv_dir=data</p>
<p>А у вас:<br>
# Ресурс на сервере для бэкапа<br>
srv_dir=/home/data/</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14473" data-commentid="14473" data-postid="984" data-belowelement="comment-14473" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-14479">
<div class="comment even depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Сергей Вагнер</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14479">	17.08.2020 в 13:29</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Огромное спасибо за помощь!!!</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14479" data-commentid="14479" data-postid="984" data-belowelement="comment-14479" data-respondelement="respond" data-replyto="Комментарий к записи Сергей Вагнер" aria-label="Комментарий к записи Сергей Вагнер">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-14480">
<div class="comment odd alt depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Сергей Вагнер</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14480">	17.08.2020 в 13:31</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Раз уж такое дело, может быть подскажите как быть с ошибкой:</p>
<p>[root@test home]# ./backup1.sh<br>
Mon Aug 17 03:37:48 MSK 2020<br>
Start backup test<br>
The --password-file option may only be used when accessing an rsync daemon.<br>
rsync error: syntax or usage error (code 1) at main.c(1393) [Receiver=3.1.3]<br>
Mon Aug 17 03:37:48 MSK 2020<br>
Finish backup test</p>
<p>На файле с паролем выставлены права 600. В чем еще может быть проблема?</p>
<p>Спасибо заранее!!!</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14480" data-commentid="14480" data-postid="984" data-belowelement="comment-14480" data-respondelement="respond" data-replyto="Комментарий к записи Сергей Вагнер" aria-label="Комментарий к записи Сергей Вагнер">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-14481">
<div class="comment byuser comment-author-zerox bypostauthor even depth-4 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14481">	17.08.2020 в 14:01</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Судя по всему у вас не запущена служба rsyncd. Ошибка явно на это указывает:</p>
<p> The --password-file option may only be used when accessing an rsync daemon.</p>
<p>Опция --password-file может быть использована только когда идет взаимодействие с демоном.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14481" data-commentid="14481" data-postid="984" data-belowelement="comment-14481" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-14494">
<div class="comment odd alt depth-5 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Сергей Вагнер</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14494">	18.08.2020 в 13:24</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Большое спасибо за помощь и быструю обратную связь! У меня все заработало - можно спать спокойно)))</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14494" data-commentid="14494" data-postid="984" data-belowelement="comment-14494" data-respondelement="respond" data-replyto="Комментарий к записи Сергей Вагнер" aria-label="Комментарий к записи Сергей Вагнер">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-14253">
<div class="comment even thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Александр</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14253">	30.07.2020 в 00:00</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Здравствуйте. Планируете ли добавить описание установки rsync на CentOS 8?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14253" data-commentid="14253" data-postid="984" data-belowelement="comment-14253" data-respondelement="respond" data-replyto="Комментарий к записи Александр" aria-label="Комментарий к записи Александр">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-14254">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14254">	30.07.2020 в 00:06</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Там все просто:</p>
<pre># dnf install rsync</pre>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14254" data-commentid="14254" data-postid="984" data-belowelement="comment-14254" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-14255">
<div class="comment even depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Александр</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14255">	30.07.2020 в 00:12</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Запустилось после dnf -y install rsync rsync-daemon</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14255" data-commentid="14255" data-postid="984" data-belowelement="comment-14255" data-respondelement="respond" data-replyto="Комментарий к записи Александр" aria-label="Комментарий к записи Александр">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-14017">
<div class="comment odd alt thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Алексей Сафонов</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14017">	11.07.2020 в 16:52</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>В скрипте инкрементного бэкапа на сервере приёмнике есть строчка:</p>
<p>/usr/bin/rsync -a – delete – password-file=/etc/rsyncd.scrt ${srv_user}@${srv_ip}::${srv_dir} ${syst_dir}${srv_name}/current/ – backup – backup-dir=${syst_dir}${srv_name}/increment/`date +%Y-%m-%d`/</p>
<p>Видимо, было написано:</p>
<p>/usr/bin/rsync -a --delete --password-file=/etc/rsyncd.scrt ${srv_user}@${srv_ip}::${srv_dir} ${syst_dir}${srv_name}/current/ --backup --backup-dir=${syst_dir}${srv_name}/increment/`date +%Y-%m-%d`/ </p>
<p>Надеюсь, с моим комментарием этого не произойдёт.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14017" data-commentid="14017" data-postid="984" data-belowelement="comment-14017" data-respondelement="respond" data-replyto="Комментарий к записи Алексей Сафонов" aria-label="Комментарий к записи Алексей Сафонов">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-14019">
<div class="comment even depth-2 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Алексей Сафонов</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14019">	11.07.2020 в 16:58</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>...произошло.<br>
В общем, перед длинными опциями, как обычно в GNU Linux, два тире.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14019" data-commentid="14019" data-postid="984" data-belowelement="comment-14019" data-respondelement="respond" data-replyto="Комментарий к записи Алексей Сафонов" aria-label="Комментарий к записи Алексей Сафонов">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-13647">
<div class="comment odd alt thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Аноним</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-13647">	09.06.2020 в 13:26</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>понять не могу почему крон эти скрипты не обрабатывает. в почту пишет мол<br>
rsync: could not open password file /etc/rsyncdnos.scrt: Permission denied (13)<br>
rsync error: syntax or usage error (code 1) at authenticate.c(187) [Receiver=3.1.3]<br>
тоесть как я понимаю скрипт запускаеться а потом rsync не может открыть скрипт с паролем?<br>
права на чтение\запись у них есть<br>
в чем беда  то?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-13647" data-commentid="13647" data-postid="984" data-belowelement="comment-13647" data-respondelement="respond" data-replyto="Комментарий к записи Аноним" aria-label="Комментарий к записи Аноним">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-13648">
<div class="comment byuser comment-author-zerox bypostauthor even depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-13648">	09.06.2020 в 14:39</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Явно указано, что у rsync нет доступа к файлу с паролем. Он запускается под отдельным пользователем.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-13648" data-commentid="13648" data-postid="984" data-belowelement="comment-13648" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-13655">
<div class="comment odd alt depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Аноним</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-13655">	10.06.2020 в 07:22</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>nano /etc/crontab -e -u user?<br>
как я понял записывать нужно<br>
10 09 * * * user       /home/user/backup/backup.sh</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-13655" data-commentid="13655" data-postid="984" data-belowelement="comment-13655" data-respondelement="respond" data-replyto="Комментарий к записи Аноним" aria-label="Комментарий к записи Аноним">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-13511">
<div class="comment even thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Ильдар</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-13511">	29.05.2020 в 08:11</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>день добрый.  вроде все копирует но вот что пишет<br>
rsync: opendir "/.aptitude" (in data) failed: Permission denied (13)<br>
cannot delete non-empty directory: ams/backup/amsmz/increment<br>
cannot delete non-empty directory: ams/backup/amsmz<br>
cannot delete non-empty directory: ams/backup/amsmz<br>
cannot delete non-empty directory: ams/backup<br>
cannot delete non-empty directory: ams/backup<br>
cannot delete non-empty directory: ams<br>
IO error encountered -- skipping file deletion<br>
rsync: send_files failed to open "/.mysql_history" (in data): Permission denied (13)<br>
rsync error: some files/attrs were not transferred (see previous errors) (code 23) at main.c(1677) [generator=3.1.3]<br>
/usr/bin/find: ‘ams/backup/amsmz/increment/’: Нет такого файла или каталога<br>
в чем проблема?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-13511" data-commentid="13511" data-postid="984" data-belowelement="comment-13511" data-respondelement="respond" data-replyto="Комментарий к записи Ильдар" aria-label="Комментарий к записи Ильдар">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-13513">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-13513">	29.05.2020 в 10:59</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Так тут же прямым текстом описаны все проблемы с доступом rsync к файлам:</p>
<pre> rsync: opendir «<strong>/.aptitude</strong>» (in data) failed: Permission denied (13)
rsync: send_files failed to open «<strong>/.mysql_history</strong>» (in data): Permission denied (13)</pre>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-13513" data-commentid="13513" data-postid="984" data-belowelement="comment-13513" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-11141">
<div class="comment even thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Александр</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-11141">	11.12.2019 в 10:42</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Не нашел способа, скажите, не удавалось ли заставить делать сначала полный архив, а уже последующие - в сравнении с начальным включали бы только измененные/добавленные файлы?<br>
Вопрос в том, что если допустим инкремент копии хранятся две недели, а какой-то файл был создан месяц назад, и вчера был удален, то в последней текущей копии его не будет, как и в хранящихся инкрементальных, так как его никто не трогал и не изменял.<br>
Или я не прав, и rcync также в инкремент копиях складывает и удаленные файлы (берет из предыдущей текущей копии?) ?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-11141" data-commentid="11141" data-postid="984" data-belowelement="comment-11141" data-respondelement="respond" data-replyto="Комментарий к записи Александр" aria-label="Комментарий к записи Александр">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-11142">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-11142">	11.12.2019 в 14:50</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Если файл был удален вчера, то он уедет в папку с удаленными файлами за прошлый день. Не важно, когда он был создан и изменялся. Как только во время сравнения оригинала и бэкапа в оригинале его не будет, из бэкапа он уедет в удаленные в тот день, когда его не окажется в оригинале.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-11142" data-commentid="11142" data-postid="984" data-belowelement="comment-11142" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-10951">
<div class="comment even thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Pingvin</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-10951">	22.11.2019 в 14:38</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Добрый день. Есть боевой сервер (FreeBSD) есть бэкап сервер (Debian).<br>
При запуске конфига выдаёт такую ошибку:<br>
@ERROR: chroot failed<br>
rsync error: error starting client-server protocol (code 5) at main.c(1675) [Receiver=3.1.3]<br>
Пт ноя 22 17:36:05 +06 2019</p>
<p>Вписывал в конфиг ( на боевом ) use chroot = false, так уже выдывало ошибку:<br>
@ERROR chdir failed<br>
rsync error: error starting client-server protocol (code 5) at main.c(1675) [Receiver=3.1.3]<br>
Подскажите что делать, заранее спасибо.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-10951" data-commentid="10951" data-postid="984" data-belowelement="comment-10951" data-respondelement="respond" data-replyto="Комментарий к записи Pingvin" aria-label="Комментарий к записи Pingvin">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-10930">
<div class="comment odd alt thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Николай</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-10930">	21.11.2019 в 10:34</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Не пробовали систему BackupPC ?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-10930" data-commentid="10930" data-postid="984" data-belowelement="comment-10930" data-respondelement="respond" data-replyto="Комментарий к записи Николай" aria-label="Комментарий к записи Николай">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-10931">
<div class="comment byuser comment-author-zerox bypostauthor even depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-10931">	21.11.2019 в 11:13</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Нет.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-10931" data-commentid="10931" data-postid="984" data-belowelement="comment-10931" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-10635">
<div class="comment odd alt thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">baracuda</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-10635">	25.10.2019 в 07:55</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Добрый день!<br>
Проверил файл на права, права стоят на 600 даже не знаю куда еще копать, прошу посмотри настройки может где нибудь ошибка а я ее не вижу.<br>
вот настройки:<br>
rsync.conf<br>
port = 873<br>
pid file = /var/run/rsyncd.pid<br>
log file = /var/log/rsyncd.log<br>
transfer logging = true<br>
munge symlinks = yes</p>
<p># Папка источник для бэкапа<br>
[data]<br>
path = /mnt/net<br>
uid = root<br>
read only = yes<br>
list = yes<br>
comment = Data backup Dir<br>
auth users = backuppc<br>
secrets file = /etc/rsyncd.scrt</p>
<p>Сам скрипт<br>
#!/bin/bash<br>
date</p>
<p># Папка куда будем складывать архивы<br>
syst_dir=/sharedfolders/BACKUP/</p>
<p># Имя Сервера, который архевируем<br>
srv_name=server-backup<br>
# Адрес сервера, который архевируем<br>
srv_ip=127.0.0.1<br>
# Пользователь  на сервере, который архевируем<br>
srv_user=backuppc</p>
<p># Ресурс на сервере для бэкапа<br>
srv_dir=/mnt/net</p>
<p>echo "Start backup ${srv_name}"<br>
# Создаем папку для инкрементных бэкапов<br>
mkdir -p ${syst_dir}${srv_name}/increment/</p>
<p># Запускаем непосредственно бэкап с параметрами<br>
/usr/bin/rsync -a --delete --password-file=/etc/rsyncd.scrt ${srv_user}@${srv_ip}:${srv_dir} ${syst_dir}${srv_name}</p>
<p># Чистим папки с инкрементными архивами старше 20-ти дней<br>
/usr/bin/find ${syst_dir}${srv_name}/increment/ -maxdepth 1 -type d -mtime +20 -exec rm -rf {} \;<br>
date<br>
echo "Finish backup ${srv_name}"</p>
<p>У меня виндовая шара примонтирована в /mnt/net/</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-10635" data-commentid="10635" data-postid="984" data-belowelement="comment-10635" data-respondelement="respond" data-replyto="Комментарий к записи baracuda" aria-label="Комментарий к записи baracuda">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-12131">
<div class="comment even depth-2 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">volcano</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-12131">	26.02.2020 в 19:12</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Понимаю, что это некропостинг, но всё же, вдруг кому ещё поможет)</p>
<p>У тебя ошибка в команде "/usr/bin/rsync -a —delete —password-file=/etc/rsyncd.scrt ${srv_user}@${srv_ip}:${srv_dir} ${syst_dir}${srv_name}". В конце должно быть 2 двоеточия в {srv_ip}::${srv_dir}. Если одно, как у тебя, rsync пытается подключиться через шелл и использовать его же авторизацию, поэтому у тебя выходит ошибка "The —password-file option may only be used when accessing an rsync daemon". Т.е. ты пытаешься одним способом, а авторизацию пройти другим, из-за этого конфликт. А когда ты используешь ::, то ты подключаешься напрямую к демону rsync на удалённой тачке и используешь его внутреннюю авторизацию, для этого и нужен ключ —password-file=.</p>
<p>Считаю, нужно этот момент в статью добавить, а то неясно поначалу. Сам не знал об этом, пока не споткнулся и не полез разбираться.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-12131" data-commentid="12131" data-postid="984" data-belowelement="comment-12131" data-respondelement="respond" data-replyto="Комментарий к записи volcano" aria-label="Комментарий к записи volcano">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-14022">
<div class="comment odd alt depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Алексей Сафонов</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14022">	11.07.2020 в 22:39</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Удивительно, с какой бы админской темой ни полез разбираться, вижу статьи Владимира Zerox в первых строках выдачи. И уже который год. Моё искреннее уважение. Когда нужно поднять что-то на линуксе ещё вчера, а разбираться приходится по ходу дела, то его статьи -- вне конкуренции. И даже не видно как-то этой самой...  конкуренции. А вы говорите: "некропостинг"! А комментарии в таких статьях важная вещь. </p>
<p>У Barracuda, на ошибку которого вы указали, проблема не столько в синтаксисе команды, сколько в понимании того, что он делает. Посмотрите на IP его сервера. Он монтирует виндовую шару к тому же серверу, на котором создаёт бэкап. Тут вообще не нужен пароль.  </p>
<p>Возможно, его ввёл в заблуждение предпоследний абзац:<br>
"Все, теперь папку /mnt/docs можно использовать в качестве приемника в нашем скрипте бэкапа с rsync. Если папка примонтирована непосредственно к серверу с бэкапами, то нужно на нем самом настроить конфиг rsyncd на примере серверов источников, запустить на нем rsyncd и в скрипте в качестве ip адреса сервера указывать 127.0.0.1."</p>
<p>Вероятно, Владимир имел ввиду "использовать в качестве источника". Но не суть. Мне кажется, в этом случае вообще не нужен конфиг rsync.conf.  Как и сам демон rsyncd. Хватит самой команды rsync, которая работает тут аналогом команды cp, только лучше: умеет копировать права доступа, ссылки-симлинки, главное, не будет тянуть те файлы, которые не изменились.</p>
<p>В общем, достаточно будет команды:<br>
rsync -a /mnt/net  /sharedfolders/BACKUP </p>
<p>Опция "delete" не нужна, и без неё будет удалять в приёмнике отсутствующие в источнике файлы.<br>
Опцию "backup" Baracuda не использовал, поэтому папка для инкрементных бэкапов у него будет пустая.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14022" data-commentid="14022" data-postid="984" data-belowelement="comment-14022" data-respondelement="respond" data-replyto="Комментарий к записи Алексей Сафонов" aria-label="Комментарий к записи Алексей Сафонов">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-14025">
<div class="comment byuser comment-author-zerox bypostauthor even depth-4 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14025">	12.07.2020 в 09:23</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Я хорошо прорабатывал статьи. У них хорошие поведенческие факторы и много комментариев, поэтому и позиции высокие. Но устал уже, давно ничего хорошего не писал. Нет времени.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14025" data-commentid="14025" data-postid="984" data-belowelement="comment-14025" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-14478">
<div class="comment odd alt depth-5 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Сергей Вагнер</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14478">	17.08.2020 в 13:27</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>сил тебе побольше, уважаемый автор! Насчет статей, это правда, если что то нужно поднять - в первую очередь иду на serveradmin. Так что пожалуйста, не забрасывай сайт)))) Всего хорошего!</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-14478" data-commentid="14478" data-postid="984" data-belowelement="comment-14478" data-respondelement="respond" data-replyto="Комментарий к записи Сергей Вагнер" aria-label="Комментарий к записи Сергей Вагнер">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-16907">
<div class="comment even depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">damianden</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16907">	12.03.2021 в 08:20</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Про двойное двоеточие  (::)  не забывайте если удаленный коннект к дэмону rsync  . ЭТО НЕ ОПЕЧАТКА. Если удаленный коннект через ssh тогда  ОДИНАРНОЕ  (:)</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-16907" data-commentid="16907" data-postid="984" data-belowelement="comment-16907" data-respondelement="respond" data-replyto="Комментарий к записи damianden" aria-label="Комментарий к записи damianden">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-10617">
<div class="comment odd alt thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">baracuda</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-10617">	24.10.2019 в 10:20</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Добрый день!<br>
Статья понравилась, как раз для моего случая мне тоже надо забэкапить с сервера Windows, настроил все по инструкции но при запуске файла ошибка:<br>
root@angar13:~/bin# ./backup-server1.sh<br>
Thu Oct 24 02:14:47 CDT 2019<br>
Start backup server-backup<br>
The --password-file option may only be used when accessing an rsync daemon.<br>
rsync error: syntax or usage error (code 1) at main.c(1400) [Receiver=3.1.2]<br>
Thu Oct 24 02:14:47 CDT 2019<br>
Finish backup server-backup</p>
<p>Я rsync впервый раз пользуюсь, не подскажешь куда копать, уже море статей в гугле перечитал не могу понять в чем причина.<br>
Спасибо</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-10617" data-commentid="10617" data-postid="984" data-belowelement="comment-10617" data-respondelement="respond" data-replyto="Комментарий к записи baracuda" aria-label="Комментарий к записи baracuda">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-10620">
<div class="comment byuser comment-author-zerox bypostauthor even depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-10620">	24.10.2019 в 11:12</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Вот ошибка:</p>
<p>The —password-file option may only be used when accessing an rsync daemon</p>
<p>Доступ к файлу с паролем должен быть только у root, если rsync от него работает. Права на файл 600 должны быть.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-10620" data-commentid="10620" data-postid="984" data-belowelement="comment-10620" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-9699">
<div class="comment odd alt thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Сергей</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9699">	07.08.2019 в 08:28</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Здравствуйте! А как настроить бэкап если на у файлов есть ACL?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9699" data-commentid="9699" data-postid="984" data-belowelement="comment-9699" data-respondelement="respond" data-replyto="Комментарий к записи Сергей" aria-label="Комментарий к записи Сергей">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-9702">
<div class="comment byuser comment-author-zerox bypostauthor even depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9702">	07.08.2019 в 10:58</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Rsync умеет сохранять расширенные права доступа через дополнительные ключи -A, --acls или -X, --xattrs. Но для надежности я еще выгружаю набор прав в отдельный файл:<br>
# getfacl -R /share/documents &gt; permissions.acl<br>
Потом их можно восстановить:<br>
# setfacl --restore=permissions.acl</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9702" data-commentid="9702" data-postid="984" data-belowelement="comment-9702" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-9707">
<div class="comment odd alt depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Аноним</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9707">	07.08.2019 в 13:05</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Спасибо. Попробую.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9707" data-commentid="9707" data-postid="984" data-belowelement="comment-9707" data-respondelement="respond" data-replyto="Комментарий к записи Аноним" aria-label="Комментарий к записи Аноним">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-11054">
<div class="comment even depth-4 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Smitellos</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-11054">	04.12.2019 в 16:17</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>В общую копилочку, на офф вики samba есть руководство по репликации sysvol, в нем и xattr и acls в rsync используются.<br>
пруф: <a href="https://wiki.samba.org/index.php/Rsync_based_SysVol_replication_workaround" rel="nofollow ugc">https://wiki.samba.org/index.php/Rsync_based_SysVol_replication_workaround</a>
</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-11054" data-commentid="11054" data-postid="984" data-belowelement="comment-11054" data-respondelement="respond" data-replyto="Комментарий к записи Smitellos" aria-label="Комментарий к записи Smitellos">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-9038">
<div class="comment odd alt thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Аноним</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9038">	26.05.2019 в 18:09</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>все заработало, извиняюсь за беспокойство</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9038" data-commentid="9038" data-postid="984" data-belowelement="comment-9038" data-respondelement="respond" data-replyto="Комментарий к записи Аноним" aria-label="Комментарий к записи Аноним">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-9037">
<div class="comment even thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Аноним</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9037">	26.05.2019 в 18:00</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>да действительно первый раз не понял,теперь вот это выпрыгивает<br>
rsync error: error starting client-server protocol (code 5) at main.c(1648) [Receiver=3.1.2]</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9037" data-commentid="9037" data-postid="984" data-belowelement="comment-9037" data-respondelement="respond" data-replyto="Комментарий к записи Аноним" aria-label="Комментарий к записи Аноним">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-9034">
<div class="comment odd alt thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Аноним</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9034">	26.05.2019 в 17:04</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>windows7<br>
сама папка с windows монтируется,все норм.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9034" data-commentid="9034" data-postid="984" data-belowelement="comment-9034" data-respondelement="respond" data-replyto="Комментарий к записи Аноним" aria-label="Комментарий к записи Аноним">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-9035">
<div class="comment byuser comment-author-zerox bypostauthor even depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9035">	26.05.2019 в 17:18</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Так если вы папку примонтировали к серверу с rsync, зачем вы пытаетесь подключиться к серверу windows с ip 192.168.1.3, если там rsync нет вообще? Походу вы не поняли принцип бэкапа виндовых машин. Прочитайте еще раз внимательно на эту тему. Надо монтировать шару и бэкапить через rsync с примонтированной шары в локальную директорию.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9035" data-commentid="9035" data-postid="984" data-belowelement="comment-9035" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-9036">
<div class="comment odd alt depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Вячеслав</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9036">	26.05.2019 в 17:22</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>centos7 ip 192.168.1.8, на нем стоит rsync и на нем же примонтирована папка от windows.<br>
windows 7 ip 192.168.1.3 на этой системе шара.<br>
Что именно я не так сделал?)</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9036" data-commentid="9036" data-postid="984" data-belowelement="comment-9036" data-respondelement="respond" data-replyto="Комментарий к записи Вячеслав" aria-label="Комментарий к записи Вячеслав">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-9030">
<div class="comment even thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Вячеслав</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9030">	26.05.2019 в 14:30</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Ребят как это победить? при попытке сделать бэкап виндовой шары выскакивает это </p>
<p>Start backup server1<br>
rsync: failed to connect to 192.168.1.3 (192.168.1.3): Connection refused (111)<br>
rsync error: error in socket IO (code 10) at clientserver.c(125) [Receiver=3.1.2]<br>
Вс май 26 19:28:05 +04 2019</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9030" data-commentid="9030" data-postid="984" data-belowelement="comment-9030" data-respondelement="respond" data-replyto="Комментарий к записи Вячеслав" aria-label="Комментарий к записи Вячеслав">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-9031">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9031">	26.05.2019 в 16:55</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>А что на 192.168.1.3? Кто должен ответить на запрос rsync?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-9031" data-commentid="9031" data-postid="984" data-belowelement="comment-9031" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-8215">
<div class="comment even thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Арти</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-8215">	20.02.2019 в 22:51</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>А вот как настроить bash скрипт что бы с QNAP-a забирать? На самом QNAP-е включен сервер Rsync вбит логин пароль.<br>
<a href="https://support.qnap.ru/hc/ru/articles/360000723574-%D0%A1%D0%BE%D0%B2%D0%BC%D0%B5%D1%81%D1%82%D0%BD%D0%BE%D0%B5-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-RSync-%D1%81%D0%B5%D1%80%D0%B2%D0%B5%D1%80%D0%B0-%D1%81%D0%B5%D1%82%D0%B5%D0%B2%D0%BE%D0%B3%D0%BE-%D1%85%D1%80%D0%B0%D0%BD%D0%B8%D0%BB%D0%B8%D1%89%D0%B0-QNAP-%D0%B8-%D0%BA%D0%BE%D0%BC%D0%BF%D1%8C%D1%8E%D1%82%D0%B5%D1%80%D0%B0-%D0%BF%D0%BE%D0%B4-%D1%83%D0%BF%D1%80%D0%B0%D0%B2%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5%D0%BC-%D0%9E%D0%A1-Windows" rel="nofollow ugc">https://support.qnap.ru/hc/ru/articles/360000723574-%D0%A1%D0%BE%D0%B2%D0%BC%D0%B5%D1%81%D1%82%D0%BD%D0%BE%D0%B5-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-RSync-%D1%81%D0%B5%D1%80%D0%B2%D0%B5%D1%80%D0%B0-%D1%81%D0%B5%D1%82%D0%B5%D0%B2%D0%BE%D0%B3%D0%BE-%D1%85%D1%80%D0%B0%D0%BD%D0%B8%D0%BB%D0%B8%D1%89%D0%B0-QNAP-%D0%B8-%D0%BA%D0%BE%D0%BC%D0%BF%D1%8C%D1%8E%D1%82%D0%B5%D1%80%D0%B0-%D0%BF%D0%BE%D0%B4-%D1%83%D0%BF%D1%80%D0%B0%D0%B2%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5%D0%BC-%D0%9E%D0%A1-Windows</a>
</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-8215" data-commentid="8215" data-postid="984" data-belowelement="comment-8215" data-respondelement="respond" data-replyto="Комментарий к записи Арти" aria-label="Комментарий к записи Арти">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-8216">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-8216">	21.02.2019 в 08:28</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Так в чем конкретно проблема, если на qnap работает rsync?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-8216" data-commentid="8216" data-postid="984" data-belowelement="comment-8216" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-8245">
<div class="comment even depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Арти</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-8245">	24.02.2019 в 22:26</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>[DATA]<br>
path = /mnt/d/<br>
list = yes<br>
read only = yes<br>
auth users = backup<br>
secrets file = /etc/rsyncd.scrt<br>
hosts allow = localhost 192.168.1.1<br>
hosts deny = *</p>
<p>[var/log/rsync]<br>
name lookup failed for 192.168.1.1: Name or service not known<br>
connect from UNKNOWN (192.168.1.1)<br>
rsync on DATA/NAS_HOME_1.hbk from backup@UNKNOWN (192.168.1.1)<br>
building file list<br>
rsync: link_stat "/NAS_HOME_1.hbk" (in DATA) failed: No such file or directory (2)<br>
sent 101 bytes  received 26 bytes  total size 0</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-8245" data-commentid="8245" data-postid="984" data-belowelement="comment-8245" data-respondelement="respond" data-replyto="Комментарий к записи Арти" aria-label="Комментарий к записи Арти">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-8251">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-4 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-8251">	25.02.2019 в 10:43</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Это похоже на проблемы с настройкой rsync на qnap. Вы пытаетесь скопировать файл NAS_HOME_1.hbk, которого нету в директории /mnt/d/, которую вы указали в конфиге rsync.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-8251" data-commentid="8251" data-postid="984" data-belowelement="comment-8251" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-8362">
<div class="comment even depth-5 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Александр</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-8362">	07.03.2019 в 21:46</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Имею на вооружении OpenMediaVault. Данные хранятся на первом массиве(зеркало 2тб) , который является шарой CIFS. ПО вашей статье на второй массив(зеркало 8 тб) делаются current и Increment все отлично. В сети есть машина на windows10. Хочется забирать оттуда данные по такому же принципе на второй массив. Расшарил с windows 10 это папкой через SMB. Примантировал с помощью плагина Remote shares (тот же маунт)  Все делалось успешно. Выключился свет, все перезагрузилось. Шара автоматом не примантирвалась, current пустой в increment лежит полностью все. Как выйти из это ситуации, можно ли прям rsync забрать с виндовой машины?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-8362" data-commentid="8362" data-postid="984" data-belowelement="comment-8362" data-respondelement="respond" data-replyto="Комментарий к записи Александр" aria-label="Комментарий к записи Александр">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-8363">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-6 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-8363">	08.03.2019 в 17:48</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Какую-то проверку надо сделать перед бэкапом. Например вот так:</p>
<p>df -h | grep SHARE<br>
if [ $? -eq 0 ]<br>
then exit<br>
else /root/scripts/mount.sh<br>
fi</p>
<p>Если вывод от df по имени SHARE равен 0 (т.е. сетевой ресурс присутсвует), то все в порядке, выходим, иначе запускается скрипт мотирования шары.</p>
<p>Это просто пример, я не отлаживал, но примерно так обычно делаю.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-8363" data-commentid="8363" data-postid="984" data-belowelement="comment-8363" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-7077">
<div class="comment even thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">VJ</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7077">	12.10.2018 в 11:08</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>да они понимают, разъяснил что тех проблема. но делать не хотят, так некогда, да и честно не охота проверять все файлы (чтобы переименовать). в связи с чем написал директору что технически резервные копии сделать нет возможности, что в случае аварии приведет к потере всей информации, пока не будут переименованы файлы. В результате у нас начался конфликт, которому конца и края не видно, а делать надо. Вот и ищу какой костыль сделать можно</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7077" data-commentid="7077" data-postid="984" data-belowelement="comment-7077" data-respondelement="respond" data-replyto="Комментарий к записи VJ" aria-label="Комментарий к записи VJ">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-7067">
<div class="comment odd alt thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">VJ</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7067">	12.10.2018 в 10:19</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Народ, нужна помощь. Разобрался с косяками запустил новый сервер резервирования. Но размер бэкапа очень маленький по сравнению с оригиналом. Долго разбирался и выяснил что во время копирования данных с основного сервера (под Win 2008R2) выходит ошибка:  rsync transfer failed: File name too long (36).</p>
<p>Попросив пользователей переименовать файлы, оказалось некоторые пользователи целые стихи вбивают в название файла (средняя длина имени 180-200 байт), на что получил категорический отказ мотивированный тем что таких файлов море, да и им тогда не понятно что за файл. Как теперь я понимаю ошибка о повреждении и невозможности восстановить копии на старой системе связанна как раз с тем что под win 2008r2 у файлов длина пути превышает 255 байт.<br>
Решить через служебную с разъяснением почему надо писать короткие имена, а так же что надо переименовать старый, не удалось. Директор вставил в тык за то что саботирую работу сотрудников и вообще мешаю им работать и лишь создаю видимость свой работы. </p>
<p>В общем прошу подсказать как можно обойти данную проблему. На Centos использую систему ext4 и судя из <a href="https://en.wikipedia.org/wiki/Comparison_of_file_systems" rel="nofollow ugc">https://en.wikipedia.org/wiki/Comparison_of_file_systems</a> помочь может только переход на Reiser4 или ReiserFS, которые не поддерживаются Centos</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7067" data-commentid="7067" data-postid="984" data-belowelement="comment-7067" data-respondelement="respond" data-replyto="Комментарий к записи VJ" aria-label="Комментарий к записи VJ">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-7071">
<div class="comment byuser comment-author-zerox bypostauthor even depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7071">	12.10.2018 в 10:59</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Ограничение на длину пути файла это проблема windows. Я с ней сталкивался много раз, но мне всегда удавалось объяснить, что это техническое ограничение. Ведь это так и есть. А так да, тоже в свое время до конфликтов доходило. Тут мне нечего посоветовать. Обойти это ограничение я не знаю как. Нужно учиться объяснять и отстаивать свою правоту. А то тут один человек просил помочь с тем, что места для почты нет на сервере, а с него требуют, чтобы появилось, но без удаления писем. Уступите сейчас, потом будете место силой мысли на серверах освобождать. Есть объективные технические ограничения, их нужно учитывать, а не искать костыли.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7071" data-commentid="7071" data-postid="984" data-belowelement="comment-7071" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-7022">
<div class="comment odd alt thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Korus</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7022">	09.10.2018 в 16:03</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Я не селен в настройках логов. Но у меня в логе только одно сообщение, о том что rsync запущен и какой порт использует. как настроит более детальный лог, что бы хотя бы писал во сколько начал и во сколько закончил резервирование?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7022" data-commentid="7022" data-postid="984" data-belowelement="comment-7022" data-respondelement="respond" data-replyto="Комментарий к записи Korus" aria-label="Комментарий к записи Korus">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-7026">
<div class="comment byuser comment-author-zerox bypostauthor even depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7026">	09.10.2018 в 20:08</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>После обращения к серверу, в логе /var/log/rsyncd.log будет вся информация, в том числе о переданных файлах.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7026" data-commentid="7026" data-postid="984" data-belowelement="comment-7026" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-7065">
<div class="comment odd alt depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Korus</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7065">	12.10.2018 в 04:33</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>не знаю. у меня в логе только:<br>
sent 0 bytes  received 0 bytes  total size 0<br>
rsyncd version 3.1.2 starting, listening on port 873</p>
<p>и то только после ручного запуска.<br>
все сделано как и у вас.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7065" data-commentid="7065" data-postid="984" data-belowelement="comment-7065" data-respondelement="respond" data-replyto="Комментарий к записи Korus" aria-label="Комментарий к записи Korus">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-7070">
<div class="comment byuser comment-author-zerox bypostauthor even depth-4 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7070">	12.10.2018 в 10:55</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Информация должна появиться в логе, когда кто-то подключится и заберет файлы.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7070" data-commentid="7070" data-postid="984" data-belowelement="comment-7070" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-7074">
<div class="comment odd alt depth-5 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Korus</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7074">	12.10.2018 в 11:03</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>А если у меня сервер на себя же копирует документы, которые смонтированы с сетевого хранилища и win сервера?<br>
rsyncd.conf у меня такой:</p>
<p>pid file = /var/run/rsyncd.pid<br>
log file = /var/log/rsyncd.log<br>
transfer logging = true<br>
munge symlinks = yes<br>
syslog facility = local5</p>
<p># папка источник для бэкапа<br>
[data]<br>
path = /docs       #точка монтирования сервера с документами<br>
uid = root<br>
read only = yes<br>
list = yes</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7074" data-commentid="7074" data-postid="984" data-belowelement="comment-7074" data-respondelement="respond" data-replyto="Комментарий к записи Korus" aria-label="Комментарий к записи Korus">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-7076">
<div class="comment byuser comment-author-zerox bypostauthor even depth-6 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7076">	12.10.2018 в 11:08</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Если хочется подробную информацию, тогда проще просто запускать rsync с ключами --progress -av и направлять вывод в какой-нибудь файл. Например так:</p>
<pre>rsync --delete --progress -av /mnt/documents/ /mnt/backup &gt;&gt; /var/log/rsync/rsync-documents.log</pre>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7076" data-commentid="7076" data-postid="984" data-belowelement="comment-7076" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-7078">
<div class="comment odd alt depth-7 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Korus</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7078">	12.10.2018 в 11:31</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Спасибо!! Практически то что надо, в таком виде многовато перебирать, но меня устроит)</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7078" data-commentid="7078" data-postid="984" data-belowelement="comment-7078" data-respondelement="respond" data-replyto="Комментарий к записи Korus" aria-label="Комментарий к записи Korus">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-7081">
<div class="comment byuser comment-author-zerox bypostauthor even depth-8 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7081">	12.10.2018 в 15:09</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Ключ progress можно убрать. Он нужен, только если в консоли сам смотришь за процессом. В лог эту информацию нет смысла отправлять.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-7081" data-commentid="7081" data-postid="984" data-belowelement="comment-7081" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-6817">
<div class="comment odd alt thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">VJ</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6817">	21.09.2018 в 09:45</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Вопрос отпал. Нашел косяк. Теперь разбираюсь с ошибкой монтирования директории хранения архива "SMB signature verification returned error = -13"</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6817" data-commentid="6817" data-postid="984" data-belowelement="comment-6817" data-respondelement="respond" data-replyto="Комментарий к записи VJ" aria-label="Комментарий к записи VJ">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-6812">
<div class="comment even thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">VJ</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6812">	21.09.2018 в 07:06</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>вот так выглядит rsyncd.conf:</p>
<p> gid = users<br>
transfer logging = true<br>
log format = %h %o %f %l %b<br>
log file = /var/log/rsyncd.log<br>
pid file = /var/run/rsyncd.pid</p>
<p> [IT]<br>
path = /dom/otlde/it<br>
uid = root<br>
read only = yes<br>
list = yes<br>
comment = Data backup Dir<br>
auth users = backup<br>
secrets file = /etc/rsyncd.scrt</p>
<p>а вот так мой скрипт:</p>
<p> #!/bin/bash</p>
<p>date<br>
#Папкв, куда складываются архивы<br>
syst_dir=/disbackup/otdel</p>
<p>#Имя сервер, который архивируем<br>
srv_name=servotdel</p>
<p>#Адрес сервера, который архивируем<br>
srv_ip=127.0.0.1</p>
<p>#Пользователь из подкоторого выполняется скрипт<br>
srv_user=backup</p>
<p>#Ресурс для резервирования<br>
srv_dir=/dom/otdel/IT</p>
<p>echo "Start bcakup ${srv_name}"</p>
<p>#Создаем папку для инкриментного резервирования<br>
mkdir -p ${syst_dir}/increment/</p>
<p>#Запускаем резервирование<br>
/usr/bin/rsync -a --delete /dom/otdel/IT ${sust_dir}/current/ --backup --backup-dir=${syst_dir}/increment/`date +%Y-%m-%d`/</p>
<p>#Чистим инкремент старше 30 дней<br>
/usr/bin/find ${syst_dir}/increment -maxdepth 1 -type d -mtime +30 -exec rm -rf {} \;</p>
<p>date</p>
<p>echo "Finish backup ${srv_name}"</p>
<p>/dom/otdel/IT и /disbackup/otdel - шары приментонтированные к серверу который делает резервирование<br>
полная копия должна лежать в шаре /disbackup/otdel/</p>
<p>в общем где у меня косяк?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6812" data-commentid="6812" data-postid="984" data-belowelement="comment-6812" data-respondelement="respond" data-replyto="Комментарий к записи VJ" aria-label="Комментарий к записи VJ">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-6811">
<div class="comment odd alt thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">VJ</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6811">	21.09.2018 в 06:58</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Сделал все по вашей инструкции и столкнулся с проблемой. Копирование папки происходит в директорию current, которая лежит в корне, а не туда куда я хотел бы положить. В документации не увидел ключа по которому можно это реализовать. Ключ path как я понял применим только когда говорим о пути до источника резервирования или я ошибаюсь? В общем подскажите как изменить директорию для полной копии</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6811" data-commentid="6811" data-postid="984" data-belowelement="comment-6811" data-respondelement="respond" data-replyto="Комментарий к записи VJ" aria-label="Комментарий к записи VJ">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-6789">
<div class="comment even thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Mad_Bear</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6789">	20.09.2018 в 13:01</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>А какова глубина резервирования: 1 раз в месяц полная и каждый день в течение него инкрементные с последующей перезаписью, и все? или каждый месяц одна полная и в течении него инкрементные?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6789" data-commentid="6789" data-postid="984" data-belowelement="comment-6789" data-respondelement="respond" data-replyto="Комментарий к записи Mad_Bear" aria-label="Комментарий к записи Mad_Bear">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-6793">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6793">	20.09.2018 в 13:43</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>"Теперь приступаем к настройке. Логика наших бэкапов будет следующая. При первом запуске мы делаем полный бэкап интересующей нас информации в папку current. Потом раз в сутки мы сверяем имеющийся архив с источником и делаем его вновь актуальным, перезаписывая все изменившиеся файлы, но при этом не удаляем их, а складываем в папку increment, где каждый день создается папка с именем в виде даты, в которую складываются все измененные файлы за текущий день. Таким образом, у нас всегда будет полный архив, актуальный на момент последней синхронизации, плюс набор папок за каждый день с изменившимися в этот день файлами. Сколько дней хранить можно выбрать по необходимости."</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6793" data-commentid="6793" data-postid="984" data-belowelement="comment-6793" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-6795">
<div class="comment even depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Mad_Bear</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6795">	20.09.2018 в 13:45</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>" Таким образом, у нас всегда будет полный архив, актуальный на момент последней синхронизации" вот эта фраза как раз и вызывает вопрос о частоте получения полной копии</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6795" data-commentid="6795" data-postid="984" data-belowelement="comment-6795" data-respondelement="respond" data-replyto="Комментарий к записи Mad_Bear" aria-label="Комментарий к записи Mad_Bear">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-6797">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-4 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6797">	20.09.2018 в 13:50</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>У вас полная копия будет каждый день после синхронизации. Не знаю, как еще понятнее объяснить. Вы один раз делаете полную копию, а потом сравниваете изменения за день и актуализируете каждый день эту полную копию. А изменившиеся файлы складываете в отдельную папку. </p>
<p>Это не похоже на инкрементные копии, к примеру, veeam, так как он хранит данные не в открытом виде, а в своем формате. Здесь же у вас будут сырые данные, таком виде, как они есть на источнике.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6797" data-commentid="6797" data-postid="984" data-belowelement="comment-6797" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-6800">
<div class="comment even depth-5 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Mad_Bear</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6800">	20.09.2018 в 13:57</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Вот честно я в тупике) Исходя из сказанного я так понимаю что каждый день делается полная копия с актуальными данными, при этом мы файлы которые изменились складываем еще и отдельно. В таком случае возникает вопрос, а зачем "инкримент нужен", ведь подобный архив будет жрать место.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6800" data-commentid="6800" data-postid="984" data-belowelement="comment-6800" data-respondelement="respond" data-replyto="Комментарий к записи Mad_Bear" aria-label="Комментарий к записи Mad_Bear">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-6803">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-6 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6803">	20.09.2018 в 15:19</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Вместо тысячи слов, проще просто проверить, как это работает. Никто там не жрет место. Расход по месту как раз минимальный получается. Ничего лишнего.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6803" data-commentid="6803" data-postid="984" data-belowelement="comment-6803" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-8482">
<div class="comment even depth-7 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Ayrat</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-8482">	22.03.2019 в 11:34</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Статья замечательная !))<br>
Мне кажется, чтобы было понятно, нужно сформулировать немного иначе.<br>
Делается синхронизация источника в каталог current,<br>
а в каталог increment складываются старые версии измененных файлов,<br>
так на всякий случай (например, пользователь по ошибке заменил файл пустым).</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-8482" data-commentid="8482" data-postid="984" data-belowelement="comment-8482" data-respondelement="respond" data-replyto="Комментарий к записи Ayrat" aria-label="Комментарий к записи Ayrat">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-6538">
<div class="comment odd alt thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">VJ</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6538">	20.08.2018 в 09:42</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>я не до конца понял. ты на Unix сервера бэкапишь или сами сервера?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6538" data-commentid="6538" data-postid="984" data-belowelement="comment-6538" data-respondelement="respond" data-replyto="Комментарий к записи VJ" aria-label="Комментарий к записи VJ">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-6540">
<div class="comment byuser comment-author-asp even depth-2 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">ASP</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6540">	20.08.2018 в 17:26</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Линуксом бекаплю данные с вин и линукс серверов и сохраняю их в том числе и на сетевые ресурсы. grsync - я имел в виду для тех кто не любит скрипты и командную строку, а хочет все настроить через графический интерфейс.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6540" data-commentid="6540" data-postid="984" data-belowelement="comment-6540" data-respondelement="respond" data-replyto="Комментарий к записи ASP" aria-label="Комментарий к записи ASP">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-6541">
<div class="comment odd alt depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">VJ</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6541">	21.08.2018 в 04:38</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Я у автора спрашал))) Может ты тогда подскажешь. Из статьи я вижу что данные не архивируются. а тупа копируются. Это так?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6541" data-commentid="6541" data-postid="984" data-belowelement="comment-6541" data-respondelement="respond" data-replyto="Комментарий к записи VJ" aria-label="Комментарий к записи VJ">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-6543">
<div class="comment byuser comment-author-zerox bypostauthor even depth-4 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6543">	21.08.2018 в 19:09</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Да, данные только копируются. При желании, их можно потом сжимать на сервере с бэкапами. Но тогда сравнение с текущими данными не будет работать. Архивы надо либо распаковывать при сравнении, либо заново полный архив делать.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6543" data-commentid="6543" data-postid="984" data-belowelement="comment-6543" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-6544">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6544">	21.08.2018 в 19:09</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Бэкаплю любые данные на unix сервер.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6544" data-commentid="6544" data-postid="984" data-belowelement="comment-6544" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-6776">
<div class="comment even depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">VJ</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6776">	19.09.2018 в 10:30</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Подскажи пожалуйста. Пробую сделать как выше описано и не могу разобраться в одной мелочи. У меня есть сервер на котором штук 15 шар на разных дисках, которые надо резервировать, точно так же в разные шары, которые физически находятся на отдельно стоящем сервер. Я их отдельно цепляю к серваку. Вопрос как правильно их писать в конфиге. Я делаю так</p>
<p>[data1]<br>
path = /data1<br>
...<br>
[data3]<br>
path = /data3<br>
...<br>
[data3]<br>
path = /data3</p>
<p>И вопрос у меня все делается на одной машине, но хранится все на разных. я так понимаю что и исполняемые скрипты, для инкрементного резервирования, должны быть на той же машине что и rsync?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6776" data-commentid="6776" data-postid="984" data-belowelement="comment-6776" data-respondelement="respond" data-replyto="Комментарий к записи VJ" aria-label="Комментарий к записи VJ">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-6320">
<div class="comment odd alt thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">asp</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6320">	11.07.2018 в 12:04</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Автору большое спасибо за статью, все клево работает )</p>
<p>Маленькое дополнение, для тех кто любит окошки будет полезен гуй для rsync — grsync.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-6320" data-commentid="6320" data-postid="984" data-belowelement="comment-6320" data-respondelement="respond" data-replyto="Комментарий к записи asp" aria-label="Комментарий к записи asp">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-4104">
<div class="comment even thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Павел</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-4104">	26.04.2018 в 17:01</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>ОФИГЕТЬ!! Работает!! я целый день убил на настройку этой хрени, пока не наткнулся на эту статью. спасибо большое, успехов и процветания тебе!</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-4104" data-commentid="4104" data-postid="984" data-belowelement="comment-4104" data-respondelement="respond" data-replyto="Комментарий к записи Павел" aria-label="Комментарий к записи Павел">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-3211">
<div class="comment odd alt thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Hanbi</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-3211">	24.12.2017 в 04:41</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Хочу перенастроить выделенный sys  сервер ovh.<br>
Не поможете</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-3211" data-commentid="3211" data-postid="984" data-belowelement="comment-3211" data-respondelement="respond" data-replyto="Комментарий к записи Hanbi" aria-label="Комментарий к записи Hanbi">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-2095">
<div class="comment even thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">nostromo</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-2095">	25.07.2017 в 10:26</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Спасибо. Статья замечательная!)<br>
На Ubuntu Server 16.04 в increment стал перекладывать только так...<br>
/usr/bin/rsync -a /mnt/ ${syst_dir}${srv_name}/current/ --backup --delete --backup-dir=${syst_dir}${srv_name}/increment/`date +%Y-%m-%d`/ до этого сваливал все в current, пока во второй части не указал --delete (если писать вначале, то не перекладывает и операции производятся между current и смонтированной папкой)<br>
Если папка не смонтирована, то действительно, переложит вообще все из current в increment. Проверку добавил так:<br>
Монтируем папку удобным для вас способом, смотрим df -h (к примеру там файловая система <a href="mailto:user@172.16.2.100">user@172.16.2.100</a>:/share и бла-бла)<br>
В скрипте пишем проверку:<br>
#!/bin/bash<br>
df -h | grep 172.16.2.100:/share<br>
if [ $? -eq 0 ] #если папка смонтирована, то выполняем код бэкапа<br>
then<br>
#тут код из статьи выше для бекапа....<br>
......<br>
......<br>
else touch /backup/error_1C_`date +%Y-%m-%d` # если папка не смонтирована, то например создаем файлик с датой и на выход<br>
fi</p>
<p>Как-то так...</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-2095" data-commentid="2095" data-postid="984" data-belowelement="comment-2095" data-respondelement="respond" data-replyto="Комментарий к записи nostromo" aria-label="Комментарий к записи nostromo">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-2056">
<div class="comment odd alt thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">
<a href="http://sysalex.com/" rel="external nofollow ugc" class="url">POS_troi</a>
</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-2056">	16.07.2017 в 16:44</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>secrets file = /etc/rsyncd.scrt</p>
<p>Можно указать в основной секции а не в модуле.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-2056" data-commentid="2056" data-postid="984" data-belowelement="comment-2056" data-respondelement="respond" data-replyto="Комментарий к записи POS_troi" aria-label="Комментарий к записи POS_troi">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-1782">
<div class="comment even thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Aleks</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1782">	25.05.2017 в 10:55</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>И по ssh раз в час примерно связь отрубается, теряется соединение и ничего не поделаешь, а в rsync можно чтобы он если связь оборвалась до копировал недостающие файлы в папке?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1782" data-commentid="1782" data-postid="984" data-belowelement="comment-1782" data-respondelement="respond" data-replyto="Комментарий к записи Aleks" aria-label="Комментарий к записи Aleks">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-1784">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1784">	25.05.2017 в 12:20</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>При повторном запуске он продолжит синхронизацию.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1784" data-commentid="1784" data-postid="984" data-belowelement="comment-1784" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-1781">
<div class="comment even thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Aleks</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1781">	25.05.2017 в 10:51</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Самое интересное что две страницы google просмотрел и складывается ощущение что password-file использовать бессмысленно - ведь запрос выдает не rsync, а ssh.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1781" data-commentid="1781" data-postid="984" data-belowelement="comment-1781" data-respondelement="respond" data-replyto="Комментарий к записи Aleks" aria-label="Комментарий к записи Aleks">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-1780">
<div class="comment odd alt thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Aleks</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1780">	25.05.2017 в 10:41</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Здравствуйте, на одном сервере все работает как часы, а на другом у нас нет прав root - ни порты не открыть, ни файлы сконфигурировать вот и приходиться выкручиваться и использовать rsync через ssh. Но файл с паролем не проходит конфиг вот такой:<br>
rsync  -a --delete --password-file=/etc/rsyncdwor.scrt -e 'ssh -p 2222' ${srv_user}@${srv_ip}:${srv_dir} ${syst_dir}${srv_name}/current/ --backup --backup-dir=${syst_dir}${srv_name}/increment/`date +%Y-%m-%d`/<br>
и сразу вываливается ошибка -<br>
The --password-file option may only be used when accessing an rsync daemon.<br>
rsync error: syntax or usage error (code 1) at main.c(1251) [Receiver=3.0.9]<br>
Если пароль забивать ручками, то работает.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1780" data-commentid="1780" data-postid="984" data-belowelement="comment-1780" data-respondelement="respond" data-replyto="Комментарий к записи Aleks" aria-label="Комментарий к записи Aleks">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-1755">
<div class="comment even thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Aleks</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1755">	22.05.2017 в 11:25</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Спасибо большое, разобрался в iptables, оказалось что это предыдущие настройщики разрешили с нашего ip, а все остальное отрубили - добавил, заработало! Спасибо за подсказку. Никак не могу разобраться чтобы команда работала наоборот, чтобы в current лежал полный архив, например, за 20 мая, а в increment складывались изменения за 21 мая, за 22 мая. Что то он меня не понимает. А вообще rsync довольно шустро передает, я с одного сервера на другой им перекинул 50 Гб за 28 минут, а ftp тот же объем ли 1ч10.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1755" data-commentid="1755" data-postid="984" data-belowelement="comment-1755" data-respondelement="respond" data-replyto="Комментарий к записи Aleks" aria-label="Комментарий к записи Aleks">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-1756">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1756">	22.05.2017 в 11:40</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Да, rsync работает быстрее всех известных мне способов передачи информации. Всегда его использую при возможности.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1756" data-commentid="1756" data-postid="984" data-belowelement="comment-1756" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-1757">
<div class="comment even depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Aleks</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1757">	22.05.2017 в 12:04</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>"Никак не могу разобраться чтобы команда работала наоборот, чтобы в current лежал полный архив, например, за 20 мая, а в increment складывались изменения за 21 мая, за 22 мая."<br>
А это вообще возможно или нет?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1757" data-commentid="1757" data-postid="984" data-belowelement="comment-1757" data-respondelement="respond" data-replyto="Комментарий к записи Aleks" aria-label="Комментарий к записи Aleks">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-1728">
<div class="comment odd alt thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Aleks</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1728">	19.05.2017 в 15:05</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>И вроде только порт 873, с остальных адресов могу подключиться Telnet - порт отвечает.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1728" data-commentid="1728" data-postid="984" data-belowelement="comment-1728" data-respondelement="respond" data-replyto="Комментарий к записи Aleks" aria-label="Комментарий к записи Aleks">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-1727">
<div class="comment even thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Aleks</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1727">	19.05.2017 в 14:59</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Здравствуйте, помогите пожалуйста. Недели три назад проверял rsync, настроил и видимо указал где то чтобы принимал запросы только с одного ip. И теперь не могу понять как это изменить. Потому что с других адресов сразу отбивает, говорит что соединение не установилось. Вывод команды admroot@eph# sudo netstat -lnpt | grep 873<br>
tcp        0      0 0.0.0.0:873                 0.0.0.0:*                   LISTEN      27164/xinetd</p>
<p>Вроде все порты слушает, только с одного ip пробивает telnet, остальные отбой дают. Пожалуйста помогите.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1727" data-commentid="1727" data-postid="984" data-belowelement="comment-1727" data-respondelement="respond" data-replyto="Комментарий к записи Aleks" aria-label="Комментарий к записи Aleks">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-1729">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1729">	19.05.2017 в 15:06</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Скорее всего ограничение доступа было настроено с помощью фаервола - iptables. Там и надо смотреть.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1729" data-commentid="1729" data-postid="984" data-belowelement="comment-1729" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-1648">
<div class="comment even thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Aleks</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1648">	04.05.2017 в 08:59</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Спасибо огромное, первый раз пользовался rsync и Ваша статья просто сказка, вам бы инструкции писать - четко, понятно, мысли - "А откуда это взялось - не возникает". Но можно вопрос, по причине тугодумности, а как восстанавливать? И можно ли, чтобы копия делалась наоборот - в increment создавалась папка с изменениями, а в current оставались файлы неизменны?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1648" data-commentid="1648" data-postid="984" data-belowelement="comment-1648" data-respondelement="respond" data-replyto="Комментарий к записи Aleks" aria-label="Комментарий к записи Aleks">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-1650">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1650">	04.05.2017 в 10:27</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Не понял вопрос про восстановление. Файлы же в открытом виде лежат. Можно просто зайти в папку и скопировать куда хочется.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1650" data-commentid="1650" data-postid="984" data-belowelement="comment-1650" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-1652">
<div class="comment even depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Aleks</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1652">	04.05.2017 в 11:02</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>А автоматически, командой rsync, с сервера где лежит резервная копия? Например если резервная копия более 100 Гб, а сервер удаленный. Не слишком удобно копировать обратно посредством, допустим ftp-сервера.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1652" data-commentid="1652" data-postid="984" data-belowelement="comment-1652" data-respondelement="respond" data-replyto="Комментарий к записи Aleks" aria-label="Комментарий к записи Aleks">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-1653">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-4 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1653">	04.05.2017 в 11:09</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Тогда можно воспользоваться rsync, только в обратном направлении. Для этого подойдет простой запуск команды без лишних ключей:<br>
rsync -v /backup /new_folder<br>
Папку /new_folder можно подмонтировать каким-то образом к серверу с бэкапом, если нужно на удаленный сервер загрузить. Это самый быстрый вариант. </p>
<p>А можно просто настроить все то же самое, что описано в статье, только в обратную сторону. Поменять местами источник и приемник.</p>
<p>В общем, тут можно воспользоваться абсолютно любым вариантом передачи файлов с одного сервера на другой. Это же сырые данные, просто файлы. Передавай их так, как тебе удобно. </p>
<p>Если файлов 100 Гб, то очевидно, их лучше сжать сначала архиватором перед отправкой. </p>
<p>Rsync просто инструмент копирования, это не готовая система бэкапа, где все можно в несколько кликов сделать и восстановить на место файлы, как, например, в veeam.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1653" data-commentid="1653" data-postid="984" data-belowelement="comment-1653" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-1615">
<div class="comment even thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Игорь</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1615">	28.04.2017 в 11:43</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Добрый день.<br>
Кажется у вас там опечатка в строке =&gt;<br>
/usr/bin/rsync -a --delete --password-file=/etc/rsyncd.scrt ${srv_user}@${srv_ip}::${srv_dir} ${syst_dir}${srv_name}/current/ --backup --backup-dir=${syst_dir}${srv_name}/increment/`date +%Y-%m-%d`/<br>
Тут достаточно одного двоеточия.<br>
Ну и лично от меня. Кажется удобнее подключаться с помощью ssh ключа чем с файлом паролем.<br>
Отличная статья как всегда!</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1615" data-commentid="1615" data-postid="984" data-belowelement="comment-1615" data-respondelement="respond" data-replyto="Комментарий к записи Игорь" aria-label="Комментарий к записи Игорь">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-1616">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1616">	28.04.2017 в 11:51</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>У меня именно два двоеточия в скриптах, так и работает. Уже не помню почему и зачем их два :) По ssh ключу тоже иногда настраиваю, если он есть. Тут субъективно, кому как больше нравится.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1616" data-commentid="1616" data-postid="984" data-belowelement="comment-1616" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-1238">
<div class="comment even thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Роман</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1238">	13.03.2017 в 18:18</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Подскажите как мне на Ubuntu настроить бэкап vmware esxi на этой вертуалке крктиться ad и основной host причем Ubuntu крутиться на отдельной железке?я нечего не шарю в бкапах и линуксе , помогите плиз)</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-1238" data-commentid="1238" data-postid="984" data-belowelement="comment-1238" data-respondelement="respond" data-replyto="Комментарий к записи Роман" aria-label="Комментарий к записи Роман">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-907">
<div class="comment odd alt thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">iltmpz</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-907">	25.01.2017 в 13:29</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Спасибо за статью!<br>
Возник вопрос, в чем преимущества/недостатки отдельного rsync-сервера на отдельном порту по сравнению с ssh.</p>
<p>Я давно и успешно пользуюсь ssh для этой цели: rsync -aux hostname:/dir /backup/hostname/dir (для копирования с сервера hostname в локальный каталог). Все эти --backup-dir тоже отлично работают.<br>
Не надо настраивать отдельных сервисов на серверах-источниках, все спокойно скачивается по ssh.<br>
Единственное, приходится открывать рута для доступа по ssh и генерировать пару ключей для беспарольного входа. Это безусловно минус к безопасности. Который я надеялся обойти при помощи rsync-сервера.<br>
Но когда я прочитал вот это: "backup:12345" - тупо пароль в текстовом файле, даже не зашифрованный! (спасибо, что хоть "Делаем права на чтение только root, иначе rsync не запустится"), то желание "повышать безопасность" таким способом отпало напрочь.<br>
Ведь фактически, любой, кто узнает этот пароль, автоматически получит полный доступ к данным сервера!<br>
Есть у кого-нибудь какие-то соображения на этот счет?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-907" data-commentid="907" data-postid="984" data-belowelement="comment-907" data-respondelement="respond" data-replyto="Комментарий к записи iltmpz" aria-label="Комментарий к записи iltmpz">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-908">
<div class="comment byuser comment-author-zerox bypostauthor even depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-908">	25.01.2017 в 14:02</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Я не проверял специально, но думаю, что по ssh будет меньше скорость, чем напрямую через rsync. Узнав пароль пользователя rsync, можно получить данные, к которым есть доступ только через rsync, а не ко всем данным сервера. А с учетом того, что доступ на чтение файла с паролем есть только у рута, узнать пароль сможет только тот, кто получил рут доступ. В общем, как мне видится, какого-то принципиального отличия в безопасности я не вижу. </p>
<p>Даже более того, если будет скомпрометирован сервер с бэкапами, злоумышленник получит рут доступ ко всем серверам, с которых по ssh забирались данные через учетку рута. А тут будет только ограниченный доступ к каталогам с бэкапом. </p>
<p>Думаю, от ситуации надо отталкиваться. Если реально нужны высокие меры безопасности, то можно придумать решение. Но я не вижу в этом надобности в обычной среднестатистической ситуации.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-908" data-commentid="908" data-postid="984" data-belowelement="comment-908" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-534">
<div class="comment odd alt thread-even depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Виктор</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-534">	28.11.2016 в 17:04</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Добрый день. Воспользовался вашей статьей, сам в первые пользуюсь линуксом, юзаю Ubuntu server 14.04. Есть необходимость подключать виндовс шару, бекапить ее на линукс сервер. Скрипт заработал у меня в следующем виде:</p>
<p>#!/bin/sh<br>
#монтируем виндовс ресурс, кторый хотим сохранить<br>
mount -t cifs //192.168.0.100/Doks /mnt/Doks -o user=username,password=password<br>
echo "mount Doks"<br>
#бекапим файлы с помощью демона rsync<br>
date<br>
# Папка, куда будем складывать архивы<br>
syst_dir=/windows/<br>
# Имя сервера, который архивируем<br>
srv_name=myserv<br>
# Адрес сервера, который архивируем<br>
srv_ip=127.0.0.1<br>
# Пользователь rsync на сервере, который архивируем<br>
srv_user=username<br>
# Ресурс на сервере для бэкапа<br>
srv_dir=/mnt/Doks<br>
echo «Start backup ${srv_name}»<br>
# Создаем папку для инкрементных бэкапов<br>
mkdir -p ${syst_dir}${srv_name}/increment/<br>
# Запускаем непосредственно бэкап с параметрами<br>
/usr/bin/rsync -a --delete /mnt/Doks/ ${syst_dir}${srv_name}/current/ --backup --backup-dir=${syst_dir}${srv_name}/increment/`date +%Y-%m-%d`/<br>
# Чистим папки с инкрементными архивами старше 30-ти дней<br>
/usr/bin/find ${syst_dir}${srv_name}/increment/ -maxdepth 1 -type d -mtime +30 -exec rm -rf {} \;<br>
date<br>
echo «Finish backup ${srv_name}»<br>
#размонтируем виндовс ресурс<br>
umount /mnt/Doks<br>
echo "umount Doks"</p>
<p>И проблема в том, что при первом запуске скрипт работает как задумано - создает бекап в папку current, создает папку increment  с текущем числом, в которой лежат пустые папки из виндовс шары, но стоит либо скрипт запустить повторно, либо по крону настроить автоматический запуск, как начинается какая то муть - каждый четный запуск скрипта (2,4,6 и т.д.) приводит к тому, что все, что лежит в папке Current копируется в текущий increment и удалется. То есть 50 гектар бекапа полностью перетекают в increment, после чего папка Current становиться пустой. Каждый нечетный запуск скрипта (1,3,5 и т.д.) сохраняет данные виндовс шары в папку current, то есть все как задумывалось работает. Опыта к сожалению мало, мануалы почитал, но то ли лыжи не едут, то ли одно из двух %) Подскажите в чем может быть пробелма? Или хотя бы куда копать?</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-534" data-commentid="534" data-postid="984" data-belowelement="comment-534" data-respondelement="respond" data-replyto="Комментарий к записи Виктор" aria-label="Комментарий к записи Виктор">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-535">
<div class="comment byuser comment-author-zerox bypostauthor even depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-535">	28.11.2016 в 17:28</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Судя по тому, что данные из current улетают в increment, во время бэкапа папка с данными не подмонтирована, либо она по какой-то причине пустая. Rsync считает, что в папке пусто и все, что было ранее, перемещает в папку increment. Это его нормальное поведение при пустом источнике файлов. Копай в эту сторону.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-535" data-commentid="535" data-postid="984" data-belowelement="comment-535" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-541">
<div class="comment odd alt depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Виктор</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-541">	28.11.2016 в 20:37</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Спасибо за совет. Буду смотреть, что да как монтируется.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-541" data-commentid="541" data-postid="984" data-belowelement="comment-541" data-respondelement="respond" data-replyto="Комментарий к записи Виктор" aria-label="Комментарий к записи Виктор">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-951">
<div class="comment even depth-4 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Виктор</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-951">	31.01.2017 в 15:26</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Все, докопался: бэкапил два ноутбука и из-за того, что они в любой момент могут быть как выключены, так и просто унесены из дома на работу/учебу/etc, то и получалось, что скрипт пытался монтировать папки с данными, которых не было в сети, а rsync  уже бэкапил пустые директории. Решил проблему следующим костылем %): создал в директориях для бэкапа файлы, типо frbckp.txt, и в скрипт добавил проверку наличия этих файлов. Если проверка не проходит, значит шара не подмонтирована и Rsync не запускается. Вот кусок скрипта:</p>
<p>#монтируем виндовс ресурс, кторый хотим сохранить<br>
mount -t cifs //192.168.0.100/Doks /mnt/Doks -o user=user,password=password<br>
#проверяем смонтировалось или нет<br>
if  test -e /mnt/Doks/frbckp.txt<br>
#если да, то начинаем бэкап<br>
then echo  "Сохранение данных успешно : " &gt;&gt; /windows/log.txt<br>
date &gt;&gt; /windows/log.txt<br>
.......<br>
#если нет, то ничего не делаем<br>
else echo  "Облом, компа нет в сети, не сохранилось: " &gt;&gt; /windows/log.txt<br>
date &gt;&gt; /windows/log.txt<br>
fi<br>
Вдруг кто на те же грабли наступит.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-951" data-commentid="951" data-postid="984" data-belowelement="comment-951" data-respondelement="respond" data-replyto="Комментарий к записи Виктор" aria-label="Комментарий к записи Виктор">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-957">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-5 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-957">	31.01.2017 в 18:13</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Да, костыль нормальный :) Более правильно конечно проверять сам факт, что нужный ресурс смонтирован. Я на самом деле так и делаю, тут старая версия, не отражено это. Здесь я все-таки более универсальный подход привел, без привязки к точкам монтирования. Они могут быть разными.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-957" data-commentid="957" data-postid="984" data-belowelement="comment-957" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
<li id="comment-238">
<div class="comment even thread-odd thread-alt depth-1 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Pngn</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-238">	17.09.2015 в 12:35</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Добрый день. Настраивал rsync в ubuntu server 14.04 по Вашей инструкции.</p>
<p>Монтирование шары винды сработало только так:<br>
mount cifs //192.168.0.1/data /mnt/data -o user=user,pass=123,iocharset=utf8,rw,dir_mode=0777,file_mode=0777</p>
<p>Скрипт сработал только так:<br>
#!/bin/bash<br>
date<br>
# Папка, куда будем складывать архивы<br>
syst_dir=/backup/<br>
# Имя сервера, который архивируем<br>
srv_name=server1<br>
# Адрес сервера, который архивируем<br>
srv_ip=127.0.0.1<br>
# Пользователь rsync на сервере, который архивируем<br>
srv_user=backup<br>
# Ресурс на сервере для бэкапа<br>
srv_dir=/mnt/data<br>
echo "Start backup ${srv_name}"<br>
# Создаем папку для инкрементных бэкапов<br>
mkdir -p ${syst_dir}${srv_name}/increment/<br>
# Запускаем непосредственно бэкап с параметрами<br>
/usr/bin/rsync -a --delete /mnt/data ${syst_dir}${srv_name}/current/ --backup --backup-dir=${syst_dir}${srv_name}/increment/`date +%Y-%m-%d`/<br>
# Чистим папки с инкрементными архивами старше 30-ти дней<br>
/usr/bin/find ${syst_dir}${srv_name}/increment/ -maxdepth 1 -type d -mtime +30 -exec rm -rf {} \;<br>
date<br>
echo "Finish backup ${srv_name}"</p>
<p>Может кому пригодится)</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-238" data-commentid="238" data-postid="984" data-belowelement="comment-238" data-respondelement="respond" data-replyto="Комментарий к записи Pngn" aria-label="Комментарий к записи Pngn">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-239">
<div class="comment byuser comment-author-zerox bypostauthor odd alt depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-239">	17.09.2015 в 12:40</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Спасибо за комментарий, кому-то может пригодиться. Изменения не принципиальные, просто чуть другие параметры. Я все делал на Debian, когда писал. В каких-то мелочах могут быть отличия от Ubuntu.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-239" data-commentid="239" data-postid="984" data-belowelement="comment-239" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
<li id="comment-240">
<div class="comment byuser comment-author-zerox bypostauthor even depth-2 comment-wrap">
<div class="comment-avatar">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-65 photo " height="65" width="65">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Zerox</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-240">	17.09.2015 в 12:41</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>А в целом получилось бэкап настроить? Мне нравится такая схема, я часто ее использую. Быстро, бесплатно и эффективно.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-240" data-commentid="240" data-postid="984" data-belowelement="comment-240" data-respondelement="respond" data-replyto="Комментарий к записи Zerox" aria-label="Комментарий к записи Zerox">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
<ul class="children">
<li id="comment-241">
<div class="comment odd alt depth-3 comment-wrap">
<div class="comment-avatar">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-65 photo" height="65" width="65" loading="lazy" decoding="async" data-pin-nopin="nopin">
</div>
<div class="comment-content">
<div class="author-comment">
<cite class="fn">Pngn</cite> 				
<div class="comment-meta commentmetadata">
<a href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-241">	17.09.2015 в 12:45</a>
</div>
<!-- .comment-meta .commentmetadata -->
<div class="clear">
</div>
</div>
<p>Да, всё заработало, спасибо.<br>
Друг рассказывал про синк, но добрался я до него через пол года, действительно удобно.</p>
</div>
<div class="reply">
<a rel="nofollow" class="comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#comment-241" data-commentid="241" data-postid="984" data-belowelement="comment-241" data-respondelement="respond" data-replyto="Комментарий к записи Pngn" aria-label="Комментарий к записи Pngn">Ответить</a>
</div>
<!-- .reply -->
</div>
<!-- #comment-##  -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ul>
<!-- .children -->
</li>
<!-- #comment-## -->
</ol>
</div>
</div>
<!-- #comments-box -->
<div class="clear">
</div>
<div id="respond" class="comment-respond">
<h3 id="reply-title" class="comment-reply-title">Добавить комментарий <small>
<a rel="nofollow" id="cancel-comment-reply-link" href="https://serveradmin.ru/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/#respond" style="display:none;">Отменить ответ</a>
</small>
</h3>
<div class="stripe-line">
</div>
<form action="https://serveradmin.ru/wp-comments-post.php" method="post" id="commentform" class="comment-form" novalidate="">
<p class="comment-notes">
<span id="email-notes">Ваш адрес email не будет опубликован.</span> <span class="required-field-message">Обязательные поля помечены <span class="required">*</span>
</span>
</p>
<p class="comment-form-comment">
<label for="comment">Комментарий <span class="required">*</span>
</label> <textarea id="comment" name="comment" cols="45" rows="8" maxlength="65525" required="">
</textarea>
</p>
<p class="comment-form-author">
<label for="author">Имя</label> <input id="author" name="author" type="text" value="" size="30" maxlength="245" autocomplete="name">
</p>
<p class="comment-form-email">
<label for="email">Email</label> <input id="email" name="email" type="email" value="" size="30" maxlength="100" aria-describedby="email-notes" autocomplete="email">
</p>
<p class="comment-form-url">
<label for="url">Сайт</label> <input id="url" name="url" type="url" value="" size="30" maxlength="200" autocomplete="url">
</p>
<p class="form-submit">
<input name="submit" type="submit" id="submit" class="submit" value="Отправить комментарий"> <input type="hidden" name="comment_post_ID" value="984" id="comment_post_ID">
<input type="hidden" name="comment_parent" id="comment_parent" value="0">
</p>Нажимая кнопку "<strong>Отправить комментарий</strong>" Я даю <a href="https://serveradmin.ru/politika-konfidentsialnosti/" target="_blank" rel="noopener">
<u>согласие на обработку персональных данных</u>
</a>.</form>	</div>
<!-- #respond -->
</div>
<!-- #comments -->
</div>
<!-- .content -->
<aside id="sidebar" style="position: relative; overflow: visible; box-sizing: border-box; min-height: 1px;">
<div class="theiaStickySidebar" style="padding-top: 1px; padding-bottom: 1px; position: static; top: 0px; left: 999.5px;">
<div id="text-html-widget-26" class="text-html-box">
<div class="ca-ca ca-ca-default ca-ca-5">
<div class="" data-ai-debug1="5">
<!-- Yandex.RTB R-A-184428-3 -->
<div id="yandex_rtb_R-A-184428-3">
</div>
<script>window.yaContextCb.push(()=>{
Ya.Context.AdvManager.render({
renderTo: 'yandex_rtb_R-A-184428-3',
blockId: 'R-A-184428-3'
})
})</script>
</div>
<div class="" style="visibility: hidden; display: none;" data-ai-tracking="WzAsMiwi0JHQsNC90L3QtdGAIDIgYWRibG9jayIsImt1cnNpLXBvLWl0IiwwXQ==" data-ai-debug1="5 <= 6">
<a href="https://serveradmin.ru/mtcna-online" target="_blank" rel="noopener">
<img class="aligncenter" src="https://serveradmin.ru/wp-content/uploads/2022/04/mikrotik-sensei-006.jpg" alt="" width="250" height="417">
</a>
</div>
</div>
</div>
<div id="text-html-widget-30" class="widget text-html">
<div class="widget-top">
<h4> </h4>
<div class="stripe-line">
</div>
</div>
<div class="widget-container">
<div style="text-align:center;">
<style>
A.dot {
text-decoration: underline;
}
</style>
<table cellpadding="5">
<tbody>
<tr>
<td width="120">
<a href="https://www.reg.ru/dedicated/" target="_blank" rel="noopener">
<img class="size-full wp-image-9399 aligncenter" src="https://serveradmin.ru/wp-content/uploads/2021/08/regru-logo-color-4-1.png" alt="glladf6" width="120" height="75">
</a>
</td>
<td style="padding-left: 8px;" align="left">
<a href="https://www.reg.ru/dedicated/" class="dot" target="_blank" rel="noopener">Аренда сервера</a> - от дешёвых до топовых, с индивидуальным сопровождением и заботливой поддержкой. REG.ru</td>
</tr>
</tbody>
</table>
</div>
<div class="clear">
</div>
</div>
</div>
<!-- .widget /-->
<div id="text-html-widget-33" class="widget text-html">
<div class="widget-top">
<h4> </h4>
<div class="stripe-line">
</div>
</div>
<div class="widget-container">
<div style="text-align:center;">
<table cellpadding="5">
<tbody>
<tr>
<td width="120">
<a href="https://t.me/mikrotik_sensei" target="_blank" rel="noopener">
<img class="size-full wp-image-9399 aligncenter" src="https://serveradmin.ru/wp-content/uploads/2022/02/mikrot_shirt.png" alt="mikrotik_sensei" width="120" height="75">
</a>
</td>
<td style="padding-left: 8px;" align="left">
<img class="alignnone size-full wp-image-5973" src="https://serveradmin.ru/wp-content/uploads/2017/11/telegram.png" alt="" width="16" height="16" data-wp-pid="5973">  <a class="dot" href="https://t.me/mikrotik_sensei" target="_blank" rel="noopener">Telegram-канал</a> "MikroTik сэнсэй". Узнайте то, чего нет в мануалах.</td>
</tr>
</tbody>
</table>
</div>
<div class="clear">
</div>
</div>
</div>
<!-- .widget /-->
<div id="text-html-widget-8" class="widget text-html">
<div class="widget-top">
<h4> </h4>
<div class="stripe-line">
</div>
</div>
<div class="widget-container">
<div style="text-align:center;">
<table cellpadding="5">
<tbody>
<tr>
<td width="120">
<a href="https://serveradmin.ru/lklTref4" target="_blank">
<img class="size-full wp-image-9399 aligncenter" src="https://serveradmin.ru/wp-content/uploads/2021/02/dtyp45cvfs.png" alt="glladf6" width="120" height="60">
</a>
</td>
<td style="padding-left: 8px;" align="left">
<a href="https://serveradmin.ru/lklTref4" class="dot" rel="noopener" target="_blank">Дешевые дедики</a> от Selectel, есть посуточная оплата. Использую сам.</td>
</tr>
</tbody>
</table>
</div>
<div class="clear">
</div>
</div>
</div>
<!-- .widget /-->
<div id="text-html-widget-25" class="widget text-html">
<div class="widget-top">
<h4>Ссылки</h4>
<div class="stripe-line">
</div>
</div>
<div class="widget-container">
<div>	<table border="1" cellpadding="1" cellspacing="1">
<tbody>
<tr>
<td class="vk-border" style="width: 30px; height: 30px;">
<a href="https://serveradmin.ru/telegram-header" target="_blank">
<img class="size-full wp-image-5973 aligncenter" src="https://serveradmin.ru/wp-content/uploads/2017/11/telegram.png" alt="Telegram канал" width="16" height="16">
</a>
<a href="https://www.youtube.com/user/zeroxzed/" target="_blank">
</a>
</td>
<td class="vk-border" align="left" style="height: 14px;">
<span style="width: 320px; height: 24px;">
<strong>TG канал</strong>: <a href="https://serveradmin.ru/telegram-header" target="_blank" rel="noopener">
<u>t.me/srv_admin</u>
</a>
</span>
</td>
</tr>
<tr>
<td style="height: 30px;">
<a href="https://www.youtube.com/user/zeroxzed/" target="_blank">
<img class="size-full wp-image-5972 aligncenter" src="https://serveradmin.ru/wp-content/uploads/2018/12/youtube.png" alt="Youtube канал" width="16" height="16">
</a>
</td>
<td align="left" style="width: 320px; height: 24px;">
<span style="height: 14px;">Youtube канал: <a href="https://www.youtube.com/user/zeroxzed/" target="_blank">
<u>youtube.com/user/zeroxzed</u>
</a>
</span>
</td>
</tr>
</tbody>
</table>
</div>
<div class="clear">
</div>
</div>
</div>
<!-- .widget /-->		
<div id="text-html-widget-24" class="text-html-box">
</div>
<div id="text-html-widget-13" class="widget text-html">
<div class="widget-top">
<h4>Группа Вконтакте</h4>
<div class="stripe-line">
</div>
</div>
<div class="widget-container">
<div style="text-align:center;">
<style type="text/css">
color: #656565;
padding: 6px;
}
.vk3 {
margin-top: 0;
text-align: center;
margin-left: auto;
margin-right: auto;
}
.tabl-vk {
padding: 6px;
box-shadow: 0 0 0 1px rgba(4,47,89,.12) inset;
border-radius: 3px;
border-top-left-radius: 3px;
border-top-right-radius: 3px;
border-bottom-right-radius: 3px;
border-bottom-left-radius: 3px;
margin: auto;
}
.vk-link {
color: #2b598c;
font-size: 13px;
font-weight: 700;
}
.vk-pic {
border-radius: 50%;
}
.vk-border {
border-bottom: 1px solid #e7e8ec;
}
</style>
<table width="100%" border="0" class="tabl-vk">
<tbody>
<tr>
<td class="vk-border">
<table width="100%" border="0" align="right" class="vk3">
<tbody>
<tr>
<td width="60" align="left">
<a href="https://vk.com/serv_adm" target="_blank" alt="Группа Вконтакте Системное администрирование">
<img src="https://serveradmin.ru/wp-content/uploads/2018/02/srvadmin.jpg" width="50" height="50" class="vk-pic">
</a>
</td>
<td width="212" align="left">
<a href="https://vk.com/serv_adm" target="_blank" class="vk-link">Системное администрирование</a>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
<tr>
<td align="center">
<a href="https://vk.com/serv_adm" target="_blank" alt="Группа Вконтакте Системное администрирование">
<img src="https://serveradmin.ru/wp-content/uploads/2018/02/vk.png" alt="" width="328" height="32" class="vk-link">
</a>
</td>
</tr>
</tbody>
</table>
</div>
<div class="clear">
</div>
</div>
</div>
<!-- .widget /-->
<div id="posts-list-widget-2" class="widget posts-list">
<div class="widget-top">
<h4>Популярное		</h4>
<div class="stripe-line">
</div>
</div>
<div class="widget-container">				<ul>
<li>
<div class="post-thumbnail">
<a href="https://serveradmin.ru/bazovaya-nastroyka-routera-mikrotik/" title="Как настроить микротик routerboard RB951G-2HnD" rel="bookmark">
<img width="110" height="75" src="https://serveradmin.ru/wp-content/uploads/2015/12/mikrotik-settings-110x75.png" class="attachment-tie-small size-tie-small wp-post-image" alt="" decoding="async" loading="lazy" data-wp-pid="2525">
<span class="fa overlay-icon">
</span>
</a>
</div>
<!-- post-thumbnail /-->
<h3>
<a href="https://serveradmin.ru/bazovaya-nastroyka-routera-mikrotik/">Как настроить микротик routerboard RB951G-2HnD</a>
</h3>
<span class="tie-date">
<i class="fa fa-clock-o">
</i>Написано: 21.11.2018</span>									<span class="post-views-widget">
<span class="post-views">
<i class="fa fa-eye">
</i>1,281,096 </span> </span>
</li>
<li>
<div class="post-thumbnail">
<a href="https://serveradmin.ru/nastroyka-seti-v-centos/" title="Сетевые настройки в CentOS 8, 7" rel="bookmark">
<img width="110" height="75" src="https://serveradmin.ru/wp-content/uploads/2015/08/centos-network-configure-110x75.png" class="attachment-tie-small size-tie-small wp-post-image" alt="" decoding="async" loading="lazy" data-wp-pid="10130">
<span class="fa overlay-icon">
</span>
</a>
</div>
<!-- post-thumbnail /-->
<h3>
<a href="https://serveradmin.ru/nastroyka-seti-v-centos/">Сетевые настройки в CentOS 8, 7</a>
</h3>
<span class="tie-date">
<i class="fa fa-clock-o">
</i>Написано: 17.10.2019</span>									<span class="post-views-widget">
<span class="post-views">
<i class="fa fa-eye">
</i>815,908 </span> </span>
</li>
<li>
<div class="post-thumbnail">
<a href="https://serveradmin.ru/centos-nastroyka-servera/" title="CentOS 7 и 8 настройка сервера после установки" rel="bookmark">
<img width="110" height="75" src="https://serveradmin.ru/wp-content/uploads/2019/10/centos-configure-110x75.png" class="attachment-tie-small size-tie-small wp-post-image" alt="Настройка CentOS" decoding="async" loading="lazy" data-wp-pid="9958">
<span class="fa overlay-icon">
</span>
</a>
</div>
<!-- post-thumbnail /-->
<h3>
<a href="https://serveradmin.ru/centos-nastroyka-servera/">CentOS 7 и 8 настройка сервера после установки</a>
</h3>
<span class="tie-date">
<i class="fa fa-clock-o">
</i>Написано: 05.10.2019</span>									<span class="post-views-widget">
<span class="post-views">
<i class="fa fa-eye">
</i>768,135 </span> </span>
</li>
<li>
<div class="post-thumbnail">
<a href="https://serveradmin.ru/nastroyka-servera-telefonii-asterisk-s-nulya/" title="Asterisk - SIP АТС для офиса, пошаговая инструкция по настройке с нуля" rel="bookmark">
<img width="110" height="75" src="https://serveradmin.ru/wp-content/uploads/2020/03/asterisk-nastroyka-110x75.png" class="attachment-tie-small size-tie-small wp-post-image" alt="" decoding="async" loading="lazy" data-wp-pid="11011">
<span class="fa overlay-icon">
</span>
</a>
</div>
<!-- post-thumbnail /-->
<h3>
<a href="https://serveradmin.ru/nastroyka-servera-telefonii-asterisk-s-nulya/">Asterisk - SIP АТС для офиса, пошаговая инструкция по настройке с нуля</a>
</h3>
<span class="tie-date">
<i class="fa fa-clock-o">
</i>Написано: 03.03.2020</span>									<span class="post-views-widget">
<span class="post-views">
<i class="fa fa-eye">
</i>621,675 </span> </span>
</li>
<li>
<div class="post-thumbnail">
<a href="https://serveradmin.ru/perenos-konteynerov-zakryityih-klyuchey-i-sertifikatov-cryptopro/" title="Перенос контейнеров закрытых ключей и сертификатов CryptoPro" rel="bookmark">
<img width="110" height="75" src="https://serveradmin.ru/wp-content/uploads/2018/04/perenos-sertificatov-110x75.png" class="attachment-tie-small size-tie-small wp-post-image" alt="" decoding="async" loading="lazy" data-wp-pid="6414">
<span class="fa overlay-icon">
</span>
</a>
</div>
<!-- post-thumbnail /-->
<h3>
<a href="https://serveradmin.ru/perenos-konteynerov-zakryityih-klyuchey-i-sertifikatov-cryptopro/">Перенос контейнеров закрытых ключей и сертификатов CryptoPro</a>
</h3>
<span class="tie-date">
<i class="fa fa-clock-o">
</i>Написано: 25.03.2021</span>									<span class="post-views-widget">
<span class="post-views">
<i class="fa fa-eye">
</i>566,994 </span> </span>
</li>
</ul>
<div class="clear">
</div>
</div>
</div>
<!-- .widget /-->
<div id="text-html-widget-18" class="widget text-html">
<div class="widget-top">
<h4>Прикольная игра</h4>
<div class="stripe-line">
</div>
</div>
<div class="widget-container">
<div>
<a href="https://serveradmin.ru/igra-sistemnyiy-administrator/" alt="Игра системный администратор">
<img class="aligncenter wp-image-2248 size-full" title="Симулятор системного администратора" src="https://serveradmin.ru/wp-content/uploads/2015/10/sysadmin-game.png" alt="Игра Системный администратор" width="330" height="245">
</a>
</div>
<div class="clear">
</div>
</div>
</div>
<!-- .widget /-->
<div id="text-html-widget-6" class="widget text-html">
<div class="widget-top">
<h4>
<a href="https://serveradmin.ru/igra-sistemnyiy-administrator/" alt="Игра системный администратор"> </a>
</h4>
<div class="stripe-line">
</div>
</div>
<a href="https://serveradmin.ru/igra-sistemnyiy-administrator/" alt="Игра системный администратор">
</a>
<div class="widget-container">
<a href="https://serveradmin.ru/igra-sistemnyiy-administrator/" alt="Игра системный администратор">
</a>
<div>
<a href="https://serveradmin.ru/igra-sistemnyiy-administrator/" alt="Игра системный администратор">
</a>
<div class="ca-ca ca-ca-center ca-ca-4">
<a href="https://serveradmin.ru/igra-sistemnyiy-administrator/" alt="Игра системный администратор">
</a>
<a href="https://serveradmin.ru/devsecops-pic" target="_blank" rel="noopener">
<img class="aligncenter" src="https://serveradmin.ru/wp-content/uploads/2023/01/devsecops_03.jpg" alt="" width="299" height="601">
</a>
</div>
</div>
<div class="clear">
</div>
</div>
</div>
<!-- .widget /-->	</div>
<!-- .theiaStickySidebar /-->
</aside>
<!-- #sidebar /-->
<div class="clear">
</div>
</div>
<!-- .container /-->
<footer id="theme-footer">
<div id="footer-widget-area" class="footer-3c">
<div id="footer-first" class="footer-widgets-box">
<div id="login-widget-2" class="footer-widget login-widget">
<div class="footer-widget-top">
<h4>Вход/Регистрация</h4>
</div>
<div class="footer-widget-container">	
<div id="login-form">
<form name="loginform" id="loginform" action="https://serveradmin.ru/wp-login.php" method="post">
<p id="log-username">
<input type="text" name="log" id="log" title="Username" value="Username" onfocus="if (this.value == 'Username') {this.value = '';}" onblur="if (this.value == '') {this.value = 'Username';}" size="33">
</p>
<p id="log-pass">
<input type="password" name="pwd" id="pwd" title="Password" value="Password" onfocus="if (this.value == 'Password') {this.value = '';}" onblur="if (this.value == '') {this.value = 'Password';}" size="33">
</p>
<input type="submit" name="submit" value="Log in" class="login-button">
<label for="rememberme">
<input name="rememberme" id="rememberme" type="checkbox" checked="checked" value="forever"> Remember Me</label>
<input type="hidden" name="redirect_to" value="/rsync-nastroyka-bekapa-na-centos-debian-ubuntu/">
</form>
<ul class="login-links">
<li>
<a rel="nofollow" href="https://serveradmin.ru/wp-login.php?action=register">Регистрация</a>
</li>				<li>
<a href="https://serveradmin.ru/wp-login.php?action=lostpassword&amp;redirect_to=https%3A%2F%2Fserveradmin.ru">Lost your password?</a>
</li>
</ul>
</div>
</div>
</div>
<!-- .widget /-->
<div id="text-2" class="footer-widget widget_text">
<div class="footer-widget-top">
<h4>Статистика</h4>
</div>
<div class="footer-widget-container">		
<div class="textwidget">
<!-- Yandex.Metrika informer -->
<a href="https://metrika.yandex.ru/stat/?id=23506456&amp;from=informer" target="_blank" rel="nofollow noopener">
<img src="https://informer.yandex.ru/informer/23506456/3_0_FFD386FF_FFB366FF_0_pageviews" style="width:88px; height:31px; border:0;" alt="Яндекс.Метрика" title="Яндекс.Метрика: данные за сегодня (просмотры, визиты и уникальные посетители)" class="ym-advanced-informer" data-cid="23506456" data-lang="ru">
</a>
<!-- /Yandex.Metrika informer -->
</div>
</div>
</div>
<!-- .widget /-->
<div id="text-html-widget-23" class="footer-widget text-html">
<div class="footer-widget-top">
<h4>Соглашение</h4>
</div>
<div class="footer-widget-container">
<div>
<a href="https://serveradmin.ru/politika-konfidentsialnosti/" target="_blank" rel="noopener">Политика конфиденциальности</a>
</div>
<div class="clear">
</div>
</div>
</div>
<!-- .widget /-->		</div>
<div id="footer-second" class="footer-widgets-box">
<div id="posts-list-widget-3" class="footer-widget posts-list">
<div class="footer-widget-top">
<h4>Свежие записи		</h4>
</div>
<div class="footer-widget-container">				<ul>
<li>
<div class="post-thumbnail">
<a href="https://serveradmin.ru/nastroyka-opoveshheniy-zabbix-v-telegram/" rel="bookmark">
<img width="110" height="75" src="https://serveradmin.ru/wp-content/uploads/2020/08/zabbix-telegram-messages-110x75.png" class="attachment-tie-small size-tie-small wp-post-image" alt="" decoding="async" loading="lazy" data-wp-pid="12367">
<span class="fa overlay-icon">
</span>
</a>
</div>
<!-- post-thumbnail /-->
<h3>
<a href="https://serveradmin.ru/nastroyka-opoveshheniy-zabbix-v-telegram/">Отправка уведомлений и графиков из zabbix в telegram</a>
</h3>
<span class="tie-date">
<i class="fa fa-clock-o">
</i>Написано: 25.01.2023</span>		</li>
<li>
<div class="post-thumbnail">
<a href="https://serveradmin.ru/imapsync-perenos-pochtovyh-yashhikov-imap/" rel="bookmark">
<img width="110" height="75" src="https://serveradmin.ru/wp-content/uploads/2023/01/imapsync-110x75.jpg" class="attachment-tie-small size-tie-small wp-post-image" alt="" decoding="async" loading="lazy" data-wp-pid="15163">
<span class="fa overlay-icon">
</span>
</a>
</div>
<!-- post-thumbnail /-->
<h3>
<a href="https://serveradmin.ru/imapsync-perenos-pochtovyh-yashhikov-imap/">imapsync — перенос почтовых ящиков imap</a>
</h3>
<span class="tie-date">
<i class="fa fa-clock-o">
</i>Написано: 23.01.2023</span>		</li>
<li>
<div class="post-thumbnail">
<a href="https://serveradmin.ru/roxy-wi-veb-interfejs-dlya-upravleniya-haproxy/" rel="bookmark">
<img width="110" height="75" src="https://serveradmin.ru/wp-content/uploads/2023/01/roxy-wi-110x75.jpg" class="attachment-tie-small size-tie-small wp-post-image" alt="Roxy-WI" decoding="async" loading="lazy" data-wp-pid="15156">
<span class="fa overlay-icon">
</span>
</a>
</div>
<!-- post-thumbnail /-->
<h3>
<a href="https://serveradmin.ru/roxy-wi-veb-interfejs-dlya-upravleniya-haproxy/">Roxy-WI — веб-интерфейс для управления HAProxy</a>
</h3>
<span class="tie-date">
<i class="fa fa-clock-o">
</i>Написано: 17.01.2023</span>		</li>
<li>
<div class="post-thumbnail">
<a href="https://serveradmin.ru/hostery-lichnaya-rekomendacziya/" rel="bookmark">
<img width="110" height="75" src="https://serveradmin.ru/wp-content/uploads/2020/02/recommended-hosters-110x75.png" class="attachment-tie-small size-tie-small wp-post-image" alt="Хостеры" decoding="async" loading="lazy" data-wp-pid="10774">
<span class="fa overlay-icon">
</span>
</a>
</div>
<!-- post-thumbnail /-->
<h3>
<a href="https://serveradmin.ru/hostery-lichnaya-rekomendacziya/">Хостеры, личная рекомендация</a>
</h3>
<span class="tie-date">
<i class="fa fa-clock-o">
</i>Написано: 15.01.2023</span>		</li>
<li>
<div class="post-thumbnail">
<a href="https://serveradmin.ru/grafana-oncall-czentralizovannoe-upravlenie-opoveshheniyami-ot-monitoringa/" rel="bookmark">
<img width="110" height="75" src="https://serveradmin.ru/wp-content/uploads/2023/01/grafana-oncall-110x75.jpg" class="attachment-tie-small size-tie-small wp-post-image" alt="Grafana OnCall" decoding="async" loading="lazy" data-wp-pid="15126">
<span class="fa overlay-icon">
</span>
</a>
</div>
<!-- post-thumbnail /-->
<h3>
<a href="https://serveradmin.ru/grafana-oncall-czentralizovannoe-upravlenie-opoveshheniyami-ot-monitoringa/">Grafana OnCall - централизованное управление оповещениями от мониторинга</a>
</h3>
<span class="tie-date">
<i class="fa fa-clock-o">
</i>Написано: 13.01.2023</span>		</li>
</ul>
<div class="clear">
</div>
</div>
</div>
<!-- .widget /-->		</div>
<!-- #second .widget-area -->
<div id="footer-third" class="footer-widgets-box">
<div id="comments_avatar-widget-2" class="footer-widget comments-avatar">
<div class="footer-widget-top">
<h4>Комментарии		</h4>
</div>
<div class="footer-widget-container">			<ul>
<li>
<div class="post-thumbnail" style="width:55px">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-55 photo " height="55" width="55">		</div>
<a href="https://serveradmin.ru/nastroyka-opoveshheniy-zabbix-v-telegram/#comment-20540">
Zerox: Для этого можно использовать макрос {EVENT.OPDATA}. Если не ошибаюсь, именно в н... </a>
</li>
<li>
<div class="post-thumbnail" style="width:55px">
<img data-del="avatar" src="https://serveradmin.ru/wp-content/uploads/2020/11/dsc5287_-150x150.jpg" class="avatar pp-user-avatar avatar-55 photo " height="55" width="55">		</div>
<a href="https://serveradmin.ru/nastrojka-postfix-dovecot-postfixadmin-roundcube-dkim-na-debian/#comment-20539">
Zerox: Суть ошибки ясна. Ключевое тут: unknown ca. Дело не с авторизацией. У вас исполь... </a>
</li>
<li>
<div class="post-thumbnail" style="width:55px">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-55 photo" height="55" width="55" loading="lazy" decoding="async" data-pin-nopin="nopin">		</div>
<a href="https://serveradmin.ru/nastroyka-opoveshheniy-zabbix-v-telegram/#comment-20538">
: last(/VM Webserver/system.users.num)&gt;1 Просто используй конструктор выражений... </a>
</li>
<li>
<div class="post-thumbnail" style="width:55px">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-55 photo" height="55" width="55" loading="lazy" decoding="async" data-pin-nopin="nopin">		</div>
<a href="https://serveradmin.ru/nastrojka-postfix-dovecot-postfixadmin-roundcube-dkim-na-debian/#comment-20537">
Андрей: Добрый вечер. Столкнулся с любопытной проблемой. При проверки отправки писем из... </a>
</li>
<li>
<div class="post-thumbnail" style="width:55px">
<img alt="" src="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png" srcset="https://serveradmin.ru/wp-content/uploads/2020/02/sysadmin2-150x150.png 2x" class="avatar avatar-55 photo" height="55" width="55" loading="lazy" decoding="async" data-pin-nopin="nopin">		</div>
<a href="https://serveradmin.ru/konvertatsiya-diskov-qcow2-lvm-v-kvm-proxmox/#comment-20536">
Константин: Как сделать обратную операцию? Конвертировать том zfs в файл qcow2?... </a>
</li>
</ul>
</div>
</div>
<!-- .widget /-->		</div>
<!-- #third .widget-area -->
</div>
<!-- #footer-widget-area -->
<div class="clear">
</div>
</footer>
<!-- .Footer /-->
<div class="clear">
</div>
<div class="footer-bottom">
<div class="container">
<div class="alignright">
</div>
<div class="alignleft">
</div>
<div class="clear">
</div>
</div>
<!-- .Container -->
</div>
<!-- .Footer bottom -->
</div>
<!-- .inner-Wrapper -->
</div>
<!-- #Wrapper -->
</div>
<!-- .Wrapper-outer -->
<div id="topcontrol" class="fa fa-angle-up" title="Scroll To Top" style="bottom: -100px;">
</div>
<div id="fb-root">
</div>
<div id="reading-position-indicator" style="width: 0%;">
</div>
<!-- Yandex.Metrika counter -->
<script type="text/javascript">
(function (d, w, c) {
(w[c] = w[c] || []).push(function() {
try {
w.yaCounter23506456 = new Ya.Metrika({
id:23506456,
clickmap:true,
trackLinks:true,
accurateTrackBounce:true,
webvisor:true
});
} catch(e) { }
});
var n = d.getElementsByTagName("script")[0],
s = d.createElement("script"),
f = function () { n.parentNode.insertBefore(s, n); };
s.type = "text/javascript";
s.async = true;
s.src = "https://serveradmin.ru/watch.js";
if (w.opera == "[object Opera]") {
d.addEventListener("DOMContentLoaded", f, false);
} else { f(); }
})(document, window, "yandex_metrika_callbacks");
</script>
<noscript>
<div>
<img src="https://mc.yandex.ru/watch/23506456" style="position:absolute; left:-9999px;" alt="" />
</div>
</noscript>
<!-- /Yandex.Metrika counter -->      <style>
.njt-nofi-notification-bar .njt-nofi-hide-button {
display: none;
}
.njt-nofi-notification-bar .njt-nofi-content {
font-size : 15px;
}
/* body{
padding-top: 49px;
} */
</style>
<div class="njt-nofi-container-content">
<div class="njt-nofi-container" style="position: fixed; top: 0px;">
<div class="njt-nofi-notification-bar njt-nofi-bgcolor-notification" style="background:#ef5451">
<div class="njt-nofi-content njt-nofi-text-color njt-nofi-align-content njt-nofi-content-deskop " style="max-width: 100%; justify-content: center; color: rgb(250, 250, 250);">
<div class="njt-nofi-text njt-nofi-padding-text">Используешь Telegram? Подпишись на канал автора →</div>
<div class="njt-nofi-button njt-nofi-padding-text " style="">
<a target="_blank" href="https://serveradmin.ru/telegram-header" class="njt-nofi-button-text njt-nofi-padding-text" style="background: rgb(255, 167, 38); border-radius: 3px; color: rgb(255, 255, 255);">посмотреть</a>
</div>
</div>
<div class="njt-nofi-content njt-nofi-text-color njt-nofi-align-content njt-display-none njt-nofi-content-mobile " style="max-width: 100%; justify-content: center; color: rgb(250, 250, 250);">
<div class="njt-nofi-text njt-nofi-padding-text">This is default text for notification bar</div>
<div class="njt-nofi-button njt-nofi-padding-text " style="">
<a target="_blank" href="" class="njt-nofi-button-text njt-nofi-padding-text" style="background: rgb(255, 167, 38); border-radius: 3px; color: rgb(255, 255, 255);">Learn more</a>
</div>
</div>
<a href="javascript:void(0)" class="njt-nofi-toggle-button njt-nofi-hide njt-nofi-text-color njt-nofi-hide-admin-custom" style="display: none; color: rgb(250, 250, 250);">
<span>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs" version="1.1" width="512" height="512" x="0" y="0" viewBox="0 0 386.667 386.667" style="enable-background:new 0 0 512 512" xml:space="preserve" class="njt-nofi-close-icon">
<g>
<path xmlns="http://www.w3.org/2000/svg" d="m386.667 45.564-45.564-45.564-147.77 147.769-147.769-147.769-45.564 45.564 147.769 147.769-147.769 147.77 45.564 45.564 147.769-147.769 147.769 147.769 45.564-45.564-147.768-147.77z" fill="#ffffff" data-original="#000000" style="" class="">
</path>
</g>
</svg>
</span>
</a>
<a href="javascript:void(0)" class="njt-nofi-close-button njt-nofi-hide njt-nofi-text-color njt-nofi-hide-admin-custom" style="display: block; color: rgb(250, 250, 250);">
<span>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs" version="1.1" width="512" height="512" x="0" y="0" viewBox="0 0 386.667 386.667" style="enable-background:new 0 0 512 512" xml:space="preserve" class="njt-nofi-close-icon">
<g>
<path xmlns="http://www.w3.org/2000/svg" d="m386.667 45.564-45.564-45.564-147.77 147.769-147.769-147.769-45.564 45.564 147.769 147.769-147.769 147.77 45.564 45.564 147.769-147.769 147.769 147.769 45.564-45.564-147.768-147.77z" fill="#ffffff" data-original="#000000" style="" class="">
</path>
</g>
</svg>
</span>
</a>  
</div>
<div>
<a href="javascript:void(0)" class="njt-nofi-display-toggle njt-nofi-text-color njt-nofi-bgcolor-notification" style="background: rgb(239, 84, 81); color: rgb(250, 250, 250);">
<span>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svgjs="http://svgjs.com/svgjs" version="1.1" width="512" height="512" x="0" y="0" viewBox="0 0 386.667 386.667" style="enable-background:new 0 0 512 512" xml:space="preserve" class="njt-nofi-display-toggle-icon">
<g>
<path xmlns="http://www.w3.org/2000/svg" d="m386.667 45.564-45.564-45.564-147.77 147.769-147.769-147.769-45.564 45.564 147.769 147.769-147.769 147.77 45.564 45.564 147.769-147.769 147.769 147.769 45.564-45.564-147.768-147.77z" fill="#ffffff" data-original="#000000" style="" class="">
</path>
</g>
</svg>
</span>
</a>
</div>
</div>
</div>
<input type="hidden" id="njt_nofi_checkDisplayReview" name="njt_nofi_checkDisplayReview" value="{&quot;is_home&quot;:false,&quot;is_page&quot;:false,&quot;is_single&quot;:true,&quot;id_page&quot;:984}">
<link rel="stylesheet" id="lwptoc-main-css" href="https://serveradmin.ru/wp-content/plugins/luckywp-table-of-contents/front/assets/main.min.css" type="text/css" media="all">
<script type="text/javascript" src="https://serveradmin.ru/wp-content/plugins/dk-pdf/assets/js/frontend.js" id="dkpdf-frontend-js">
</script>
<script type="text/javascript" id="toc-front-js-extra">
/* <![CDATA[ */
var tocplus = {"smooth_scroll":"1"};
/* ]]> */
</script>
<script type="text/javascript" src="https://serveradmin.ru/wp-content/plugins/table-of-contents-plus/front.min.js" id="toc-front-js">
</script>
<script type="text/javascript" id="ppress-frontend-script-js-extra">
/* <![CDATA[ */
var pp_ajax_form = {"ajaxurl":"https:\/\/serveradmin.ru\/wp-admin\/admin-ajax.php","confirm_delete":"\u0412\u044b \u0443\u0432\u0435\u0440\u0435\u043d\u044b?","deleting_text":"\u0423\u0434\u0430\u043b\u0435\u043d\u0438\u0435...","deleting_error":"\u041f\u0440\u043e\u0438\u0437\u043e\u0448\u043b\u0430 \u043e\u0448\u0438\u0431\u043a\u0430. \u041f\u043e\u0436\u0430\u043b\u0443\u0439\u0441\u0442\u0430, \u043f\u043e\u043f\u0440\u043e\u0431\u0443\u0439\u0442\u0435 \u0435\u0449\u0435 \u0440\u0430\u0437.","nonce":"7d8555611a","disable_ajax_form":"false","is_checkout":"0","is_checkout_tax_enabled":"0"};
/* ]]> */
</script>
<script type="text/javascript" src="https://serveradmin.ru/wp-content/plugins/wp-user-avatar/assets/js/frontend.min.js" id="ppress-frontend-script-js">
</script>
<script type="text/javascript" id="njt-nofi-js-extra">
/* <![CDATA[ */
var wpData = {"admin_ajax":"https:\/\/serveradmin.ru\/wp-admin\/admin-ajax.php","nonce":"1a9313ef16","isPositionFix":"1","hideCloseButton":"close_button","isDisplayButton":"1","presetColor":"1","alignContent":"center","textColorNotification":"#FAFAFA","textButtonColor":"#ffffff","wp_is_mobile":"","is_customize_preview":"","wp_get_theme":"Sahifa"};
/* ]]> */
</script>
<script type="text/javascript" src="https://serveradmin.ru/wp-content/plugins/notibar/assets/frontend/js/notibar.js" id="njt-nofi-js">
</script>
<script type="text/javascript" id="tie-scripts-js-extra">
/* <![CDATA[ */
var tie = {"mobile_menu_active":"true","mobile_menu_top":"","lightbox_all":"","lightbox_gallery":"","woocommerce_lightbox":"","lightbox_skin":"smooth","lightbox_thumb":"vertical","lightbox_arrows":"","sticky_sidebar":"1","is_singular":"1","SmothScroll":"","reading_indicator":"true","lang_no_results":"No Results","lang_results_found":"Results Found"};
/* ]]> */
</script>
<script type="text/javascript" src="https://serveradmin.ru/wp-content/themes/sahifa/js/tie-scripts.js" id="tie-scripts-js">
</script>
<script type="text/javascript" src="https://serveradmin.ru/wp-content/themes/sahifa/js/ilightbox.packed.js" id="tie-ilightbox-js">
</script>
<script type="text/javascript" src="https://serveradmin.ru/wp-includes/js/comment-reply.min.js" id="comment-reply-js">
</script>
<script type="text/javascript" src="https://serveradmin.ru/wp-content/plugins/luckywp-table-of-contents/front/assets/main.min.js" id="lwptoc-main-js">
</script>
<script id="kama_spamblock">
(function(){
const catch_submit = function( ev ){
let sbmt = ev.target.closest( '#submit' );
if( ! sbmt ){
return;
}
let input = document.createElement( 'input' );
let date = new Date();
input.value = ''+ date.getUTCDate() + (date.getUTCMonth() + 1) + 'uniq9066';
input.name = 'ksbn_code';
input.type = 'hidden';
sbmt.parentNode.insertBefore( input, sbmt );
}
document.addEventListener( 'mousedown', catch_submit );
document.addEventListener( 'keypress', catch_submit );
})()
</script>
<!-- Code for ad blocking detection -->
<!--noptimize-->
<div id="banner-advert-container" class="adsense sponsor-ad" style="position:absolute; z-index: -10; height: 1px; width: 1px; top: -100px; left: -100px;">
</div>
<script async="" id="ai-adb-ads" src="https://serveradmin.ru/wp-content/uploads/ad-inserter/cb1a0418e83/ads.js?ver=2.7.17-1674432001">
</script>
<script async="" id="ai-adb-sponsors" src="https://serveradmin.ru/wp-content/uploads/ad-inserter/cb1a0418e83/sponsors.js?ver=2.7.17-1674432001">
</script>
<script async="" id="ai-adb-advertising" src="https://serveradmin.ru/wp-content/uploads/ad-inserter/cb1a0418e83/advertising.js?ver=2.7.17-1674432001">
</script>
<script async="" id="ai-adb-adverts" src="https://serveradmin.ru/wp-content/uploads/ad-inserter/cb1a0418e83/adverts.js?ver=2.7.17-1674432001">
</script>
<script async="" id="ai-adb-banner" src="https://serveradmin.ru/wp-content/plugins/ad-inserter-pro/js/banner.js?ver=2.7.17">
</script>
<script async="" id="ai-adb-300x250" src="https://serveradmin.ru/wp-content/plugins/ad-inserter-pro/js/300x250.js?ver=2.7.17">
</script>
<!--/noptimize-->
<!-- Code for ad blocking detection END -->
<script>
function daeffead(a){var b,c=0,l=0,f="",g=[];if(!a)return a;do{var e=a.charCodeAt(c++);var h=a.charCodeAt(c++);var k=a.charCodeAt(c++);var d=e<<16|h<<8|k;e=63&d>>18;h=63&d>>12;k=63&d>>6;d&=63;g[l++]="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".charAt(e)+"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".charAt(h)+"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".charAt(k)+"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".charAt(d)}while(c<
a.length);return f=g.join(""),b=a.length%3,(b?f.slice(0,b-3):f)+"===".slice(b||3)}function cfdb3f64(a){var b,c,l,f={},g=0,e=0,h="",k=String.fromCharCode,d=a.length;for(b=0;64>b;b++)f["ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(b)]=b;for(c=0;d>c;c++)for(b=f[a.charAt(c)],g=(g<<6)+b,e+=6;8<=e;)((l=255&g>>>(e-=8))||d-2>c)&&(h+=k(l));return h}deebbbd2=function(a){return daeffead(encodeURIComponent(a).replace(/%([0-9A-F]{2})/g,function(b,a){return String.fromCharCode("0x"+a)}))};
dedd0f5d=function(a){return decodeURIComponent(cfdb3f64(a).split("").map(function(a){return"%"+("00"+a.charCodeAt(0).toString(16)).slice(-2)}).join(""))};
/* <![CDATA[ */
ai_front = {"insertion_before":"BEFORE","insertion_after":"AFTER","insertion_prepend":"PREPEND CONTENT","insertion_append":"APPEND CONTENT","insertion_replace_content":"REPLACE CONTENT","insertion_replace_element":"REPLACE ELEMENT","visible":"VISIBLE","hidden":"HIDDEN","fallback":"FALLBACK","automatically_placed":"Automatically placed by AdSense Auto ads code","cancel":"Cancel","use":"Use","add":"Add","parent":"Parent","cancel_element_selection":"Cancel element selection","select_parent_element":"Select parent element","css_selector":"CSS selector","use_current_selector":"Use current selector","element":"ELEMENT","path":"PATH","selector":"SELECTOR"};
/* ]]> */
(function(a){if("function"===typeof define&&define.amd){define(a);var c=!0}"object"===typeof exports&&(module.exports=a(),c=!0);if(!c){var d=window.Cookies,b=window.Cookies=a();b.noConflict=function(){window.Cookies=d;return b}}})(function(){function a(){for(var d=0,b={};d<arguments.length;d++){var f=arguments[d],e;for(e in f)b[e]=f[e]}return b}function c(d){function b(){}function f(h,k,g){if("undefined"!==typeof document){g=a({path:"/",sameSite:"Lax"},b.defaults,g);"number"===typeof g.expires&&(g.expires=
new Date(1*new Date+864E5*g.expires));g.expires=g.expires?g.expires.toUTCString():"";try{var l=JSON.stringify(k);/^[\{\[]/.test(l)&&(k=l)}catch(p){}k=d.write?d.write(k,h):encodeURIComponent(String(k)).replace(/%(23|24|26|2B|3A|3C|3E|3D|2F|3F|40|5B|5D|5E|60|7B|7D|7C)/g,decodeURIComponent);h=encodeURIComponent(String(h)).replace(/%(23|24|26|2B|5E|60|7C)/g,decodeURIComponent).replace(/[\(\)]/g,escape);l="";for(var n in g)g[n]&&(l+="; "+n,!0!==g[n]&&(l+="="+g[n].split(";")[0]));return document.cookie=
h+"="+k+l}}function e(h,k){if("undefined"!==typeof document){for(var g={},l=document.cookie?document.cookie.split("; "):[],n=0;n<l.length;n++){var p=l[n].split("="),m=p.slice(1).join("=");k||'"'!==m.charAt(0)||(m=m.slice(1,-1));try{var q=p[0].replace(/(%[0-9A-Z]{2})+/g,decodeURIComponent);m=(d.read||d)(m,q)||m.replace(/(%[0-9A-Z]{2})+/g,decodeURIComponent);if(k)try{m=JSON.parse(m)}catch(r){}g[q]=m;if(h===q)break}catch(r){}}return h?g[h]:g}}b.set=f;b.get=function(h){return e(h,!1)};b.getJSON=function(h){return e(h,
!0)};b.remove=function(h,k){f(h,"",a(k,{expires:-1}))};b.defaults={};b.withConverter=c;return b}return c(function(){})});AiCookies=Cookies.noConflict();
ai_check_block=function(a){if(null==a)return!0;var c=AiCookies.getJSON("aiBLOCKS");ai_debug_cookie_status="";null==c&&(c={});"undefined"!==typeof ai_delay_showing_pageviews&&(c.hasOwnProperty(a)||(c[a]={}),c[a].hasOwnProperty("d")||(c[a].d=ai_delay_showing_pageviews));if(c.hasOwnProperty(a)){for(var d in c[a]){if("x"==d){var b="",f=document.querySelectorAll('span[data-ai-block="'+a+'"]')[0];"aiHash"in f.dataset&&(b=f.dataset.aiHash);f="";c[a].hasOwnProperty("h")&&(f=c[a].h);var e=new Date;e=c[a][d]-
Math.round(e.getTime()/1E3);if(0<e&&f==b)return ai_debug_cookie_status=a="closed for "+e+" s = "+Math.round(1E4*e/3600/24)/1E4+" days",!1;ai_set_cookie(a,"x","");c[a].hasOwnProperty("i")||c[a].hasOwnProperty("c")||ai_set_cookie(a,"h","")}else if("d"==d){if(0!=c[a][d])return ai_debug_cookie_status=a="delayed for "+c[a][d]+" pageviews",!1}else if("i"==d){b="";f=document.querySelectorAll('span[data-ai-block="'+a+'"]')[0];"aiHash"in f.dataset&&(b=f.dataset.aiHash);f="";c[a].hasOwnProperty("h")&&(f=c[a].h);
if(0==c[a][d]&&f==b)return ai_debug_cookie_status=a="max impressions reached",!1;if(0>c[a][d]&&f==b){e=new Date;e=-c[a][d]-Math.round(e.getTime()/1E3);if(0<e)return ai_debug_cookie_status=a="max imp. reached ("+Math.round(1E4*e/24/3600)/1E4+" days = "+e+" s)",!1;ai_set_cookie(a,"i","");c[a].hasOwnProperty("c")||c[a].hasOwnProperty("x")||ai_set_cookie(a,"h","")}}if("ipt"==d&&0==c[a][d]&&(e=new Date,b=Math.round(e.getTime()/1E3),e=c[a].it-b,0<e))return ai_debug_cookie_status=a="max imp. per time reached ("+
Math.round(1E4*e/24/3600)/1E4+" days = "+e+" s)",!1;if("c"==d){b="";f=document.querySelectorAll('span[data-ai-block="'+a+'"]')[0];"aiHash"in f.dataset&&(b=f.dataset.aiHash);f="";c[a].hasOwnProperty("h")&&(f=c[a].h);if(0==c[a][d]&&f==b)return ai_debug_cookie_status=a="max clicks reached",!1;if(0>c[a][d]&&f==b){e=new Date;e=-c[a][d]-Math.round(e.getTime()/1E3);if(0<e)return ai_debug_cookie_status=a="max clicks reached ("+Math.round(1E4*e/24/3600)/1E4+" days = "+e+" s)",!1;ai_set_cookie(a,"c","");c[a].hasOwnProperty("i")||
c[a].hasOwnProperty("x")||ai_set_cookie(a,"h","")}}if("cpt"==d&&0==c[a][d]&&(e=new Date,b=Math.round(e.getTime()/1E3),e=c[a].ct-b,0<e))return ai_debug_cookie_status=a="max clicks per time reached ("+Math.round(1E4*e/24/3600)/1E4+" days = "+e+" s)",!1}if(c.hasOwnProperty("G")&&c.G.hasOwnProperty("cpt")&&0==c.G.cpt&&(e=new Date,b=Math.round(e.getTime()/1E3),e=c.G.ct-b,0<e))return ai_debug_cookie_status=a="max global clicks per time reached ("+Math.round(1E4*e/24/3600)/1E4+" days = "+e+" s)",!1}ai_debug_cookie_status=
"OK";return!0};
ai_check_and_insert_block=function(a,c){if(null==a)return!0;var d=document.getElementsByClassName(c);if(d.length){d=d[0];var b=d.closest(".ca-ca"),f=ai_check_block(a);!f&&0!=parseInt(d.getAttribute("limits-fallback"))&&d.hasAttribute("data-fallback-code")&&(d.setAttribute("data-code",d.getAttribute("data-fallback-code")),b.hasAttribute("data-ai")&&d.hasAttribute("fallback-tracking")&&d.hasAttribute("fallback_level")&&b.setAttribute("data-ai-"+d.getAttribute("fallback_level"),d.getAttribute("fallback-tracking")),
f=!0);if(f)ai_insert_code(d),b&&(f=b.querySelectorAll(".ai-debug-block"),b&&f.length&&(b.classList.remove("ai-list-block"),b.classList.remove("ai-list-block-ip"),b.classList.remove("ai-list-block-filter"),b.style.visibility="",b.classList.contains("ai-remove-position")&&(b.style.position="")));else{f=d.closest("div[data-ai]");if(null!=f&&"undefined"!=typeof f.getAttribute("data-ai")){var e=JSON.parse(dedd0f5d(f.getAttribute("data-ai")));"undefined"!==typeof e&&e.constructor===Array&&(e[1]="",f.setAttribute("data-ai",
deebbbd2(JSON.stringify(e))))}f=b.querySelectorAll(".ai-debug-block");b&&f.length&&(b.classList.remove("ai-list-block"),b.classList.remove("ai-list-block-ip"),b.classList.remove("ai-list-block-filter"),b.style.visibility="",b.classList.contains("ai-remove-position")&&(b.style.position=""))}d.classList.remove(c)}d=document.querySelectorAll("."+c+"-dbg");b=0;for(f=d.length;b<f;b++)e=d[b],e.querySelector(".ai-status").textContent=ai_debug_cookie_status,e.querySelector(".ai-cookie-data").textContent=ai_get_cookie_text(a),
e.classList.remove(c+"-dbg")};function ai_load_cookie(){var a=AiCookies.getJSON("aiBLOCKS");null==a&&(a={});return a}function ai_get_cookie(a,c){var d="",b=ai_load_cookie();b.hasOwnProperty(a)&&b[a].hasOwnProperty(c)&&(d=b[a][c]);return d}
function ai_set_cookie(a,c,d){var b=ai_load_cookie();if(""===d){if(b.hasOwnProperty(a)){delete b[a][c];a:{c=b[a];for(f in c)if(c.hasOwnProperty(f)){var f=!1;break a}f=!0}f&&delete b[a]}}else b.hasOwnProperty(a)||(b[a]={}),b[a][c]=d;0===Object.keys(b).length&&b.constructor===Object?AiCookies.remove("aiBLOCKS"):AiCookies.set("aiBLOCKS",b,{expires:365,path:"/"});return b}
ai_get_cookie_text=function(a){var c=AiCookies.getJSON("aiBLOCKS");null==c&&(c={});var d="";c.hasOwnProperty("G")&&(d="G["+JSON.stringify(c.G).replace(/"/g,"").replace("{","").replace("}","")+"] ");var b="";c.hasOwnProperty(a)&&(b=JSON.stringify(c[a]).replace(/"/g,"").replace("{","").replace("}",""));return d+b};
;(function(h,f){h(function(){function m(a,b){return null!=a&&null!=b&&a.toLowerCase()===b.toLowerCase()}function h(a,b){var c,d=a.length;if(!d||!b)return!1;var f=b.toLowerCase();for(c=0;c<d;++c)if(f===a[c].toLowerCase())return!0;return!1}function k(a){for(var b in a)l.call(a,b)&&(a[b]=new RegExp(a[b],"i"))}function g(a,b){this.ua=(a||"").substr(0,500);this._cache={};this.maxPhoneWidth=b||600}var b={mobileDetectRules:{phones:{iPhone:"\\biPhone\\b|\\biPod\\b",BlackBerry:"BlackBerry|\\bBB10\\b|rim[0-9]+|\\b(BBA100|BBB100|BBD100|BBE100|BBF100|STH100)\\b-[0-9]+",
HTC:"HTC|HTC.*(Sensation|Evo|Vision|Explorer|6800|8100|8900|A7272|S510e|C110e|Legend|Desire|T8282)|APX515CKT|Qtek9090|APA9292KT|HD_mini|Sensation.*Z710e|PG86100|Z715e|Desire.*(A8181|HD)|ADR6200|ADR6400L|ADR6425|001HT|Inspire 4G|Android.*\\bEVO\\b|T-Mobile G1|Z520m|Android [0-9.]+; Pixel",Nexus:"Nexus One|Nexus S|Galaxy.*Nexus|Android.*Nexus.*Mobile|Nexus 4|Nexus 5|Nexus 6",Dell:"Dell[;]? (Streak|Aero|Venue|Venue Pro|Flash|Smoke|Mini 3iX)|XCD28|XCD35|\\b001DL\\b|\\b101DL\\b|\\bGS01\\b",Motorola:"Motorola|DROIDX|DROID BIONIC|\\bDroid\\b.*Build|Android.*Xoom|HRI39|MOT-|A1260|A1680|A555|A853|A855|A953|A955|A956|Motorola.*ELECTRIFY|Motorola.*i1|i867|i940|MB200|MB300|MB501|MB502|MB508|MB511|MB520|MB525|MB526|MB611|MB612|MB632|MB810|MB855|MB860|MB861|MB865|MB870|ME501|ME502|ME511|ME525|ME600|ME632|ME722|ME811|ME860|ME863|ME865|MT620|MT710|MT716|MT720|MT810|MT870|MT917|Motorola.*TITANIUM|WX435|WX445|XT300|XT301|XT311|XT316|XT317|XT319|XT320|XT390|XT502|XT530|XT531|XT532|XT535|XT603|XT610|XT611|XT615|XT681|XT701|XT702|XT711|XT720|XT800|XT806|XT860|XT862|XT875|XT882|XT883|XT894|XT901|XT907|XT909|XT910|XT912|XT928|XT926|XT915|XT919|XT925|XT1021|\\bMoto E\\b|XT1068|XT1092|XT1052",
Samsung:"\\bSamsung\\b|SM-G950F|SM-G955F|SM-G9250|GT-19300|SGH-I337|BGT-S5230|GT-B2100|GT-B2700|GT-B2710|GT-B3210|GT-B3310|GT-B3410|GT-B3730|GT-B3740|GT-B5510|GT-B5512|GT-B5722|GT-B6520|GT-B7300|GT-B7320|GT-B7330|GT-B7350|GT-B7510|GT-B7722|GT-B7800|GT-C3010|GT-C3011|GT-C3060|GT-C3200|GT-C3212|GT-C3212I|GT-C3262|GT-C3222|GT-C3300|GT-C3300K|GT-C3303|GT-C3303K|GT-C3310|GT-C3322|GT-C3330|GT-C3350|GT-C3500|GT-C3510|GT-C3530|GT-C3630|GT-C3780|GT-C5010|GT-C5212|GT-C6620|GT-C6625|GT-C6712|GT-E1050|GT-E1070|GT-E1075|GT-E1080|GT-E1081|GT-E1085|GT-E1087|GT-E1100|GT-E1107|GT-E1110|GT-E1120|GT-E1125|GT-E1130|GT-E1160|GT-E1170|GT-E1175|GT-E1180|GT-E1182|GT-E1200|GT-E1210|GT-E1225|GT-E1230|GT-E1390|GT-E2100|GT-E2120|GT-E2121|GT-E2152|GT-E2220|GT-E2222|GT-E2230|GT-E2232|GT-E2250|GT-E2370|GT-E2550|GT-E2652|GT-E3210|GT-E3213|GT-I5500|GT-I5503|GT-I5700|GT-I5800|GT-I5801|GT-I6410|GT-I6420|GT-I7110|GT-I7410|GT-I7500|GT-I8000|GT-I8150|GT-I8160|GT-I8190|GT-I8320|GT-I8330|GT-I8350|GT-I8530|GT-I8700|GT-I8703|GT-I8910|GT-I9000|GT-I9001|GT-I9003|GT-I9010|GT-I9020|GT-I9023|GT-I9070|GT-I9082|GT-I9100|GT-I9103|GT-I9220|GT-I9250|GT-I9300|GT-I9305|GT-I9500|GT-I9505|GT-M3510|GT-M5650|GT-M7500|GT-M7600|GT-M7603|GT-M8800|GT-M8910|GT-N7000|GT-S3110|GT-S3310|GT-S3350|GT-S3353|GT-S3370|GT-S3650|GT-S3653|GT-S3770|GT-S3850|GT-S5210|GT-S5220|GT-S5229|GT-S5230|GT-S5233|GT-S5250|GT-S5253|GT-S5260|GT-S5263|GT-S5270|GT-S5300|GT-S5330|GT-S5350|GT-S5360|GT-S5363|GT-S5369|GT-S5380|GT-S5380D|GT-S5560|GT-S5570|GT-S5600|GT-S5603|GT-S5610|GT-S5620|GT-S5660|GT-S5670|GT-S5690|GT-S5750|GT-S5780|GT-S5830|GT-S5839|GT-S6102|GT-S6500|GT-S7070|GT-S7200|GT-S7220|GT-S7230|GT-S7233|GT-S7250|GT-S7500|GT-S7530|GT-S7550|GT-S7562|GT-S7710|GT-S8000|GT-S8003|GT-S8500|GT-S8530|GT-S8600|SCH-A310|SCH-A530|SCH-A570|SCH-A610|SCH-A630|SCH-A650|SCH-A790|SCH-A795|SCH-A850|SCH-A870|SCH-A890|SCH-A930|SCH-A950|SCH-A970|SCH-A990|SCH-I100|SCH-I110|SCH-I400|SCH-I405|SCH-I500|SCH-I510|SCH-I515|SCH-I600|SCH-I730|SCH-I760|SCH-I770|SCH-I830|SCH-I910|SCH-I920|SCH-I959|SCH-LC11|SCH-N150|SCH-N300|SCH-R100|SCH-R300|SCH-R351|SCH-R400|SCH-R410|SCH-T300|SCH-U310|SCH-U320|SCH-U350|SCH-U360|SCH-U365|SCH-U370|SCH-U380|SCH-U410|SCH-U430|SCH-U450|SCH-U460|SCH-U470|SCH-U490|SCH-U540|SCH-U550|SCH-U620|SCH-U640|SCH-U650|SCH-U660|SCH-U700|SCH-U740|SCH-U750|SCH-U810|SCH-U820|SCH-U900|SCH-U940|SCH-U960|SCS-26UC|SGH-A107|SGH-A117|SGH-A127|SGH-A137|SGH-A157|SGH-A167|SGH-A177|SGH-A187|SGH-A197|SGH-A227|SGH-A237|SGH-A257|SGH-A437|SGH-A517|SGH-A597|SGH-A637|SGH-A657|SGH-A667|SGH-A687|SGH-A697|SGH-A707|SGH-A717|SGH-A727|SGH-A737|SGH-A747|SGH-A767|SGH-A777|SGH-A797|SGH-A817|SGH-A827|SGH-A837|SGH-A847|SGH-A867|SGH-A877|SGH-A887|SGH-A897|SGH-A927|SGH-B100|SGH-B130|SGH-B200|SGH-B220|SGH-C100|SGH-C110|SGH-C120|SGH-C130|SGH-C140|SGH-C160|SGH-C170|SGH-C180|SGH-C200|SGH-C207|SGH-C210|SGH-C225|SGH-C230|SGH-C417|SGH-C450|SGH-D307|SGH-D347|SGH-D357|SGH-D407|SGH-D415|SGH-D780|SGH-D807|SGH-D980|SGH-E105|SGH-E200|SGH-E315|SGH-E316|SGH-E317|SGH-E335|SGH-E590|SGH-E635|SGH-E715|SGH-E890|SGH-F300|SGH-F480|SGH-I200|SGH-I300|SGH-I320|SGH-I550|SGH-I577|SGH-I600|SGH-I607|SGH-I617|SGH-I627|SGH-I637|SGH-I677|SGH-I700|SGH-I717|SGH-I727|SGH-i747M|SGH-I777|SGH-I780|SGH-I827|SGH-I847|SGH-I857|SGH-I896|SGH-I897|SGH-I900|SGH-I907|SGH-I917|SGH-I927|SGH-I937|SGH-I997|SGH-J150|SGH-J200|SGH-L170|SGH-L700|SGH-M110|SGH-M150|SGH-M200|SGH-N105|SGH-N500|SGH-N600|SGH-N620|SGH-N625|SGH-N700|SGH-N710|SGH-P107|SGH-P207|SGH-P300|SGH-P310|SGH-P520|SGH-P735|SGH-P777|SGH-Q105|SGH-R210|SGH-R220|SGH-R225|SGH-S105|SGH-S307|SGH-T109|SGH-T119|SGH-T139|SGH-T209|SGH-T219|SGH-T229|SGH-T239|SGH-T249|SGH-T259|SGH-T309|SGH-T319|SGH-T329|SGH-T339|SGH-T349|SGH-T359|SGH-T369|SGH-T379|SGH-T409|SGH-T429|SGH-T439|SGH-T459|SGH-T469|SGH-T479|SGH-T499|SGH-T509|SGH-T519|SGH-T539|SGH-T559|SGH-T589|SGH-T609|SGH-T619|SGH-T629|SGH-T639|SGH-T659|SGH-T669|SGH-T679|SGH-T709|SGH-T719|SGH-T729|SGH-T739|SGH-T746|SGH-T749|SGH-T759|SGH-T769|SGH-T809|SGH-T819|SGH-T839|SGH-T919|SGH-T929|SGH-T939|SGH-T959|SGH-T989|SGH-U100|SGH-U200|SGH-U800|SGH-V205|SGH-V206|SGH-X100|SGH-X105|SGH-X120|SGH-X140|SGH-X426|SGH-X427|SGH-X475|SGH-X495|SGH-X497|SGH-X507|SGH-X600|SGH-X610|SGH-X620|SGH-X630|SGH-X700|SGH-X820|SGH-X890|SGH-Z130|SGH-Z150|SGH-Z170|SGH-ZX10|SGH-ZX20|SHW-M110|SPH-A120|SPH-A400|SPH-A420|SPH-A460|SPH-A500|SPH-A560|SPH-A600|SPH-A620|SPH-A660|SPH-A700|SPH-A740|SPH-A760|SPH-A790|SPH-A800|SPH-A820|SPH-A840|SPH-A880|SPH-A900|SPH-A940|SPH-A960|SPH-D600|SPH-D700|SPH-D710|SPH-D720|SPH-I300|SPH-I325|SPH-I330|SPH-I350|SPH-I500|SPH-I600|SPH-I700|SPH-L700|SPH-M100|SPH-M220|SPH-M240|SPH-M300|SPH-M305|SPH-M320|SPH-M330|SPH-M350|SPH-M360|SPH-M370|SPH-M380|SPH-M510|SPH-M540|SPH-M550|SPH-M560|SPH-M570|SPH-M580|SPH-M610|SPH-M620|SPH-M630|SPH-M800|SPH-M810|SPH-M850|SPH-M900|SPH-M910|SPH-M920|SPH-M930|SPH-N100|SPH-N200|SPH-N240|SPH-N300|SPH-N400|SPH-Z400|SWC-E100|SCH-i909|GT-N7100|GT-N7105|SCH-I535|SM-N900A|SGH-I317|SGH-T999L|GT-S5360B|GT-I8262|GT-S6802|GT-S6312|GT-S6310|GT-S5312|GT-S5310|GT-I9105|GT-I8510|GT-S6790N|SM-G7105|SM-N9005|GT-S5301|GT-I9295|GT-I9195|SM-C101|GT-S7392|GT-S7560|GT-B7610|GT-I5510|GT-S7582|GT-S7530E|GT-I8750|SM-G9006V|SM-G9008V|SM-G9009D|SM-G900A|SM-G900D|SM-G900F|SM-G900H|SM-G900I|SM-G900J|SM-G900K|SM-G900L|SM-G900M|SM-G900P|SM-G900R4|SM-G900S|SM-G900T|SM-G900V|SM-G900W8|SHV-E160K|SCH-P709|SCH-P729|SM-T2558|GT-I9205|SM-G9350|SM-J120F|SM-G920F|SM-G920V|SM-G930F|SM-N910C|SM-A310F|GT-I9190|SM-J500FN|SM-G903F|SM-J330F",
LG:"\\bLG\\b;|LG[- ]?(C800|C900|E400|E610|E900|E-900|F160|F180K|F180L|F180S|730|855|L160|LS740|LS840|LS970|LU6200|MS690|MS695|MS770|MS840|MS870|MS910|P500|P700|P705|VM696|AS680|AS695|AX840|C729|E970|GS505|272|C395|E739BK|E960|L55C|L75C|LS696|LS860|P769BK|P350|P500|P509|P870|UN272|US730|VS840|VS950|LN272|LN510|LS670|LS855|LW690|MN270|MN510|P509|P769|P930|UN200|UN270|UN510|UN610|US670|US740|US760|UX265|UX840|VN271|VN530|VS660|VS700|VS740|VS750|VS910|VS920|VS930|VX9200|VX11000|AX840A|LW770|P506|P925|P999|E612|D955|D802|MS323|M257)|LM-G710",
Sony:"SonyST|SonyLT|SonyEricsson|SonyEricssonLT15iv|LT18i|E10i|LT28h|LT26w|SonyEricssonMT27i|C5303|C6902|C6903|C6906|C6943|D2533",Asus:"Asus.*Galaxy|PadFone.*Mobile",NokiaLumia:"Lumia [0-9]{3,4}",Micromax:"Micromax.*\\b(A210|A92|A88|A72|A111|A110Q|A115|A116|A110|A90S|A26|A51|A35|A54|A25|A27|A89|A68|A65|A57|A90)\\b",Palm:"PalmSource|Palm",Vertu:"Vertu|Vertu.*Ltd|Vertu.*Ascent|Vertu.*Ayxta|Vertu.*Constellation(F|Quest)?|Vertu.*Monika|Vertu.*Signature",Pantech:"PANTECH|IM-A850S|IM-A840S|IM-A830L|IM-A830K|IM-A830S|IM-A820L|IM-A810K|IM-A810S|IM-A800S|IM-T100K|IM-A725L|IM-A780L|IM-A775C|IM-A770K|IM-A760S|IM-A750K|IM-A740S|IM-A730S|IM-A720L|IM-A710K|IM-A690L|IM-A690S|IM-A650S|IM-A630K|IM-A600S|VEGA PTL21|PT003|P8010|ADR910L|P6030|P6020|P9070|P4100|P9060|P5000|CDM8992|TXT8045|ADR8995|IS11PT|P2030|P6010|P8000|PT002|IS06|CDM8999|P9050|PT001|TXT8040|P2020|P9020|P2000|P7040|P7000|C790",
Fly:"IQ230|IQ444|IQ450|IQ440|IQ442|IQ441|IQ245|IQ256|IQ236|IQ255|IQ235|IQ245|IQ275|IQ240|IQ285|IQ280|IQ270|IQ260|IQ250",Wiko:"KITE 4G|HIGHWAY|GETAWAY|STAIRWAY|DARKSIDE|DARKFULL|DARKNIGHT|DARKMOON|SLIDE|WAX 4G|RAINBOW|BLOOM|SUNSET|GOA(?!nna)|LENNY|BARRY|IGGY|OZZY|CINK FIVE|CINK PEAX|CINK PEAX 2|CINK SLIM|CINK SLIM 2|CINK +|CINK KING|CINK PEAX|CINK SLIM|SUBLIM",iMobile:"i-mobile (IQ|i-STYLE|idea|ZAA|Hitz)",SimValley:"\\b(SP-80|XT-930|SX-340|XT-930|SX-310|SP-360|SP60|SPT-800|SP-120|SPT-800|SP-140|SPX-5|SPX-8|SP-100|SPX-8|SPX-12)\\b",
Wolfgang:"AT-B24D|AT-AS50HD|AT-AS40W|AT-AS55HD|AT-AS45q2|AT-B26D|AT-AS50Q",Alcatel:"Alcatel",Nintendo:"Nintendo (3DS|Switch)",Amoi:"Amoi",INQ:"INQ",OnePlus:"ONEPLUS",GenericPhone:"Tapatalk|PDA;|SAGEM|\\bmmp\\b|pocket|\\bpsp\\b|symbian|Smartphone|smartfon|treo|up.browser|up.link|vodafone|\\bwap\\b|nokia|Series40|Series60|S60|SonyEricsson|N900|MAUI.*WAP.*Browser"},tablets:{iPad:"iPad|iPad.*Mobile",NexusTablet:"Android.*Nexus[\\s]+(7|9|10)",GoogleTablet:"Android.*Pixel C",SamsungTablet:"SAMSUNG.*Tablet|Galaxy.*Tab|SC-01C|GT-P1000|GT-P1003|GT-P1010|GT-P3105|GT-P6210|GT-P6800|GT-P6810|GT-P7100|GT-P7300|GT-P7310|GT-P7500|GT-P7510|SCH-I800|SCH-I815|SCH-I905|SGH-I957|SGH-I987|SGH-T849|SGH-T859|SGH-T869|SPH-P100|GT-P3100|GT-P3108|GT-P3110|GT-P5100|GT-P5110|GT-P6200|GT-P7320|GT-P7511|GT-N8000|GT-P8510|SGH-I497|SPH-P500|SGH-T779|SCH-I705|SCH-I915|GT-N8013|GT-P3113|GT-P5113|GT-P8110|GT-N8010|GT-N8005|GT-N8020|GT-P1013|GT-P6201|GT-P7501|GT-N5100|GT-N5105|GT-N5110|SHV-E140K|SHV-E140L|SHV-E140S|SHV-E150S|SHV-E230K|SHV-E230L|SHV-E230S|SHW-M180K|SHW-M180L|SHW-M180S|SHW-M180W|SHW-M300W|SHW-M305W|SHW-M380K|SHW-M380S|SHW-M380W|SHW-M430W|SHW-M480K|SHW-M480S|SHW-M480W|SHW-M485W|SHW-M486W|SHW-M500W|GT-I9228|SCH-P739|SCH-I925|GT-I9200|GT-P5200|GT-P5210|GT-P5210X|SM-T311|SM-T310|SM-T310X|SM-T210|SM-T210R|SM-T211|SM-P600|SM-P601|SM-P605|SM-P900|SM-P901|SM-T217|SM-T217A|SM-T217S|SM-P6000|SM-T3100|SGH-I467|XE500|SM-T110|GT-P5220|GT-I9200X|GT-N5110X|GT-N5120|SM-P905|SM-T111|SM-T2105|SM-T315|SM-T320|SM-T320X|SM-T321|SM-T520|SM-T525|SM-T530NU|SM-T230NU|SM-T330NU|SM-T900|XE500T1C|SM-P605V|SM-P905V|SM-T337V|SM-T537V|SM-T707V|SM-T807V|SM-P600X|SM-P900X|SM-T210X|SM-T230|SM-T230X|SM-T325|GT-P7503|SM-T531|SM-T330|SM-T530|SM-T705|SM-T705C|SM-T535|SM-T331|SM-T800|SM-T700|SM-T537|SM-T807|SM-P907A|SM-T337A|SM-T537A|SM-T707A|SM-T807A|SM-T237|SM-T807P|SM-P607T|SM-T217T|SM-T337T|SM-T807T|SM-T116NQ|SM-T116BU|SM-P550|SM-T350|SM-T550|SM-T9000|SM-P9000|SM-T705Y|SM-T805|GT-P3113|SM-T710|SM-T810|SM-T815|SM-T360|SM-T533|SM-T113|SM-T335|SM-T715|SM-T560|SM-T670|SM-T677|SM-T377|SM-T567|SM-T357T|SM-T555|SM-T561|SM-T713|SM-T719|SM-T813|SM-T819|SM-T580|SM-T355Y?|SM-T280|SM-T817A|SM-T820|SM-W700|SM-P580|SM-T587|SM-P350|SM-P555M|SM-P355M|SM-T113NU|SM-T815Y|SM-T585|SM-T285|SM-T825|SM-W708|SM-T835|SM-T830|SM-T837V|SM-T720|SM-T510|SM-T387V",
Kindle:"Kindle|Silk.*Accelerated|Android.*\\b(KFOT|KFTT|KFJWI|KFJWA|KFOTE|KFSOWI|KFTHWI|KFTHWA|KFAPWI|KFAPWA|WFJWAE|KFSAWA|KFSAWI|KFASWI|KFARWI|KFFOWI|KFGIWI|KFMEWI)\\b|Android.*Silk/[0-9.]+ like Chrome/[0-9.]+ (?!Mobile)",SurfaceTablet:"Windows NT [0-9.]+; ARM;.*(Tablet|ARMBJS)",HPTablet:"HP Slate (7|8|10)|HP ElitePad 900|hp-tablet|EliteBook.*Touch|HP 8|Slate 21|HP SlateBook 10",AsusTablet:"^.*PadFone((?!Mobile).)*$|Transformer|TF101|TF101G|TF300T|TF300TG|TF300TL|TF700T|TF700KL|TF701T|TF810C|ME171|ME301T|ME302C|ME371MG|ME370T|ME372MG|ME172V|ME173X|ME400C|Slider SL101|\\bK00F\\b|\\bK00C\\b|\\bK00E\\b|\\bK00L\\b|TX201LA|ME176C|ME102A|\\bM80TA\\b|ME372CL|ME560CG|ME372CG|ME302KL| K010 | K011 | K017 | K01E |ME572C|ME103K|ME170C|ME171C|\\bME70C\\b|ME581C|ME581CL|ME8510C|ME181C|P01Y|PO1MA|P01Z|\\bP027\\b|\\bP024\\b|\\bP00C\\b",
BlackBerryTablet:"PlayBook|RIM Tablet",HTCtablet:"HTC_Flyer_P512|HTC Flyer|HTC Jetstream|HTC-P715a|HTC EVO View 4G|PG41200|PG09410",MotorolaTablet:"xoom|sholest|MZ615|MZ605|MZ505|MZ601|MZ602|MZ603|MZ604|MZ606|MZ607|MZ608|MZ609|MZ615|MZ616|MZ617",NookTablet:"Android.*Nook|NookColor|nook browser|BNRV200|BNRV200A|BNTV250|BNTV250A|BNTV400|BNTV600|LogicPD Zoom2",AcerTablet:"Android.*; \\b(A100|A101|A110|A200|A210|A211|A500|A501|A510|A511|A700|A701|W500|W500P|W501|W501P|W510|W511|W700|G100|G100W|B1-A71|B1-710|B1-711|A1-810|A1-811|A1-830)\\b|W3-810|\\bA3-A10\\b|\\bA3-A11\\b|\\bA3-A20\\b|\\bA3-A30",
ToshibaTablet:"Android.*(AT100|AT105|AT200|AT205|AT270|AT275|AT300|AT305|AT1S5|AT500|AT570|AT700|AT830)|TOSHIBA.*FOLIO",LGTablet:"\\bL-06C|LG-V909|LG-V900|LG-V700|LG-V510|LG-V500|LG-V410|LG-V400|LG-VK810\\b",FujitsuTablet:"Android.*\\b(F-01D|F-02F|F-05E|F-10D|M532|Q572)\\b",PrestigioTablet:"PMP3170B|PMP3270B|PMP3470B|PMP7170B|PMP3370B|PMP3570C|PMP5870C|PMP3670B|PMP5570C|PMP5770D|PMP3970B|PMP3870C|PMP5580C|PMP5880D|PMP5780D|PMP5588C|PMP7280C|PMP7280C3G|PMP7280|PMP7880D|PMP5597D|PMP5597|PMP7100D|PER3464|PER3274|PER3574|PER3884|PER5274|PER5474|PMP5097CPRO|PMP5097|PMP7380D|PMP5297C|PMP5297C_QUAD|PMP812E|PMP812E3G|PMP812F|PMP810E|PMP880TD|PMT3017|PMT3037|PMT3047|PMT3057|PMT7008|PMT5887|PMT5001|PMT5002",
LenovoTablet:"Lenovo TAB|Idea(Tab|Pad)( A1|A10| K1|)|ThinkPad([ ]+)?Tablet|YT3-850M|YT3-X90L|YT3-X90F|YT3-X90X|Lenovo.*(S2109|S2110|S5000|S6000|K3011|A3000|A3500|A1000|A2107|A2109|A1107|A5500|A7600|B6000|B8000|B8080)(-|)(FL|F|HV|H|)|TB-X103F|TB-X304X|TB-X304F|TB-X304L|TB-X505F|TB-X505L|TB-X505X|TB-X605F|TB-X605L|TB-8703F|TB-8703X|TB-8703N|TB-8704N|TB-8704F|TB-8704X|TB-8704V|TB-7304F|TB-7304I|TB-7304X|Tab2A7-10F|Tab2A7-20F|TB2-X30L|YT3-X50L|YT3-X50F|YT3-X50M|YT-X705F|YT-X703F|YT-X703L|YT-X705L|YT-X705X|TB2-X30F|TB2-X30L|TB2-X30M|A2107A-F|A2107A-H|TB3-730F|TB3-730M|TB3-730X|TB-7504F|TB-7504X",
DellTablet:"Venue 11|Venue 8|Venue 7|Dell Streak 10|Dell Streak 7",YarvikTablet:"Android.*\\b(TAB210|TAB211|TAB224|TAB250|TAB260|TAB264|TAB310|TAB360|TAB364|TAB410|TAB411|TAB420|TAB424|TAB450|TAB460|TAB461|TAB464|TAB465|TAB467|TAB468|TAB07-100|TAB07-101|TAB07-150|TAB07-151|TAB07-152|TAB07-200|TAB07-201-3G|TAB07-210|TAB07-211|TAB07-212|TAB07-214|TAB07-220|TAB07-400|TAB07-485|TAB08-150|TAB08-200|TAB08-201-3G|TAB08-201-30|TAB09-100|TAB09-211|TAB09-410|TAB10-150|TAB10-201|TAB10-211|TAB10-400|TAB10-410|TAB13-201|TAB274EUK|TAB275EUK|TAB374EUK|TAB462EUK|TAB474EUK|TAB9-200)\\b",
MedionTablet:"Android.*\\bOYO\\b|LIFE.*(P9212|P9514|P9516|S9512)|LIFETAB",ArnovaTablet:"97G4|AN10G2|AN7bG3|AN7fG3|AN8G3|AN8cG3|AN7G3|AN9G3|AN7dG3|AN7dG3ST|AN7dG3ChildPad|AN10bG3|AN10bG3DT|AN9G2",IntensoTablet:"INM8002KP|INM1010FP|INM805ND|Intenso Tab|TAB1004",IRUTablet:"M702pro",MegafonTablet:"MegaFon V9|\\bZTE V9\\b|Android.*\\bMT7A\\b",EbodaTablet:"E-Boda (Supreme|Impresspeed|Izzycomm|Essential)",AllViewTablet:"Allview.*(Viva|Alldro|City|Speed|All TV|Frenzy|Quasar|Shine|TX1|AX1|AX2)",ArchosTablet:"\\b(101G9|80G9|A101IT)\\b|Qilive 97R|Archos5|\\bARCHOS (70|79|80|90|97|101|FAMILYPAD|)(b|c|)(G10| Cobalt| TITANIUM(HD|)| Xenon| Neon|XSK| 2| XS 2| PLATINUM| CARBON|GAMEPAD)\\b",
AinolTablet:"NOVO7|NOVO8|NOVO10|Novo7Aurora|Novo7Basic|NOVO7PALADIN|novo9-Spark",NokiaLumiaTablet:"Lumia 2520",SonyTablet:"Sony.*Tablet|Xperia Tablet|Sony Tablet S|SO-03E|SGPT12|SGPT13|SGPT114|SGPT121|SGPT122|SGPT123|SGPT111|SGPT112|SGPT113|SGPT131|SGPT132|SGPT133|SGPT211|SGPT212|SGPT213|SGP311|SGP312|SGP321|EBRD1101|EBRD1102|EBRD1201|SGP351|SGP341|SGP511|SGP512|SGP521|SGP541|SGP551|SGP621|SGP641|SGP612|SOT31|SGP771|SGP611|SGP612|SGP712",PhilipsTablet:"\\b(PI2010|PI3000|PI3100|PI3105|PI3110|PI3205|PI3210|PI3900|PI4010|PI7000|PI7100)\\b",
CubeTablet:"Android.*(K8GT|U9GT|U10GT|U16GT|U17GT|U18GT|U19GT|U20GT|U23GT|U30GT)|CUBE U8GT",CobyTablet:"MID1042|MID1045|MID1125|MID1126|MID7012|MID7014|MID7015|MID7034|MID7035|MID7036|MID7042|MID7048|MID7127|MID8042|MID8048|MID8127|MID9042|MID9740|MID9742|MID7022|MID7010",MIDTablet:"M9701|M9000|M9100|M806|M1052|M806|T703|MID701|MID713|MID710|MID727|MID760|MID830|MID728|MID933|MID125|MID810|MID732|MID120|MID930|MID800|MID731|MID900|MID100|MID820|MID735|MID980|MID130|MID833|MID737|MID960|MID135|MID860|MID736|MID140|MID930|MID835|MID733|MID4X10",
MSITablet:"MSI \\b(Primo 73K|Primo 73L|Primo 81L|Primo 77|Primo 93|Primo 75|Primo 76|Primo 73|Primo 81|Primo 91|Primo 90|Enjoy 71|Enjoy 7|Enjoy 10)\\b",SMiTTablet:"Android.*(\\bMID\\b|MID-560|MTV-T1200|MTV-PND531|MTV-P1101|MTV-PND530)",RockChipTablet:"Android.*(RK2818|RK2808A|RK2918|RK3066)|RK2738|RK2808A",FlyTablet:"IQ310|Fly Vision",bqTablet:"Android.*(bq)?.*\\b(Elcano|Curie|Edison|Maxwell|Kepler|Pascal|Tesla|Hypatia|Platon|Newton|Livingstone|Cervantes|Avant|Aquaris ([E|M]10|M8))\\b|Maxwell.*Lite|Maxwell.*Plus",
HuaweiTablet:"MediaPad|MediaPad 7 Youth|IDEOS S7|S7-201c|S7-202u|S7-101|S7-103|S7-104|S7-105|S7-106|S7-201|S7-Slim|M2-A01L|BAH-L09|BAH-W09|AGS-L09|CMR-AL19",NecTablet:"\\bN-06D|\\bN-08D",PantechTablet:"Pantech.*P4100",BronchoTablet:"Broncho.*(N701|N708|N802|a710)",VersusTablet:"TOUCHPAD.*[78910]|\\bTOUCHTAB\\b",ZyncTablet:"z1000|Z99 2G|z930|z990|z909|Z919|z900",PositivoTablet:"TB07STA|TB10STA|TB07FTA|TB10FTA",NabiTablet:"Android.*\\bNabi",KoboTablet:"Kobo Touch|\\bK080\\b|\\bVox\\b Build|\\bArc\\b Build",
DanewTablet:"DSlide.*\\b(700|701R|702|703R|704|802|970|971|972|973|974|1010|1012)\\b",TexetTablet:"NaviPad|TB-772A|TM-7045|TM-7055|TM-9750|TM-7016|TM-7024|TM-7026|TM-7041|TM-7043|TM-7047|TM-8041|TM-9741|TM-9747|TM-9748|TM-9751|TM-7022|TM-7021|TM-7020|TM-7011|TM-7010|TM-7023|TM-7025|TM-7037W|TM-7038W|TM-7027W|TM-9720|TM-9725|TM-9737W|TM-1020|TM-9738W|TM-9740|TM-9743W|TB-807A|TB-771A|TB-727A|TB-725A|TB-719A|TB-823A|TB-805A|TB-723A|TB-715A|TB-707A|TB-705A|TB-709A|TB-711A|TB-890HD|TB-880HD|TB-790HD|TB-780HD|TB-770HD|TB-721HD|TB-710HD|TB-434HD|TB-860HD|TB-840HD|TB-760HD|TB-750HD|TB-740HD|TB-730HD|TB-722HD|TB-720HD|TB-700HD|TB-500HD|TB-470HD|TB-431HD|TB-430HD|TB-506|TB-504|TB-446|TB-436|TB-416|TB-146SE|TB-126SE",
PlaystationTablet:"Playstation.*(Portable|Vita)",TrekstorTablet:"ST10416-1|VT10416-1|ST70408-1|ST702xx-1|ST702xx-2|ST80208|ST97216|ST70104-2|VT10416-2|ST10216-2A|SurfTab",PyleAudioTablet:"\\b(PTBL10CEU|PTBL10C|PTBL72BC|PTBL72BCEU|PTBL7CEU|PTBL7C|PTBL92BC|PTBL92BCEU|PTBL9CEU|PTBL9CUK|PTBL9C)\\b",AdvanTablet:"Android.* \\b(E3A|T3X|T5C|T5B|T3E|T3C|T3B|T1J|T1F|T2A|T1H|T1i|E1C|T1-E|T5-A|T4|E1-B|T2Ci|T1-B|T1-D|O1-A|E1-A|T1-A|T3A|T4i)\\b ",DanyTechTablet:"Genius Tab G3|Genius Tab S2|Genius Tab Q3|Genius Tab G4|Genius Tab Q4|Genius Tab G-II|Genius TAB GII|Genius TAB GIII|Genius Tab S1",
GalapadTablet:"Android.*\\bG1\\b(?!\\))",MicromaxTablet:"Funbook|Micromax.*\\b(P250|P560|P360|P362|P600|P300|P350|P500|P275)\\b",KarbonnTablet:"Android.*\\b(A39|A37|A34|ST8|ST10|ST7|Smart Tab3|Smart Tab2)\\b",AllFineTablet:"Fine7 Genius|Fine7 Shine|Fine7 Air|Fine8 Style|Fine9 More|Fine10 Joy|Fine11 Wide",PROSCANTablet:"\\b(PEM63|PLT1023G|PLT1041|PLT1044|PLT1044G|PLT1091|PLT4311|PLT4311PL|PLT4315|PLT7030|PLT7033|PLT7033D|PLT7035|PLT7035D|PLT7044K|PLT7045K|PLT7045KB|PLT7071KG|PLT7072|PLT7223G|PLT7225G|PLT7777G|PLT7810K|PLT7849G|PLT7851G|PLT7852G|PLT8015|PLT8031|PLT8034|PLT8036|PLT8080K|PLT8082|PLT8088|PLT8223G|PLT8234G|PLT8235G|PLT8816K|PLT9011|PLT9045K|PLT9233G|PLT9735|PLT9760G|PLT9770G)\\b",
YONESTablet:"BQ1078|BC1003|BC1077|RK9702|BC9730|BC9001|IT9001|BC7008|BC7010|BC708|BC728|BC7012|BC7030|BC7027|BC7026",ChangJiaTablet:"TPC7102|TPC7103|TPC7105|TPC7106|TPC7107|TPC7201|TPC7203|TPC7205|TPC7210|TPC7708|TPC7709|TPC7712|TPC7110|TPC8101|TPC8103|TPC8105|TPC8106|TPC8203|TPC8205|TPC8503|TPC9106|TPC9701|TPC97101|TPC97103|TPC97105|TPC97106|TPC97111|TPC97113|TPC97203|TPC97603|TPC97809|TPC97205|TPC10101|TPC10103|TPC10106|TPC10111|TPC10203|TPC10205|TPC10503",GUTablet:"TX-A1301|TX-M9002|Q702|kf026",
PointOfViewTablet:"TAB-P506|TAB-navi-7-3G-M|TAB-P517|TAB-P-527|TAB-P701|TAB-P703|TAB-P721|TAB-P731N|TAB-P741|TAB-P825|TAB-P905|TAB-P925|TAB-PR945|TAB-PL1015|TAB-P1025|TAB-PI1045|TAB-P1325|TAB-PROTAB[0-9]+|TAB-PROTAB25|TAB-PROTAB26|TAB-PROTAB27|TAB-PROTAB26XL|TAB-PROTAB2-IPS9|TAB-PROTAB30-IPS9|TAB-PROTAB25XXL|TAB-PROTAB26-IPS10|TAB-PROTAB30-IPS10",OvermaxTablet:"OV-(SteelCore|NewBase|Basecore|Baseone|Exellen|Quattor|EduTab|Solution|ACTION|BasicTab|TeddyTab|MagicTab|Stream|TB-08|TB-09)|Qualcore 1027",
HCLTablet:"HCL.*Tablet|Connect-3G-2.0|Connect-2G-2.0|ME Tablet U1|ME Tablet U2|ME Tablet G1|ME Tablet X1|ME Tablet Y2|ME Tablet Sync",DPSTablet:"DPS Dream 9|DPS Dual 7",VistureTablet:"V97 HD|i75 3G|Visture V4( HD)?|Visture V5( HD)?|Visture V10",CrestaTablet:"CTP(-)?810|CTP(-)?818|CTP(-)?828|CTP(-)?838|CTP(-)?888|CTP(-)?978|CTP(-)?980|CTP(-)?987|CTP(-)?988|CTP(-)?989",MediatekTablet:"\\bMT8125|MT8389|MT8135|MT8377\\b",ConcordeTablet:"Concorde([ ]+)?Tab|ConCorde ReadMan",GoCleverTablet:"GOCLEVER TAB|A7GOCLEVER|M1042|M7841|M742|R1042BK|R1041|TAB A975|TAB A7842|TAB A741|TAB A741L|TAB M723G|TAB M721|TAB A1021|TAB I921|TAB R721|TAB I720|TAB T76|TAB R70|TAB R76.2|TAB R106|TAB R83.2|TAB M813G|TAB I721|GCTA722|TAB I70|TAB I71|TAB S73|TAB R73|TAB R74|TAB R93|TAB R75|TAB R76.1|TAB A73|TAB A93|TAB A93.2|TAB T72|TAB R83|TAB R974|TAB R973|TAB A101|TAB A103|TAB A104|TAB A104.2|R105BK|M713G|A972BK|TAB A971|TAB R974.2|TAB R104|TAB R83.3|TAB A1042",
ModecomTablet:"FreeTAB 9000|FreeTAB 7.4|FreeTAB 7004|FreeTAB 7800|FreeTAB 2096|FreeTAB 7.5|FreeTAB 1014|FreeTAB 1001 |FreeTAB 8001|FreeTAB 9706|FreeTAB 9702|FreeTAB 7003|FreeTAB 7002|FreeTAB 1002|FreeTAB 7801|FreeTAB 1331|FreeTAB 1004|FreeTAB 8002|FreeTAB 8014|FreeTAB 9704|FreeTAB 1003",VoninoTablet:"\\b(Argus[ _]?S|Diamond[ _]?79HD|Emerald[ _]?78E|Luna[ _]?70C|Onyx[ _]?S|Onyx[ _]?Z|Orin[ _]?HD|Orin[ _]?S|Otis[ _]?S|SpeedStar[ _]?S|Magnet[ _]?M9|Primus[ _]?94[ _]?3G|Primus[ _]?94HD|Primus[ _]?QS|Android.*\\bQ8\\b|Sirius[ _]?EVO[ _]?QS|Sirius[ _]?QS|Spirit[ _]?S)\\b",
ECSTablet:"V07OT2|TM105A|S10OT1|TR10CS1",StorexTablet:"eZee[_']?(Tab|Go)[0-9]+|TabLC7|Looney Tunes Tab",VodafoneTablet:"SmartTab([ ]+)?[0-9]+|SmartTabII10|SmartTabII7|VF-1497|VFD 1400",EssentielBTablet:"Smart[ ']?TAB[ ]+?[0-9]+|Family[ ']?TAB2",RossMoorTablet:"RM-790|RM-997|RMD-878G|RMD-974R|RMT-705A|RMT-701|RME-601|RMT-501|RMT-711",iMobileTablet:"i-mobile i-note",TolinoTablet:"tolino tab [0-9.]+|tolino shine",AudioSonicTablet:"\\bC-22Q|T7-QC|T-17B|T-17P\\b",AMPETablet:"Android.* A78 ",SkkTablet:"Android.* (SKYPAD|PHOENIX|CYCLOPS)",
TecnoTablet:"TECNO P9|TECNO DP8D",JXDTablet:"Android.* \\b(F3000|A3300|JXD5000|JXD3000|JXD2000|JXD300B|JXD300|S5800|S7800|S602b|S5110b|S7300|S5300|S602|S603|S5100|S5110|S601|S7100a|P3000F|P3000s|P101|P200s|P1000m|P200m|P9100|P1000s|S6600b|S908|P1000|P300|S18|S6600|S9100)\\b",iJoyTablet:"Tablet (Spirit 7|Essentia|Galatea|Fusion|Onix 7|Landa|Titan|Scooby|Deox|Stella|Themis|Argon|Unique 7|Sygnus|Hexen|Finity 7|Cream|Cream X2|Jade|Neon 7|Neron 7|Kandy|Scape|Saphyr 7|Rebel|Biox|Rebel|Rebel 8GB|Myst|Draco 7|Myst|Tab7-004|Myst|Tadeo Jones|Tablet Boing|Arrow|Draco Dual Cam|Aurix|Mint|Amity|Revolution|Finity 9|Neon 9|T9w|Amity 4GB Dual Cam|Stone 4GB|Stone 8GB|Andromeda|Silken|X2|Andromeda II|Halley|Flame|Saphyr 9,7|Touch 8|Planet|Triton|Unique 10|Hexen 10|Memphis 4GB|Memphis 8GB|Onix 10)",
FX2Tablet:"FX2 PAD7|FX2 PAD10",XoroTablet:"KidsPAD 701|PAD[ ]?712|PAD[ ]?714|PAD[ ]?716|PAD[ ]?717|PAD[ ]?718|PAD[ ]?720|PAD[ ]?721|PAD[ ]?722|PAD[ ]?790|PAD[ ]?792|PAD[ ]?900|PAD[ ]?9715D|PAD[ ]?9716DR|PAD[ ]?9718DR|PAD[ ]?9719QR|PAD[ ]?9720QR|TelePAD1030|Telepad1032|TelePAD730|TelePAD731|TelePAD732|TelePAD735Q|TelePAD830|TelePAD9730|TelePAD795|MegaPAD 1331|MegaPAD 1851|MegaPAD 2151",ViewsonicTablet:"ViewPad 10pi|ViewPad 10e|ViewPad 10s|ViewPad E72|ViewPad7|ViewPad E100|ViewPad 7e|ViewSonic VB733|VB100a",
VerizonTablet:"QTAQZ3|QTAIR7|QTAQTZ3|QTASUN1|QTASUN2|QTAXIA1",OdysTablet:"LOOX|XENO10|ODYS[ -](Space|EVO|Xpress|NOON)|\\bXELIO\\b|Xelio10Pro|XELIO7PHONETAB|XELIO10EXTREME|XELIOPT2|NEO_QUAD10",CaptivaTablet:"CAPTIVA PAD",IconbitTablet:"NetTAB|NT-3702|NT-3702S|NT-3702S|NT-3603P|NT-3603P|NT-0704S|NT-0704S|NT-3805C|NT-3805C|NT-0806C|NT-0806C|NT-0909T|NT-0909T|NT-0907S|NT-0907S|NT-0902S|NT-0902S",TeclastTablet:"T98 4G|\\bP80\\b|\\bX90HD\\b|X98 Air|X98 Air 3G|\\bX89\\b|P80 3G|\\bX80h\\b|P98 Air|\\bX89HD\\b|P98 3G|\\bP90HD\\b|P89 3G|X98 3G|\\bP70h\\b|P79HD 3G|G18d 3G|\\bP79HD\\b|\\bP89s\\b|\\bA88\\b|\\bP10HD\\b|\\bP19HD\\b|G18 3G|\\bP78HD\\b|\\bA78\\b|\\bP75\\b|G17s 3G|G17h 3G|\\bP85t\\b|\\bP90\\b|\\bP11\\b|\\bP98t\\b|\\bP98HD\\b|\\bG18d\\b|\\bP85s\\b|\\bP11HD\\b|\\bP88s\\b|\\bA80HD\\b|\\bA80se\\b|\\bA10h\\b|\\bP89\\b|\\bP78s\\b|\\bG18\\b|\\bP85\\b|\\bA70h\\b|\\bA70\\b|\\bG17\\b|\\bP18\\b|\\bA80s\\b|\\bA11s\\b|\\bP88HD\\b|\\bA80h\\b|\\bP76s\\b|\\bP76h\\b|\\bP98\\b|\\bA10HD\\b|\\bP78\\b|\\bP88\\b|\\bA11\\b|\\bA10t\\b|\\bP76a\\b|\\bP76t\\b|\\bP76e\\b|\\bP85HD\\b|\\bP85a\\b|\\bP86\\b|\\bP75HD\\b|\\bP76v\\b|\\bA12\\b|\\bP75a\\b|\\bA15\\b|\\bP76Ti\\b|\\bP81HD\\b|\\bA10\\b|\\bT760VE\\b|\\bT720HD\\b|\\bP76\\b|\\bP73\\b|\\bP71\\b|\\bP72\\b|\\bT720SE\\b|\\bC520Ti\\b|\\bT760\\b|\\bT720VE\\b|T720-3GE|T720-WiFi",
OndaTablet:"\\b(V975i|Vi30|VX530|V701|Vi60|V701s|Vi50|V801s|V719|Vx610w|VX610W|V819i|Vi10|VX580W|Vi10|V711s|V813|V811|V820w|V820|Vi20|V711|VI30W|V712|V891w|V972|V819w|V820w|Vi60|V820w|V711|V813s|V801|V819|V975s|V801|V819|V819|V818|V811|V712|V975m|V101w|V961w|V812|V818|V971|V971s|V919|V989|V116w|V102w|V973|Vi40)\\b[\\s]+|V10 \\b4G\\b",JaytechTablet:"TPC-PA762",BlaupunktTablet:"Endeavour 800NG|Endeavour 1010",DigmaTablet:"\\b(iDx10|iDx9|iDx8|iDx7|iDxD7|iDxD8|iDsQ8|iDsQ7|iDsQ8|iDsD10|iDnD7|3TS804H|iDsQ11|iDj7|iDs10)\\b",
EvolioTablet:"ARIA_Mini_wifi|Aria[ _]Mini|Evolio X10|Evolio X7|Evolio X8|\\bEvotab\\b|\\bNeura\\b",LavaTablet:"QPAD E704|\\bIvoryS\\b|E-TAB IVORY|\\bE-TAB\\b",AocTablet:"MW0811|MW0812|MW0922|MTK8382|MW1031|MW0831|MW0821|MW0931|MW0712",MpmanTablet:"MP11 OCTA|MP10 OCTA|MPQC1114|MPQC1004|MPQC994|MPQC974|MPQC973|MPQC804|MPQC784|MPQC780|\\bMPG7\\b|MPDCG75|MPDCG71|MPDC1006|MP101DC|MPDC9000|MPDC905|MPDC706HD|MPDC706|MPDC705|MPDC110|MPDC100|MPDC99|MPDC97|MPDC88|MPDC8|MPDC77|MP709|MID701|MID711|MID170|MPDC703|MPQC1010",
CelkonTablet:"CT695|CT888|CT[\\s]?910|CT7 Tab|CT9 Tab|CT3 Tab|CT2 Tab|CT1 Tab|C820|C720|\\bCT-1\\b",WolderTablet:"miTab \\b(DIAMOND|SPACE|BROOKLYN|NEO|FLY|MANHATTAN|FUNK|EVOLUTION|SKY|GOCAR|IRON|GENIUS|POP|MINT|EPSILON|BROADWAY|JUMP|HOP|LEGEND|NEW AGE|LINE|ADVANCE|FEEL|FOLLOW|LIKE|LINK|LIVE|THINK|FREEDOM|CHICAGO|CLEVELAND|BALTIMORE-GH|IOWA|BOSTON|SEATTLE|PHOENIX|DALLAS|IN 101|MasterChef)\\b",MediacomTablet:"M-MPI10C3G|M-SP10EG|M-SP10EGP|M-SP10HXAH|M-SP7HXAH|M-SP10HXBH|M-SP8HXAH|M-SP8MXA",MiTablet:"\\bMI PAD\\b|\\bHM NOTE 1W\\b",
NibiruTablet:"Nibiru M1|Nibiru Jupiter One",NexoTablet:"NEXO NOVA|NEXO 10|NEXO AVIO|NEXO FREE|NEXO GO|NEXO EVO|NEXO 3G|NEXO SMART|NEXO KIDDO|NEXO MOBI",LeaderTablet:"TBLT10Q|TBLT10I|TBL-10WDKB|TBL-10WDKBO2013|TBL-W230V2|TBL-W450|TBL-W500|SV572|TBLT7I|TBA-AC7-8G|TBLT79|TBL-8W16|TBL-10W32|TBL-10WKB|TBL-W100",UbislateTablet:"UbiSlate[\\s]?7C",PocketBookTablet:"Pocketbook",KocasoTablet:"\\b(TB-1207)\\b",HisenseTablet:"\\b(F5281|E2371)\\b",Hudl:"Hudl HT7S3|Hudl 2",TelstraTablet:"T-Hub2",GenericTablet:"Android.*\\b97D\\b|Tablet(?!.*PC)|BNTV250A|MID-WCDMA|LogicPD Zoom2|\\bA7EB\\b|CatNova8|A1_07|CT704|CT1002|\\bM721\\b|rk30sdk|\\bEVOTAB\\b|M758A|ET904|ALUMIUM10|Smartfren Tab|Endeavour 1010|Tablet-PC-4|Tagi Tab|\\bM6pro\\b|CT1020W|arc 10HD|\\bTP750\\b|\\bQTAQZ3\\b|WVT101|TM1088|KT107"},
oss:{AndroidOS:"Android",BlackBerryOS:"blackberry|\\bBB10\\b|rim tablet os",PalmOS:"PalmOS|avantgo|blazer|elaine|hiptop|palm|plucker|xiino",SymbianOS:"Symbian|SymbOS|Series60|Series40|SYB-[0-9]+|\\bS60\\b",WindowsMobileOS:"Windows CE.*(PPC|Smartphone|Mobile|[0-9]{3}x[0-9]{3})|Windows Mobile|Windows Phone [0-9.]+|WCE;",WindowsPhoneOS:"Windows Phone 10.0|Windows Phone 8.1|Windows Phone 8.0|Windows Phone OS|XBLWP7|ZuneWP7|Windows NT 6.[23]; ARM;",iOS:"\\biPhone.*Mobile|\\biPod|\\biPad|AppleCoreMedia",
iPadOS:"CPU OS 13",MeeGoOS:"MeeGo",MaemoOS:"Maemo",JavaOS:"J2ME/|\\bMIDP\\b|\\bCLDC\\b",webOS:"webOS|hpwOS",badaOS:"\\bBada\\b",BREWOS:"BREW",Windows:"Windows","Windows NT":"Windows NT","OS X":"Mac OS X",Debian:"Debian",Ubuntu:"Ubuntu",Macintosh:"PPC",OpenBSD:"OpenBSD",Linux:"Linux",ChromeOS:"CrOS"},uas:{Dolfin:"\\bDolfin\\b",Skyfire:"Skyfire",Bolt:"bolt",TeaShark:"teashark",Blazer:"Blazer",WeChat:"\\bMicroMessenger\\b",baiduboxapp:"baiduboxapp",baidubrowser:"baidubrowser",DiigoBrowser:"DiigoBrowser",
Mercury:"\\bMercury\\b",ObigoBrowser:"Obigo",NetFront:"NF-Browser",GenericBrowser:"NokiaBrowser|OviBrowser|OneBrowser|TwonkyBeamBrowser|SEMC.*Browser|FlyFlow|Minimo|NetFront|Novarra-Vision|MQQBrowser|MicroMessenger",PaleMoon:"Android.*PaleMoon|Mobile.*PaleMoon","Opera Mini":"Opera Mini",Opera:"Opera|OPR",Edge:"Edge",UCBrowser:"UCBrowser",Vivaldi:"Vivaldi",Chrome:"Chrome",Firefox:"Firefox",Safari:"Safari",IE:"MSIE|IEMobile|MSIEMobile|Trident/[.0-9]+",Netscape:"Netscape",Mozilla:"Mozilla"},props:{Mobile:"Mobile/[VER]",
Build:"Build/[VER]",Version:"Version/[VER]",VendorID:"VendorID/[VER]",iPad:"iPad.*CPU[a-z ]+[VER]",iPhone:"iPhone.*CPU[a-z ]+[VER]",iPod:"iPod.*CPU[a-z ]+[VER]",Kindle:"Kindle/[VER]",Chrome:["Chrome/[VER]","CriOS/[VER]","CrMo/[VER]"],Coast:["Coast/[VER]"],Dolfin:"Dolfin/[VER]",Firefox:["Firefox/[VER]","FxiOS/[VER]"],Fennec:"Fennec/[VER]",NetFront:"NetFront/[VER]",NokiaBrowser:"NokiaBrowser/[VER]","Opera Mobi":"Version/[VER]",UCBrowser:["UCWEB[VER]","UC.*Browser/[VER]"],MQQBrowser:"MQQBrowser/[VER]",
MicroMessenger:"MicroMessenger/[VER]",baiduboxapp:"baiduboxapp/[VER]",baidubrowser:"baidubrowser/[VER]",SamsungBrowser:"SamsungBrowser/[VER]",Iron:"Iron/[VER]",Safari:["Version/[VER]","Safari/[VER]"],Skyfire:"Skyfire/[VER]",Tizen:"Tizen/[VER]",Webkit:"webkit[ /][VER]",PaleMoon:"PaleMoon/[VER]",Gecko:"Gecko/[VER]",Trident:"Trident/[VER]",Presto:"Presto/[VER]",Goanna:"Goanna/[VER]",iOS:" \\bi?OS\\b [VER][ ;]{1}",Android:"Android [VER]",BlackBerry:["BlackBerry[\\w]+/[VER]","BlackBerry.*Version/[VER]",
"Version/[VER]"],BREW:"BREW [VER]",Java:"Java/[VER]","Windows Phone OS":["Windows Phone OS [VER]","Windows Phone [VER]"],"Windows Phone":"Windows Phone [VER]","Windows CE":"Windows CE/[VER]",Symbian:["SymbianOS/[VER]","Symbian/[VER]"],webOS:["webOS/[VER]","hpwOS/[VER];"],Windows:"Windows NT [VER]","Windows NT":"Windows NT [VER]","OS X":"OS X [VER]",BlackBerryOS:["BlackBerry[w]+/[VER]","BlackBerry.*Version/[VER]","Version/[VER]"],AndroidOS:"Android [VER]",ChromeOS:"CrOS x86_64 [VER]","Opera Mini":"Opera Mini/[VER]",
Opera:[" OPR/[VER]","Opera Mini/[VER]","Version/[VER]","Opera [VER]"],Netscape:"Netscape/[VER]",Mozilla:"rv:[VER]",IE:["IEMobile/[VER];","IEMobile [VER]","MSIE [VER];","rv:[VER]"],Edge:"Edge/[VER]",Vivaldi:"Vivaldi/[VER]"},utils:{Bot:"Googlebot|facebookexternalhit|Google-AMPHTML|s~amp-validator|AdsBot-Google|Google Keyword Suggestion|Facebot|YandexBot|YandexMobileBot|bingbot|ia_archiver|AhrefsBot|Ezooms|GSLFbot|WBSearchBot|Twitterbot|TweetmemeBot|Twikle|PaperLiBot|Wotbox|UnwindFetchor|Exabot|MJ12bot|YandexImages|TurnitinBot|Pingdom|contentkingapp",
MobileBot:"Googlebot-Mobile|AdsBot-Google-Mobile|YahooSeeker/M1A1-R2D2",DesktopMode:"WPDesktop",TV:"SonyDTV|HbbTV",WebKit:"(webkit)[ /]([\\w.]+)",Console:"\\b(Nintendo|Nintendo WiiU|Nintendo 3DS|Nintendo Switch|PLAYSTATION|Xbox)\\b",Watch:"SM-V700",Macintosh:"Macintosh"}},detectMobileBrowsers:{fullPattern:/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i,
shortPattern:/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i,
tabletPattern:/android|ipad|playbook|silk/i}},l=Object.prototype.hasOwnProperty;b.FALLBACK_PHONE="UnknownPhone";b.FALLBACK_TABLET="UnknownTablet";b.FALLBACK_MOBILE="UnknownMobile";var n="isArray"in Array?Array.isArray:function(a){return"[object Array]"===Object.prototype.toString.call(a)};(function(){var a,c,e=b.mobileDetectRules;for(a in e.props)if(l.call(e.props,a)){var d=e.props[a];n(d)||(d=[d]);var f=d.length;for(c=0;c<f;++c){var g=d[c];var h=g.indexOf("[VER]");0<=h&&(g=g.substring(0,h)+"([\\w._\\+]+)"+
g.substring(h+5));d[c]=new RegExp(g,"i")}e.props[a]=d}k(e.oss);k(e.phones);k(e.tablets);k(e.uas);k(e.utils);e.oss0={WindowsPhoneOS:e.oss.WindowsPhoneOS,WindowsMobileOS:e.oss.WindowsMobileOS}})();b.findMatch=function(a,b){for(var c in a)if(l.call(a,c)&&a[c].test(b))return c;return null};b.findMatches=function(a,b){var c=[],d;for(d in a)l.call(a,d)&&a[d].test(b)&&c.push(d);return c};b.getVersionStr=function(a,c){var e=b.mobileDetectRules.props,d;if(l.call(e,a)){e=e[a];var f=e.length;for(d=0;d<f;++d){var g=
e[d].exec(c);if(null!==g)return g[1]}}return null};b.getVersion=function(a,c){var e=b.getVersionStr(a,c);return e?b.prepareVersionNo(e):NaN};b.prepareVersionNo=function(a){var b=a.split(/[a-z._ \/\-]/i);1===b.length&&(a=b[0]);1<b.length&&(a=b[0]+".",b.shift(),a+=b.join(""));return Number(a)};b.isMobileFallback=function(a){return b.detectMobileBrowsers.fullPattern.test(a)||b.detectMobileBrowsers.shortPattern.test(a.substr(0,4))};b.isTabletFallback=function(a){return b.detectMobileBrowsers.tabletPattern.test(a)};
b.prepareDetectionCache=function(a,c,e){if(a.mobile===f){var d;(d=b.findMatch(b.mobileDetectRules.tablets,c))?(a.mobile=a.tablet=d,a.phone=null):(d=b.findMatch(b.mobileDetectRules.phones,c))?(a.mobile=a.phone=d,a.tablet=null):b.isMobileFallback(c)?(c=g.isPhoneSized(e),c===f?(a.mobile=b.FALLBACK_MOBILE,a.tablet=a.phone=null):c?(a.mobile=a.phone=b.FALLBACK_PHONE,a.tablet=null):(a.mobile=a.tablet=b.FALLBACK_TABLET,a.phone=null)):b.isTabletFallback(c)?(a.mobile=a.tablet=b.FALLBACK_TABLET,a.phone=null):
a.mobile=a.tablet=a.phone=null}};b.mobileGrade=function(a){var b=null!==a.mobile();if(a.os("iOS")&&4.3<=a.version("iPad")||a.os("iOS")&&3.1<=a.version("iPhone")||a.os("iOS")&&3.1<=a.version("iPod")||2.1<a.version("Android")&&a.is("Webkit")||7<=a.version("Windows Phone OS")||a.is("BlackBerry")&&6<=a.version("BlackBerry")||a.match("Playbook.*Tablet")||1.4<=a.version("webOS")&&a.match("Palm|Pre|Pixi")||a.match("hp.*TouchPad")||a.is("Firefox")&&12<=a.version("Firefox")||a.is("Chrome")&&a.is("AndroidOS")&&
4<=a.version("Android")||a.is("Skyfire")&&4.1<=a.version("Skyfire")&&a.is("AndroidOS")&&2.3<=a.version("Android")||a.is("Opera")&&11<a.version("Opera Mobi")&&a.is("AndroidOS")||a.is("MeeGoOS")||a.is("Tizen")||a.is("Dolfin")&&2<=a.version("Bada")||(a.is("UC Browser")||a.is("Dolfin"))&&2.3<=a.version("Android")||a.match("Kindle Fire")||a.is("Kindle")&&3<=a.version("Kindle")||a.is("AndroidOS")&&a.is("NookTablet")||11<=a.version("Chrome")&&!b||5<=a.version("Safari")&&!b||4<=a.version("Firefox")&&!b||
7<=a.version("MSIE")&&!b||10<=a.version("Opera")&&!b)return"A";if(a.os("iOS")&&4.3>a.version("iPad")||a.os("iOS")&&3.1>a.version("iPhone")||a.os("iOS")&&3.1>a.version("iPod")||a.is("Blackberry")&&5<=a.version("BlackBerry")&&6>a.version("BlackBerry")||5<=a.version("Opera Mini")&&6.5>=a.version("Opera Mini")&&(2.3<=a.version("Android")||a.is("iOS"))||a.match("NokiaN8|NokiaC7|N97.*Series60|Symbian/3")||11<=a.version("Opera Mobi")&&a.is("SymbianOS"))return"B";5>a.version("BlackBerry")||a.match("MSIEMobile|Windows CE.*Mobile")||
a.version("Windows Mobile");return"C"};b.detectOS=function(a){return b.findMatch(b.mobileDetectRules.oss0,a)||b.findMatch(b.mobileDetectRules.oss,a)};b.getDeviceSmallerSide=function(){return window.screen.width<window.screen.height?window.screen.width:window.screen.height};g.prototype={constructor:g,mobile:function(){b.prepareDetectionCache(this._cache,this.ua,this.maxPhoneWidth);return this._cache.mobile},phone:function(){b.prepareDetectionCache(this._cache,this.ua,this.maxPhoneWidth);return this._cache.phone},
tablet:function(){b.prepareDetectionCache(this._cache,this.ua,this.maxPhoneWidth);return this._cache.tablet},userAgent:function(){this._cache.userAgent===f&&(this._cache.userAgent=b.findMatch(b.mobileDetectRules.uas,this.ua));return this._cache.userAgent},userAgents:function(){this._cache.userAgents===f&&(this._cache.userAgents=b.findMatches(b.mobileDetectRules.uas,this.ua));return this._cache.userAgents},os:function(){this._cache.os===f&&(this._cache.os=b.detectOS(this.ua));return this._cache.os},
version:function(a){return b.getVersion(a,this.ua)},versionStr:function(a){return b.getVersionStr(a,this.ua)},is:function(a){return h(this.userAgents(),a)||m(a,this.os())||m(a,this.phone())||m(a,this.tablet())||h(b.findMatches(b.mobileDetectRules.utils,this.ua),a)},match:function(a){a instanceof RegExp||(a=new RegExp(a,"i"));return a.test(this.ua)},isPhoneSized:function(a){return g.isPhoneSized(a||this.maxPhoneWidth)},mobileGrade:function(){this._cache.grade===f&&(this._cache.grade=b.mobileGrade(this));
return this._cache.grade}};g.isPhoneSized="undefined"!==typeof window&&window.screen?function(a){return 0>a?f:b.getDeviceSmallerSide()<=a}:function(){};g._impl=b;g.version="1.4.4 2019-09-21";return g})})(function(h){if("undefined"!==typeof module&&module.exports)return function(f){module.exports=f()};if("function"===typeof define&&define.amd)return define;if("undefined"!==typeof window)return function(f){window.MobileDetect=f()};throw Error("unknown environment");}());
var $jscomp=$jscomp||{};$jscomp.scope={};$jscomp.createTemplateTagFirstArg=function(a){return a.raw=a};$jscomp.createTemplateTagFirstArgWithRaw=function(a,n){a.raw=n;return a};$jscomp.arrayIteratorImpl=function(a){var n=0;return function(){return n<a.length?{done:!1,value:a[n++]}:{done:!0}}};$jscomp.arrayIterator=function(a){return{next:$jscomp.arrayIteratorImpl(a)}};$jscomp.makeIterator=function(a){var n="undefined"!=typeof Symbol&&Symbol.iterator&&a[Symbol.iterator];return n?n.call(a):$jscomp.arrayIterator(a)};
jQuery(function(a){function n(c){c=c.match(ba);return null!=c&&1<c.length&&"string"===typeof c[1]&&0<c[1].length?c[1].toLowerCase():null}function E(c){return c.includes(":")?(c=c.split(":"),1E3*(3600*parseInt(c[0])+60*parseInt(c[1])+parseInt(c[2]))):null}function v(c){try{var l=Date.parse(c);isNaN(l)&&(l=null)}catch(G){l=null}if(null==l&&c.includes(" ")){c=c.split(" ");try{l=Date.parse(c[0]),l+=E(c[1]),isNaN(l)&&(l=null)}catch(G){l=null}}return l}function H(){(jQuery("#ai-iab-tcf-bar").length||jQuery(".ai-list-manual").length)&&
"function"==typeof __tcfapi&&"function"==typeof ai_load_blocks&&"undefined"==typeof ai_iab_tcf_callback_installed&&(__tcfapi("addEventListener",2,function(c,l){l&&"useractioncomplete"===c.eventStatus&&(ai_tcData=c,ai_load_blocks(),jQuery("#ai-iab-tcf-status").text("IAB TCF 2.0 DATA LOADED"),jQuery("#ai-iab-tcf-bar").addClass("status-ok").removeClass("status-error"))}),ai_iab_tcf_callback_installed=!0)}function w(c){c=("; "+document.cookie).split("; "+c+"=");if(2===c.length)return c.pop().split(";").shift()}
function k(c){if(w(c)){var l=window.location.hostname;w(c)&&(document.cookie=c+"=;path=/"+(l?";domain="+l:"")+";expires=Thu, 01 Jan 1970 00:00:01 GMT");document.cookie=c+"=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;"}}Array.prototype.includes||(Array.prototype.includes=function(c){return!!~this.indexOf(c)});var ba=RegExp(":\\/\\/(.[^/:]+)","i");ai_process_lists=function(c){function l(m,e,d){if(0==m.length){if("!@!"==d)return!0;e!=d&&("true"==d.toLowerCase()?d=!0:"false"==d.toLowerCase()&&(d=
!1));return e==d}if("object"!=typeof e&&"array"!=typeof e)return!1;var h=m[0];m=m.slice(1);if("*"==h)for(e=$jscomp.makeIterator(Object.entries(e)),h=e.next();!h.done;h=e.next()){if(h=$jscomp.makeIterator(h.value),h.next(),h=h.next().value,l(m,h,d))return!0}else if(h in e)return l(m,e[h],d);return!1}function G(m,e,d){if("object"!=typeof m||-1==e.indexOf("["))return!1;e=e.replace(/]| /gi,"").split("[");return l(e,m,d)}function ca(){"function"==typeof __tcfapi&&(a("#ai-iab-tcf-status").text("IAB TCF 2.0 DETECTED"),
__tcfapi("getTCData",2,function(m,e){e?(a("#ai-iab-tcf-bar").addClass("status-ok"),"tcloaded"==m.eventStatus||"useractioncomplete"==m.eventStatus?(ai_tcData=m,m.gdprApplies?a("#ai-iab-tcf-status").text("IAB TCF 2.0 DATA LOADED"):jQuery("#ai-iab-tcf-status").text("IAB TCF 2.0 GDPR DOES NOT APPLY"),a("#ai-iab-tcf-bar").addClass("status-ok").removeClass("status-error"),setTimeout(function(){ai_process_lists()},10)):"cmpuishown"==m.eventStatus&&(ai_cmpuishown=!0,a("#ai-iab-tcf-status").text("IAB TCF 2.0 CMP UI SHOWN"),
a("#ai-iab-tcf-bar").addClass("status-ok").removeClass("status-error"))):(a("#ai-iab-tcf-status").text("IAB TCF 2.0 __tcfapi getTCData failed"),a("#ai-iab-tcf-bar").removeClass("status-ok").addClass("status-error"))}))}function K(m){"function"==typeof __tcfapi?("undefined"==typeof ai_iab_tcf_callback_installed&&H(),"undefined"==typeof ai_tcData_requested&&(ai_tcData_requested=!0,ca(),cookies_need_tcData=!0)):m&&(a("#ai-iab-tcf-bar").addClass("status-error").removeClass("status-ok"),a("#ai-iab-tcf-status").text("IAB TCF 2.0 MISSING: __tcfapi function not found"))}
c=null==c?a("div.ai-list-data, meta.ai-list-data"):c.filter(".ai-list-data");if(c.length){c.removeClass("ai-list-data");var V=getAllUrlParams(window.location.search);if(null!=V.referrer)var y=V.referrer;else y=document.referrer,""!=y&&(y=n(y));var R=window.navigator.userAgent,S=R.toLowerCase(),W=navigator.language,L=W.toLowerCase();if("undefined"!==typeof MobileDetect)var X=new MobileDetect(R);c.each(function(){var m=document.cookie.split(";");m.forEach(function(A,g){m[g]=A.trim()});var e=a(this).closest("div.ca-ca"),
d=!0,h=a(this).attr("referer-list");if("undefined"!=typeof h){h=dedd0f5d(h).split(",");var r=a(this).attr("referer-list-type"),I=!1;a.each(h,function(A,g){g=g.trim();if(""==g)return!0;if("*"==g.charAt(0))if("*"==g.charAt(g.length-1)){if(g=g.substr(1,g.length-2),-1!=y.indexOf(g))return I=!0,!1}else{if(g=g.substr(1),y.substr(-g.length)==g)return I=!0,!1}else if("*"==g.charAt(g.length-1)){if(g=g.substr(0,g.length-1),0==y.indexOf(g))return I=!0,!1}else if("#"==g){if(""==y)return I=!0,!1}else if(g==y)return I=
!0,!1});var p=I;switch(r){case "B":p&&(d=!1);break;case "W":p||(d=!1)}}if(d&&(h=a(this).attr("client-list"),"undefined"!=typeof h&&"undefined"!==typeof X))switch(h=dedd0f5d(h).split(","),r=a(this).attr("client-list-type"),p=!1,a.each(h,function(A,g){if(""==g.trim())return!0;var M=g.split("&&");a.each(M,function(da,b){var u=!0,t=!1;for(b=b.trim();"!!"==b.substring(0,2);)u=!u,b=b.substring(2);"language:"==b.substring(0,9)&&(t=!0,b=b.substring(9).toLowerCase());var q=!1;t?"*"==b.charAt(0)?"*"==b.charAt(b.length-
1)?(b=b.substr(1,b.length-2).toLowerCase(),-1!=L.indexOf(b)&&(q=!0)):(b=b.substr(1).toLowerCase(),L.substr(-b.length)==b&&(q=!0)):"*"==b.charAt(b.length-1)?(b=b.substr(0,b.length-1).toLowerCase(),0==L.indexOf(b)&&(q=!0)):b==L&&(q=!0):"*"==b.charAt(0)?"*"==b.charAt(b.length-1)?(b=b.substr(1,b.length-2).toLowerCase(),-1!=S.indexOf(b)&&(q=!0)):(b=b.substr(1).toLowerCase(),S.substr(-b.length)==b&&(q=!0)):"*"==b.charAt(b.length-1)?(b=b.substr(0,b.length-1).toLowerCase(),0==S.indexOf(b)&&(q=!0)):X.is(b)&&
(q=!0);p=q?u:!u;if(!p)return!1});if(p)return!1}),r){case "B":p&&(d=!1);break;case "W":p||(d=!1)}var N=h=!1;for(r=1;2>=r;r++)if(d){switch(r){case 1:var f=a(this).attr("cookie-list");break;case 2:f=a(this).attr("parameter-list")}if("undefined"!=typeof f){f=dedd0f5d(f);switch(r){case 1:var B=a(this).attr("cookie-list-type");break;case 2:B=a(this).attr("parameter-list-type")}f=f.replace("tcf-gdpr","tcf-v2[gdprApplies]=true");f=f.replace("tcf-no-gdpr","tcf-v2[gdprApplies]=false");f=f.replace("tcf-google",
"tcf-v2[vendor][consents][755]=true && tcf-v2[purpose][consents][1]=true");f=f.replace("tcf-no-google","!!tcf-v2[vendor][consents][755]");f=f.replace("tcf-media.net","tcf-v2[vendor][consents][142]=true && tcf-v2[purpose][consents][1]=true");f=f.replace("tcf-no-media.net","!!tcf-v2[vendor][consents][142]");f=f.replace("tcf-amazon","tcf-v2[vendor][consents][793]=true && tcf-v2[purpose][consents][1]=true");f=f.replace("tcf-no-amazon","!!tcf-v2[vendor][consents][793]");f=f.replace("tcf-ezoic","tcf-v2[vendor][consents][347]=true && tcf-v2[purpose][consents][1]=true");
f=f.replace("tcf-no-ezoic","!!tcf-v2[vendor][consents][347]");var D=f.split(","),Y=[];m.forEach(function(A){A=A.split("=");try{var g=JSON.parse(decodeURIComponent(A[1]))}catch(M){g=decodeURIComponent(A[1])}Y[A[0]]=g});p=!1;var O=a(this);a.each(D,function(A,g){var M=g.split("&&");a.each(M,function(da,b){var u=!0;for(b=b.trim();"!!"==b.substring(0,2);)u=!u,b=b.substring(2);var t=b,q="!@!",Z=-1!=b.indexOf("["),aa=(0==b.indexOf("tcf-v2")||0==b.indexOf("euconsent-v2"))&&-1!=b.indexOf("[");-1!=b.indexOf("=")&&
(q=b.split("="),t=q[0],q=q[1],Z=-1!=t.indexOf("["),aa=(0==t.indexOf("tcf-v2")||0==t.indexOf("euconsent-v2"))&&-1!=t.indexOf("["));if(aa)a("#ai-iab-tcf-bar").show(),"object"==typeof ai_tcData?(a("#ai-iab-tcf-bar").addClass("status-ok"),t=t.replace(/]| /gi,"").split("["),t.shift(),p=(t=l(t,ai_tcData,q))?u:!u):(O.addClass("ai-list-data"),N=!0,"function"==typeof __tcfapi?K(!1):"undefined"==typeof ai_tcData_retrying&&(ai_tcData_retrying=!0,setTimeout(function(){"function"==typeof __tcfapi?K(!1):setTimeout(function(){"function"==
typeof __tcfapi?K(!1):setTimeout(function(){K(!0)},3E3)},1E3)},600)));else if(Z)p=(t=G(Y,t,q))?u:!u;else{var T=!1;"!@!"==q?m.every(function(ea){return ea.split("=")[0]==b?(T=!0,!1):!0}):T=-1!=m.indexOf(b);p=T?u:!u}if(!p)return!1});if(p)return!1});p&&(N=!1);switch(B){case "B":p&&(d=!1);break;case "W":p||(d=!1)}}}a(this).hasClass("ai-list-manual")&&(d?(O.removeClass("ai-list-data"),O.removeClass("ai-list-manual")):(h=!0,O.addClass("ai-list-data")));if(d||!h&&!N)if(f=a(this).data("debug-info"),"undefined"!=
typeof f&&(f=a("."+f),0!=f.length)){var x=f.parent();x.hasClass("ai-debug-info")&&x.remove()}x=a(this).prevAll(".ai-debug-bar.ai-debug-lists");f=""==y?"#":y;x.find(".ai-debug-name.ai-list-info").text(f).attr("title",R+"\n"+W);x.find(".ai-debug-name.ai-list-status").text(d?ai_front.visible:ai_front.hidden);f=!1;if(d&&(r=a(this).attr("scheduling-start"),B=a(this).attr("scheduling-end"),D=a(this).attr("scheduling-days"),"undefined"!=typeof r&&"undefined"!=typeof B&&"undefined"!=typeof D)){f=!0;var z=
dedd0f5d(r),P=dedd0f5d(B),U=parseInt(a(this).attr("scheduling-fallback")),Q=parseInt(a(this).attr("gmt"));z.includes("-")||P.includes("-")?(B=v(z)+Q,r=v(P)+Q):(B=E(z),r=E(P));D=dedd0f5d(D).split(",");x=a(this).attr("scheduling-type");var C=(new Date).getTime()+Q,F=new Date(C),J=F.getDay();z.includes("-")||P.includes("-")||(z=(new Date(F.getFullYear(),F.getMonth(),F.getDate())).getTime()+Q,C-=z,0>C&&(C+=864E5));0==J?J=6:J--;z=C>=B&&C<r&&D.includes(J.toString());switch(x){case "B":z=!z}z||(d=!1);F=F.toISOString().split(".")[0].replace("T",
" ");x=a(this).prevAll(".ai-debug-bar.ai-debug-scheduling");x.find(".ai-debug-name.ai-scheduling-info").text(F+" "+J+" current_time:"+Math.floor(C.toString()/1E3)+"  start_date:"+Math.floor(B/1E3).toString()+" ="+(C>=B).toString()+" end_date:"+Math.floor(r/1E3).toString()+" =:"+(C<r).toString()+" days:"+D.toString()+" =:"+D.includes(J.toString()).toString());x.find(".ai-debug-name.ai-scheduling-status").text(d?ai_front.visible:ai_front.hidden);d||0==U||(x.removeClass("ai-debug-scheduling").addClass("ai-debug-fallback"),
x.find(".ai-debug-name.ai-scheduling-status").text(ai_front.fallback+" = "+U))}if(h||!d&&N)return!0;a(this).css({visibility:"",position:"",width:"",height:"","z-index":""});d?(e.css({visibility:""}),e.hasClass("ai-remove-position")&&e.css({position:""}),"undefined"!=typeof a(this).data("code")&&(d=dedd0f5d(a(this).data("code")),0!=a(this).closest("head").length?(a(this).after(d),a(this).remove()):a(this).append(d),ai_process_element_lists(this))):f&&!z&&0!=U?(e.css({visibility:""}),e.hasClass("ai-remove-position")&&
e.css({position:""}),a(this).next(".ai-fallback").removeClass("ai-fallback"),"undefined"!=typeof a(this).data("fallback-code")?(d=dedd0f5d(a(this).data("fallback-code")),a(this).append(d),ai_process_element_lists(this)):(a(this).hide(),!e.find(".ai-debug-block").length&&e[0].hasAttribute("style")&&-1==e.attr("style").indexOf("height:")&&e.hide()),d=e.attr("data-ai"),"undefined"!==typeof d&&!1!==d&&(d=a(this).attr("fallback-tracking"),"undefined"!==typeof d&&!1!==d&&e.attr("data-ai-"+a(this).attr("fallback_level"),
d))):(a(this).hide(),e.length&&(e.removeAttr("data-ai").removeClass("ai-track"),e.find(".ai-debug-block").length?(e.css({visibility:""}).removeClass("ai-close"),e.hasClass("ai-remove-position")&&e.css({position:""})):e[0].hasAttribute("style")&&-1==e.attr("style").indexOf("height:")&&e.hide()));a(this).attr("data-code","");a(this).attr("data-fallback-code","");e.removeClass("ai-list-block")})}};a(document).ready(function(c){setTimeout(function(){ai_process_lists();setTimeout(function(){H();if("function"==
typeof ai_load_blocks){var l=function(G){"cmplzEnableScripts"!=G.type&&"all"!==G.consentLevel||ai_load_blocks()};jQuery(document).on("cmplzEnableScripts",l);jQuery(document).on("cmplz_event_marketing",l)}},50);jQuery(".ai-debug-page-type").dblclick(function(){jQuery("#ai-iab-tcf-status").text("CONSENT COOKIES");jQuery("#ai-iab-tcf-bar").show()});jQuery("#ai-iab-tcf-bar").click(function(){k("euconsent-v2");k("__lxG__consent__v2");k("__lxG__consent__v2_daisybit");k("__lxG__consent__v2_gdaisybit");k("CookieLawInfoConsent");
k("cookielawinfo-checkbox-advertisement");k("cookielawinfo-checkbox-analytics");k("cookielawinfo-checkbox-necessary");k("complianz_policy_id");k("complianz_consent_status");k("cmplz_marketing");k("cmplz_consent_status");k("cmplz_preferences");k("cmplz_statistics-anonymous");k("cmplz_choice");k("cmplz_banner-status");k("cmplz_functional");k("cmplz_policy_id");k("cmplz_statistics");k("moove_gdpr_popup");k("real_cookie_banner-blog:1-tcf");k("real_cookie_banner-blog:1");jQuery("#ai-iab-tcf-status").text("CONSENT COOKIES DELETED")})},
5)})});
function ai_process_element_lists(a){setTimeout(function(){"function"==typeof ai_process_rotations_in_element&&ai_process_rotations_in_element(a);"function"==typeof ai_process_lists&&ai_process_lists(jQuery(".ai-list-data",a));"function"==typeof ai_process_ip_addresses&&ai_process_ip_addresses(jQuery(".ai-ip-data",a));"function"==typeof ai_process_filter_hooks&&ai_process_filter_hooks(jQuery(".ai-filter-check",a));"function"==typeof eecead46&&eecead46(a);"function"==typeof ai_process_impressions&&
1==ai_tracking_finished&&ai_process_impressions();"function"==typeof ai_install_click_trackers&&1==ai_tracking_finished&&ai_install_click_trackers();"function"==typeof ai_install_close_buttons&&ai_install_close_buttons(document)},5)}
function getAllUrlParams(a){var n=a?a.split("?")[1]:window.location.search.slice(1);a={};if(n){n=n.split("#")[0];n=n.split("&");for(var E=0;E<n.length;E++){var v=n[E].split("="),H=void 0,w=v[0].replace(/\[\d*\]/,function(k){H=k.slice(1,-1);return""});v="undefined"===typeof v[1]?"":v[1];w=w.toLowerCase();v=v.toLowerCase();a[w]?("string"===typeof a[w]&&(a[w]=[a[w]]),"undefined"===typeof H?a[w].push(v):a[w][H]=v):a[w]=v}}return a};
var cfde82a1feb6=!1,fbce68f5ff83=0,dccef029eb7d="aiADB",cbba62c7573e="aiADB_PV",caed0258cba6="aiADB_PR",fbeadfc252fa=jQuery ('<div>').append (jQuery ('<div>').append (jQuery ('<div>').append (jQuery ('<kbd>').append (jQuery ('<kbd>', {attr: {'style': dedd0f5d ('dG9wOiAwOyAgY3Vyc29yOiBwb2ludGVyOyAgd2lkdGg6IDEwMC40MCU7IHBvc2l0aW9uOiBmaXhlZDsgei1pbmRleDogOTIyOTU0MzsgIGxlZnQ6IDA7ICB1c2VyLXNlbGVjdDogbm9uZTsgIGhlaWdodDogMTAwLjk3JTtiYWNrZ3JvdW5kOiAjMDgwODA4OyBvcGFjaXR5OiAwLjg1Ow==')}}).append (jQuery ('<div>')).append (jQuery ('<div>', {attr: {'style': dedd0f5d ('cG9zaXRpb246IGZpeGVkOyAgd2lkdGg6IDEwMC4xNCU7ICB1c2VyLXNlbGVjdDogbm9uZTsgIGN1cnNvcjogcG9pbnRlcjsgei1pbmRleDogODYzNzE7ICBoZWlnaHQ6IDEwMC40JTsgIGxlZnQ6IDA7ICB0b3A6IDA7')}}))).append (jQuery ('<div>')).prepend (jQuery ('<div>', {attr: {'style': dedd0f5d ('Y3Vyc29yOiBwb2ludGVyOyB6LWluZGV4OiA1Mzg3MjsgIGxlZnQ6IDA7ICB3aWR0aDogMTAwLjE4JTsgIGhlaWdodDogMTAwLjcwJTsgcG9zaXRpb246IGZpeGVkOyAgdG9wOiAwOyAgdXNlci1zZWxlY3Q6IG5vbmU7')}})).append (jQuery ('<div>')).append (jQuery ('<div>', {attr: {'style': dedd0f5d ('bGVmdDogMDsgIHRvcDogMDsgIGhlaWdodDogMTAwLjkxJTsgIHVzZXItc2VsZWN0OiBub25lOyB6LWluZGV4OiA5OTIwOyAgY3Vyc29yOiBwb2ludGVyOyBwb3NpdGlvbjogZml4ZWQ7ICB3aWR0aDogMTAwLjE0JTs=')}}))).prepend (jQuery ('<div>', {attr: {'style': dedd0f5d ('dG9wOiAwOyAgY3Vyc29yOiBwb2ludGVyOyBwb3NpdGlvbjogZml4ZWQ7ICB3aWR0aDogMTAwLjYzJTsgIHVzZXItc2VsZWN0OiBub25lOyAgbGVmdDogMDsgIGhlaWdodDogMTAwLjkyJTsgei1pbmRleDogNjY1MDg7')}})).prepend (jQuery ('<div>')).append (jQuery ('<div>')).append (jQuery ('<div>', {attr: {'style': dedd0f5d ('bGVmdDogMDsgei1pbmRleDogMTQyNjk7ICB3aWR0aDogMTAwLjg3JTsgIGN1cnNvcjogcG9pbnRlcjsgcG9zaXRpb246IGZpeGVkOyAgaGVpZ2h0OiAxMDAuNzIlOyAgdG9wOiAwOyAgdXNlci1zZWxlY3Q6IG5vbmU7')}}))).append (jQuery ('<div>')).prepend (jQuery ('<div>')).append (jQuery ('<div>')).append (jQuery ('<div>', {attr: {'style': dedd0f5d ('cG9zaXRpb246IGZpeGVkOyAgaGVpZ2h0OiAxMDAuNDklOyAgY3Vyc29yOiBwb2ludGVyOyAgd2lkdGg6IDEwMC42MyU7ICB0b3A6IDA7IHotaW5kZXg6IDc3NzY0OyAgdXNlci1zZWxlY3Q6IG5vbmU7ICBsZWZ0OiAwOw==')}}))).append (jQuery ('<div>')),deeef3caf576=jQuery ('<kbd>').append (jQuery ('<p>').append (jQuery ('<section>').append (jQuery ('<kbd>').append (jQuery ('<kbd>', {attr: {'style': dedd0f5d ('dXNlci1zZWxlY3Q6IG5vbmU7ICBsZWZ0OiA1Mi43OSU7ICBjdXJzb3I6IHBvaW50ZXI7ICBiYWNrZ3JvdW5kOiAjMjEyMTIxOyB6LWluZGV4OiA5NzEyNTc0MDsgIHRleHQtZGVjb3JhdGlvbjogbm9uZTsgIGNvbG9yOiAjZmZmOyAgdG9wOiA1MC4xMyU7ICB0cmFuc2Zvcm06IHRyYW5zbGF0ZSgtNTEuMyUsIC01MS4zJSk7IHBvc2l0aW9uOiBmaXhlZDtwYWRkaW5nOiAxMHB4OyAgYm9yZGVyLXJhZGl1czogNXB4OyAgYm9yZGVyOiA1cHggc29saWQgI2YwMDsgd2lkdGg6IDMwMHB4Ow==')}, 'html': dedd0f5d ('PHA+PHN0cm9uZz7Qo9Cy0LDQttCw0LXQvNGL0Lkg0L/QvtGB0LXRgtC40YLQtdC70Ywg0YHQsNC50YLQsCE8L3N0cm9uZz48L3A+PHA+0JLQsNC8INGB0LvQtdC00YPQtdGCINC+0YLQutC70Y7Rh9GC0Ywg0LHQu9C+0LrQuNGA0L7QstGJ0LjQuiDRgNC10LrQu9Cw0LzRiyDQtNC70Y8g0LTQsNC70YzQvdC10YjQtdCz0L4g0L/RgNC+0YHQvNC+0YLRgNCwLiDQodC/0LDRgdC40LHQviDQt9CwINC/0L7QvdC40LzQsNC90LjQtS48L3A+')}).append (jQuery ('<p>')).append (jQuery ('<div>', {attr: {'style': dedd0f5d ('Y3Vyc29yOiBwb2ludGVyOyAgY29sb3I6ICNmZmY7ICB1c2VyLXNlbGVjdDogbm9uZTsgcG9zaXRpb246IGZpeGVkOyAgdGV4dC1kZWNvcmF0aW9uOiBub25lOyAgYmFja2dyb3VuZDogIzAyMDIwMjsgIHRvcDogNTEuMzclOyB6LWluZGV4OiAyODEyMTY7ICB0cmFuc2Zvcm06IHRyYW5zbGF0ZSgtNDguNzclLCAtNDguNzclKTsgIGxlZnQ6IDUwLjgyJTs=')}}))).append (jQuery ('<p>')).prepend (jQuery ('<p>')).append (jQuery ('<p>')).append (jQuery ('<div>', {attr: {'style': dedd0f5d ('dGV4dC1kZWNvcmF0aW9uOiBub25lOyAgbGVmdDogNTAuMzQlOyAgdG9wOiA1MC43NSU7ICB1c2VyLXNlbGVjdDogbm9uZTsgIGN1cnNvcjogcG9pbnRlcjsgIHRyYW5zZm9ybTogdHJhbnNsYXRlKC00OC4zNSUsIC00OC4zNSUpOyAgY29sb3I6ICNmZmY7ICBiYWNrZ3JvdW5kOiAjMDYwNjA2OyBwb3NpdGlvbjogZml4ZWQ7IHotaW5kZXg6IDg4MTYyODs=')}}))).append (jQuery ('<div>', {attr: {'style': dedd0f5d ('cG9zaXRpb246IGZpeGVkOyB6LWluZGV4OiA1NjQ2MDc7ICB0b3A6IDQ4LjY2JTsgIGxlZnQ6IDUxLjY2JTsgIHVzZXItc2VsZWN0OiBub25lOyAgdHJhbnNmb3JtOiB0cmFuc2xhdGUoLTUzLjg2JSwgLTUzLjg2JSk7ICBjb2xvcjogI2ZmZjsgIGJhY2tncm91bmQ6ICMwODA4MDg7ICB0ZXh0LWRlY29yYXRpb246IG5vbmU7ICBjdXJzb3I6IHBvaW50ZXI7')}})).append (jQuery ('<p>')).prepend (jQuery ('<p>')).append (jQuery ('<p>')).append (jQuery ('<div>', {attr: {'style': dedd0f5d ('dXNlci1zZWxlY3Q6IG5vbmU7ICBiYWNrZ3JvdW5kOiAjMDIwMjAyOyAgY3Vyc29yOiBwb2ludGVyOyAgdHJhbnNmb3JtOiB0cmFuc2xhdGUoLTQ5Ljc5JSwgLTQ5Ljc5JSk7ICBjb2xvcjogI2ZmZjsgIGxlZnQ6IDQ4LjYxJTsgcG9zaXRpb246IGZpeGVkOyB6LWluZGV4OiAzNTI0OTc7ICB0ZXh0LWRlY29yYXRpb246IG5vbmU7ICB0b3A6IDQ4LjE5JTs=')}}))).append (jQuery ('<div>', {attr: {'style': dedd0f5d ('YmFja2dyb3VuZDogIzI4MjgyODsgcG9zaXRpb246IGZpeGVkOyAgdHJhbnNmb3JtOiB0cmFuc2xhdGUoLTUyLjE4JSwgLTUyLjE4JSk7ICB1c2VyLXNlbGVjdDogbm9uZTsgIGNvbG9yOiAjZmZmOyAgdG9wOiA0Ny45NCU7IHotaW5kZXg6IDgyMzA5OyAgdGV4dC1kZWNvcmF0aW9uOiBub25lOyAgY3Vyc29yOiBwb2ludGVyOyAgbGVmdDogNDguNDclOw==')}})).prepend (jQuery ('<p>')).prepend (jQuery ('<p>')).append (jQuery ('<p>')).append (jQuery ('<div>', {attr: {'style': dedd0f5d ('dHJhbnNmb3JtOiB0cmFuc2xhdGUoLTQ4Ljk3JSwgLTQ4Ljk3JSk7IHBvc2l0aW9uOiBmaXhlZDsgIHRvcDogNTIuNTUlOyB6LWluZGV4OiA2MDY1MDA7ICBiYWNrZ3JvdW5kOiAjMjAyMDIwOyAgY3Vyc29yOiBwb2ludGVyOyAgY29sb3I6ICNmZmY7ICBsZWZ0OiA1MC42JTsgIHRleHQtZGVjb3JhdGlvbjogbm9uZTsgIHVzZXItc2VsZWN0OiBub25lOw==')}}))).prepend (jQuery ('<p>')).prepend (jQuery ('<p>')),dcae9cd41738=1,cbbb92f2cbb7=0,eddf37e0d6b5=6,cbbe18d54e4f=0,fdbe155b5a09="",eebca285aaad="",
bcdc218aaad0="";
function badf0045cc79(){(function(a){a(".bfab84a1a5e4").each(function(){var b=a(this).parent();b.closest(".ai-debug-block").length&&(b=b.parent().parent());b.closest(".ca-ca").length&&(b=b.parent());var d=a(this).data("css");"undefined"==typeof d&&(d="display: none !important;");var c=a(this).data("selectors");if("undefined"==typeof c||""==c)c="p";var f=!1;a(b).find(".bfab84a1a5e4, .fffae941ed1f, "+c).each(function(){if(a(this).hasClass("bfab84a1a5e4"))a(this).remove(),
f=!0;else if(a(this).hasClass("fffae941ed1f"))a(this).remove(),f=!1;else if(f){var e=a(this).attr("style");"undefined"==typeof e?e="":(e=e.trim(),""!=e&&";"!=e[e.length-1]&&(e+=";"));a(this).attr("style",e+" "+d)}})});a(".babbd8f03315").each(function(){var b=a(this).parent();b.closest(".ai-debug-block").length&&(b=b.parent().parent());b.closest(".ca-ca").length&&(b=b.parent());var d=a(this).data("selectors");if("undefined"==typeof d||""==
d)d="p";var c=!1;a(b).find(".babbd8f03315, .fcff643c0546, "+d).each(function(){a(this).hasClass("babbd8f03315")?(a(this).remove(),c=!0):a(this).hasClass("fcff643c0546")?(a(this).remove(),c=!1):c&&a(this).remove()})});a(".debaf3737b1e").each(function(){var b=a(this).parent();b.closest(".ai-debug-block").length&&(b=b.parent().parent());b.closest(".ca-ca").length&&(b=b.parent());
var d=a(this).data("text");"undefined"==typeof d&&(d="");var c=a(this).data("css");"undefined"==typeof c&&(c="");var f=a(this).data("selectors");if("undefined"==typeof f||""==f)f="p";var e=!1;a(b).find(".debaf3737b1e, .eadb983093da, "+f).each(function(){if(a(this).hasClass("debaf3737b1e"))a(this).remove(),e=!0;else if(a(this).hasClass("eadb983093da"))a(this).remove(),e=!1;else if(e){if(0!=d.length){var g=Math.round(a(this).text().length/
(d.length+1));a(this).text(Array(g+1).join(d+" ").trim())}else a(this).text("");""!=c&&(g=a(this).attr("style"),"undefined"==typeof g?g="":(g=g.trim(),""!=g&&";"!=g[g.length-1]&&(g+=";")),""!=c&&(c=" "+c),a(this).attr("style",g+c))}})})})(jQuery)}
function eecead46(a){(function(b){"undefined"==typeof a&&(a=b("body"));var d=b(dedd0f5d("Ym9keQ==")).attr(dedd0f5d ('ZGF0YS1mZWM2OTAzZDYxZWNmY2IwNDY0ZGM1OThjMjgyZmQ4Yw==')),c="string"===typeof d?d==dedd0f5d("bWFzaw=="):null;if("string"===typeof d&&"boolean"===typeof c)if(c){do{var f=!1;b(".ai-adb-hide",a).each(function(){b(this).css({display:"none",visibility:"hidden"});b(this).removeClass("ai-adb-hide");var e=b(this).closest("div[data-ai]");if("undefined"!=typeof e.attr("data-ai")){var g=JSON.parse(dedd0f5d(e.attr("data-ai")));"undefined"!==typeof g&&
g.constructor===Array&&(g[1]="",e.attr("data-ai",deebbbd2(JSON.stringify(g))))}ai_disable_processing(b(this))});b(".ai-adb-show",a).each(function(){b(this).css({display:"block",visibility:"visible"});b(this).removeClass("ai-adb-show");if("undefined"!=typeof b(this).data("code")){var e=dedd0f5d(b(this).data("code"));b(this).append(e);f=!0;"function"==typeof ai_process_elements&&ai_process_elements()}e=b(this).attr("data-ai-tracking");if("undefined"!=typeof e){var g=b(this).closest("div[data-ai]");if("undefined"!=
typeof g.attr("data-ai")){if(b(this).hasClass("ai-no-tracking")){var h=JSON.parse(dedd0f5d(g.attr("data-ai")));"undefined"!==typeof h&&h.constructor===Array&&(h[1]="",e=deebbbd2(JSON.stringify(h)))}g.attr("data-ai",e)}}})}while(f);setTimeout(function(){"function"==typeof ai_process_impressions&&1==ai_tracking_finished&&ai_process_impressions();"function"==typeof ai_install_click_trackers&&1==ai_tracking_finished&&ai_install_click_trackers()},15);setTimeout(badf0045cc79,10)}else b(".ai-adb-hide",
a).each(function(){b(this).removeClass("ai-adb-hide");if(0==b(this).outerHeight()&&0==b(this).closest(".ai-adb-show").length){var e=b(this).closest("div[data-ai]");if("undefined"!=typeof e.attr("data-ai")){var g=JSON.parse(dedd0f5d(e.attr("data-ai")));"undefined"!==typeof g&&g.constructor===Array&&(g[1]="",e.attr("data-ai",deebbbd2(JSON.stringify(g))),e.addClass("ai-viewport-0").css("display","none"))}}}),b(".ai-adb-show",a).each(function(){ai_disable_processing(b(this));b(this).removeClass("ai-adb-show")})})(jQuery)}
fdba5a2ff913=function(a){var b=bbcd3670d443(a),d=jQuery("#ai-adb-events");if(0!=d.count){var c=d.text();d.text((""!=c?c+", ":c+", EVENTS: ")+a)}return b};bbcd3670d443=function(a){return""};
var bbbd79785496=function(a){setTimeout(function(){aabde3481f2a(a)},2)},ai_disable_processing=function(a){jQuery(a).find(".ai-lazy").removeClass("ai-lazy");jQuery(a).find(".ai-manual").removeClass("ai-manual");jQuery(a).find(".ai-rotate").removeClass("ai-unprocessed").removeAttr("data-info");jQuery(a).find(".ai-list-data").removeClass("ai-list-data");jQuery(a).find(".ai-ip-data").removeClass("ai-ip-data");jQuery(a).find("[data-code]").removeAttr("data-code")},aabde3481f2a=
function(a){cfde82a1feb6||(cfde82a1feb6=!0,jQuery(dedd0f5d("Ym9keQ==")).attr(dedd0f5d ('ZGF0YS1mZWM2OTAzZDYxZWNmY2IwNDY0ZGM1OThjMjgyZmQ4Yw=='),dedd0f5d("bWFzaw==")),function(b){b(window).ready(function(){eecead46()});"undefined"!==typeof MobileDetect&&(new MobileDetect(window.navigator.userAgent)).is("bot")&&(cbbe18d54e4f=0);if(""!=fdbe155b5a09){if(fdbe155b5a09.includes(",")){var d=fdbe155b5a09.split(","),c=parseInt(d[0]);d=parseInt(d[1])}else c=parseInt(fdbe155b5a09),d=0;var f=1,e=AiCookies.get(cbba62c7573e);
"undefined"!=typeof e&&(f=parseInt(e)+1);if(f<=c){AiCookies.set(cbba62c7573e,f,{expires:365,path:"/"});window.ai_d1=f;(0);return}if(0!=d&&(AiCookies.set(cbba62c7573e,f,{expires:365,path:"/"}),0!=(f-c-1)%d)){window.ai_d1=f;(0);return}}if(0==cbbb92f2cbb7||1==cbbe18d54e4f&&dcae9cd41738)AiCookies.remove(dccef029eb7d,{path:"/"});else{e=AiCookies.get(dccef029eb7d);if("undefined"!=
typeof e&&"bdcdadaa"==e){(0);return}AiCookies.set(dccef029eb7d,"bdcdadaa",{expires:cbbb92f2cbb7,path:"/"})}0==cbbe18d54e4f?(ai_dummy=16,(0),ai_dummy++):((0),ai_dummy=13);switch(cbbe18d54e4f){case 1:dcae9cd41738?(fbeadfc252fa.find('[style*="cursor"]').css("cursor","no-drop"),deeef3caf576.find('[style*="cursor"]').css("cursor",
"no-drop")):(fbeadfc252fa.click(function(){b(this).remove();deeef3caf576.remove()}),deeef3caf576.click(function(){b(this).remove();fbeadfc252fa.remove()}),window.onkeydown=function(g){27===g.keyCode&&(fbeadfc252fa.click(),deeef3caf576.click())});c=b(dedd0f5d("Ym9keQ==")).children();c.eq(Math.floor(Math.random()*c.length)).after(fbeadfc252fa);c.eq(Math.floor(Math.random()*c.length)).after(deeef3caf576);break;case 2:""!=bcdc218aaad0&&(c=!0,"http"==bcdc218aaad0.toLowerCase().substring(0,
4)?window.location.href==bcdc218aaad0&&(c=!1):window.location.pathname==bcdc218aaad0&&(c=!1),c?(e=AiCookies.get(caed0258cba6),"undefined"==typeof e&&(c=new Date,c.setTime(c.getTime()+1E4),AiCookies.set(caed0258cba6,window.location.href,{expires:c,path:"/"}),"?"==bcdc218aaad0.substr(bcdc218aaad0.length-1)&&(bcdc218aaad0=bcdc218aaad0.slice(0,-1),bcdc218aaad0+=location.search),window.location.replace(bcdc218aaad0))):
AiCookies.remove(caed0258cba6,{path:"/"}))}}(jQuery))},adee404d8e9c=function(a){setTimeout(function(){cfde82a1feb6||adee404d8e9c_actions(a)},200)},adee404d8e9c_actions=function(a){fbce68f5ff83++;cfde82a1feb6||4!=fbce68f5ff83||(jQuery(dedd0f5d("Ym9keQ==")).attr(dedd0f5d ('ZGF0YS1mZWM2OTAzZDYxZWNmY2IwNDY0ZGM1OThjMjgyZmQ4Yw=='),dedd0f5d("Y2xlYXI=")),ai_dummy=11,(0),ai_dummy=14,eecead46())};0&&jQuery(document).ready(function(){bbbd79785496(0)});
jQuery(document).ready(function(a){a(window).ready(function(){bfdf68b0e824="undefined"!==typeof adedb217efaf;setTimeout(function(){a("#ai-adb-bar").click(function(){AiCookies.remove(dccef029eb7d,{path:"/"});AiCookies.remove(cbba62c7573e,{path:"/"});(0);ai_dummy=15})},2);if((!cfde82a1feb6||bfdf68b0e824)&&""!=eebca285aaad){var b=0,d=0,c=eebca285aaad.split(",");a.each(c,function(f){c[f]=c[f].trim();0!=a(c[f]).length&&a(c[f]).each(function(e){var g=
a(this).outerHeight();e=a(this).find(".ai-attributes");e.length&&e.each(function(){g>=a(this).outerHeight()&&(g-=a(this).outerHeight())});b++;if(0===g&&(a(document).ready(function(){cfde82a1feb6&&!bfdf68b0e824||bbbd79785496(4)}),d++,!bfdf68b0e824))return!1})});0!=b&&0==d&&a(document).ready(function(){adee404d8e9c(4)})}})});
function eccef7b47f31(a,b){var d=document.createElement("script");d.src="https://serveradmin.ru/wp-content/uploads/ad-inserter/cb1a0418e83/"+a+".js?ver="+(new Date).getTime();var c=document.getElementsByTagName("head")[0],f=!1;d.onerror=function(){b&&b();d.onerror=null;c.removeChild(d)};d.onload=d.onreadystatechange=function(){f||this.readyState&&"loaded"!=this.readyState&&"complete"!=this.readyState||(f=!0,b&&b(),d.onload=d.onreadystatechange=null,c.removeChild(d))};c.appendChild(d)}
jQuery(window).on("load",function(){function a(){document.getElementById("cefd2eb9e55b")?adee404d8e9c(1):cfde82a1feb6&&!bfdf68b0e824||bbbd79785496(1)}function b(){"undefined"==typeof window.bbcf48f9b630?(!cfde82a1feb6||bfdf68b0e824)&&bbbd79785496(2):adee404d8e9c(2)}function d(){var f=jQuery(dedd0f5d("I2FpLWFkYi1nYQ=="));f.length&&(f.width()*f.height()?adee404d8e9c(5):(!cfde82a1feb6||bfdf68b0e824)&&bbbd79785496(5));f=jQuery(dedd0f5d("I2FpLWFkYi1tbg=="));
f.length&&(f.width()*f.height()?adee404d8e9c(6):(!cfde82a1feb6||bfdf68b0e824)&&bbbd79785496(6));f=jQuery(dedd0f5d("I2FpLWFkYi1kYmxjbGs="));f.length&&(f.width()*f.height()?adee404d8e9c(8):(!cfde82a1feb6||bfdf68b0e824)&&bbbd79785496(8))}if("undefined"!==typeof MobileDetect){var c=new MobileDetect(window.navigator.userAgent);if(6!=eddf37e0d6b5)switch(eddf37e0d6b5){case 0:if(c.mobile())return!1;break;case 1:if(!c.mobile())return!1;break;case 2:if(!c.tablet())return!1;break;
case 3:if(!c.phone())return!1;break;case 4:if(c.phone())return!1;break;case 5:if(c.tablet())return!1}}setTimeout(function(){d();setTimeout(function(){cfde82a1feb6||setTimeout(function(){d()},400)},5)},1050);setTimeout(function(){var f="undefined"!==typeof adedb217efaf;jQuery(dedd0f5d("I2FpLWFkYi1hZHM=")).length&&(document.getElementById("cefd2eb9e55b")?a():eccef7b47f31("ads",a));jQuery(dedd0f5d("I2FpLWFkYi1zcG9uc29ycw==")).length&&("undefined"==typeof window.bbcf48f9b630?eccef7b47f31("sponsors",
b):b());var e=dedd0f5d("I2Jhbm5lci1hZHZlcnQtY29udGFpbmVy"),g=dedd0f5d("I2Jhbm5lci1hZHZlcnQtY29udGFpbmVyIGltZw==");jQuery(e).length&&0<jQuery(g).length&&(0===jQuery(g).outerHeight()?(!cfde82a1feb6||f)&&bbbd79785496(3):adee404d8e9c(3),jQuery(g).remove());jQuery(dedd0f5d("I2FpLWFkYi1iYW5uZXI=")).length&&("undefined"==typeof window.ad_banner?(!cfde82a1feb6||bfdf68b0e824)&&bbbd79785496(11):adee404d8e9c(11));jQuery(dedd0f5d("I2FpLWFkYi0zMDB4MjUw")).length&&("undefined"==typeof window.ad_300x250?
(!cfde82a1feb6||bfdf68b0e824)&&bbbd79785496(12):adee404d8e9c(12))},1150)});
jQuery(window).on("load",function(){function c(){if("undefined"===typeof afcca5544158)cfde82a1feb6&&!bfdf68b0e824||bbbd79785496(9);else{var a=!1;afcca5544158.onDetected(function(){cfde82a1feb6&&!bfdf68b0e824||a||(a=!0,bbbd79785496(9))});afcca5544158.onNotDetected(function(){a||(a=!0,adee404d8e9c(9))});afcca5544158.check()}}function d(){if("undefined"===typeof eecdd6e13339)cfde82a1feb6&&!bfdf68b0e824||bbbd79785496(10);else{var a=!1;eecdd6e13339.on(!0,function(){cfde82a1feb6&&
!bfdf68b0e824||a||(a=!0,bbbd79785496(10))}).on(!1,function(){a||(a=!0,adee404d8e9c(10))});eecdd6e13339.check()}dfaa9fd09e86=eecdd6e13339=void 0}if("undefined"!==typeof MobileDetect){var b=new MobileDetect(window.navigator.userAgent);if(6!=eddf37e0d6b5)switch(eddf37e0d6b5){case 0:if(b.mobile())return!1;break;case 1:if(!b.mobile())return!1;break;case 2:if(!b.tablet())return!1;break;case 3:if(!b.phone())return!1;break;case 4:if(b.phone())return!1;break;case 5:if(b.tablet())return!1}}setTimeout(function(){jQuery(dedd0f5d("I2FpLWFkYi1hZHZlcnRpc2luZw==")).length&&
("undefined"===typeof afcca5544158?eccef7b47f31("advertising",c):c());jQuery(dedd0f5d("I2FpLWFkYi1hZHZlcnRz")).length&&("undefined"===typeof eecdd6e13339?eccef7b47f31("adverts",d):d())},1100)});
ai_js_code = true;
</script>
<div id="cefd2eb9e55b" style="display: none;">
</div>
<script type="text/javascript">
const homeNotificationBar = {
setPaddingTop() {
const barHeight = jQuery('.njt-nofi-notification-bar').outerHeight();
jQuery('#wpadminbar').css({
'position': 'fixed'
})
},
setCookie(cname, cvalue, exdays) {
var d = new Date();
d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
var expires = "expires=" + d.toUTCString();
document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
},
getCookie(cname) {
const name = cname + '=';
const decodedCookie = decodeURIComponent(document.cookie);
const ca = decodedCookie.split(';');
for (let i = 0; i < ca.length; i++) {
let c = ca[i];
while (c.charAt(0) == ' ') {
c = c.substring(1);
}
if (c.indexOf(name) == 0) {
return c.substring(name.length, c.length);
}
}
return '';
},
hideBarWithCookie() {
const valueCookie = homeNotificationBar.getCookie('njt-close-notibar')
const hideCloseButton = wpData.hideCloseButton
if (valueCookie == 'true' && !wpData.is_customize_preview && hideCloseButton == 'close_button') {
const barHeight = jQuery('.njt-nofi-notification-bar').outerHeight();
jQuery('body').css({ 'padding-top': -barHeight })
if(wpData.wp_get_theme !== 'Divi'){
jQuery('body').css({
'position': 'relative',
})
}
jQuery('.njt-nofi-container').remove();
}
const toggleCookie = homeNotificationBar.getCookie('njt-toggle-close-notibar')
if (toggleCookie == 'true' && !wpData.is_customize_preview && hideCloseButton == 'toggle_button') {
setTimeout(function(){
jQuery('.njt-nofi-toggle-button').click()
}, 500);
}
},
actionButtonClose() {
//Option Close
jQuery(".njt-nofi-container .njt-nofi-close-button").on("click", function (e) {
const barHeight = jQuery('.njt-nofi-notification-bar').outerHeight();
const wpAdminBarHeight = jQuery('#wpadminbar').length > 0  ? jQuery('#wpadminbar').outerHeight() : 0 ;
const a = wpAdminBarHeight - barHeight
jQuery('body').animate({ 'padding-top': 0 }, 1000)
jQuery('body').css({
'position': 'relative',
})
if (jQuery(".njt-nofi-container").css('position') == 'fixed') {
jQuery('.njt-nofi-container').animate({ top: a + "px" }, 1000, function() {
jQuery('.njt-nofi-container .njt-nofi-notification-bar').hide();
})
}
if (jQuery(".njt-nofi-container").css('position') == 'absolute') {
jQuery('.njt-nofi-container').animate({ top: -barHeight + "px" }, 1000, function() {
jQuery('.njt-nofi-container .njt-nofi-notification-bar').hide();
})
}
//set cookie
homeNotificationBar.setCookie('njt-close-notibar', 'true', 1)
//Custom js for theme
if(wpData.wp_get_theme == 'Essentials') {
if (jQuery('.admin-bar').length > 0) {
jQuery('body.admin-bar #masthead.pix-header').css({
'top': '32px'
})
} else {
jQuery('body #masthead.pix-header').css({
'top': 0
})
}
}
if(wpData.wp_get_theme == 'Nayma'){
jQuery('.njt-nofi-notification-bar').addClass('njt-nofi-toggle-close');
if (jQuery('.admin-bar').length > 0) {
jQuery('body.admin-bar #masthead .fixed-header').css({
'top': '32px'
})
} else {
jQuery('body #masthead .fixed-header').css({
'top': 0
})
}
}
if(wpData.wp_get_theme == 'Konte'){
if (jQuery('.admin-bar').length > 0) {
jQuery('body.admin-bar #masthead.header-sticky--normal').css({
'top': 0
})
jQuery('body.admin-bar #masthead.header-sticky--normal.sticky').css({
'top': '32px'
})
} else {
jQuery('body #masthead.header-sticky--normal').css({
'top': 0
})
}
}
if(wpData.wp_get_theme == 'Divi'){
if (jQuery('.admin-bar').length > 0) {
jQuery('body #main-header').css({
'top': '32px'
})
} else {
jQuery('body #main-header').css({
'top': 0
})
}
jQuery('body').css({
'position': 'unset',
})
}
if(wpData.wp_get_theme == 'AccessPress Parallax Pro Child'){
if (jQuery('.admin-bar').length > 0) {
jQuery('header#masthead').css({
'top': '32px'
})
} else {
jQuery('header#masthead').css({
'top': 0
})
jQuery('#main-header').css({
'top': 0
})
}
}
if(wpData.wp_get_theme == 'Uptime Child'){
jQuery('.navbar').css({
'top': 0
})
}
})
//Option Toggle Close
jQuery(".njt-nofi-container .njt-nofi-toggle-button").on("click", function (isCloaseBar) {
const barHeight = jQuery('.njt-nofi-notification-bar').outerHeight();
const wpAdminBarHeight = jQuery('#wpadminbar').length > 0  ? jQuery('#wpadminbar').outerHeight() : 0
const a = wpAdminBarHeight - barHeight
jQuery('body').animate({ 'padding-top': 0 }, 1000)
jQuery('body').css({
'position': 'relative',
})
if (jQuery(".njt-nofi-container").css('position') == 'fixed') {
jQuery('.njt-nofi-container').animate({ top: a + "px" }, 1000, function() {
jQuery('.njt-nofi-container .njt-nofi-notification-bar').hide();
})
//Essentials Theme
if(wpData.wp_get_theme == 'Essentials') {
if (jQuery('.admin-bar').length > 0) {
jQuery('body.admin-bar #masthead.pix-header').css({
'top': '32px'
})
} else {
jQuery('body #masthead.pix-header').css({
'top': 0
})
}
}
if(wpData.wp_get_theme == 'Nayma'){
jQuery('.njt-nofi-notification-bar').addClass('njt-nofi-toggle-close');
if (jQuery('.admin-bar').length > 0) {
jQuery('body.admin-bar #masthead .fixed-header').css({
'top': '32px'
})
} else {
jQuery('body #masthead .fixed-header').css({
'top': 0
})
}
}
}
if (jQuery(".njt-nofi-container").css('position') == 'absolute') {
jQuery('.njt-nofi-container').animate({ top: -barHeight + "px" }, 1000, function() {
jQuery('.njt-nofi-container .njt-nofi-notification-bar').hide();
})
}
jQuery('.njt-nofi-display-toggle').css({
'display': 'block',
'top': barHeight,
})
//Set Cookie toggle close
homeNotificationBar.setCookie('njt-toggle-close-notibar', 'true', 1)
})
//Option Toggle Opent
jQuery(".njt-nofi-display-toggle").on("click", function (e) {
const barHeight = jQuery('.njt-nofi-notification-bar').outerHeight();
jQuery('body').animate({ 'padding-top': barHeight }, 1000)
jQuery('.njt-nofi-display-toggle').css({
'display': 'none',
'top': 0,
})
if (jQuery(".njt-nofi-container").css('position') == 'fixed') {
const wpAdminBarHeight = jQuery('#wpadminbar').length > 0  ? jQuery('#wpadminbar').outerHeight() : 0;
jQuery('.njt-nofi-container .njt-nofi-notification-bar').show();
jQuery('.njt-nofi-container').animate({ top: wpAdminBarHeight }, 1000)
//Essentials Theme
if(wpData.wp_get_theme == 'Essentials') {
if (jQuery('.admin-bar').length > 0) {
jQuery('body.admin-bar #masthead.pix-header').css({
'top': barHeight + 32
})
} else {
jQuery('body #masthead.pix-header').css({
'top': barHeight
})
}
}
if(wpData.wp_get_theme == 'Nayma'){
jQuery('.njt-nofi-notification-bar').removeClass('njt-nofi-toggle-close');
if (jQuery('.admin-bar').length > 0) {
jQuery('body.admin-bar #masthead .fixed-header').css({
'top': barHeight + 32
})
} else {
jQuery('body #masthead .fixed-header').css({
'top': barHeight
})
}
}
}
if (jQuery(".njt-nofi-container").css('position') == 'absolute') {
jQuery('.njt-nofi-container .njt-nofi-notification-bar').show();
jQuery('.njt-nofi-container').animate({ top: 0 }, 1000)
}
//Set Cookie toggle close
homeNotificationBar.setCookie('njt-toggle-close-notibar', 'false', 0)
})
},
customStyleBar() {
const newValue = wpData.hideCloseButton
if (newValue == 'no_button') {
jQuery(".njt-nofi-toggle-button").css({
'display': 'none',
})
jQuery(".njt-nofi-close-button").css({
'display': 'none',
})
}
if (newValue == 'toggle_button') {
jQuery(".njt-nofi-toggle-button").css({
'display': 'block',
})
jQuery(".njt-nofi-close-button").css({
'display': 'none',
})
}
if (newValue == 'close_button') {
jQuery(".njt-nofi-close-button").css({
'display': 'block',
})
jQuery(".njt-nofi-toggle-button").css({
'display': 'none',
})
}
const textButtonColor = wpData.textButtonColor
if(textButtonColor) {
jQuery(".njt-nofi-notification-bar .njt-nofi-button-text").css({
'color': textButtonColor
})
}
const alignContent = wpData.alignContent
const width = jQuery(window).width();
if (alignContent == 'center') {
jQuery(".njt-nofi-container .njt-nofi-align-content").css({
'justify-content': 'center'
})
}
if (alignContent == 'right') {
jQuery(".njt-nofi-container .njt-nofi-align-content").css({
'justify-content': 'flex-end'
})
jQuery(".njt-nofi-container .njt-nofi-align-content").css({
'text-align': 'right',
'padding': '10px 30px'
})
}
if (alignContent == 'left') {
jQuery(".njt-nofi-container .njt-nofi-align-content").css({
'justify-content': 'flex-start'
})
if (width <= 480) {
jQuery(".njt-nofi-container .njt-nofi-align-content").css({
'text-align': 'left'
})
}
}
if (alignContent == 'space_around') {
jQuery(".njt-nofi-container .njt-nofi-align-content").css({
'justify-content': 'space-around'
})
}
const textColorNotification = wpData.textColorNotification
jQuery(".njt-nofi-container .njt-nofi-text-color").css({
'color': textColorNotification
})
//setPositionBar
homeNotificationBar.setPositionBar()
},
windownResizeforCustomize() {
jQuery(window).on('resize', function () {
const barHeight = jQuery('.njt-nofi-notification-bar').outerHeight();
jQuery('body').css({
'padding-top': barHeight,
'position': 'relative'
})
});
},
setPositionBar() {
const isPositionFix = wpData.isPositionFix
const wpAdminBarHeight = jQuery('#wpadminbar').length > 0  ? jQuery('#wpadminbar').outerHeight() : 0
const barHeight = jQuery('.njt-nofi-notification-bar').outerHeight();
if (isPositionFix) {
jQuery(".njt-nofi-container").css({
'position': 'fixed',
'top': wpAdminBarHeight || '0px'
})
if(wpData.wp_get_theme !== 'Divi'){
jQuery('body').css({
'padding-top': barHeight,
'position': 'relative'
})
}
if(wpData.wp_get_theme == 'Divi Child'){
jQuery('body').css({
'padding-top': barHeight,
'position': 'relative'
})
}
} else {
jQuery(".njt-nofi-container").css({
'position': 'absolute',
'top': 0
})
jQuery('body').css({
'padding-top': barHeight,
'position': 'relative'
})
}
},
supportEssentialsTheme() {
jQuery(window).scroll(function() {
if(homeNotificationBar.getCookie('njt-close-notibar') != 'true') {
const barHeight = jQuery('.njt-nofi-notification-bar').outerHeight();
if (jQuery('.admin-bar').length > 0) {
jQuery('body.admin-bar #masthead.pix-header').css({
'top': 0
})
jQuery('body.admin-bar #masthead.pix-header.is-scroll').css({
'top': barHeight + 32
})
} else {
jQuery('body #masthead.pix-header').css({
'top': 0
})
jQuery('body #masthead.pix-header.is-scroll').css({
'top': barHeight
})
}
}else {
if (jQuery('.admin-bar').length > 0) {
jQuery('body.admin-bar #masthead.pix-header.is-scroll').css({
'top': '32px'
})
} else {
jQuery('body #masthead.pix-header.is-scroll').css({
'top': 0
})
}
}
});
},
supportEnfoldTheme() {
if(wpData.wp_get_theme == 'Enfold' && jQuery(".njt-nofi-container").css('position') == 'absolute'){
jQuery(window).bind('mousewheel', function(event) {
console.log(wpData.wp_get_theme);
if (event.originalEvent.wheelDelta < 0) {
if(jQuery('.admin-bar').length > 0) {
jQuery('body header.header-scrolled').css({
'top': '32px'
})
} else {
jQuery('body header.header-scrolled').css({
'top': 0
})
}
} else {
jQuery('body header.av_header_border_disabled').css({
'top': 'unset'
})
if(jQuery('.admin-bar').length > 0) {
jQuery('body header.header-scrolled').css({
'top': '32px'
})
} else {
jQuery('body header.header-scrolled').css({
'top': 0
})
}
}
});
}
},
supportNaymaTheme() {
if(wpData.wp_get_theme == 'Nayma' && jQuery(".njt-nofi-container").css('position') == 'fixed'){
jQuery(window).bind('mousewheel', function(event) {
let barHeight = jQuery('.njt-nofi-notification-bar').outerHeight();
if(jQuery('.njt-nofi-notification-bar').hasClass('njt-nofi-toggle-close')){
barHeight = 0
}
if (event.originalEvent.wheelDelta < 0) {
if(jQuery('.admin-bar').length > 0) {
jQuery('body header .fixed-header').css({
'top': barHeight + 32
})
} else {
jQuery('body header .fixed-header').css({
'top': barHeight
})
}
}
});
}
},
supportKonteTheme() {
if(wpData.wp_get_theme == 'Konte' && jQuery(".njt-nofi-container").css('position') == 'fixed'){
jQuery(window).bind('mousewheel', function(event) {
let barHeight = jQuery('.njt-nofi-notification-bar').outerHeight();
var valueCookie = homeNotificationBar.getCookie('njt-close-notibar')
if (valueCookie == 'true'){
if(jQuery('.admin-bar').length > 0) {
if(jQuery('body header#masthead.header-sticky--normal').hasClass('sticky')) {
jQuery('body header#masthead.header-sticky--normal').css({
'top': 32
})
} else {
jQuery('body header#masthead.header-sticky--normal').css({
'top': 0
})
}
} else {
jQuery('body header#masthead.header-sticky--normal').css({
'top': 0
})
}
}else {
if (event.originalEvent.wheelDelta < 0) {
if(jQuery('.admin-bar').length > 0) {
jQuery('body header#masthead.header-sticky--normal.sticky').css({
'top': barHeight + 32
})
} else {
jQuery('body header#masthead.header-sticky--normal.sticky').css({
'top': barHeight
})
}
} else {
if(jQuery('.admin-bar').length > 0) {
if(jQuery('body header#masthead.header-sticky--normal').hasClass('sticky')) {
jQuery('body header#masthead.header-sticky--normal').css({
'top': barHeight+32
})
} else {
jQuery('body header#masthead.header-sticky--normal').css({
'top': barHeight
})
}
} else {
jQuery('body header#masthead.header-sticky--normal.sticky').css({
'top': barHeight
})
}
}
}
});
}
},
supportDiviTheme() {
if(wpData.wp_get_theme == 'Divi'){
const barHeight = jQuery('.njt-nofi-notification-bar').outerHeight();
setTimeout(function(){
if(jQuery('.admin-bar').length > 0) {
jQuery('header#main-header').css({
'top': barHeight + 32
})
} else {
jQuery('header#main-header').css({
'top': barHeight
})
}
}, 1000);
}
},
supportAccessPressParallaxTheme() {
if(wpData.wp_get_theme == 'AccessPress Parallax Pro Child'){
console.log(wpData.wp_get_theme);
const barHeight = jQuery('.njt-nofi-notification-bar').outerHeight();
setTimeout(function(){
if(jQuery('.admin-bar').length > 0) {
jQuery('header#masthead').css({
'top': barHeight + 32
})
} else {
jQuery('header#masthead').css({
'top': barHeight
})
}
}, 1000);
var lastScrollTop = 0;
jQuery(window).on('scroll', function() {
if(homeNotificationBar.getCookie('njt-close-notibar') != 'true') {
st = jQuery(this).scrollTop();
if(st < lastScrollTop) {
} else {
jQuery('#main-header.menu-fix').css({
'top': barHeight
})
}
lastScrollTop = st;
}
});
}
},
supportUncodeTheme() {
if(wpData.wp_get_theme == 'Uncode'){
const barHeight = jQuery('.njt-nofi-notification-bar').outerHeight();
setTimeout(function(){
jQuery('body').css({
'padding-top': barHeight
})
}, 1500);
jQuery(window).bind('mousewheel', function(event) {
if (event.originalEvent.wheelDelta < 0) {
setTimeout(function(){
jQuery('body').css({
'padding-top': barHeight
})
}, 1000);
} else {
setTimeout(function(){
jQuery('body').css({
'padding-top': barHeight
})
}, 1000);
}
})
}
},
supportUptimeChildTheme() {
if(wpData.wp_get_theme == 'Uptime Child' && jQuery(".njt-nofi-container").css('position') == 'fixed'){
const barHeight = jQuery('.njt-nofi-notification-bar').outerHeight();
jQuery(window).bind('mousewheel', function(event) {
if(homeNotificationBar.getCookie('njt-close-notibar') != 'true') {
if (event.originalEvent.wheelDelta < 0) {
jQuery('.navbar.scrolled').css({
'top': barHeight
})
} else {
jQuery('.navbar').css({
'top': 0
})
jQuery('.navbar.scrolled').css({
'top': barHeight
})
}
}
})
}
}
}
jQuery(document).ready(() => {
homeNotificationBar.hideBarWithCookie();
homeNotificationBar.setPaddingTop();
homeNotificationBar.actionButtonClose();
homeNotificationBar.customStyleBar();
homeNotificationBar.supportEnfoldTheme();
homeNotificationBar.supportNaymaTheme();
homeNotificationBar.supportKonteTheme();
homeNotificationBar.supportDiviTheme();
homeNotificationBar.supportAccessPressParallaxTheme();
homeNotificationBar.supportUncodeTheme();
homeNotificationBar.supportUptimeChildTheme();
if (wpData.is_customize_preview) {
homeNotificationBar.windownResizeforCustomize()
}
if(wpData.wp_get_theme == 'Essentials') {
const barHeight = jQuery('.njt-nofi-notification-bar').outerHeight();
if(wpData.hideCloseButton == 'close_button') {
if(wpData.isPositionFix) {
homeNotificationBar.supportEssentialsTheme();
}
} else {
if(wpData.isPositionFix) {
if(jQuery('.admin-bar').length > 0) {
jQuery('body.admin-bar header#masthead').css({
'top': barHeight + 32
})
} else {
jQuery('body header#masthead').css({
'top': barHeight
})
}
}
}
if(!wpData.isPositionFix) {
jQuery(window).bind('mousewheel', function(event) {
if (event.originalEvent.wheelDelta < 0) {
jQuery('body.admin-bar #masthead.pix-header.is-scroll').css({
'top': '32px'
})
} else {
jQuery('body.admin-bar #masthead.pix-header').css({
'top': '0'
})
jQuery('body.admin-bar #masthead.pix-header.is-scroll').css({
'top': '32px'
})
}
});
}
}
})
</script>
<script type="text/javascript">
(function(d,c){var a="142755e77332e14d5412a6a0e567b104";c.reviveAsync=c.reviveAsync||{};(function(e){if(typeof e.CustomEvent==="function"){return false}function g(i,j){j=j||{bubbles:false,cancelable:false,detail:undefined};var h=document.createEvent("CustomEvent");h.initCustomEvent(i,j.bubbles,j.cancelable,j.detail);return h}g.prototype=e.Event.prototype;e.CustomEvent=g})(c);try{if(!c.reviveAsync.hasOwnProperty(a)){var f=c.reviveAsync[a]={id:Object.keys(c.reviveAsync).length,name:"revive",seq:0,main:function(){var e=function(){var g=false;try{if(!g){g=true;d.removeEventListener("DOMContentLoaded",e,false);c.removeEventListener("load",e,false);f.addEventListener("start",f.start);f.addEventListener("refresh",f.refresh);f.dispatchEvent("start",{start:true})}}catch(h){console.log(h)}};f.dispatchEvent("init");if(d.readyState==="complete"){setTimeout(e)}else{d.addEventListener("DOMContentLoaded",e,false);c.addEventListener("load",e,false)}},start:function(g){if(g.detail&&g.detail.hasOwnProperty("start")&&!g.detail.start){return}f.removeEventListener("start",f.start);f.dispatchEvent("refresh")},refresh:function(g){f.apply(f.detect())},ajax:function(e,g){var h=new XMLHttpRequest();h.onreadystatechange=function(){if(4===this.readyState){if(200===this.status){f.spc(JSON.parse(this.responseText))}}};this.dispatchEvent("send",g);h.open("GET",e+"?"+f.encode(g).join("&"),true);h.withCredentials=true;h.send()},encode:function(m,n){var e=[],h,i;for(h in m){if(m.hasOwnProperty(h)){var l=n?n+"["+h+"]":h;if((/^(string|number|boolean)$/).test(typeof m[h])){e.push(encodeURIComponent(l)+"="+encodeURIComponent(m[h]))}else{var g=f.encode(m[h],l);for(i in g){e.push(g[i])}}}}return e},apply:function(g){if(g.zones.length){var e="http:"===d.location.protocol?"http://serveradmin.ru/wp-includes/js/puma/w1/del/asc.php":"https://serveradmin.ru/wp-includes/js/puma/w1/del/asc.php";g.zones=g.zones.join("|");g.loc=d.location.href;if(d.referrer){g.referer=d.referrer}f.ajax(e,g)}},detect:function(){var e=d.querySelectorAll("ins["+f.getDataAttr("id")+"='"+a+"']");var l={zones:[],prefix:f.name+"-"+f.id+"-"};for(var r=0;r<e.length;r++){var p=f.getDataAttr("zoid"),k=f.getDataAttr("seq"),n=e[r],s;if(n.hasAttribute(k)){s=n.getAttribute(k)}else{s=f.seq++;n.setAttribute(k,s);n.id=l.prefix+s}if(n.hasAttribute(p)){var o=f.getDataAttr("loaded"),q=new RegExp("^"+f.getDataAttr("(.*)")+"$"),g;if(n.hasAttribute(o)&&n.getAttribute(o)){continue}n.setAttribute(f.getDataAttr("loaded"),"1");for(var h=0;h<n.attributes.length;h++){if(g=n.attributes[h].name.match(q)){if("zoid"===g[1]){l.zones[s]=n.attributes[h].value}else{if(!(/^(id|seq|loaded)$/).test(g[1])){l[g[1]]=n.attributes[h].value}}}}}}return l},createFrame:function(h){var e=d.createElement("IFRAME"),g=e.style;e.scrolling="no";e.frameBorder=0;e.width=h.width>0?h.width:0;e.height=h.height>0?h.height:0;g.border=0;g.overflow="hidden";return e},loadFrame:function(g,e){var h=g.contentDocument||g.contentWindow.document;h.open();h.writeln("<!DOCTYPE html>");h.writeln("<html>");h.writeln('<head>
<base target="_top">
<meta charset="UTF-8">
</head>');h.writeln('<body border="0" margin="0" style="margin: 0; padding: 0">');h.writeln(e);h.writeln("</body>");h.writeln("</html>");h.close()},spc:function(l){this.dispatchEvent("receive",l);for(var e in l){if(l.hasOwnProperty(e)){var p=l[e];var o=d.getElementById(e);if(o){var n=o.cloneNode(false);if(p.iframeFriendly){var k=f.createFrame(p);n.appendChild(k);o.parentNode.replaceChild(n,o);f.loadFrame(k,p.html)}else{n.style.textDecoration="none";n.innerHTML=p.html;var g=n.getElementsByTagName("SCRIPT");for(var m=0;m<g.length;m++){var r=document.createElement("SCRIPT");var q=g[m].attributes;for(var h=0;h<q.length;h++){r[q[h].nodeName]=q[h].value}if(g[m].innerHTML){r.text=g[m].innerHTML}g[m].parentNode.replaceChild(r,g[m])}o.parentNode.replaceChild(n,o)}}}}},getDataAttr:function(e){return"data-"+f.name+"-"+e},getEventName:function(e){return this.name+"-"+a+"-"+e},addEventListener:function(e,g){d.addEventListener(this.getEventName(e),g)},removeEventListener:function(e,g){d.removeEventListener(this.getEventName(e),g,true)},dispatchEvent:function(e,g){d.dispatchEvent(new CustomEvent(this.getEventName(e),{detail:g||{}}))}};f.main()}}catch(b){if(console.log){console.log(b)}}})(document,window);if(typeof org=="undefined"){var org={}}if(typeof org.openx=="undefined"){org.openx={}}if(typeof org.openx.util=="undefined"){org.openx.util={}}if(typeof org.openx.SWFObjectUtil=="undefined"){org.openx.SWFObjectUtil={}}org.openx.SWFObject=function(f,d,m,g,j,l,n,i,a,e){if(!document.getElementById){return}this.DETECT_KEY=e?e:"detectflash";this.skipDetect=org.openx.util.getRequestParameter(this.DETECT_KEY);this.params=new Object();this.variables=new Object();this.attributes=new Array();if(f){this.setAttribute("swf",f)}if(d){this.setAttribute("id",d)}if(m){this.setAttribute("width",m)}if(g){this.setAttribute("height",g)}if(j){this.setAttribute("version",new org.openx.PlayerVersion(j.toString().split(".")))}this.installedVer=org.openx.SWFObjectUtil.getPlayerVersion();if(!window.opera&&document.all&&this.installedVer.major>7){org.openx.SWFObject.doPrepUnload=true}if(l){this.addParam("bgcolor",l)}var b=n?n:"high";this.addParam("quality",b);var k=(i)?i:window.location;this.setAttribute("xiRedirectUrl",k);this.setAttribute("redirectUrl","");if(a){this.setAttribute("redirectUrl",a)}};org.openx.SWFObject.prototype={setAttribute:function(a,b){this.attributes[a]=b},getAttribute:function(a){return this.attributes[a]},addParam:function(a,b){this.params[a]=b},getParams:function(){return this.params},addVariable:function(a,b){this.variables[a]=b},getVariable:function(a){return this.variables[a]},getVariables:function(){return this.variables},getVariablePairs:function(){var a=new Array();var b;var c=this.getVariables();for(b in c){a[a.length]=b+"="+c[b]}return a},getSWFHTML:function(){var d="";if(navigator.plugins&&navigator.mimeTypes&&navigator.mimeTypes.length){d='<embed type="application/x-shockwave-flash" src="'+this.getAttribute("swf")+'" width="'+this.getAttribute("width")+'" height="'+this.getAttribute("height")+'" style="'+this.getAttribute("style")+'"';d+=' id="'+this.getAttribute("id")+'" name="'+this.getAttribute("id")+'" ';var c=this.getParams();for(var a in c){d+=[a]+'="'+c[a]+'" '}var b=this.getVariablePairs().join("&");if(b.length>0){d+='flashvars="'+b+'"'}d+="/>"}else{d='<object id="'+this.getAttribute("id")+'" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="'+this.getAttribute("width")+'" height="'+this.getAttribute("height")+'" style="'+this.getAttribute("style")+'">';d+='<param name="movie" value="'+this.getAttribute("swf")+'" />';var c=this.getParams();for(var a in c){d+='<param name="'+a+'" value="'+c[a]+'" />'}var b=this.getVariablePairs().join("&");if(b.length>0){d+='<param name="flashvars" value="'+b+'" />'}d+="</object>"}return d},write:function(a,b,d){if(this.skipDetect||this.installedVer.versionIsValid(this.getAttribute("version"))){var c=(typeof a=="string")?document.getElementById(a):a;c.innerHTML=this.getSWFHTML();this.logImpression(c,b);return true}else{if(this.getAttribute("redirectUrl")!=""){document.location.replace(this.getAttribute("redirectUrl"))}}this.logImpression(c,d);return false},logImpression:function(c,a){if(a){var b=document.createElement("IMG");b.style.position="absolute";b.style.width=0;b.src=a;c.appendChild(b)}}};org.openx.SWFObjectUtil.getPlayerVersion=function(){var c=new org.openx.PlayerVersion([0,0,0]);if(navigator.plugins&&navigator.mimeTypes.length){var a=navigator.plugins["Shockwave Flash"];if(a&&a.description){c=new org.openx.PlayerVersion(a.description.replace(/([a-zA-Z]|\s)+/,"").replace(/(\s+r|\s+b[0-9]+)/,".").split("."))}}else{if(navigator.userAgent&&navigator.userAgent.indexOf("Windows CE")>=0){var d=1;var b=3;while(d){try{b++;d=new ActiveXObject("ShockwaveFlash.ShockwaveFlash."+b);c=new org.openx.PlayerVersion([b,0,0])}catch(f){d=null}}}else{try{var d=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7")}catch(f){try{var d=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6");c=new org.openx.PlayerVersion([6,0,21]);d.AllowScriptAccess="always"}catch(f){if(c.major==6){return c}}try{d=new ActiveXObject("ShockwaveFlash.ShockwaveFlash")}catch(f){}}if(d!=null){c=new org.openx.PlayerVersion(d.GetVariable("$version").split(" ")[1].split(","))}}}return c};org.openx.PlayerVersion=function(a){this.major=a[0]!=null?parseInt(a[0]):0;this.minor=a[1]!=null?parseInt(a[1]):0;this.rev=a[2]!=null?parseInt(a[2]):0};org.openx.PlayerVersion.prototype.versionIsValid=function(a){if(this.major<a.major){return false}if(this.major>a.major){return true}if(this.minor<a.minor){return false}if(this.minor>a.minor){return true}if(this.rev<a.rev){return false}return true};org.openx.util={getRequestParameter:function(d){var c=document.location.search||document.location.hash;if(d==null){return c}if(c){var b=c.substring(1).split("&");for(var a=0;a<b.length;a++){if(b[a].substring(0,b[a].indexOf("="))==d){return b[a].substring((b[a].indexOf("=")+1))}}}return""}};org.openx.SWFObjectUtil.cleanupSWFs=function(){var c=document.getElementsByTagName("OBJECT");for(var b=c.length-1;b>=0;b--){c[b].style.display="none";for(var a in c[b]){if(typeof c[b][a]=="function"){c[b][a]=function(){}}}}};if(org.openx.SWFObject.doPrepUnload){if(!org.openx.unloadSet){org.openx.SWFObjectUtil.prepUnload=function(){__flash_unloadHandler=function(){};__flash_savedUnloadHandler=function(){};window.attachEvent("onunload",org.openx.SWFObjectUtil.cleanupSWFs)};window.attachEvent("onbeforeunload",org.openx.SWFObjectUtil.prepUnload);org.openx.unloadSet=true}}if(!document.getElementById&&document.all){document.getElementById=function(a){return document.all[a]}}var getQueryParamValue=org.openx.util.getRequestParameter;var FlashObject=org.openx.SWFObject;var SWFObject=org.openx.SWFObject;document.mmm_fo=1;
</script>
</body>
