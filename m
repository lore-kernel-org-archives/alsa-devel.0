From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC 0/4] ASoC: OMAP3: Extended threshold mode
Date: Mon, 02 Aug 2010 10:43:15 +0100
Message-ID: <1280742195.3095.24.camel@odin>
References: <1280386288-22019-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100729172247.GC24781@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BACE0243BB
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 11:43:18 +0200 (CEST)
Received: by wwe15 with SMTP id 15so2306042wwe.20
	for <alsa-devel@alsa-project.org>; Mon, 02 Aug 2010 02:43:18 -0700 (PDT)
In-Reply-To: <20100729172247.GC24781@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-07-29 at 10:22 -0700, Mark Brown wrote:
> On Thu, Jul 29, 2010 at 09:51:24AM +0300, Peter Ujfalusi wrote:
> 
> > After the series the limitation on the period size can be lifted, so user space
> > can ask for any period size on any of the McBSP ports.
> 
> All looks OK from a generic ASoC point of view
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

All applied.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
