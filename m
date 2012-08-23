From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Re: [PATCH 3/5] ASoC: Davinci: pcm: Add device tree
	bindings
Date: Thu, 23 Aug 2012 05:13:59 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA68662@DBDE01.ent.ti.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-4-git-send-email-gururaja.hebbar@ti.com>
 <20120817223122.GA21445@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EA67DA1@DBDE01.ent.ti.com>
 <20120822155808.GP7995@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id B7A75266195
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 07:14:08 +0200 (CEST)
In-Reply-To: <20120822155808.GP7995@opensource.wolfsonmicro.com>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Rajashekhara,
 Sudhakar" <sudhakar.raj@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Nori,
 Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Ujfalusi,
 Peter" <peter.ujfalusi@ti.com>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 22, 2012 at 21:28:08, Mark Brown wrote:
> On Wed, Aug 22, 2012 at 01:50:09PM +0000, Hebbar, Gururaja wrote:
> 
> > From your for-3.7 branch, I could only find such implementation in Tegra
> > Platform. 
> > Most Freescale platforms implements this through a device/driver method.
> > Exception being sound/soc/mxs/mxs-pcm.c
> 
> > So should I follow tegra implementation?
> 
> Tegra and mxs should be good examples, yes.

Ok. Will update in V2

> 


Regards, 
Gururaja
