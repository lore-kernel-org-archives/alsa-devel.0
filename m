From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: SIU driver shall select FW_LOADER
Date: Thu, 18 Mar 2010 09:01:05 +0000
Message-ID: <1268902865.3773.15.camel@odin>
References: <Pine.LNX.4.64.1003180916590.4485@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f176.google.com (mail-iw0-f176.google.com
	[209.85.223.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 21882245FA
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 10:01:09 +0100 (CET)
Received: by iwn6 with SMTP id 6so236755iwn.4
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 02:01:08 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1003180916590.4485@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-03-18 at 09:39 +0100, Guennadi Liakhovetski wrote:
> The SIU ASoC driver must load firmware to program the DSP, therefore it 
> has to select FW_LOADER in its Kconfig entry.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
