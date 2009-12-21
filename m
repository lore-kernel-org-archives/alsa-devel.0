From: krzysztof.h1@poczta.fm
Subject: Re:
	=?utf-8?q?=5BPATCH=5D_jazz16=3A_Add_support_for_Medi?=
	=?utf-8?q?a_Vision_Jazz16_chipset?=
Date: 21 Dec 2009 12:57:38 +0100
Message-ID: <20091221115738.D2ABD7DC910@f47.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 33E4010386F
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 12:57:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

"Takashi Iwai" <tiwai@suse.de> pisze:
> At Sun, 20 Dec 2009 19:01:50 +0100,

> Krzysztof Helt wrote:

> > 

> > From: Krzysztof Helt <krzysztof.h1@wp.pl>

> > 

> > This is one of Sound Blaster Pro compatible chipsets which is supported

> > by Linux OSS driver and was missing native supoort for ALSA.

> > 

> > The Jazz16 audio codec is Crystal CS4216 which is capable

> > of playback and recording up to 48 kHz stereo.

> > 

> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

> 

> Applied.  Could you add the entry to ALSA-Configuration.txt, too?

> 

Yes. There is also one more thing to test - if only one DMA channel is specified (the same for both DMAs).

Regards,
Krzysztof

----------------------------------------------------------------------
Sypie, sypie, ale czy sypac bedzie nadal?
Sprawdz pogode >> http://link.interia.pl/f2530
