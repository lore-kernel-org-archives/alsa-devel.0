From: "Ambrose, Martin" <martin@ti.com>
Subject: Re: [PATCH 0/1] Add AIC3106 support.
Date: Wed, 13 May 2009 11:30:33 -0500
Message-ID: <A24693684029E5489D1D202277BE89443E393A6D@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE89443E39393E@dlee02.ent.ti.com>
	<20090513161952.GB3629@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id CA3C21038C6
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 18:30:41 +0200 (CEST)
In-Reply-To: <20090513161952.GB3629@sirena.org.uk>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 11:19:52, Mark Brown wrote:

> 
> > This patch applies to the ASoC tree: 
> ddc4097b77bbb227851a44287acb2fb8a9896cc1
> > But it also applies cleanly to the Davinci tree:
> 
> Please submit patches against ALSA git - you want the 
> topic/asoc branch
> of
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

Sorry copy/paste error. The patch is against the current tip
tip of the topic/asoc tree: dd4a416442a2fb4bd761163277d37ab6ce75ee4e

I included the davinci ID for completeness since I needed to use that tree 
to perform the sanity check of building and running.

Regards, 
Martin
