From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] sound/cs4231: replace schedule_timeout()
 with msleep_interruptible()
Date: Thu, 4 Nov 2004 08:58:52 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411040857580.11867-100000__17795.4773222611$1099556172$gmane$org@studcom.urz.uni-halle.de>
References: <20041103180315.GE2163@us.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 00AF6218
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2004 08:58:57 +0100 (MET)
In-Reply-To: <20041103180315.GE2163@us.ibm.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: perex@suse.cz, kernel-janitors@lists.osdl.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nishanth Aravamudan wrote:
> [...]
> These changes have been made in the following patch. Does it look better
> now?

Yes.  Applied.


Thanks!
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
