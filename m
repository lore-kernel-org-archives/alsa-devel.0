From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: ALSA 'share' device, or 'software multi-open'
Date: Mon, 30 Sep 2002 22:08:36 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D984CD4.3050304@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id PAA25006
	for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2002 15:10:02 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
Cc: Pete Black <pete@claudia.daemon.sh>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

[ please forward to alsa-devel for me. thanks. ]

 >IIUC the share plugin is not even intended to do what you want (as you
 >mention above) it is written to share audio between different devices
 >specified in the asoundrc file. Not to mix multiple streams from
 >multiple apps. Paul you should stop suggesting the share plugin as an
 >almost possible option. It is a red herring.

sorry, its a mis-identification rather than anything else. the plugin
i am trying to refer to exists, but as usual with ALSA, its not
documented and so even i don't know its name :) but yes, "mix" or
"smix" is the right one, not "share".

--p





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
