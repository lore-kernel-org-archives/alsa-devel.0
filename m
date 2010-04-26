From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: ASoC: OMAP/TI upstream route
Date: Mon, 26 Apr 2010 21:23:31 +0300
Message-ID: <20100426212331.c9ce25a8.jhnikula@gmail.com>
References: <1272293803.3208.85.camel@odin>
	<20100426192228.228489c7.jhnikula@gmail.com>
	<1272302027.3208.209.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f219.google.com (mail-ew0-f219.google.com
	[209.85.219.219])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DA2C24691
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 20:22:50 +0200 (CEST)
Received: by ewy19 with SMTP id 19so3859501ewy.22
	for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2010 11:22:48 -0700 (PDT)
In-Reply-To: <1272302027.3208.209.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "Olaya, Margarita" <magi.olaya@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Apr 2010 18:13:47 +0100
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> > I don't see a need for own tree for plain sound/soc/omap/ patches but
> > this could makes sense for patches that touch also arch/arm/ (we have
> > had a few cases) or sounc/soc/codec/ (if we ever have such a need?).
> > 
> 
> This is not a cross tree merge branch or OMAP patch dumping area.
> 
> Everything is just carrying on as before except the upstream management
> effort is being divided between Mark and I. i.e. I'll manage the TI/OMAP
> based patches, Mark will manage the rest.
> 
Yeah, thanks for clarifying. Makes sense to me. I was kind of fearing
that are we creating some patch dumping area :-)


-- 
Jarkko
