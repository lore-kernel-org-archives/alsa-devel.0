From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: EP93xx: sampling rate range extended
Date: Thu, 09 Dec 2010 10:07:22 +0000
Message-ID: <1291889242.3271.19.camel@odin>
References: <1291809693.31916.2.camel@r60e>
	<20101208124637.GD16418@rakim.wolfsonmicro.main>
	<1291855429.31916.90.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DB6F103B9F
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 11:07:26 +0100 (CET)
Received: by wwe15 with SMTP id 15so2123274wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 09 Dec 2010 02:07:25 -0800 (PST)
In-Reply-To: <1291855429.31916.90.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-12-09 at 03:43 +0300, Alexander wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Changes to both I2S and PCM code:
> - Rates list extended up to 96kHz, it's tested on EDB9302 and works for both capture and
>   playback.
> 
> Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
