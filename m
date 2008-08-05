From: krzysztof.h1@poczta.fm
Subject: Re: [PATCH 07/11] wss_lib: use CS4231P instead of
	AD1848P (kill the AD1848P)
Date: 05 Aug 2008 12:53:43 +0200
Message-ID: <20080805105343.904D1E714B7@f16.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 6FFED2456C
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Aug 2008 12:53:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>, Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

> On 31-07-08 21:07, Krzysztof Helt wrote:
> 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > Use CS4231P instead of AD1848P (kill the AD1848P).
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > ---
> > Changes since previous version:
> > 
> > 1. No reformatting of the snd_ad1848_debug()
> >    as the file is going to be killed.
> > 1. Nicer formatting of WSS_SINGLE and WSS_DOUBLE
> >    macros.
> 
> I believe 1 no. 2 is a cut & paste error? There are no such changes in 
> this patch.
> 

Right.

Regards,
Krzysztof



----------------------------------------------------------------------
Wymien zeszyty na notebooka!
Sprawdz >>> http://link.interia.pl/f1eab 
