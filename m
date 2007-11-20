From: "pHilipp Zabel" <philipp.zabel@gmail.com>
Subject: Re: [PATCH] Add ASoC Magician machine support.
Date: Tue, 20 Nov 2007 19:48:19 +0100
Message-ID: <74d0deb30711201048n3c878c50yb3d15bc8d6c7df3a@mail.gmail.com>
References: <1195550746-6892-15-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-17-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-18-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-19-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-20-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-21-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h1walji05.wl%tiwai@suse.de> <20071120142017.GE21414@sirena.org.uk>
	<74d0deb30711200634o65fefd02q4f12fa83710c1869@mail.gmail.com>
	<20071120154316.GB1744@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 19B3A24A7C
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 19:48:21 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so1735808nfd
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 10:48:20 -0800 (PST)
In-Reply-To: <20071120154316.GB1744@sirena.org.uk>
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
To: pHilipp Zabel <philipp.zabel@gmail.com>, Takashi Iwai <tiwai@suse.de>, liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Nov 20, 2007 4:43 PM, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Nov 20, 2007 at 03:34:40PM +0100, pHilipp Zabel wrote:
>
> > I'm only just about to push basic HTC Magician machine support to LAK,
> > so I'm not sure if this driver should still be held back a bit. I only
>
> I've no strong feeling either way so if you're unsure if it should go
> I'll drop it from the patch series for now.  Could you take care of
> submitting the ASoC changes when everything else is ready, please?

I will. That will also give me the opportunity make the driver use
clock and GPIO API before submitting.

regards
Philipp
