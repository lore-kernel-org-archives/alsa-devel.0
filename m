From: Roo - Andrew Baines <andrewmbaines@gmail.com>
Subject: Re: Regression post-ALSA 1.0.22 for Lenovo G555
	Internal mic
Date: Tue, 24 May 2011 16:25:45 +0100
Message-ID: <BANLkTi=p6dHG3DsA89+r3PZRMyvnPG6geg@mail.gmail.com>
References: <BANLkTi=BK3OiB0=EdmSGPwiPDiiok12q8A@mail.gmail.com>
	<s5hfwo5pf72.wl%tiwai@suse.de>
	<BANLkTi=F652XC9JLvUXcQVmZo3CxymjWsg@mail.gmail.com>
	<s5htycl43xj.wl%tiwai@suse.de>
	<BANLkTimgg7YnspcKdi-5VDJPxtE0KqDo5Q@mail.gmail.com>
	<s5haaecphen.wl%tiwai@suse.de>
	<BANLkTinnt-m63aEEf0WeLkCOR6c0t6AN0Q@mail.gmail.com>
	<s5hsjs4nyqe.wl%tiwai@suse.de>
	<BANLkTimNjm7Enwvqur1F5jvqV49gVgmAMw@mail.gmail.com>
	<s5hfwo4nvil.wl%tiwai@suse.de>
	<BANLkTineCBmfzno2v9jpMJYaH+LSv+vdRw@mail.gmail.com>
	<s5hvcx0m9a9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A60481039A7
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 17:26:02 +0200 (CEST)
Received: by iwc10 with SMTP id 10so6801558iwc.38
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2011 08:26:02 -0700 (PDT)
In-Reply-To: <s5hvcx0m9a9.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Haha, no sorry, it couldnt work better - as in its working perfectly and
could not be better!

I have reduced the volumes now.

Sorry for the confusion, and thanks for the help.

Andrew

On 24 May 2011 16:02, Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 24 May 2011 14:25:17 +0100,
> Roo - Andrew Baines wrote:
> >
> > Ah, I was using the snapshot from alsa-project.org.
> >
> > Sorry about that. The (actual) latest snapshot couldnt work better.
>
> Are you sure?  What doesn't work better?  And how did you test it?
>
> As far as I see, the connection from internal-mic to ADC is OK.
> But you set all volumes to max, and this would result in too
> overloaded signal, anyway.
>
> And, the HP auto-muting should work now.
>
>
> Takashi
>
