From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Float sample format
Date: Thu, 4 Nov 2004 15:52:46 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411041550420.25979-100000@studcom.urz.uni-halle.de>
References: <E1CPfq9-0006EQ-UC@mailer.emlix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0D3A8228
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2004 15:52:47 +0100 (MET)
In-Reply-To: <E1CPfq9-0006EQ-UC@mailer.emlix.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nicolas =?iso-8859-1?q?H=FCppelsh=E4user?= <nh@emlix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nicolas H=FCppelsh=E4user wrote:
> What are the sample value ranges used when having sample format float(l=
e) or
> double(le)?

Between -1 and 1. (LE/BE doesn't make any difference.)

> When playing, the sound is loudest when using the whole range the type =
offers.

Really?  What sound card lets you play inifinitely loud samples? :-)


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
