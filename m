From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.32
Date: Sun, 30 Aug 2009 10:47:14 +0100
Message-ID: <20090830094713.GA4334@sirena.org.uk>
References: <20090823101656.GA11491@sirena.org.uk>
	<200908280229.40432.marek.vasut@gmail.com>
	<1251467389.5039.97.camel@finisterre.sirena.org.uk>
	<200908292103.50815.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 47D9E2413F
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Aug 2009 11:47:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200908292103.50815.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 29, 2009 at 09:03:50PM +0200, Marek Vasut wrote:

> I think you noticed it's not very up-to-date (.31-rc1, last update from 
> 30/07/2009).

I haven't actually had much cause to look at it but an update from a
month ago seems reasonable - the power subsystem is fairly small and I
wouldn't expect an enormous rate of change in it.

> > Also, I've asked you several times to stop sending multiple patches in
> > one e-mail.

> I mailed only one.

So you did; my mistake (I had expected you to have resent entire
series).

> > Have you tried using git format-patch and git send-email to send
> > patches? I have suggested this to you several times without any
> > response. These programs will take care of the overwhelming majority of
> > the technical issues with your submissions - there are example
> > configurations available for use with gmail.

> Yeah, I need to look into that ... it's not like Im ignoring it.

Please do so and if you're running into problems ask.  You're doing a
lot of good work but the fact that you do so much work makes it more
important that this stuff work well - an occasional patch that needs
manual handling is not so bad but the more work that's involved the more
additional overhead adds up.
