From: "Medisetty, Naresh" <naresh@ti.com>
Subject: Re: [PATCH 9/9] ARM: DaVinci: ASoC: Adds build	support
 for DM646X audio driver
Date: Wed, 18 Mar 2009 17:49:54 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B67017069809B09B@dbde02.ent.ti.com>
References: <1237205187-30297-1-git-send-email-naresh@ti.com>,
	<20090316152915.GH16539@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id ADFB61037EC
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 13:20:25 +0100 (CET)
In-Reply-To: <20090316152915.GH16539@sirena.org.uk>
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
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org

> On Mon, Mar 16, 2009 at 08:06:27AM -0400, Naresh Medisetty wrote:
>
> > +config SND_SOC_CODEC_STUBS
> > +        tristate
> > +
>
> You need to add this to SND_SOC_ALL_CODECS.



I will add this to SND_SOC_ALL_CODECS
