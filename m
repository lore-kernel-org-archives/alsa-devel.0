From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [patch] snd-pcsp: depend on CONFIG_EXPERIMENTAL
Date: Sat, 17 May 2008 12:05:17 +0300
Message-ID: <20080517090517.GB3284@cs181133002.pp.htv.fi>
References: <482E0734.7080003@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BBC524AC4
	for <alsa-devel@alsa-project.org>;
	Sat, 17 May 2008 11:07:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <482E0734.7080003@aknet.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@aknet.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 17, 2008 at 02:14:12AM +0400, Stas Sergeev wrote:
> Hello.
> 
> Considering all the feedbacks I got,
> depending snd-pcsp on CONFIG_EXPERIMENTAL
> looks like the only safe way to get out
> of all the troubles at one go. :)
>...

No objections against your patch, but considering that virtually 
everyone has EXPERIMENTAL enabled in his kernel it won't bring
you out of any troubles...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
