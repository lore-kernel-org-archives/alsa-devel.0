From: Pavel Roskin <proski@gnu.org>
Subject: Re: CVSCOMPILE problems
Date: Fri, 18 Oct 2002 23:10:31 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0210182300460.1689-100000@localhost.localdomain>
References: <20021016141742.GB25933@ee.unsw.edu.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from srv1.mail.cv.net (srv1.mail.cv.net [167.206.112.40])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id FAA32655
	for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2002 05:10:37 +0200
Received: from [192.168.2.100] (ool-43532d3b.dyn.optonline.net [67.83.45.59])
 by srv1.mail.cv.net (Sun Internet Mail Server sims.4.0.2000.10.12.16.25.p8)
 with ESMTP id <0H4700J65KPLVB@srv1.mail.cv.net> for
 alsa-devel@alsa-project.org; Fri, 18 Oct 2002 23:08:09 -0400 (EDT)
In-reply-to: <20021016141742.GB25933@ee.unsw.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matt Flax <flatmax@ieee.org>
Cc: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello!

> In relation to this article/patch, I need to compile the CVS sources
> after 14'th :
> http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg04810.html
> 
> I have downloaded them, but am having trouble compiling them.

I think you have downloaded the snapshot of the repository, not the
sources.  You can use the snapshot of the repository to set up your own
CVS server, but I don't think you need it.

Either take the latest source snapshot from
ftp://ftp.alsa-project.org/pub/cvsexport or use the CVS server on
cvs.alsa-project.org, as described at
http://www.alsa-project.org/download.php3

> But I need to run cvscompile ?

Yes, you need to run cvscompile.

> confused

Somebody please add an explanation on
http://www.alsa-project.org/download.php3 near "CVS repository snapshots".  
I'm sure that a significant part of downloads of those snapshots are by
people who don't need them.

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by:
Access Your PC Securely with GoToMyPC. Try Free Now
https://www.gotomypc.com/s/OSND/DD
