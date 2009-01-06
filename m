From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: Bug tracking help wanted (Re: alsa driver #2234
 SoundScape Elite not support)
Date: Tue, 6 Jan 2009 18:17:10 +0100
Message-ID: <20090106181710.3a9ba7cd.krzysztof.h1@poczta.fm>
References: <8D479F36-7BCB-487E-A4A9-25DB7C9A1AD0@hws.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id E4519103810
	for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2009 18:14:52 +0100 (CET)
In-Reply-To: <8D479F36-7BCB-487E-A4A9-25DB7C9A1AD0@hws.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Theodore J. Allen" <tjallen@hws.edu>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 31 Dec 2008 15:51:56 -0500
"Theodore J. Allen" <tjallen@hws.edu> wrote:

> As a new Slackware was just released this month, I have been  
> upgrading and tweaking my new 2.6.27.7 kernel and just noticed this  
> week that last year there was some activity on the ISA SoundScape non- 
> PnP ALSA driver.  I have played with it some more, but have not  
> gotten it to work.  I'm still interested in getting a working ALSA  
> driver for the SoundScape Elite, so if a developer has code for me to  
> test, I will.

I have only SoundScape VIVO card, but I can provide some help if you can
send me the output from the driver (snd_sscape module). Please compile
kernel with sound options: "Verbose printk", "Debug" and "More verbose debug".

I suspect the Elite model requires some firmware to be uploaded before the
card is usable.

Kind regards,
Krzysztof

Dzwon tanio do wszystkich!
Sprawdz >> http://link.interia.pl/f200a
