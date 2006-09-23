From: Mauro Sacchetto <mauro.sacchetto@alice.it>
Subject: Re: Troubles with hda_intel
Date: Sat, 23 Sep 2006 17:54:27 +0200
Message-ID: <200609231754.27432.mauro.sacchetto@alice.it>
References: <200609231519.53947.mauro.sacchetto@alice.it>
	<1159025098.1097.137.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp-out01.alice.it (smtp-out01.alice.it [85.33.2.12])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AAEEF101
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Sep 2006 17:54:19 +0200 (MEST)
In-Reply-To: <1159025098.1097.137.camel@mindpipe>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alle 17:24, sabato 23 settembre 2006, hai scritto:
> Check whether KDE is still using the obsolete OSS API:
> # fuser /dev/dsp
> Lee


root@darkstar:~# fuser /dev/dsp
root@darkstar:~#

Nothing is shown by fuser...
Thanx
M.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
