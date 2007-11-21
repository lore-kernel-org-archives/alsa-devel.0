From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add ASoC TLV320 Codec driver.
Date: Wed, 21 Nov 2007 12:33:05 +0000
Message-ID: <20071121123304.GA18228@sirena.org.uk>
References: <1195550746-6892-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-15-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-17-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h4pfhjihm.wl%tiwai@suse.de>
	<20071120223442.7e0bcead@hyperion.delvare>
	<s5hfxz0hqtr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F377248C3
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 13:33:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hfxz0hqtr.wl%tiwai@suse.de>
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
Cc: Jean Delvare <khali@linux-fr.org>, liam.girdwood@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, i2c@lm-sensors.org, Nicola Perrino <nicola.perrino@atlab.it>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 21, 2007 at 10:48:32AM +0100, Takashi Iwai wrote:
> Jean Delvare wrote:

> > You don't seem to use these driver IDs anywhere? These IDs are
> > optional, so if you have no need for them, it's much easier to just not
> > define them.

> Thanks, that's good to know.
> Mark, could you get rid of them in your next patch series?

Yes, I will do so.
