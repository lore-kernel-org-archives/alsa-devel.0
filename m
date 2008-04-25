From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH 1/3] asoc tlv320aic3x: revisit clock setup
Date: Fri, 25 Apr 2008 16:28:46 +0300
Message-ID: <bd7b27490804250628v44ba4892xca1ad91b4f1301ad@mail.gmail.com>
References: <20080425091707.GA18452@buzzloop.caiaq.de>
	<s5hlk32l1v7.wl%tiwai@suse.de>
	<20080425093657.GC18558@buzzloop.caiaq.de>
	<bd7b27490804250255j5ed1ea14l1df4b3c1d91e1b7c@mail.gmail.com>
	<20080425101801.GE18558@buzzloop.caiaq.de>
	<bd7b27490804250340y629cc7e6s61b056dc6505f55a@mail.gmail.com>
	<20080425104731.GF18558@buzzloop.caiaq.de>
	<bd7b27490804250430p21446f54t42dbcff07ae1579@mail.gmail.com>
	<20080425125832.GA20569@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.235])
	by alsa0.perex.cz (Postfix) with ESMTP id 54F5D247A1
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 15:28:48 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id t11so4308429wxc.23
	for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2008 06:28:47 -0700 (PDT)
In-Reply-To: <20080425125832.GA20569@buzzloop.caiaq.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 25, 2008 at 3:58 PM, Daniel Mack <daniel@caiaq.org> wrote:

> On Fri, Apr 25, 2008 at 02:30:29PM +0300, Jarkko Nikula wrote:
> > This dead code below was there but otherwise I think this is good now.
> >
> > +        /* printk(KERN_INFO "%s(): bypassing PLL with Q=%d\n",
> > +            __func__, pll_q); */
>
> Oh well. Last shot now, I hope ;)
>
>
Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
