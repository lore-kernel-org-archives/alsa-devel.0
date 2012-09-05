From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [asoc:for-3.7 95/95]
 sound/soc/codecs/wm0010.c:850:7-27: ERROR: Threaded IRQ with no primary
 handler requested without IRQF_ONESHOT
Date: Thu, 6 Sep 2012 06:20:50 +0800
Message-ID: <20120905222048.GB10580@opensource.wolfsonmicro.com>
References: <20120830151652.GB11964@localhost>
 <20120905054024.GA16276@sirena.org.uk>
 <20120905055609.GA7463@localhost>
 <20120905120546.GB16276@sirena.org.uk>
 <alpine.DEB.2.02.1209051533070.2122@hadrien>
 <20120905134827.GA8694@localhost>
 <alpine.DEB.2.02.1209051552190.2122@hadrien>
 <20120905140651.GA8947@localhost>
 <alpine.DEB.2.02.1209052200280.1912@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A06C0260317
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 00:21:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1209052200280.1912@hadrien>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Fengguang Wu <fengguang.wu@intel.com>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 05, 2012 at 10:01:12PM +0200, Julia Lawall wrote:

> I'm not sure what could be done better...

The patch itself was fine but it was buried as an attachment to a mail
that didn't have anything like a [PATCH] tag or anything so it was very
hidden when it turned up in e-mail.
