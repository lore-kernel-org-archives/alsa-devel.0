From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH v2 1/7] firmware: Sigma: Prevent out of bounds
 memory access
Date: Tue, 29 Nov 2011 11:18:36 +0100
Message-ID: <4ED4B17C.3090905@metafoo.de>
References: <1322469860-8210-1-git-send-email-lars@metafoo.de> <20111129101247.GA2851@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111129101247.GA2851@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org, stable@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 11/29/2011 11:12 AM, Mark Brown wrote:
> On Mon, Nov 28, 2011 at 09:44:14AM +0100, Lars-Peter Clausen wrote:
> 
>> Mark, in case you are ok with these patches could you take them through your
>> ASoC tree? The firmware subsystem is orphaned.
> 
> Yeah, I was planning to do that but I was waiting for Mike to be happy
> with everything as he'd had a few concerns on the previous round.  He's
> now acked some but not all of the series but there was no followup on
> the other patches - Mike, are you OK with the other changes?

He acked some patches this morning. As far as I can see all of the patches
do have his acked-by now.

Thanks
- Lars
