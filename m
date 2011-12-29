From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 02/14] ASoC: Convert cs4270 to
	devm_kzalloc()
Date: Thu, 29 Dec 2011 18:49:30 +0000
Message-ID: <4EFCB639.4090308@freescale.com>
References: <1325130983.19977.2.camel@phoenix>
	<1325131102.19977.4.camel@phoenix> <4EFC8CB3.8050507@freescale.com>
	<20111229181731.GI2909@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by alsa0.perex.cz (Postfix) with ESMTP id 0EA23103A49
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 19:49:37 +0100 (CET)
In-Reply-To: <20111229181731.GI2909@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <C4B776D39A3C304DA3DF11955577BEC1@freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Axel Lin <axel.lin@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> It's OK to ack things based purely off code review (epecially for simple
> transformations like this).

I understand that, but I would really like the opportunity to try it for 
myself first.  But if you're in a hurry to apply it, don't wait for me.
