From: prabhu  <prabhu@lbinfotech.com>
Subject: Alsa Problem
Date: Fri, 2 May 2008 17:07:11 +0530 (IST)
Message-ID: <17414844.1209728231345.JavaMail.root@127.0.0.1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lbinfotech.com (mail.lbinfotech.com [203.101.41.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B6F11037FB
	for <alsa-devel@alsa-project.org>;
	Fri,  2 May 2008 13:17:03 +0200 (CEST)
Received: from unknown (HELO mail.speechbridgetech.com) ([127.0.0.1])
	(envelope-sender <prabhu@lbinfotech.com>)
	by 0 (qmail-ldap-1.03) with SMTP
	for <alsa-devel@alsa-project.org>; 2 May 2008 11:37:11 -0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Respected Sir............
My name is prabhu working in one of the software company in india.
when i was trying to use arecord and aplay command in my console(fedora-2.6.11-1.1369_FC4) i am getting following report....
So please kindly describe me for solve this problem...i am newbie in linux...
[root@localhost cards]# arecord
ALSA lib conf.c:1578:(snd_config_load1) _toplevel_:56:23:No such file or directory
ALSA lib conf.c:2821:(snd_config_hook_load) /etc/alsa/cards/aliases.conf may be old or corrupted: consider to remove or fix it
ALSA lib conf.c:2684:(snd_config_hooks_call) function snd_config_hook_load returned error: No such file or directory
ALSA lib pcm.c:1959:(snd_pcm_open_conf) Invalid type for PCM default definition (id: default, value: cards.pcm.default)
arecord: main:564: audio open error: Invalid argument
[root@localhost cards]#
Thanks &b Regards
Prabhu P
