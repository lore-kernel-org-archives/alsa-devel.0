From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 0/7] Fix Intel audio Kconfig issues
Date: Mon, 27 Nov 2017 08:40:33 -0600
Message-ID: <12234b39-8aef-e317-ffce-53b8273c7fb1@linux.intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
 <s5ho9o07xbr.wl-tiwai@suse.de> <s5hwp2jtv4z.wl-tiwai@suse.de>
 <20171122115438.47ffg7tlfxnjczvv@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171122115438.47ffg7tlfxnjczvv@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, vinod.koul@intel.com, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On 11/22/17 5:54 AM, Mark Brown wrote:
> On Tue, Nov 21, 2017 at 06:10:52PM +0100, Takashi Iwai wrote:
>> Takashi Iwai wrote:
> 
>>> FYI, I've put these to a test branch, test/asoc-intel-kconfig, so that
>>> 0day bot can catch issues.  Let's see.
> 
>> No news is a good news, it seems that your patchset doesn't break
>> builds, at least.  Let's go ahead!
> 
> OTOH there's a bunch of "I'll fix that in the next version" stuff in the
> thread and the immediate issue got fixed already - I'd been expecting a
> new version.

Yes, there will be a new version with the comments addressed. This 
series was not intended to be applied as is.
