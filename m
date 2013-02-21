From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
	codec)
Date: Thu, 21 Feb 2013 22:01:58 +0800
Message-ID: <CAN8cciYK=o_bEW-u63+U-hOj6mYtypQ63vwVv2u7foicNr98cQ@mail.gmail.com>
References: <s5hzjzbql3a.wl%tiwai@suse.de>
 <20130216112505.GE4164@marvin.atrad.com.au>
 <s5h8v6ncpcp.wl%tiwai@suse.de>
 <20130217125316.GA25824@marvin.atrad.com.au>
 <s5h1ucedgge.wl%tiwai@suse.de> <s5hzjyzi8a5.wl%tiwai@suse.de>
 <20130220121055.GA23804@marvin.atrad.com.au>
 <s5hip5ni0ur.wl%tiwai@suse.de>
 <20130221121540.GA11524@marvin.atrad.com.au>
 <CAN8ccibAsWUVCcEem-ykcouJ6RXEG8k-eq9mPf7VV7qPied6nw@mail.gmail.com>
 <20130221135230.GA12678@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id DB5CB265005
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2013 15:01:59 +0100 (CET)
Received: by mail-ie0-f180.google.com with SMTP id bn7so11466198ieb.11
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2013 06:01:58 -0800 (PST)
In-Reply-To: <20130221135230.GA12678@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, peter.golden@btinternet.com, ullinux@ymail.com
List-Id: alsa-devel@alsa-project.org

> >
> > Can you confirm that the speaker really need this patch to work ?
> >
> >
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commit;h=978e77e78cff7a85a31ad552ffd8afee319e8721
>
> No.  The speaker required this patch:
>
>
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commit;h=e6e0ee507f630350d883bb3343e78cab30cad5e2

Is this patch also need ?

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commit;h=39aedee7a1cc3c72d68674ff6ff142299fa0897b
