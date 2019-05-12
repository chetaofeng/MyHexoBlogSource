---
title: Linux命令
tags:
  - Linux
copyright: true
comments: true
toc: true
date: 2019-03-05 08:25:33
categories: Linux
password:
--- 
~~~
su：Swith user  切换用户，切换到root用户
cat: Concatenate  串联
uname: Unix name  系统名称
df: Disk free  空余硬盘
du: Disk usage 硬盘使用率
chown: Change owner 改变所有者
chgrp: Change group 改变用户组
ps：Process Status  进程状态
tar：Tape archive 解压文件
chmod: Change mode 改变模式
umount: Unmount 卸载
ldd：List dynamic dependencies 列出动态相依
insmod：Install module 安装模块
rmmod：Remove module 删除模块
lsmod：List module 列表模块
alias :Create your own name for a command
bash :GNU Bourne-Again Shell  linux内核 
grep:global regular expression print
httpd :Start Apache
ipcalc :Calculate IP information for a host
ping :Send ICMP ECHO_Request to network hosts
reboot: Restart your computer
sudo:Superuser do
 
/bin = BINaries 
/dev = DEVices 
/etc = ETCetera 
/lib = LIBrary 
/proc = PROCesses 
/sbin = Superuser BINaries 
/tmp = TeMPorary 
/usr = Unix Shared Resources 
/var = VARiable ? 
FIFO = First In, First Out 
GRUB = GRand Unified Bootloader 
IFS = Internal Field Seperators 
LILO = LInux LOader 
MySQL = My最初作者的名字SQL = Structured Query Language 
PHP = Personal Home Page Tools = PHP Hypertext Preprocessor 
PS = Prompt String 
Perl = "Pratical Extraction and Report Language" = "Pathologically Eclectic Rubbish Lister" 
Python Monty Python's Flying Circus 
Tcl = Tool Command Language 
Tk = ToolKit 
VT = Video Terminal 
YaST = Yet Another Setup Tool 
apache = "a patchy" server 
apt = Advanced Packaging Tool 
ar = archiver 
as = assembler 
bash = Bourne Again SHell 
bc = Basic (Better) Calculator 
bg = BackGround 
cal = CALendar 
cat = CATenate 
cd = Change Directory 
chgrp = CHange GRouP 
chmod = CHange MODe 
chown = CHange OWNer 
chsh = CHange SHell 
cmp = compare 
cobra = Common Object Request Broker Architecture 
comm = common 
cp = CoPy 
cpio = CoPy In and Out 
cpp = C Pre Processor 
cups = Common Unix Printing System 
cvs = Current Version System 
daemon = Disk And Execution MONitor 
dc = Desk Calculator 
dd = Disk Dump 
df = Disk Free 
diff = DIFFerence 
dmesg = diagnostic message 
du = Disk Usage 
ed = editor 
egrep = Extended GREP 
elf = Extensible Linking Format 
elm = ELectronic Mail 
emacs = Editor MACroS 
eval = EVALuate 
ex = EXtended 
exec = EXECute 
fd = file descriptors 
fg = ForeGround 
fgrep = Fixed GREP 
fmt = format 
fsck = File System ChecK 
fstab = FileSystem TABle 
fvwm = F*** Virtual Window Manager 
gawk = GNU AWK 
gpg = GNU Privacy Guard 
groff = GNU troff 
hal = Hardware Abstraction Layer 
joe = Joe's Own Editor 
ksh = Korn SHell 
lame = Lame Ain't an MP3 Encoder 
lex = LEXical analyser 
lisp = LISt Processing = Lots of Irritating Superfluous Parentheses 
ln = LiNk 
lpr = Line PRint 
ls = list 
lsof = LiSt Open Files 
m4 = Macro processor Version 4 
man = MANual pages 
mawk = Mike Brennan's AWK 
mc = Midnight Commander 
mkfs = MaKe FileSystem 
mknod = MaKe NODe 
motd = Message of The Day 
mozilla = MOsaic GodZILLa 
mtab = Mount TABle 
mv = MoVe 
nano = Nano's ANOther editor 
nawk = New AWK 
nl = Number of Lines 
nm = names 
nohup = No HangUP 
nroff = New ROFF 
od = Octal Dump 
passwd = PASSWorD 
pg = pager 
pico = PIne's message COmposition editor 
pine = "Program for Internet News & Email" = "Pine is not Elm" 
ping =  Packet InterNet Grouper 
pirntcap = PRINTer CAPability 
popd = POP Directory 
pr = pre 
printf = PRINT Formatted 
ps = Processes Status 
pty = pseudo tty 
pushd = PUSH Directory 
pwd = Print Working Directory 
rc = runcom = run command, shell 
rev = REVerse 
rm = ReMove 
rn = Read News 
roff = RunOFF 
rpm = RPM Package Manager = RedHat Package Manager 
rsh, rlogin, = Remote 
rxvt = ouR XVT 
sed = Stream EDitor 
seq = SEQuence 
shar = SHell ARchive 
slrn = S-Lang rn 
ssh = Secure SHell 
ssl = Secure Sockets Layer 
stty = Set TTY 
su = Substitute User 
svn = SubVersioN 
tar = Tape ARchive 
tcsh = TENEX C shell 
telnet = TEminaL over Network 
termcap = terminal capability 
terminfo = terminal information 
tr = traslate 
troff = Typesetter new ROFF 
tsort = Topological SORT 
tty = TeleTypewriter 
twm = Tom's Window Manager 
tz = TimeZone 
udev = Userspace DEV 
ulimit = User's LIMIT 
umask = User's MASK 
uniq = UNIQue 
vi = VIsual = Very Inconvenient 
vim = Vi IMproved 
wall = write all 
wc = Word Count 
wine = WINE Is Not an Emulator 
xargs = eXtended ARGuments 
xdm = X Display Manager 
xlfd = X Logical Font Description 
xmms = X Multimedia System 
xrdb = X Resources DataBase 
xwd = X Window Dump 
yacc = yet another compiler compiler
~~~

