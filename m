From: Adrian Bunk <bunk@stusta.de>
Subject: Re: remove include/sound/yss225.h
Date: Sun, 27 Feb 2005 16:50:57 +0100
Message-ID: <20050227155057.GB6148__32355.1298155964$1109519411$gmane$org@stusta.de>
References: <20050227125654.GA15206@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id CE0F8285
	for <alsa-devel@alsa-project.org>; Sun, 27 Feb 2005 16:50:57 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20050227125654.GA15206@apps.cwi.nl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 27, 2005 at 01:56:56PM +0100, Andries Brouwer wrote:
> The file include/sound/yss225.h is unused.
> 
> It is more or less identical to sound/oss/yss225.h,
> used by sound/oss/wavfront.c.
> 
> # rm include/sound/yss225.h

This is already in the ALSA tree (and therefore in 2.6.11-rc4-mm1).

> Andries
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
