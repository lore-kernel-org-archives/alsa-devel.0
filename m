From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: Re: [PATCH 2/2] ALSA sound driver
	for	the	AT73C213	DAC	using Atmel SSC driver
Date: Thu, 26 Jul 2007 08:21:20 +0200
Message-ID: <1185430880.31437.28.camel@localhost.localdomain>
References: <11845952993023-git-send-email-hcegtvedt@atmel.com>
	<11845952991232-git-send-email-hcegtvedt@atmel.com>
	<s5hwsx0xu7h.wl%tiwai@suse.de>
	<1184661441.12675.6.camel@localhost.localdomain>
	<20070717104859.34f76382@dhcp-255-175.norway.atmel.com>
	<1184662459.12675.8.camel@localhost.localdomain>
	<s5hvecjwcoz.wl%tiwai@suse.de>  <s5hhcnvyy37.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (nat-132.atmel.no [80.232.32.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 70D0424379
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jul 2007 08:20:41 +0200 (CEST)
In-Reply-To: <s5hhcnvyy37.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, kernel@avr32linux.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
List-Id: alsa-devel@alsa-project.org


On Mon, 2007-07-23 at 16:49 +0200, Takashi Iwai wrote:
> At Tue, 17 Jul 2007 12:23:56 +0200,
> I wrote:
> > 
> > Then I'll queue it soon after the merge window is closed, so that your
> > driver appears in the mm tree.
> 
> FYI, I applied the patches to ALSA HG tree now (for 2.6.24).

Thanks, the SSC driver is also in Andrews -mm tree, so user should be
able to test this by fetching both trees.

-- 
With kind regards,

Hans-Christian Egtvedt, siv.ing. (M.Sc.)
Applications Engineer - AVR32 System Solutions - Atmel Norway
