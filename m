From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 3/5] ASoC: Add drivers for the Texas
 Instruments OMAP processors
Date: Wed, 23 Apr 2008 08:57:31 +0300
Message-ID: <20080423085731.f0f9c05f.jarkko.nikula@nokia.com>
References: <1208870079-5325-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208870079-5325-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208870079-5325-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hskxe9dvs.wl%tiwai@suse.de>
	<20080422144331.GB5242@rakim.wolfsonmicro.main>
	<s5hlk369bvu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 6012D2452D
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 07:56:57 +0200 (CEST)
In-Reply-To: <s5hlk369bvu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 22 Apr 2008 16:56:21 +0200
"ext Takashi Iwai" <tiwai@suse.de> wrote:

> If the stuff has to cooperate with the changes in other trees, pass it
> seprately to Andrew (or give me a hint) so that it's put to mm tree
> rightly at the next time.
> 
That's a good idea. There is a work in progress in linux-omap to update
low-level OMAP McBSP driver and to have support for newer OMAPs and I
would like to update my driver as soon as that work is ready without
waiting over one release cycle :-)


Jarkko
