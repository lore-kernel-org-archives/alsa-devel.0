From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add ASoC Magician machine support.
Date: Tue, 20 Nov 2007 14:20:18 +0000
Message-ID: <20071120142017.GE21414@sirena.org.uk>
References: <1195550746-6892-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-15-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-17-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-18-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-19-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-20-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-21-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h1walji05.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C0C3924A22
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 15:20:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h1walji05.wl%tiwai@suse.de>
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
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 20, 2007 at 12:03:54PM +0100, Takashi Iwai wrote:

> Hmm... Some patches seem to have inconsistent From: and the author
> attribute.  For exmaple, this module has 

> 	MODULE_AUTHOR("Philipp Zabel");

> while Liam is in From header here (and it's a broken address :)

Yes, there's quite a few things look a bit bogus here.  I've gone
through and reviewed things - hopefully the meta information should be
more joined up for the next submission.
