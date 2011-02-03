From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Create an AIF1ADCDAT signal
 widget to match AIF2
Date: Thu, 03 Feb 2011 20:13:33 +0000
Message-ID: <1296764013.3456.125.camel@odin>
References: <1296750455-8175-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4EC08103851
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 21:13:38 +0100 (CET)
Received: by wyi11 with SMTP id 11so1500197wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Feb 2011 12:13:36 -0800 (PST)
In-Reply-To: <1296750455-8175-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-02-03 at 16:27 +0000, Dimitris Papastamos wrote:
> From: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Due to the different routing for AIF1 and AIF2 we weren't using a
> single widget to represent the ADCDAT signal. For consistency add
> one.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
