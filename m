From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000
	machine driver
Date: Wed, 13 Jul 2011 23:16:40 +0800
Message-ID: <CAA+hA=QmcSGoe7w2jMRUCa18auQLOXXjnGQ8QtLZrteD3Q1ysA@mail.gmail.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
	<20110713115711.GG1928@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F7721CDBAA@039-SN1MPN1-002.039d.mgd.msft.net>
	<65EE16ACC360FA4D99C96DC085B3F7721CDC7C@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110713140038.GI1928@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F7721CDD7B@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110713150102.GK1928@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F15982433F
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 17:16:40 +0200 (CEST)
Received: by gwj17 with SMTP id 17so2591986gwj.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2011 08:16:40 -0700 (PDT)
In-Reply-To: <20110713150102.GK1928@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, Dong Aisheng-B29396 <B29396@freescale.com>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

2011/7/13 Wolfram Sang <w.sang@pengutronix.de>:
> On Wed, Jul 13, 2011 at 02:22:42PM +0000, Dong Aisheng-B29396 wrote:
>>
>> You mean the sound is incorrect?
>
> It was, but is fixed now. There was something wrong in our audio-path
> electrically. Together with your DMA patch, music sounds fine now \o/
>

It's good.
Thanks for the test.

Regards
Dong Aisheng
