From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: Re: [PATCH] AZT3328 driver update
Date: Wed, 14 Sep 2005 13:42:42 +0200
Message-ID: <20050914114242.GA30401@rhlx01.fht-esslingen.de>
References: <20050913225958.GA28548@rhlx01.fht-esslingen.de> <s5hd5ncdk3a.wl%tiwai@suse.de>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hd5ncdk3a.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: andi@lisas.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, Sep 14, 2005 at 12:23:05PM +0200, Takashi Iwai wrote:
> Thanks.
> 
> One thing I'd like to ask is the removal of debug messages.
> It worsens the readability.

Hm, are you talking about ALL messages or only rather unnecessary ones?
I'd rather like to keep several of those...

> Also, don't forget Signed-off-by line, too.

Yup, I really should have realized that it obviously needs it since
the driver would soon go towards kernel...

I'll send an updated driver soon.

Thanks!

Andreas Mohr


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
