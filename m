From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 05/17] mfd: madera: Register map tables
 for Cirrus Logic CS47L85
Date: Mon, 05 Jun 2017 03:42:51 -0700
Message-ID: <1496659371.15643.17.camel@perches.com>
References: <1496415790-19164-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1496415790-19164-6-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170605103357.nrgz45ms7vzcjruv@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0118.hostedemail.com
 [216.40.44.118])
 by alsa0.perex.cz (Postfix) with ESMTP id D054F266D44
 for <alsa-devel@alsa-project.org>; Mon,  5 Jun 2017 12:42:56 +0200 (CEST)
In-Reply-To: <20170605103357.nrgz45ms7vzcjruv@dell>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, tglx@linutronix.de
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-06-05 at 11:33 +0100, Lee Jones wrote:
> On Fri, 02 Jun 2017, Richard Fitzgerald wrote:
> 
> > Regmap configuration tables for Cirrus Logic CS47L85 codecs.
> > 
> > Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> > Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> > ---
> > No changes since V2
> > 
> >  drivers/mfd/Kconfig          |    7 +
> >  drivers/mfd/Makefile         |    3 +
> >  drivers/mfd/cs47l85-tables.c | 3169 ++++++++++++++++++++++++++++++++++++++++++
> 
> Yikes!
> 
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

[ and another 160KB of quoted content ]

Please trim your replies.
Stop quoting large quantities of the original email.
