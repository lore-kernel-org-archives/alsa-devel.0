From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: 1.0.2 release
Date: Tue, 27 Jan 2004 11:28:37 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401271126570.3133@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0401271049310.3133@pnote.perex-int.cz>
 <4016394B.7080201@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA15700
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 11:27:46 +0100
In-Reply-To: <4016394B.7080201@gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 27 Jan 2004, Carl-Daniel Hailfinger wrote:

> Jaroslav Kysela wrote:
> > Hello all,
> > 
> > 	we released packages 1.0.2.
> 
> The current tree from kernel.org claims in linux/include/sound/version.h
> that only Alsa 0.9.7 is integrated. Is that correct?

Yes, in Andrew Morton's (mm) tree is more updated ALSA and you can get 
latest patches from:

ftp://ftp.alsa-project.org/pub/kernel-patches

We fixed all of serious bugs now so I will ask Linus to sync with our BK 
tree today.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