~~~
在Linux中，最为常用的缩略语也许是“rc”，它是“runcomm”的缩写――即名词“run command”(运行命令)的简写。今天，“rc”是任何脚本类文件的后缀，这些脚本通常在程序的启动阶段被调用，通常是Linux系统启动时。如/etc/rs是Linux启动的主脚本，而.bashrc是当Linux的bash shell启动后所运行的脚本。.bashrc的前缀“.”是一个命名标准，它被设计用来在用户文件中隐藏那些用户指定的特殊文件;“ls”命令默认情况下不会列出此类文件，“rm”默认情况下也不会删除它们。许多程序在启动时，都需要“rc”后缀的初始文件或配置文件，这对于Unix的文件系统视图来说，没有什么神秘的。

　　ETC

　　在“etc/bin”中的“etc”真正代表的是“etcetera”(附加物)。在早期的Unix系统中，最为重要的目录是“bin”目录(“bin”是“binaries”二进制文件――编译后的程序的缩写)，“etc”中则包含琐碎的程序，如启动、关机和管理。运行一个Linux必须的东西的列表是:一个二进制程序，etcetera，etcetera――换句话说，是一个底层的重要项目，通常添加一些次等重要的零碎事物。今天，“etc”包含了广泛的系统配置文件，这些配置文件几乎包含了系统配置的方方面面，同样非常重要。

　　Bin

　　今天，许多在Linux上运行的大型子系统，如GNOME或Oracle，所编译成的程序使用它们自己的“bin”目录(或者是/usr/bin，或者是/usr/local/bin)作为标准的存放地。同样，现在也能够在这些目录看到脚本文件，因为“bin”目录通常添加到用户的PATH路径中，这样他们才能够正常的使用程序。因此运行脚本通常在bin中运行良好。

　　TTY

　　在Linux中，TTY也许是跟终端有关系的最为混乱的术语。TTY是TeleTYpe的一个老缩写。Teletypes，或者teletypewriters，原来指的是电传打字机，是通过串行线用打印机键盘通过阅读和发送信息的东西，和古老的电报机区别并不是很大。之后，当计算机只能以批处理方式运行时(当时穿孔卡片阅读器是唯一一种使程序载入运行的方式)，电传打字机成为唯一能够被使用的“实时”输入/输出设备。最终，电传打字机被键盘和显示器终端所取代，但在终端或TTY接插的地方，操作系统仍然需要一个程序来监视串行端口。一个getty“Get TTY”的处理过程是:一个程序监视物理的TTY/终端接口。对一个虚拟网络沮丧服务器(VNC)来说，一个伪装的TTY(Pseudo-TTY，即家猫的TTY，也叫做“PTY”)是等价的终端。当你运行一个xterm(终端仿真程序)或GNOME终端程序时，PTY对虚拟的用户或者如xterm一样的伪终端来说，就像是一个TTY在运行。“Pseudo”的意思是“duplicating in a fake way”(用伪造的方法复制)，它相比“virtual”或“emulated”更能真实的说明问题。而在现在的计算中，它却处于被放弃的阶段。

　　Dev

　　从TTY留下的命令有“stty”，是“set tty”(设置TTY)的缩写，它能够生成一个配置文件/etc/initab(“initialization table”，初始表)，以配置gettys使用哪一个串口。在现代，直接附加在Linux窗口上的唯一终端通常是控制台，由于它是特殊的TTY，因此被命名为“console”。当然，一旦你启动X11，“console”TTY就会消失，再也不能使用串口协议。所有的TTY都被储存在“/dev”目录，它是“ devices”([物理]设备)的缩写。以前，你必须在电脑后面的串口中接入一个新的终端时，手工修改和配置每一个设备文件。现在，Linux(和Unix)在安装过程中就在此目录中创建了它所能向导的每一个设备的文件。这就是说，你很少需要自己创建它。

