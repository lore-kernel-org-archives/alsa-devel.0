From: Olaf Hering <olh@suse.de>
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
Date: Thu, 2 Mar 2006 01:00:19 +0100
Message-ID: <20060302000019.GB6792@suse.de>
References: <jehd7527wq.fsf@sykes.suse.de> <1139783738.5247.54.camel@localhost.localdomain> <20060226173908.GA4871@suse.de> <20060301223034.GA5965@suse.de> <1141254596.3889.26.camel@localhost.localdomain> <1141256965.4378.145.camel@grayson>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1457E1AB
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 01:00:20 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <1141256965.4378.145.camel@grayson>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ben Collins <bcollins@ubuntu.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, alsa-devel@alsa-project.org, Ben Collins <ben.collins@ubuntu.com>, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

 On Wed, Mar 01, Ben Collins wrote:

> I'm rediffing now. However, I may not include my tumbler changes
> immediately. For some reason, those are the ones causing problems. I
> need to review the diff and see if I can find the problem (which I
> cannot reproduce).

Can you make individual patches, each one fixing one thing, going from A
to B.  You know that hch song...


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
