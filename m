From: "Brand, Mark (Mr) (Summerstrand Campus South)" <Mark.Brand@nmmu.ac.za>
Subject: Re: Gitcompile for Kernel 3.2?
Date: Mon, 6 Aug 2012 11:52:53 +0000
Message-ID: <35FE09CFAB387A4BA7ACDDED49F345181D0496@CRETE.nmmu.ac.za>
References: <35FE09CFAB387A4BA7ACDDED49F345181D00D8@CRETE.nmmu.ac.za>
 <s5h3940mpcd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from osiris.nmmu.ac.za (osiris.nmmu.ac.za [196.21.198.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A4E5265B59
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 13:23:37 +0200 (CEST)
In-Reply-To: <s5h3940mpcd.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Could you try the following tree (or alsa-driver snpashot)?
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver.git
>  ftp://ftp.suse.com/pub/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz

The git url couldn't be found (should I go with alsa-driver-build.git?), but I have pulled the tarball, thank you.  It wouldn't compile on my 3.2 lowlatency machine (with or without ALSAKERNELDIR set to 3.2.0-lowlatency source).  I'll carry it home and try on a vanilla 3.2 kernel tonight.  Would you mind clarifying for me: is it necessary to have kernel source on hand or not?

Thanks,
Mark Brand.

________________________________

NOTICE: Please note that this eMail, and the contents thereof, is subject to the standard NMMU eMail disclaimer which may be found at:
http://www.nmmu.ac.za/disclaimer/email.htm
