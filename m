From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [pulseaudio-discuss] alsa ucm in pulseaudio
Date: Mon, 17 Oct 2011 11:23:12 +0100
Message-ID: <20111017102312.GD5448@sirena.org.uk>
References: <4E97D81E.4080607@canonical.com>
	<CAJ4+uhUL-mR_=Tot4XBbQuMRgbg45raL+058prXgEmrpG5Jukg@mail.gmail.com>
	<4E97F964.4080701@canonical.com>
	<CAJ4+uhUGgcFtZrYdu4-kzd8Er5tr0rFuAu4foY04Ku2JyQaeyw@mail.gmail.com>
	<4E980CC9.2050303@canonical.com>
	<CAJ4+uhX1bYr3HEUwtKCSLkzsa71OLo4KSP00+Kx25H=t1Ves7g@mail.gmail.com>
	<4E9815A3.7090304@canonical.com>
	<20111014121813.GG2966@opensource.wolfsonmicro.com>
	<1318835674.17849.8.camel@snowflake>
	<4E9BE806.9040702@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FCCD243DC
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 12:23:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E9BE806.9040702@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, linaro-dev@lists.linaro.org, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, Colin Guthrie <gmane@colin.guthr.ie>, Arun Raghavan <arun.raghavan@collabora.co.uk>, Feng Wei <feng.wei@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 17, 2011 at 10:32:06AM +0200, David Henningsson wrote:
> On 10/17/2011 09:14 AM, Arun Raghavan wrote:

Arun, don't drop people from the CC list!

> Maybe it would be better trying to merge my jack detection first, so 
> that jack detection mechanism can then be adapted (if needed) to fit 
> UCM's needs?
> And for the record, the jack detection upstreaming is currently waiting 
> for Arun/Colin commenting or pushing my first jack detection patch.

Hopefully we can get both merged, they're both needed and this is all
taking far too long :(  Given the deployment in Ubuntu and your active
work on it your jack detection patch seems like the way forward for the
jack detection.

> > I don't know if Feng Wei will be at Prague for ELCE/LinuxCon/GstConf,
> > but perhaps this is something we can take up at one of the BoFs.

> Since both I and Feng (and possibly Mark Brown as well? He was present 
> at previous UDS) it might make sense to schedule a UDS session for this? 
> People not present can listen through icecast streams and join in on IRC 
> for commenting back, something I don't think is possible on LinuxCon 
> (but I don't know for sure?).

I'm not currently planning to attend UDS but I will be in Prague for
Kernel Summit, ELC-E and LinuxCon.
