From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASOC: imx: audmux: add a integrated
 configuration function
Date: Mon, 4 Feb 2013 21:39:33 +0800
Message-ID: <20130204133930.GB19301@S2101-09.ap.freescale.net>
References: <1359614566-4660-1-git-send-email-b13634@freescale.com>
 <20130131142243.GE2735@S2101-09.ap.freescale.net>
 <20130131163517.GC13321@opensource.wolfsonmicro.com>
 <20130201131007.GA23922@S2101-09.ap.freescale.net>
 <20130204100148.GB4720@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe001.messaging.microsoft.com [213.199.154.139])
 by alsa0.perex.cz (Postfix) with ESMTP id BADDC2616C9
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2013 14:39:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130204100148.GB4720@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Gary Zhang <b13634@freescale.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 04, 2013 at 10:01:49AM +0000, Mark Brown wrote:
> On Fri, Feb 01, 2013 at 09:10:09PM +0800, Shawn Guo wrote:
> 
> > imx-sgtl5000 and imx-wm8960 driver.  I'm asking if you can merge Gary's
> > the patch with leaving audmux setup as it is, and let me consolidate
> > the common part between imx-sgtl5000 and imx-wm8960 with a follow-up
> > patch.
> 
> Well, there were a bunch of other issues with the driver that I was
> looking to see addressed.

Sure.  I did not mean for any other issues, and they should be
addressed properly before getting merged.

Shawn
