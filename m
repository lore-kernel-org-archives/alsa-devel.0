From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: DMA: do all drivers need it?
Date: Tue, 23 Apr 2002 12:10:53 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020423191053.81397.qmail@web11507.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11507.mail.yahoo.com (web11507.mail.yahoo.com [216.136.172.39])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id VAA20135
	for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2002 21:10:56 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am starting to write an sound driver for a card with no previous support and
would like to know if DMA is necessary as per the ALSA framework itself. My
card doesn't support DMA, yet. So if your answer is no, I would need to
fallback on OSS for the time being.

Thanks,
Guilhem.


__________________________________________________
Do You Yahoo!?
Yahoo! Games - play chess, backgammon, pool and more
http://games.yahoo.com/

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
