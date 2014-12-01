From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: Move capture PCM pin to
 PCM0 for Broadwell/Haswell
Date: Mon, 1 Dec 2014 03:34:10 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901B73B20@SHSMSX101.ccr.corp.intel.com>
References: <1417182731-26576-1-git-send-email-yang.jie@intel.com>
 <20141128153519.GV7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 468242605B3
 for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2014 04:36:01 +0100 (CET)
In-Reply-To: <20141128153519.GV7712@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


Hi Mark,

Seems it isn't applied yet, I can't find it on any branch of your tree. :(
Maybe some network issue?

Thanks,
~Keyon


> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, November 28, 2014 11:35 PM
> To: Jie, Yang
> Cc: alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [PATCH v2] ASoC: Intel: Move capture PCM pin to PCM0 for
> Broadwell/Haswell
> 
> On Fri, Nov 28, 2014 at 09:52:11PM +0800, Jie Yang wrote:
> > Move capture PCM pin from PCM4 to PCM0 for Broadwell/Haswell.
> > This will allow us to integrate with pulseaudio better for usually
> > default device is set to 0.
> 
> Applied, thanks.
