From: Thomas Hoffmann <tjhoffm@gmail.com>
Subject: snd-hda-intel acl269 toshiba r700 speakers work,
	headphones do not
Date: Sat, 17 Jul 2010 11:40:20 -0700
Message-ID: <4C41F914.5040508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 309CA246E7
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jul 2010 20:40:21 +0200 (CEST)
Received: by pxi2 with SMTP id 2so1660274pxi.38
	for <alsa-devel@alsa-project.org>; Sat, 17 Jul 2010 11:40:20 -0700 (PDT)
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

Dear Alsa developers,

Sound works from the built in laptop speakers. When headphones are 
plugged in, the speakers properly mute, but there is no sound coming 
from the headphones. I've tried some of the options to the 
alsa-base.conf file to no avail; generally they made it so sound came 
out of the speakers always, even when headphones were plugged in.

I previously sent an e-mail to this list server:
     https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5064
where they suggested I e-mail you. My system info is available from
     
http://www.alsa-project.org/db/?f=f9aaf6e43b669cf2c4b2215781a414b12843e2a3

Best,
Tom
