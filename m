From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/3] ACPI / utils: Introduce acpi_dev_get_first_match_name()
Date: Fri, 12 Jan 2018 14:22:53 +0100
Message-ID: <17446166.yqafhElxig@aspire.rjw.lan>
References: <20180105160935.48588-1-andriy.shevchenko@linux.intel.com> <1515416960.7000.784.camel@linux.intel.com> <20180109155415.GA11471@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180109155415.GA11471@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Erik Schmauss <erik.schmauss@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday, January 9, 2018 4:54:15 PM CET Mark Brown wrote:
> 
> --vkogqOf2sHV7VnPd
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Mon, Jan 08, 2018 at 03:09:20PM +0200, Andy Shevchenko wrote:
> 
> > According to what Mark and Pierre told previously I guess we just
> > postpone patch 3 for next cycle.
> 
> Well, if someone can send me a pull request I could look at merging
> it...  I had thought we might get a new release this week and be in the
> merge window by now TBH.

Patches [1-2/3] from this series are available for pulling in the git branch at

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-gpio

with top-most commit dd1dbf94d2826a045fbbe2649d84b27d48620d56

    gpio: merrifield: Add support of ACPI enabled platforms

on top of commit b2cd1df66037e7c4697c7e40496bf7e4a5e16a2d

    Linux 4.15-rc7

Thanks!

