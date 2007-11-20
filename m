From: "pHilipp Zabel" <philipp.zabel@gmail.com>
Subject: Re: [PATCH] Add ASoC Magician machine support.
Date: Tue, 20 Nov 2007 15:34:40 +0100
Message-ID: <74d0deb30711200634o65fefd02q4f12fa83710c1869@mail.gmail.com>
References: <1195550746-6892-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-15-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-17-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-18-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-19-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-20-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-21-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h1walji05.wl%tiwai@suse.de> <20071120142017.GE21414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 990A624A25
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 15:34:42 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so1656089nfd
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 06:34:41 -0800 (PST)
In-Reply-To: <20071120142017.GE21414@sirena.org.uk>
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
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Nov 20, 2007 3:20 PM, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Nov 20, 2007 at 12:03:54PM +0100, Takashi Iwai wrote:
>
> > Hmm... Some patches seem to have inconsistent From: and the author
> > attribute.  For exmaple, this module has
>
> >       MODULE_AUTHOR("Philipp Zabel");
>
> > while Liam is in From header here (and it's a broken address :)
>
> Yes, there's quite a few things look a bit bogus here.  I've gone
> through and reviewed things - hopefully the meta information should be
> more joined up for the next submission.

I'm only just about to push basic HTC Magician machine support to LAK,
so I'm not sure if this driver should still be held back a bit. I only
sent it to Liam
directly by mail (actually I created it with his help in a sort of
email ping-pong),
so that's how his address ended up in the From: header.

regards
Philipp
