From: Frank.Uepping@t-online.de (FAU)
Subject: Async Transfer Method
Date: Fri, 26 Jul 2002 15:42:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4151DA.56765B56@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com [194.25.134.80])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA26326
	for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2002 15:43:23 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I try to do IO with the async transfer method, but I don't get it work.
As artwork I use the pcm example, but it doesn't work too (pcm -m async).
Apparently the callback gets not called.
Is there a bug concerning this?

/FAU




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