　　随着硬件在电脑中的移出移进，这些名字将变得更加模糊不清。幸运的是，今天在Linux上的高等级软件块对历史和硬件使用容易理解的名字。举例来说，嗯，Pango(http://www.pango.org/)就是其中之一。

　　如果你对这些内容很感兴趣，那么我建议你阅读宏大的，但有些以美国英语历史为中心的，由Eric S. Raymond撰写的Jargon File。它并没有解释所有在Unix中使用的术语，但是它给出了这些形成的大致情况。

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/vmlinuz 
　　我们已经知道，每一个linux都有一个内核（vmlinuz），我们在这个内核上添加上可以完成各种特定功能的模块，每个模块就体现在 linux中各种不同的目录上。当然，各种不同的发行套件，其目录有细小的差别，但主要结构都是一样的。我们还要将linux的功能模块和各种应用程序结合起来，这样，才能使你的 linux系统为你服务。在/vmlinuz目录下存放的就是系统的内核。
/bin 
　　显而易见，bin 就是二进制（binary）英文缩写。在一般的系统当中，你都可以在这个目录下找到linux常用的命令。在有的版本中你还会找到一些和根目录下相同的目录。 

/boot 
　　在这个目录下存放的都是系统启动时要用到的程序。我们在使用lilo引导linux的时候，会用到这里的一些信息。 

/dev 
　　dev 是设备(device)的英文缩写。这个目录对所有的用户都十分重要。因为在这个目录中包含了所有linux系统中使用的外部设备。但是这里并不是放的外部设备的驱动程序。这一点和我们常用的windows, dos操作系统不一样。它实际上是一个访问这些外部设备的端口。我们可以非常方便地去访问这些外部设备，和访问一个文件，一个目录没有任何区别。 例如：我们在系统中键入：cd /dev/cdrom 我们就可以看到光驱中的文件了。在这个目录下，有一个null设备，这个东西本身没有任何意义。如果你向这个目录写入文件或内容，他们统统有去无回。 

/cdrom 
　　这个目录在你刚刚安装系统的时候是空的。你可以将光驱文件系统挂在这个目录下。例如：mount /dev/cdrom /cdrom 

/etc 
　　etc这个目录是linux系统中最重要的目录之一。在这个目录下存放了系统管理时要用到的各种配置文件和子目录。我们要用到的网络配置文件，文件系统，x系统配置文件，设备配置信息，设置用户信息等都在这个目录下。 

/sbin 
　　这个目录是用来存放系统管理员的系统管理程序。 

/home 
　　如果我们建立一个用户，用户名是"xx",那么在/home目录下就有一个对应的/home/xx路径，用来存放用户的主目录。 

/lib 
　　lib是库（library）英文缩写。这个目录是用来存放系统动态连接共享库的。几乎所有的应用程序都会用到这个目录下的共享库。

/lost+found 
　　这个目录在大多数情况下都是空的。但是如果你正在工作突然停电，或是没有用正常方式关机，在你重新启动机器的时候，有些文件就会找不到应该存放的地方，对于这些文件，系统将他们放在这个目录下，就象为无家可归的人提供一个临时住所。 

/mnt 
　　这个目录在一般情况下也是空的,有时有四个空目录.你可以临时将别的文件系统挂在这个目录下。 

/proc 
　　可以在这个目录下获取系统信息。这些信息是在内存中，由系统自己产生的。这个目录是一个虚拟的目录，它是系统内存的映射，我们可以通过直接访问这个目录来获取系统信息。这个目录的内容不在硬盘上而是在内存里，我们也可以直接修改里面的某些文件，比如可以通过下面的命令来屏蔽主机的ping命令，使别人无法ping你的机器： 
　　echo 1 > /proc/sys/net/ipv4/icmp_echo_ ignore_all。

/root 
　　如果你是以超级用户的身份登录的，这个就是超级用户的主目录。 

/tmp 
　　用来存放不同程序执行时产生的临时文件。 

/usr 
　　这是linux系统中占用硬盘空间最大的目录。用户的很多应用程序和文件都存放在这个目录下。具体来说： 

　　/usr/X11R6存放X-Windows的目录； 

　　/usr/games存放着XteamLinux自带的小游戏； 

　　/usr/bin存放着许多应用程序； 

　　/usr/sbin存放root超级用户使用的管理程序； 

　　/usr/doc Linux技术文档； 

　　/usr/include用来存放Linux下开发和编译应用程序所需要的头文件； 

　　/usr/lib存放一些常用的动态链接共享库和静态档案库； 

　　/usr/local这是提供给一般用户的/usr目录，在这里安装一般的应用软件； 

　　/usr/man帮助文档所在的目录； 

　　/usr/src Linux开放的源代码，就存在这个目录，爱好者们别放过哦；

/var这个目录中存放着在不断扩充着的东西，我们习惯将那些经常被修改的目录放在这个目录下。包括各种日志文件。如果你想做一个网站，你也会用到/var/www这个目录。
~~~




